from db import cmd, cursor, conn, max_id
import datetime
import time

from media_cloud import read_csv
from diffbot import begin_batch, get_batch, delete_batch, completed_batch, begin_link_batch 
from soup import import_links_for_batch


path = 'C:\\news-search\\python\\media-cloud\\'

# For each new MediaCloudRecord, read the csv to populate MediaCloudStory 
cursor.execute('SELECT ID, Term, StartDate, EndDate, Collection, CollectionID, CsvName FROM MediaCloudBatch WHERE RunTime IS NULL')
rows = cursor.fetchall()
for media_cloud_batch in rows:
    media_cloud_batch_id = str(media_cloud_batch.ID)

    # 1
    read_csv(path + media_cloud_batch.CsvName, media_cloud_batch.ID)

    cmd("UPDATE MediaCloudBatch SET RunTime = GETDATE() WHERE ID = " + media_cloud_batch_id)

    diffbot_batch_name = media_cloud_batch_id + "_" + media_cloud_batch.Term.replace(" ", "_")
    cmd("INSERT INTO DiffBotBatch (MediaCloudBatchID, DiffBotBatchID, Name) VALUES (" + \
        media_cloud_batch_id + ", 1, '" + diffbot_batch_name + "')")

    # 2
    delete_batch(diffbot_batch_name)
    begin_batch(diffbot_batch_name, "SELECT Url, ID FROM MediaCloudStory WHERE MediaCloudBatchID  = " + media_cloud_batch_id)

    diffbot_batch_id = max_id("DiffbotBatch")
    secs = 10
    while (not completed_batch(diffbot_batch_name)):
        time.sleep(secs)
        print("Batch " + diffbot_batch_name + " waiting " + str(secs) + " sec...")

    #3
    get_batch(str(diffbot_batch_id), diffbot_batch_name)

    #4
    import_links_for_batch(diffbot_batch_id)


    begin_link_batch(diffbot_batch_id, diffbot_batch_name)
    link_batch_id = max_id("DiffbotBatch")
    secs = 10
    link_batch = diffbot_batch_name + "_Links"
    while (not completed_batch(link_batch)):
        time.sleep(secs)
        print("Batch " + link_batch + " waiting " + str(secs) + " sec...")

    print("GETTING BATCH " + str(link_batch_id) + link_batch)
    print(" ")
    get_batch(str(link_batch_id), link_batch)
    
    print('Done - ' + link_batch)

    
