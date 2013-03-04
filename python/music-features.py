import io, json, urllib2, time
import apikeys
from pyechonest import config, song, util

LASTFM_KEY = apikeys.alex_lastfm
config.ECHO_NEST_API_KEY = apikeys.alex_echonest
lastfm_failed = []
echonest_failed = []

def track_info(tracktuple):
    trinfo = {}
    trinfo['track'] = {}
    trinfo['track']['id'] = {}

    lastinfo = lastfm_info(tracktuple, trinfo)
    echoinfo = echonest_info(tracktuple, lastinfo)
    
    trinfo = echoinfo
    return trinfo

def lastfm_info(tracktuple, trinfo):
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
        global lastfm_failed
        print '?? No result for', tracktuple, 'on last.fm'
        print '   ', response
        lastfm_failed.append(tracktuple)
    if result != None:
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
        trinfo['track']['id']['musicbrainz'] = response['track']['mbid']
        trinfo['track']['duration'] = response['track']['duration']
        print trinfo['track']['name'], 'succesfully appended'
    return trinfo

def echonest_info(tracktuple, trinfo):
    sartist = str(tracktuple[1])
    stitle = str(tracktuple[2])

    while True:
        try:
            response = song.search(artist=sartist, title=stitle, results=1, \
                                   buckets=['id:musixmatch-WW',\
                                            'audio_summary',\
                                            'song_hotttnesss',\
                                            'artist_location'])
            time.sleep(1)
            break
        except util.EchoNestAPIError:
            time.sleep(15) # the Echonest call limit is variable
 
    if len(response) == 0:
        global echonest_failed
        print '?? No result for', tracktuple, 'on echonest'
        echonest_failed.append(tracktuple)
    else:
        s = response[0]
        trinfo['track']['id']['echonest'] = s.id
        trinfo['track']['audiosummary'] = s.audio_summary
        trinfo['track']['hotttnesss'] = s.song_hotttnesss
        try:
            trinfo['track']['id']['musixmatch'] = s.get_foreign_id('musixmatch-WW')
        except util.EchoNestAPIError:
            time.sleep(5)
        try:
            trinfo['track']['artist']['familiarity'] = s.artist_familiarity
        except KeyError: pass
        try:
            trinfo['track']['artist']['location'] = s.artist_location
        except KeyError: pass
    return trinfo

def get_tracks(chart):
    tracklist = []
    jchart = json.load(open(chart))
    for track in jchart['toptracks']['track']:
        tracklist.append((track['mbid'], track['artist']['name'], track['name']))
    return tracklist
    

if __name__ == '__main__' :

    chart = '../json/geochart_nyc.json'

    ## execute and save
    outfile = open('../json/trackinfo_nyc.json', 'wb')
    trlist = get_tracks(chart)
    print '++ Adding tracks from tracklist'
    infolist = []
    for tracktuple in trlist:
        trinfo = track_info(tracktuple)
        infolist.append(trinfo)
    track_features = {"trackfeatures": infolist}
    json.dump(track_features, outfile, indent=4, separators=(',', ': '))
    outfile.close()

    if len(lastfm_failed) == 0 and len(echonest_failed) == 0:
        print '!! Everything succeeded'
    else:
        print 'Last.fm failed', len(lastfm_failed), ':', lastfm_failed
        print 'Echonest failed', len(echonest_failed), ':', echonest_failed
