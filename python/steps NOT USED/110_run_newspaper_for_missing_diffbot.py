from newspaper import Article
import time
#import newspaper


import pyodbc
import sys

from db import cmd, cursor, conn, write_error


def import_story(id, url, mediaName):
    
	if url.endswith("pdf") or url.endswith("download"):
		return None

	try:
		article = Article(url)
		article.download()
		article.parse()
	except:
		return None	

	try:
		date = ''
		if article.publish_date is not None:
			date = article.publish_date.strftime("%x")
		title = article.title
		authors = ', '.join(article.authors)
		image = article.top_image
		body = article.text

	except Exception as e:
		write_error("run_newspaper", id, str(e))
		return None


print("110 Run Newspaper for missing diffbot")
runs = 0
while (1 == 1):
	try:
		print("Running")
		cursor.execute("SELECT id, url, diffBotBatchID, mediaName, title, mediaUrl, publishDate FROM MediaCloudStory WHERE ID NOT IN (SELECT MediaCloudStoryID FROM DiffBotStory)")
		stories = cursor.fetchall()
		count = 0	
		for story in stories:
			import_story(story.id, story.url, story.mediaName)
			count = count + 1

		time.sleep(60)
	except Exception as e:
		print(str(e))
		#write_log("090 " + str(e))
    
print("DONE - " + str(count) + " stories")
