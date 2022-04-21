from db import cmd, cursor, conn


def delete_links():
    cmd("DELETE FROM DiffBotLink")

def add_page_url_links():
    cmd("INSERT INTO DiffBotLink " + \
        "SELECT DISTINCT l.DiffBotStoryID, s.ID " + \
        "FROM DiffBotStoryLink l " + \
        "JOIN DiffBotStory s ON l.Link = s.PageUrl"
    )

def add_resolved_page_url_links():
    cmd("INSERT INTO DiffBotLink " + \
        "SELECT DISTINCT l.DiffBotStoryID, s.ID " + \
        "FROM DiffBotStoryLink l " + \
        "JOIN DiffBotStory s ON l.Link = s.ResolvedPageUrl " + \
        "AND s.PageUrl <> s.ResolvedPageUrl " + \
        "AND CONVERT(varchar(20), l.DiffBotStoryID) + '_' +  CONVERT(varchar(20), s.ID) NOT IN " + \
	    "(SELECT CONVERT(varchar(20), FromID) + '_' +  CONVERT(varchar(20), ToID)  FROM DiffBotLink)"
    )


# Not Great - just deletes old DiffBotLink reocrds and makes new ones. Probably at least needs to be App-specific somehow
delete_links()
add_page_url_links()
add_resolved_page_url_links()  

print("DONE")