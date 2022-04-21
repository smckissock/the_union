from newspaper import Article
import time
#import newspaper


import pyodbc
import sys

from db import cmd, cursor, conn, write_error


def import_story(story_id, url, mediaName, diffbot_batch_id, publish_date):
    #print(mediaName)
    #print(str(story_id))
    #print(str(diffbot_batch_id))

    if url.endswith("pdf") or url.endswith("download"):
        return None

    try:
        article = Article(url)
        article.download()
        article.parse()
    except:
        return None

    try:
        title = article.title
        authors = ', '.join(article.authors)
        body = article.text
        html = article.html
         
        try:
            cursor.execute("INSERT INTO DiffBotStory VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, NULL, NULL, 1)", \
                str(diffbot_batch_id), str(story_id), title, authors, "NEWSPAPER", mediaName, publish_date, publish_date, "", url, url, body, html)
            conn.commit()
        except Exception as e:
            print('Error Saving story ' + title)
            print("Error " + str(e)) # Ignore duplicate inserts?

    except Exception as e:
        write_error("run_newspaper", id, str(e))
        return None


print("110 Run Newspaper for missing diffbot")
runs = 0
while (1 == 1):
    try:
        #cursor.execute("SELECT id, url, diffBotBatchID, mediaName, title, mediaUrl, publishDate FROM MediaCloudStory WHERE ID NOT IN (SELECT MediaCloudStoryID FROM DiffBotStory) AND (DiffBotBatchID = (SELECT MAX(ID) FROM DiffBotBatch))")
        cursor.execute("SELECT id, url, diffBotBatchID, mediaName, title, mediaUrl, publishDate FROM MediaCloudStory WHERE ID NOT IN (SELECT MediaCloudStoryID FROM DiffBotStory) AND (DiffBotBatchID IN (47, 48))")
        #cursor.execute("SELECT id, url, diffBotBatchID, mediaName, title, mediaUrl, publishDate FROM MediaCloudStory WHERE ID NOT IN (SELECT MediaCloudStoryID FROM DiffBotStory)  AND mediaName = 'Politico'")
        stories = cursor.fetchall()
        count = 0
        for story in stories:            
            import_story(story.id, story.url, story.mediaName, story.diffBotBatchID, story.publishDate)
            count = count + 1
            print(story.mediaName + " " + str(count))

        print("Done looking for missing stories with Newspaper")    

        time.sleep(60)
    except Exception as e:
        print(str(e))
        #write_log("090 " + str(e))

print("DONE - " + str(count) + " stories")
