import io, json, urllib2, time
import apikeys
from pyechonest import config, song, util
import pymongo
from pymongo import MongoClient

connection = MongoClient()
db = connection.internet_information
collection = db.lastfm_music_features
trackchart_coll = db.lastfm_metro_weekly_trackchart

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
    sartist = translate_artist(tracktuple[1]).encode('utf-8')
    stitle = tracktuple[2].encode('utf-8')

    while True:
        try:
            response = song.search(artist=sartist, title=stitle, results=1, \
                                   buckets=['id:musixmatch-WW',\
                                            'audio_summary',\
                                            'song_hotttnesss',\
                                            'song_type',\
                                            'artist_familiarity',\
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
        trinfo['track']['song_type'] = s.song_type
        try:
            trinfo['track']['id']['musixmatch'] = str(s.get_foreign_id('musixmatch-WW')).replace('musixmatch-WW:', '')
        except util.EchoNestAPIError:
            time.sleep(5)
        try:
            trinfo['track']['artist']['familiarity'] = s.artist_familiarity
        except KeyError: pass
        try:
            trinfo['track']['artist']['location'] = s.artist_location
        except KeyError: pass
    return trinfo

def get_tracks(from_date, to_date, metro):
    tracklist = []
cursor = list(collection.find({'cache_index.from_date': { "$gte": from_date}, 'cache_index.to_date': {"$lte": to_date}, 'cache_index.metro': metro}))
    
    for doc in charts:
        for track in doc['toptracks']['track']:
            tracklist.append((track['mbid'], track['artist']['name'], track['name']))
    
    #TODO: write tracklist to file
    tracklist = set(tracklist)
    tracklist = list(tracklist)
    return tracklist

def translate_artist(string):
    artist_translations = {\
        'Alt-J': 'ALTJ',
        'examplestring': 'substitution'}
    keylist = artist_translations.keys()
    if string in keylist:
        string = artist_translations[string]
    return string

if __name__ == '__main__' :

    
    start_date = 1262476800
    end_date = 1263081600
    metro = 'Madrid'
    trlist = get_tracks(start_date, end_date, metro)
    print '++ Adding tracks from tracklist'
    #infolist = []
    for tracktuple in trlist:
        #Checks to see if the combination of track title and artist name already exist. 
        #Only returns the musicbrainz ID to make it not return the whole document.
        cache = collection.find_one({'track.name' : tracktuple[2], 'track.artist.name' : tracktuple[1]}, {'track.id.musicbrainz' : '1'})
        if cache != None:
                print 'Feature data of track %s by %s already in cache' % (tracktuple[2], tracktuple[1])
                continue
        trinfo = track_info(tracktuple)
        collection.insert(trinfo)
        #infolist.append(trinfo)

    #track_features = {"trackfeatures": infolist}
    if len(lastfm_failed) == 0 and len(echonest_failed) == 0:
        print '!! Everything succeeded'
    else:
        print 'Last.fm failed', len(lastfm_failed), ':', lastfm_failed
        print 'Echonest failed', len(echonest_failed), ':', echonest_failed
