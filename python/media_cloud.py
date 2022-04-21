from db import cmd, cursor, conn
import csv

from db import cmd, cursor, conn



def read_csv(file_name, media_cloud_batch_id):

    with open(file_name, mode='r', encoding='utf-8', errors='ignore') as file:
        reader = csv.DictReader(file)
        row_num = 0
        for row in reader:
            if row_num == 0:
                row_num += 1
                continue
            
            try:
                cursor.execute("INSERT INTO MediaCloudStory (MediaCloudBatchID, MediaCloudStoriesID, PublishDate, Title, Url, Language, ApSyndicated, MediaID, MediaName, MediaUrl, MediaType, Themes) " + \
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", \
                               media_cloud_batch_id, row["stories_id"], row["publish_date"], row["title"], row["url"], row["language"], \
                               row["ap_syndicated"], row["media_id"], row["media_name"], row["media_url"], row["media_media_type"], row["themes"])
                conn.commit()
                row_num += 1
            except Exception as e:
                print(row_num)
                print("Error " + str(e)) # Ignore duplicate inserts?
                print(type(e))
                print(e.args) 
            
        print(f'Inserted {(row_num-1)} rows into MediaCloudStory.')


#cmd("DELETE FROM MediaCloudStory")
#read_csv(file_name, 'Oleg Deripaska')
