from datetime import datetime
import time
from requests import get, post

from db import cmd, cursor, conn, max_id


def begin_batch(links, ids, app):

    #sql = "INSERT INTO DiffBotBatch (MediaCloudBatchID, DiffBotBatchID, Name, PagesAttempted, PagesCompleted) VALUES (1, 1, " + \
    #    " '" + batch_name + "', 0, 0)"
    sql = "INSERT INTO DiffBotBatch (StartTime, CompletedTime, PagesAttempted, PagesCompleted, Name) VALUES (GetDate(), NULL, 0, 0, '')" 
    cmd(sql)

    # Name to be used for DiffBot is ID + _links_ + app name  
    diff_bot_batch_id = max_id('DiffBotBatch')
    batch_name = str(diff_bot_batch_id) + "_links_" + app
    cursor.execute("UPDATE DiffBotBatch SET Name = ? WHERE ID = ?", batch_name, diff_bot_batch_id)
    conn.commit()


    urls_string = ' '.join(links)
    print ('Begining batch ' + str(diff_bot_batch_id) + ' with ' + str(len(links)) + ' urls')

    headers = {'Content-type': 'application/x-www-form-urlencoded'}
    params = {'token': '3cf697d4387a105d959518bd5b682679',
        'name': batch_name,
        'notifyEmail': 'scottmckissock@gmail.com',      
        'apiUrl': 'https://api.diffbot.com/v3/article'}
    data = {'urls': urls_string} 

    post('https://api.diffbot.com/v3/bulk', params=params, headers=headers, data=data)

    # Mark linked stories as being included in a batch
    for story_id in ids:
        cursor.execute("UPDATE DiffBotStoryLink SET DiffBotBatchID = ? WHERE ID = ?", diff_bot_batch_id, story_id)  
        conn.commit()


#app = "RussiaNews"
app = "Congress"
#app = "Senate"

batch_size = 1000
diff_bot_minimum_batch_size = 50

# Don't want to spend too much money...
max_stories = 200000
stories = 0

links = []
ids = []
cursor.execute("SELECT ID, Link FROM LinksToImportView")
link_rows = cursor.fetchall()
for row in link_rows:
    links.append(row.Link)
    ids.append(row.ID)
    stories += 1
    
    if len(links) == batch_size:
        begin_batch(links, ids, app)
        links = []
        ids = []

    if stories > max_stories:
        break

# Make small batch with leftovers. This could leave some un-batched, but they will be picked up later
if len(links) >= diff_bot_minimum_batch_size:
    begin_batch(links, ids, app)

print("DONE")        






#begin_link_batch(diffbot_batch_id, diffbot_batch_name)
#link_batch_id = max_id("DiffbotBatch")

#secs = 10
#link_batch = diffbot_batch_name + "_Links"
#while (not completed_batch(link_batch)):
#    time.sleep(secs)
#    print("Batch " + link_batch + " waiting " + str(secs) + " sec...")

#    print("GETTING BATCH " + str(link_batch_id) + link_batch)
#    print(" ")
#    get_batch(str(link_batch_id), link_batch)
    
#    print('Done - ' + link_batch)
