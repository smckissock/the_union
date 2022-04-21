import pyodbc 
from datetime import datetime
import re
from urllib.parse import urlparse
from bs4 import BeautifulSoup
    
from db import cmd, cursor, conn



def import_links_for_story(story_id, html, diffBotBatchID):
    soup = BeautifulSoup(html, 'html.parser')
    links = []
    for link in soup.findAll('a', attrs={'href': re.compile("^http://")}):
        links.append(link)
    for link in soup.findAll('a', attrs={'href': re.compile("^https://")}):
        links.append(link)
            
            
    for link in links:
        # count += 1
        try:
            url = link['href']
            domain = '' # Next line could be an error
            try:
                domain = urlparse(url).netloc
            except Exception as e:
                print("Error " + str(e))
            cursor.execute("INSERT INTO DiffBotStoryLink VALUES (?, ?, ?, ?)", story_id, url, domain, diffBotBatchID)
            conn.commit()
        except Exception as e:
            print("Error " + str(e)) # Ignore duplicate inserts?

    cmd("UPDATE DiffBotStory SET FindLinksDate = GetDate() WHERE ID = " + str(story_id))        

total = 0
while True: 
    cursor.execute("SELECT TOP 100 ID, Html, DiffBotBatchID FROM DiffBotStory WHERE FindLinksDate IS NULL")
    stories = cursor.fetchall()
    for story in stories:
        import_links_for_story(story.ID, story.Html, story.DiffBotBatchID) 
        total = total + 1
    print(str(total))    

print('DONE')    
        
 
