from datetime import datetime
import time
from requests import get, post

from db import cmd, cursor, conn


def delete_batch(batch_name):
    params = {'token': '3cf697d4387a105d959518bd5b682679', 'name': batch_name, 'delete': 1}
    get('https://api.diffbot.com/v3/bulk', params=params)


def begin_batch(batch_name, url_sql):
    # sql must have a "url" field
    cursor.execute(url_sql)
    rows = cursor.fetchall()
    
    # NOTE: DiffBot startup plan requires at least 50 URLS for a batch. If less than that, nothing happens 
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

    post('https://api.diffbot.com/v3/bulk', params=params, headers=headers, data=data)


# "app" SHOULD BE A PARAMETER TO THIS
# PUT THIS IN WHILE LOOP WITH A PAUSE AT THEN END

# Purpose - Start DiffBot batches for records in DiffBotBatch that haven't started   
# Input - Looks at DiffBotBatch for any batches with out a StartTime 
# Action - For each batch, start a batch on diffbot anmed DiffBotBatch.Name, using URLs from MediaCloudStory with the same DiffBotBatchID 
# Output - Once batch is started on DiffBot, put time in DiffBotBatch.StartTime, so another batch is not started
cursor.execute("SELECT ID, Name FROM DiffBotBatch WHERE (StartTime IS NULL)") 
rows = cursor.fetchall()
for diffbot_batch in rows:  
    id = str(diffbot_batch.ID)
    name = diffbot_batch.Name

    begin_batch(name, "SELECT Url FROM MediaCloudStory WHERE DiffBotBatchID = " + id)
    cmd("UPDATE DiffBotBatch SET StartTime = GetDate() WHERE ID = " + id)
    
    # diffbot requires 5 seconds between batches
    time.sleep(6)

print("DONE")    

    



