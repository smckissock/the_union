from bs4 import BeautifulSoup
import re
import json
from datetime import date, datetime

from db import cmd, cursor, conn, max_id
from soup import import_links
from requests import get, post



def test_links():
    # 5 has 2 links...
    story_id = 5;
    cursor.execute("SELECT ID, Html FROM DiffBotStory WHERE ID  = " + str(story_id))
    rows = cursor.fetchall()
    for row in rows:
        html = row.Html

        html = html.replace('data-invalid-url-rewritten-http="" ', '')
        
        print(html)

        soup = BeautifulSoup(html, 'html.parser')
        for link in soup.findAll('a', attrs={'href': re.compile("^http://")}):
            print("ANCHOR")

        for link in soup.findAll('a', attrs={'href': re.compile("^https://")}):
            print ("ANCHOR HTTPS")


def update_batch_stats(batch_name):
    params = {'token': '3cf697d4387a105d959518bd5b682679',
        'name': batch_name}
    
    r = get('https://api.diffbot.com/v3/bulk', params=params)
    
    tree = json.loads(r.text)
    job = tree["jobs"][0]

    pages_attempted = job["pageProcessAttempts"]
    pages_completed = job["pageProcessSuccesses"]
    print(str(pages_attempted))
    print(str(pages_completed))

    started = job["jobCreationTimeUTC"]
    done = job["jobCompletionTimeUTC"]

    sql = "UPDATE DiffbotBatch SET " + \
        "StartTime = '" + str(datetime.fromtimestamp(started)) + "'" + \
        ", CompletedTime = '" + str(datetime.fromtimestamp(done)) + "'" + \
        ", PagesAttempted = " + str(pages_attempted) + \
        ", PagesCompleted = " + str(pages_completed) + \
        " WHERE Name = '" + batch_name + "'"

    print(sql)
    cmd(sql)
            


update_batch_stats('1_Oleg_Deripaska')        
    
