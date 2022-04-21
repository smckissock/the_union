from datetime import datetime
from requests import get, post
import json

from db import cmd, cursor, conn, max_id


def load_page():

    start = datetime.now()
    print ('START AT ' + datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    
    payload = {'token': '3cf697d4387a105d959518bd5b682679',
           'url': 'https://slate.com/news-and-politics/2016/11/the-trump-server-evaluating-new-evidence-and-countertheories.html',
           'fields': 'meta,text'}

    r = get('https://api.diffbot.com/v3/article', params=payload)
    print("Encoding: " + r.encoding)
    print("Status Code: " + str(r.status_code))

    the_json = json.loads(r.text)
    story = the_json['objects'][0]

    #print(json.dumps(story, indent=4, sort_keys=True))

    print(story['title'])
    print(story['author'])
    print(story['authorUrl'])   
    #print(story['resolvedPageUrl']) Why isn't it here?
    print(story['date'])
    print(story['estimatedDate'])
    print(story['diffbotUri'])
    print(story['pageUrl'])

    duration = datetime.now() - start
    print('DONE IN ' + str(duration))


def begin_batch(batch_name, url_sql):
    # sql must have a "url" field
    cursor.execute(url_sql)
    rows = cursor.fetchall()
    urls = []
    for row in rows:
        urls.append(row.Url)

    urls_string = ' '.join(urls)

    print ('Begining batch ' + batch_name + ' with ' + str(len(rows)) + ' urls')

    headers = {'Content-type': 'application/x-www-form-urlencoded'}

    params = {'token': '3cf697d4387a105d959518bd5b682679',
        'name': batch_name,
        'notifyEmail': 'scottmckissock@gmail.com',      
        'apiUrl': 'https://api.diffbot.com/v3/article'}

    data = {'urls': urls_string} 

    r = post('https://api.diffbot.com/v3/bulk', params=params, headers=headers, data=data)
    print("Posted batch")
    #print(r.text)


def begin_link_batch(diffbot_batch_id, diffbot_batch):
    link_batch_name = diffbot_batch + "_Links"
    sql = "INSERT INTO DiffBotBatch (MediaCloudBatchID, DiffBotBatchID, Name, PagesAttempted, PagesCompleted) VALUES (1, " + str(diffbot_batch_id) + \
        ", '" + link_batch_name + "', 0, 0)"
    cmd(sql)

    # Need?
    #link_batch_id = max_id('DiffBotBatch')
    delete_batch(link_batch_name)
    begin_batch(link_batch_name, "SELECT Url FROM LinkUrlView WHERE DiffBotBatchID = " + str(diffbot_batch_id)) 


    
def delete_batch(batch_name):
    params = {'token': '3cf697d4387a105d959518bd5b682679',
        'name': batch_name,           
        'delete': 1}
    r = get('https://api.diffbot.com/v3/bulk', params=params)


def completed_batch(batch_name):
    params = {'token': '3cf697d4387a105d959518bd5b682679',
        'name': batch_name}
    
    r = get('https://api.diffbot.com/v3/bulk', params=params)
    
    the_json = json.loads(r.text)
    job = the_json["jobs"][0]
    # 9 = Job has completed and no repeat is scheduled.
    return job["jobStatus"]["status"] == 9
    

def get_batch(diffbot_batch_id, batch_name):

    def update_batch_stats(batch_name):
        params = {'token': '3cf697d4387a105d959518bd5b682679', 'name': batch_name}
    
        r = get('https://api.diffbot.com/v3/bulk', params=params)
        tree = json.loads(r.text)
        job = tree["jobs"][0]

        pages_attempted = job["pageProcessAttempts"]
        pages_completed = job["pageProcessSuccesses"]
        #print(str(pages_attempted))
        #print(str(pages_completed))

        started = job["jobCreationTimeUTC"]
        done = job["jobCompletionTimeUTC"]

        sql = "UPDATE DiffbotBatch SET " + \
            "StartTime = '" + str(datetime.fromtimestamp(started)) + "'" + \
            ", CompletedTime = '" + str(datetime.fromtimestamp(done)) + "'" + \
            ", PagesAttempted = " + str(pages_attempted) + \
            ", PagesCompleted = " + str(pages_completed) + \
            " WHERE Name = '" + batch_name + "'"

        print(sql)
        cmd(sql)


    def save_story(story, diffbot_batch_id):
        story_id = -1
        cursor.execute("SELECT ID FROM MediaCloudStory WHERE Url = ?", story['pageUrl'])
        rows = cursor.fetchall()
        for row in rows:
            story_id = row.ID

        # This comes from a link, not from Media Cloud
        if "_Links" in batch_name:
            story_id = 1
            print ("_Links is in batch name")

        url = story['pageUrl']
        author = story.get('author', '')
        authorUrl = story.get('authorUrl', '')
        date = story.get('date', '')
        estimatedDate = story.get('estimatedDate', '')
        html = story.get('html', '')
        resolvedPageUrl = story.get('resolvedPageUrl', url)

        try:
            cursor.execute("INSERT INTO DiffBotStory VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", \
                diffbot_batch_id, story_id, story['title'], author, authorUrl, story['siteName'], date, estimatedDate, story['diffbotUri'], url, resolvedPageUrl, story['text'], html)
            conn.commit()
        except Exception as e:
            print('Error Saving story ' + story['pageUrl'])
            print("Error " + str(e)) # Ignore duplicate inserts?
            #print(type(e))
            #print(e.args)
        

    payload = {'token': '3cf697d4387a105d959518bd5b682679',
        'name': batch_name,
        'format': 'json'}

    r = get('https://api.diffbot.com/v3/bulk/data', params=payload)
    print('Getting batch: ' + batch_name)
    
    the_json = json.loads(r.text)
    count = 0
    for story in the_json:
        count += 1
        try:
            #if count == 1:
            save_story(story, diffbot_batch_id)
        except Exception as e:
            print(str(e))

    update_batch_stats(batch_name)
    
    print(str(count) + ' stories')




#load_page()

#delete_batch('Oleg_Deripaska')
#begin_batch('Oleg_Deripaska', "SELECT Url, ID FROM MediaCloudStory WHERE SearchTerm = 'Oleg Deripaska'")
#get_batch('Oleg_Deripaska')



