from db import cmd, cursor, conn, max_id


def make_diff_bot_batch(story_id_list, app):

    # Add DiffBotBatch
    cursor.execute("INSERT INTO DiffBotBatch VALUES (NULL, NULL, 0, 0, '', NULL)")
    conn.commit()
    
    # Name to be used for DiffBot is ID + app name  
    diff_bot_batch_id = max_id('DiffBotBatch')
    cursor.execute("UPDATE DiffBotBatch SET Name = ? WHERE ID = ?", str(diff_bot_batch_id) + "_" + app, diff_bot_batch_id)
    conn.commit()

    for story_id in story_id_list:
        cursor.execute("UPDATE MediaCloudStory SET DiffBotBatchID = ? WHERE ID = ?", diff_bot_batch_id, story_id)  
        conn.commit()



# Purpose - Make DiffBotBatch records for stories that don't have them  
# Input - 
# Action -  
# Output - 


# "app" SHOULD BE A PARAMETER TO THIS
# PUT THIS IN WHILE LOOP WITH A PAUSE AT THEN END
#app = "fortnite"

batch_size = 1000
diff_bot_minimum_batch_size = 50

cursor.execute("SELECT ShortName FROM App WHERE (ID > 24) AND (ShortName <> 'doug-jones')")
apps = cursor.fetchall()
for app_rec in apps:
        app = app_rec.ShortName 

        cursor.execute("SELECT ID FROM StoryNoDiffBotBatchView WHERE App = ?", app)
        story_ids = cursor.fetchall()
        story_id_list = []
        for story_id in story_ids:
                story_id_list.append(story_id.ID)
    
                if len(story_id_list) == batch_size:
                        make_diff_bot_batch(story_id_list, app)
                        story_id_list = []

        # diffbot requires 5 seconds between batches
        #time.sleep(6)    

        # Make small batch with leftovers. This could leave some un-batched, but they will be picked up later
        if  len(story_id_list) >= diff_bot_minimum_batch_size:  
                make_diff_bot_batch(story_id_list, app)     

print("DONE")    




