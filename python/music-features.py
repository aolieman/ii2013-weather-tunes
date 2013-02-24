import io, json, urllib2

LASTFM_KEY = '126da10c7b76db388c8537edbac24c6c'
failedlist = []

def track_info(tracktuple, outfile):
    if tracktuple[0] != '':
        mbid = '&mbid=' + tracktuple[0]
    else: mbid = ''
    artist = urllib2.quote(tracktuple[1].encode('utf-8'))
    songtitle = urllib2.quote(tracktuple[2].encode('utf-8'))
    query = 'http://ws.audioscrobbler.com/2.0/?method=track.getInfo&api_key='\
        + LASTFM_KEY + mbid + '&artist=' + artist + '&track='\
        + songtitle + '&format=json'
    response = json.loads(urllib2.urlopen(query).read())
    result = None
    try:
        result = response['track']
    except KeyError:
        global failedlist
        print '?? No result for', tracktuple
        print '   ', response
        failedlist.append(tracktuple)
    if result != None:
        trinfo = {}
        trinfo['track'] = {}
        trinfo['track']['name'] = response['track']['name']
        try:
            album_response = response['track']['album']
            trinfo['track']['album'] = {}
            trinfo['track']['album']['title'] = album_response['title']
            trinfo['track']['album']['url'] = album_response['url']
            trinfo['track']['album']['artist'] = album_response['artist']
            trinfo['track']['album']['mbid'] = album_response['mbid']
        except KeyError:
            print '?? No album for', trinfo['track']['name']
        trinfo['track']['artist'] = response['track']['artist']
        trinfo['track']['toptags'] = response['track']['toptags']
        trinfo['track']['mbid'] = response['track']['mbid']
        trinfo['track']['duration'] = response['track']['duration']
        json.dump(trinfo, outfile, indent=4, separators=(',', ': '))
        outfile.write(',\n')
        print trinfo['track']['name'], 'succesfully appended'

def get_tracks(chart):
    tracklist = []
    jchart = json.load(open(chart))
    for track in jchart['toptracks']['track']:
        tracklist.append((track['mbid'], track['artist']['name'], track['name']))
    return tracklist
    

if __name__ == '__main__' :

    chart = '../json/geochart_ams.json'

    ## execute and save
    outfile = open('../json/trackinfo_ams.json', 'wb')
    trlist = get_tracks(chart)
    print '++ Adding tracks by from tracklist'
    for tracktuple in trlist:
        track_info(tracktuple, outfile)
    outfile.close()

    if len(failedlist) == 0:
        print '!! Everything succeeded'
    else: print failedlist
