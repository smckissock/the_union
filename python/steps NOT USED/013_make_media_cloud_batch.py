import datetime
import mediacloud
from db import cmd, cursor, conn, max_id


def download_batch(term, term_id, collection_id, media_cloud_collection_id):

    max_for_term = 9000

    mc = mediacloud.api.MediaCloud('310925751b83a7cd0d80ab04f28b2d4e2a7771caa7a75c01ae7c11889d3d7be0')
    
    # Better way to do it: https://pypi.org/project/mediacloud/
    #batch = mc.storyList('"' + term + '" AND tags_id_media:58722749', "(publish_day:[2015-01-01T00:00:00Z TO 2019-02-03T00:00:00Z])", rows = 5000)
    
    fetch_size = 1000
    stories = []
    last_processed_stories_id = 0
    while len(stories) < max_for_term:
        fetched_stories = mc.storyList('"' + term + '" AND tags_id_media:' + collection_id, 
                                   solr_filter=mc.publish_date_query(datetime.date(2015,1,1), datetime.date(2019,4,17)),
                                   last_processed_stories_id=last_processed_stories_id, rows= fetch_size)
        stories.extend(fetched_stories)
        if len( fetched_stories) < fetch_size:
            break
        last_processed_stories_id = stories[-1]['processed_stories_id']

    #cursor.execute("INSERT INTO MediaCloudBatch VALUES (?, '2019-01-01', '2019-05-03', GetDate(), 1, ?)", term, term_id)
    cursor.execute("INSERT INTO MediaCloudBatch VALUES (?, '2015-01-01', '2019-04-17', GetDate(), ?, ?)", term, media_cloud_collection_id, term_id)

    conn.commit()

    insert_stories(stories, term)    


def insert_stories(stories, term):
    media_cloud_batch_id = max_id('MediaCloudBatch')

    count = 0
    dupes = 0
    for story in stories:
        try:
            cursor.execute("INSERT INTO MediaCloudStory (MediaCloudBatchID, MediaCloudStoriesID, PublishDate, Title, Url, Language, ApSyndicated, MediaID, MediaName, MediaUrl, MediaType, Themes) " + \
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", \
                media_cloud_batch_id, story["stories_id"], story["publish_date"], story["title"], story["url"], story["language"], \
                story["ap_syndicated"], story["media_id"], story["media_name"], story["media_url"], "", "")
            conn.commit()
            count += 1
        except Exception as e:
            dupes += 1
            cursor.execute("INSERT INTO PipelineError VALUES ('013', 1, ?, GetDate(), ?)", str(e), term)
            conn.commit()

    print(str(count) + " stories for " + term + " " + str(dupes) + " duplicates")         


#cursor.execute("SELECT Name, ID FROM Term WHERE ID = 37")
#cursor.execute("SELECT Name, ID FROM Term WHERE Active = 1 AND ID > 564")

# Dems Only
# cursor.execute("SELECT Name, Term.ID FROM Term JOIN SenateView c ON Term.Name = c.FullName AND c.Party = 'D' WHERE Active = 1 AND ID > 564")

# esports
#cursor.execute("SELECT a.TermName, a.TermID, mcc.MediaCloudCollectionID FROM AppTermView a JOIN AppMediaCloudCollection mcc ON mcc.AppID = a.AppID WHERE a.appID > 24 AND MediaCloudCollectionID = 1")
cursor.execute("SELECT a.TermName, a.TermID, cc.CollectionID, cc.ID FROM AppTermView a JOIN AppMediaCloudCollection mcc JOIN MediaCloudCollection cc ON cc.ID = mcc.MediaCloudCollectionID ON mcc.AppID = a.AppID WHERE (a.appID > 24) AND (TermName <> 'Doug Jones')")

terms = cursor.fetchall()
for term in terms:
    download_batch(term.TermName, term.TermID, term.CollectionID, term.ID)

print("DONE")    