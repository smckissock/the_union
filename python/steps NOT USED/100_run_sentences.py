import nltk
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
from string import punctuation
import sys

from db import cmd, cursor, conn, write_error


def import_story(id, body):
    try:
        sentences = sent_tokenize(body)
        for sentence in sentences:
                cursor.execute("INSERT INTO Sentence VALUES (?, ?, GetDate())", id, sentence)
                conn.commit()
    except Exception as e:
        write_error("run_sentences", id, str(e))
        return None


# Don't need this at the moment..        
# stops = set(stopwords.words('english') + list(punctuation))
# allwords = word_tokenize(body)
# goodwords = [word for word in allwords if word not in stops]
# setwords = list(set(goodwords))
# cursor.execute("UPDATE Story SET AllWords = ? WHERE ID = ?", " ".join(setwords).lower(), id)
# conn.commit()

cursor.execute("SELECT ID, Text FROM DiffBotStory WHERE ID NOT IN (SELECT DISTINCT DiffBotStoryID FROM Sentence) ORDER BY ID ")
stories = cursor.fetchall()
for story in stories:
        import_story(story.ID, story.Text)
    
print("DONE with sentences")

