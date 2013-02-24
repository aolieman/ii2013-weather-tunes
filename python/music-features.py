import io, json, urllib2

LASTFM_KEY = '126da10c7b76db388c8537edbac24c6c'
failedlist = []

def track_info(mbid, arso, outfile):
    if mbid != None:
        query = 'http://ws.audioscrobbler.com/2.0/?method=track.getInfo&api_key='\
            + LASTFM_KEY + '&mbid=' + mbid + '&format=json'
    elif arso != None:
        artist = urllib2.quote(arso[0].encode('ascii', 'replace'))
        song = urllib2.quote(arso[1].encode('ascii', 'replace'))
        query = 'http://ws.audioscrobbler.com/2.0/?method=track.getInfo&api_key='\
            + LASTFM_KEY + '&artist=' + artist + '&track=' + song + '&format=json'
    else: print '!! Provide either an mbid or an arso to query'    
    response = json.loads(urllib2.urlopen(query).read())
    result = None
    try:
        result = response['track']
    except KeyError:
        global failedlist
        print '?? No result for', mbid
        print response
        failedlist.append(mbid)
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
    mbidlist = []
    arsolist = []
    jchart = json.load(open(chart))
    for track in jchart['toptracks']['track']:
        if len(track['mbid']) > 1:
            mbidlist.append(track['mbid'])
        else:
            arsolist.append((track['artist']['name'], track['name']))
    return mbidlist, arsolist
    

if __name__ == '__main__' :

    chart = '../json/geochart.json'

    ## execute and save
    outfile = open('../json/trackinfo.json', 'wb')
    trlist, arsolist = get_tracks(chart)
    print '++ Adding tracks by mbid'
    for mbid in trlist:
        track_info(mbid, None, outfile)
    print '++ Adding tracks by arso'
    for arso in arsolist:
        track_info(None, arso, outfile)
    outfile.close()

    print failedlist
