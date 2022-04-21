from datetime import datetime
import time
import json
from requests import get, post

from db import cmd, cursor, conn, write_log


def add_entities_for_story(story):
    url = story['pageUrl']
    resolved_url = story.get('resolvedPageUrl', url)

    if 'tags' in story:
        for tag in story["tags"]:
            score = tag["score"]
            label = tag["label"]
            count = tag["count"]
            sentiment = tag["sentiment"]
            if 'rdfTypes' in tag:
                rdf_types = ','.join(tag['rdfTypes'])
        
                try:
                    cursor.execute("INSERT INTO DiffBotTag VALUES (?, ?, ?, ?, ?, ?, GetDate(), ?)", \
                        resolved_url, label, tag['uri'], score, count, rdf_types, sentiment)
                    conn.commit()
                except Exception as e:
                    print('Error Saving story tags: ' + resolved_url)
                    print("Error " + str(e)) # Ignore duplicate inserts?    

print("080 Add Entities")

runs = 0
while (1 == 1):
    cursor.execute("SELECT ID, Name FROM DiffBotBatch WHERE (CompletedTime IS NOT NULL) AND (FindEntitiesDate IS NULL) AND (Name <> 'NONE')")
    batch_rows = cursor.fetchall()
    for batch in batch_rows:
        batch_id = batch.ID
        batch_name = batch.Name
    
        # Get the stories for the batch
        try:
            print("Starting " + batch_name)
            payload = {'token': '3cf697d4387a105d959518bd5b682679', 'name': batch_name, 'format': 'json'}
            r = get('https://api.diffbot.com/v3/bulk/data', params=payload)
            print("Got Batch " + batch_name)
        except Exception as e:
            write_log("080 " + str(e))
            print('Error getting  ' + batch_name)
            print(e)
    
        print("Before json for " + batch_name)
        json_obj = json.loads(r.text)
        print("After json for " + batch_name)
        for story in json_obj:
            try:
                print("Adding Records for " + batch_name)
                add_entities_for_story(story)
            except Exception as e:
                print(str(e))

        print ("Downloaded terms for " + batch_name)    
        cmd("UPDATE DiffBotBatch SET FindEntitiesDate = GetDate() WHERE ID = '" + str(batch_id) + "'")

    time.sleep(30)
    runs += 1
    msg = "080 Download Diffbot entities " + str(runs)
    print(msg)

# !!
print("DONE")    
