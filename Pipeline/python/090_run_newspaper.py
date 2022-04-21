from newspaper import Article
import time
#import newspaper


import pyodbc
import sys

from db import cmd, cursor, conn, write_error, write_log


def import_story(id, url, has_text):

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
		body = ''
		if has_text == 0:
			body = article.text

		cursor.execute("INSERT INTO NewspaperStory VALUES (?, ?, ?, ?, ?, ?, GetDate())", id, date, title, authors, image, body)
		conn.commit()
	except Exception as e:
		write_error("run_newspaper", id, str(e))
		return None


print("090 Run Newspaper")
runs = 0
while (1 == 1):
	try:
		cursor.execute("SELECT DiffBotStoryID, Url, HasText FROM NewspaperUrlView ORDER BY DiffBotStoryID")
		stories = cursor.fetchall()
		count = 0	
		for story in stories:
			import_story(story.DiffBotStoryID, story.Url, story.HasText)
			count = count + 1
			print(str(count) + " newspaper stories imported")

		print("Done first loop running newspaper")
		count = 0	

		time.sleep(60)
	except Exception as e:
		print(str(e))
		write_log("090 " + str(e))
    
print("DONE - " + str(count) + " stories")
