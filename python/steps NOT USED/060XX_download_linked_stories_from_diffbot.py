from datetime import datetime
import time
import json
from requests import get, post

from db import cmd, cursor, conn


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
            "StartTime = '" + str(datetime.fromtimestamp(started)) + "'" + \
            ", CompletedTime = '" + str(datetime.fromtimestamp(done)) + "'" + \
            ", PagesAttempted = " + str(pages_attempted) + \
            ", PagesCompleted = " + str(pages_completed) + \
            " WHERE Name = '" + batch_name + "'"
        print(sql)
        cmd(sql)
    except Exception as e:
        print('Error Saving batch Info')
        print("Error " + str(e)) # Ignore duplicate inserts?    

def save_story(story, diffbot_batch_id):
    story_id = 1
    
    author = story.get('author', '')
    authorUrl = story.get('authorUrl', '')
    date = story.get('date', '')
    estimatedDate = story.get('estimatedDate', '')
    html = story.get('html', '')

    url = story['pageUrl']
    resolvedPageUrl = story.get('resolvedPageUrl', url)

    try:
        cursor.execute("INSERT INTO DiffBotStory VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)", \
            diffbot_batch_id, story_id, story['title'], author, authorUrl, story['siteName'], date, estimatedDate, story['diffbotUri'], url, resolvedPageUrl, story['text'], html)
        conn.commit()
    except Exception as e:
        print('Error Saving story ' + story['pageUrl'])
        print("Error " + str(e)) # Ignore duplicate inserts?
        #print(type(e))
        #print(e.args)


# This just assumes the batches are done and grabs them all - doesn't look at api results to see...
# But it doesn mark them when done!
cursor.execute("SELECT ID, Name FROM DiffBotBatch WHERE Name like '%_Links'")
batch_rows = cursor.fetchall()
for batch in batch_rows:
    batch_id = batch.ID
    batch_name = batch.Name
    
    # Get the stories for the batch
    payload = {'token': '3cf697d4387a105d959518bd5b682679', 'name': batch_name, 'format': 'json'}
    r = get('https://api.diffbot.com/v3/bulk/data', params=payload)
    
    json_obj = json.loads(r.text)
    for story in json_obj:
        try:
            save_story(story, batch_id)
        except Exception as e:
            print(str(e))

    update_batch_stats(batch_name)
