import mediacloud.api

mc = mediacloud.api.MediaCloud('ed8ada55ff11950787b7d61e7d4d04087eb4100f9954dc085fd15fb5892694b8')

print("before")
#https://github.com/mitmedialab/MediaCloud-API-Client/blob/master/mediacloud/api.py
# ~line 150


media = mc.mediaList(rows=200)
print(str(len(media)))
print(media[0])


print("after")
input("Press Enter to continue...")
    


# media = []
# last_media_id = 0
# rows  = 1000
# while True:
#     params = { 'last_media_id': last_media_id, 'rows': rows, 'key': MY_KEY }
#     print "last_media_id:{} rows:{}".format( last_media_id, rows)
#     r = requests.get( 'https://api.mediacloud.org/api/v2/media/list', params = params, headers = { 'Accept': 'application/json'} )
#     data = r.json()

#     if len(data) == 0:
#         break

#     last_media_id = data[-1]['media_id']
#     media.extend( data )

# fieldnames = [
#     u'media_id',
#     u'url',
#     u'name'
# ]

# with open( '/tmp/media.csv', 'wb') as csvfile:
#     print "open"
#     cwriter = csv.DictWriter( csvfile, fieldnames, extrasaction='ignore')
#     cwriter.writeheader()
#     cwriter.writerows( media )