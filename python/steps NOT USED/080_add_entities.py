from datetime import datetime
import time
import json
from requests import get, post

from db import cmd, cursor, conn


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

# Just get all the batches!!
cursor.execute("SELECT ID, Name FROM DiffBotBatch WHERE FindEntitiesDate IS NULL AND Name <> 'NONE'")
batch_rows = cursor.fetchall()
for batch in batch_rows:
    batch_id = batch.ID
    batch_name = batch.Name
    
    # Get the stories for the batch
    try:
        payload = {'token': '3cf697d4387a105d959518bd5b682679', 'name': batch_name, 'format': 'json'}
        r = get('https://api.diffbot.com/v3/bulk/data', params=payload)
    except Exception as e:
        print('Error getting  ' + batch_name)
        print(e)
    
    json_obj = json.loads(r.text)
    for story in json_obj:
        try:
            add_entities_for_story(story)
        except Exception as e:
            print(str(e))

    cmd("UPDATE DiffBotBatch SET FindEntitiesDate = GetDate() WHERE ID = '" + str(batch_id) + "'")

print("DONE")    
