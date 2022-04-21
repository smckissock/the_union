from datetime import datetime
from requests import get, post
import json
import time

from db import cmd, cursor, conn, write_log, write_error


def get_batch_statuses():
    params = {'token': '3cf697d4387a105d959518bd5b682679'}
    response = get('https://api.diffbot.com/v3/bulk', params=params)
    return response.text


def get_batch(diffbot_batch_id, batch_name):

    def update_batch_stats(batch_name):
        params = {'token': '3cf697d4387a105d959518bd5b682679', 'name': batch_name}
    
        r = get('https://api.diffbot.com/v3/bulk', params=params)
        tree = json.loads(r.text)

        try:
            job = tree["jobs"][0]

            pages_attempted = job["pageProcessAttempts"]
            pages_completed = job["pageProcessSuccesses"]

            started = job["jobCreationTimeUTC"]
            done = job["jobCompletionTimeUTC"]

            sql = "UPDATE DiffbotBatch SET " + \
                "CompletedTime = '" + str(datetime.fromtimestamp(done)) + "'" + \
                ", PagesAttempted = " + str(pages_attempted) + \
                ", PagesCompleted = " + str(pages_completed) + \
                " WHERE Name = '" + batch_name + "'"
            cmd(sql)
            print ("Batch " + batch_name + " done")
        except Exception as e:
            print('Error Saving batch Info')
            print("Error " + str(e)) # Ignore duplicate inserts?


    def save_story(story, diffbot_batch_id):
        story_id = -1
        cursor.execute("SELECT ID FROM MediaCloudStory WHERE Url = ?", story['pageUrl'])
        rows = cursor.fetchall()
        for row in rows:
            story_id = row.ID

        # This comes from a link, not from Media Cloud
        if "_links_" in batch_name:
            story_id = 1
            #print ("_Links is in batch name")

        url = story['pageUrl']
        author = story.get('author', '')
        authorUrl = story.get('authorUrl', '')
        date = story.get('date', '')
        estimatedDate = story.get('estimatedDate', '')
        html = story.get('html', '')
        resolvedPageUrl = story.get('resolvedPageUrl', url)

        try:    
            cursor.execute("INSERT INTO DiffBotStory VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, NULL, NULL, 1)", \
                diffbot_batch_id, story_id, story['title'], author, authorUrl, story['siteName'], date, estimatedDate, story['diffbotUri'], url, resolvedPageUrl, story['text'], html)
            conn.commit()
        except Exception as e:
            print('Error Saving story ' + story['pageUrl'])
            print("Error " + str(e)) # Ignore duplicate inserts?

               
    print('About to get batch: ' + batch_name)
    payload = {'token': '3cf697d4387a105d959518bd5b682679', 'name': batch_name, 'format': 'json'}

    r = get('https://api.diffbot.com/v3/bulk/data', params=payload)
    print('Getting batch: ' + batch_name)
    
    # this blows up very rarely - need to log
    try: 
        the_json = json.loads(r.text)
    except Exception as e:
        cursor.execute("INSERT INTO PipelineError VALUES ('030', 1, ?, GetDate(), ?)", str(e), "Problem parsing batch " + batch_name)
        # Don't attempt to load the stories. But do what??
        return
         
    count = 0
    for story in the_json:
        count += 1
        try:
            save_story(story, diffbot_batch_id)
        except Exception as e:
            # This will throw a lot of errors (~10%) because ResolvedPageURl has a unique indes on it, and Media cloud has a lot of pages that redirect to the same page 
            print(str(e))

    update_batch_stats(batch_name)
    
    print(str(count) + ' stories')


print("040 Download Diffbot stories")

runs = 0
while (1 == 1):
    try:
        jobs_json = get_batch_statuses()
        jobs = json.loads(jobs_json)
        for job in jobs["jobs"]:
            print(job["name"] + " status " + str(job["jobStatus"]["status"]))
            if job["jobStatus"]["status"] == 9:
                print("Completed job found " + job["name"]) 
                # This will return one row, or zero, if job has already been marked completed
                cursor.execute("SELECT ID FROM DiffBotBatch WHERE (CompletedTime IS NULL) AND Name = ?", job["name"])
                rows = cursor.fetchall()
                for row in rows:
                    get_batch(row.ID, job["name"])

        runs += 1
        msg = "040 Download Diffbot stories runs = " + str(runs)
        print(msg)

        time.sleep(60)
    except Exception as e:
        # This will throw a lot of errors (~10%) because ResolvedPageURl has a unique indes on it, and Media cloud has a lot of pages that redirect to the same page 
        print(str(e))
        write_log("040 " + str(e))


print("DONE")    