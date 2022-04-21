import pyodbc

conn = pyodbc.connect(
    r'DRIVER={SQL Server Native Client 11.0};'
    #r'SERVER=SCOTT-PC\SQLExpress;'
    # r'SERVER=PC\SQLExpress;'

    r'SERVER=DESKTOP-S1K43CL\SQLEXPRESS;'

    # r'DATABASE=RussiaNews;'
    #r'DATABASE=Senate_2019_04_25;'
    #r'DATABASE=lincoln_project;'
    r'DATABASE=TheUnion;'
    r'Trusted_Connection=yes;'
)
cursor = conn.cursor()

# r'DRIVER={SQQL Server Native Client 11.0};'
# r'SERVER=SCOTT-PC\SQLExpress;'


def cmd(sql):
    try:
        cursor.execute(sql)
        conn.commit()
    except Exception as e:
        write_log(sql)
        print(sql)
        str(e)   


def max_id(table):
    cursor.execute("SELECT MAX(ID) FROM " + table)
    rows = cursor.fetchall()
    return rows[0][0]


def write_error(step, id, message):
    #print("Writing Error")
    cursor.execute("INSERT INTO PipelineError VALUES (?, ?, ?, GetDate(), '')", step, id, message)
    conn.commit   


def write_log(message):
    print("Writing Log")
    cursor.execute("INSERT INTO PythonLog VALUES (?, GetDate())", message)
    conn.commit   
             


# Query
#
# cursor.execute('SELECT TOP 50 Link FROM GoodStoriesView')
# rows = cursor.fetchall()
# for row in rows:
#    urls.append(row.Link)

# Command
#
# cursor = conn.cursor()
# cursor.execute("DELETE FROM StoryLink")
# conn.commit();
