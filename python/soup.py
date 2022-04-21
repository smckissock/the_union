import pyodbc 
from datetime import datetime
import re
from bs4 import BeautifulSoup
    
from db import cmd, cursor, conn


def import_links(story_id, html):
    soup = BeautifulSoup(html, 'html.parser')
    links = []
    for link in soup.findAll('a', attrs={'href': re.compile("^http://")}):
        links.append(link)
    for link in soup.findAll('a', attrs={'href': re.compile("^https://")}):
        links.append(link)
            
    for link in links:
        try:
            cursor.execute("INSERT INTO DiffBotStoryLink VALUES (?, ?)", story_id, link['href'])
            conn.commit()
            print(str(story_id) + " " + link['href'])
        except:
            print("Error Inserting") # Ignore duplicate inserts

                
def import_links_for_batch(diffbot_batch_id):
    cursor.execute("SELECT ID, Html FROM DiffBotStory WHERE Html <> '' AND DiffBotBatchID = " + str(diffbot_batch_id))
    rows = cursor.fetchall()
    for story in rows:
        import_links(story.ID, story.Html)
        
 

