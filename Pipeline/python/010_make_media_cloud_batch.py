import datetime
import time
import mediacloud.api
from db import cmd, cursor, conn, max_id, write_log, write_error

# lincolnprojectpress.gmail.com  09_ (gmail)  87_ (MediaCloud) 09_ (diffbot)

# def download_batch(term, term_id, collection_id, media_cloud_collection_id):
def download_batch(media_cloud_batch_id, term, collection_id, start_date, end_date):
    max_for_term = 9000

    mc = mediacloud.api.MediaCloud('ed8ada55ff11950787b7d61e7d4d04087eb4100f9954dc085fd15fb5892694b8')

    # Better way to do it: https://pypi.org/project/mediacloud/
    #batch = mc.storyList('"' + term + '" AND tags_id_media:58722749', "(publish_day:[2015-01-01T00:00:00Z TO 2019-02-03T00:00:00Z])", rows = 5000)

    fetch_size = 1000
    stories = []
    last_processed_stories_id = 0
    while len(stories) < max_for_term:
        fetched_stories = mc.storyList('"' + term + '" AND tags_id_media:' + collection_id,
                                       solr_filter=mc.publish_date_query(
                                           start_date, end_date),
                                       last_processed_stories_id=last_processed_stories_id, rows=fetch_size)
        stories.extend(fetched_stories)
        if len(fetched_stories) < fetch_size:
            break
        last_processed_stories_id = stories[-1]['processed_stories_id']

    #cursor.execute("INSERT INTO MediaCloudBatch VALUES (?, '2019-01-01', '2019-05-03', GetDate(), 1, ?)", term, term_id)
    #cursor.execute("INSERT INTO MediaCloudBatch VALUES (?, '2015-01-01', '2019-04-17', GetDate(), ?, ?)", term, media_cloud_collection_id, term_id)
    cursor.execute(
        "UPDATE MediaCloudBatch SET RunTime = GetDate() WHERE ID = ?", media_cloud_batch_id)
    conn.commit()
    insert_stories(stories, term, media_cloud_batch_id)


def insert_stories(stories, term, media_cloud_batch_id):
    #media_cloud_batch_id = max_id('MediaCloudBatch')

    count = 0
    dupes = 0
    for story in stories:
        try:
            cursor.execute("INSERT INTO MediaCloudStory (MediaCloudBatchID, MediaCloudStoriesID, PublishDate, Title, Url, Language, ApSyndicated, MediaID, MediaName, MediaUrl, MediaType, Themes) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                           media_cloud_batch_id, story["stories_id"], story[
                               "publish_date"], story["title"], story["url"], story["language"],
                           story["ap_syndicated"], story["media_id"], story["media_name"], story["media_url"], "", "")
            conn.commit()
            count += 1
        except Exception as e:
            dupes += 1
            cursor.execute(
                "INSERT INTO PipelineError VALUES ('013', 1, ?, GetDate(), ?)", str(e), term)
            conn.commit()

    print(str(count) + " stories for " + term +
          " " + str(dupes) + " duplicates")


print("010 Make MediaCloud batch")
runs = 0
while (1 == 1):
    try:
        #curson.execute("SELECT Term, StartDate, EndDate, MediaCloudCollectionID, TermID FROM MediaCloudBatch WHERE RunTime IS NULL")
        cursor.execute("SELECT b.ID, b.Term, b.StartDate, EndDate, MediaCloudCollectionID, TermID, c.CollectionID " +
                       "FROM MediaCloudBatch b "
                       "JOIN MediaCloudCollection c ON b.MediaCloudCollectionID = c.ID "
                       "WHERE RunTime IS NULL ORDER BY TermID DESC")

        batches = cursor.fetchall()
        for batch in batches:
            download_batch(batch.ID, batch.Term, batch.CollectionID,
                           batch.StartDate, batch.EndDate)
            #download_batch(batch.TermName, batch.TermID, batch.CollectionID, batch.ID)

        runs += 1
        msg = "010 Run MediaCloud batches: # of runs = " + str(runs)
        write_log(msg)
        print(msg)

        time.sleep(30)
    except Exception as e:
        print(e)
        get_input = input()
        print("Error " + get_input)

# should never happen
write_log("Done running")
print("DONE")
