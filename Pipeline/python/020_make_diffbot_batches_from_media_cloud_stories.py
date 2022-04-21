from db import cmd, cursor, conn, max_id, write_log, write_error
import time


def make_diff_bot_batch(story_id_list):

    # Add DiffBotBatch
    cursor.execute(
        "INSERT INTO DiffBotBatch VALUES (NULL, NULL, 0, 0, '', NULL)")
    conn.commit()

    # Name to be used for DiffBot is ID + "_News"
    diff_bot_batch_id = max_id('DiffBotBatch')
    batch_name = str(diff_bot_batch_id) + "_News"
    cursor.execute("UPDATE DiffBotBatch SET Name = ? WHERE ID = ?", batch_name, diff_bot_batch_id)      
    conn.commit()
    print("020 Added diffBot batch " + batch_name)

    for story_id in story_id_list:
        cursor.execute(
            "UPDATE MediaCloudStory SET DiffBotBatchID = ? WHERE ID = ?", diff_bot_batch_id, story_id)
        conn.commit()



print("020 Make Diff Bot batches")

batch_size = 900
diff_bot_minimum_batch_size = 50

runs = 0
while (1 == 1):
        # Get MediaCloudStories without DiffBOtBatchIDs.  These can be from a mix of apps. The most recent come first
        # Ass many as 50 will not be pciked up because minimum batch size is 50
        cursor.execute("SELECT ID FROM StoryNoDiffBotBatchView ORDER BY PublishDate DESC")
        story_ids = cursor.fetchall()   
        story_id_list = []
        for story_id in story_ids:
                story_id_list.append(story_id.ID)

                if len(story_id_list) == batch_size:
                        make_diff_bot_batch(story_id_list)
                        story_id_list = []

        # Make small batch with leftovers. This could leave some un-batched, but they will be picked up later
        if len(story_id_list) >= diff_bot_minimum_batch_size:
                make_diff_bot_batch(story_id_list)

        time.sleep(30)

        runs += 1
        msg = "020 Make Diffbot batch records Runs = " + str(runs)
        print(msg)

# Never done!
print("DONE")
