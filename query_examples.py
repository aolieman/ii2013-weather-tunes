import pymongo
from helpers.datetimehelper import *
from scrapers.lastfm_scraper import METRO_WEEKLY_TRACKCHART
from scrapers.wunderground_scraper import WOUNDERGROUND_DAILY_SUMMARY

import time
import datetime
import random

def date_to_timestamp(d) :
  return int(time.mktime(d.timetuple()))

def randomDate(start, end):
  stime = date_to_timestamp(start)
  etime = date_to_timestamp(end)
  ptime = stime + random.random() * (etime - stime)
  return datetime.date.fromtimestamp(ptime)

def get_random_days(start, end):
    days = (end - start).days
    n_test_days = int(days * 0.2)
    test_days = []

    while len(test_days) < n_test_days:
        rand_day = randomDate(start, end)
        if rand_day not in test_days:
            test_days.append(rand_day)

    return test_days

start = datetime.date(2010, 1, 3)
end = datetime.date(2013, 1, 5)
random_days = get_random_days(start, end)

# setup db
db = pymongo.Connection('localhost', 27017)['internet_information']

# get and list some charts for a datetime interval
charts = db[METRO_WEEKLY_TRACKCHART].find()
chart_list = [c for c in charts]
for chart in chart_list:
    metro = chart['cache_index']['metro']                      
    from_date = chart['cache_index']['from_date']
    to_date =  chart['cache_index']['to_date']
    weather = db[WOUNDERGROUND_DAILY_SUMMARY].find({'cache_index.metro':metro, 'cache_index.date':{'$gte':from_date, '$lte':to_date}})
    weather_list = [w for w in weather]
    try:
        tracks = chart['toptracks']['track']
    except KeyError:
        print '?? No tracks found in chart, skipping.'
    else:
        for track in chart['toptracks']['track']:
            artist = track['artist']['name']
            title = track['name']
            rank = track['@attr']['rank']
            
            track_features = db['lastfm_music_features'].find_one({'track.artist.name':artist, 'track.name':title}, {'track':1})
            if track_features == None:
                continue            
            listeners = int(track['listeners'])
            
            for w in weather_list[1:]: # mon - sunday
                try:
                    date = w['history']['utcdate']
                    summary = w['history']['dailysummary'][0]
                    
                    mongo_features = 'features_train'
                    d = datetime.date(int(date['year']), int(date['mon']), int(date['mday']))
                    if d in random_days:
                        mongo_features = 'features_test'
                    
                    features = {}
                    features['metro'] = metro
                    features['day'] = int(date['mday'])
                    features['month'] = int(date['mon'])
                    features['year'] = int(date['year'])                    
                    features['music'] = {}
                    features['music']['listeners'] = listeners
                    features['music']['title'] = title
                    features['music']['artist'] = track_features['track']['artist']                    
                    features['music']['features'] = track_features['track']                    
                    features['weather'] = summary                    
                    db[mongo_features].insert(features)                    
                    print u'Succesfully merged features for weather on %s-%s-%s (%s) and track #%s %s - %s' % (date['mday'], date['mon'], date['year'], metro, rank, artist, title)
                except KeyError:                    
                    print u'?? Error merging features for %s - %s' % (artist, title)
                except UnicodeEncodeError:
                    print 'Error printing..'
        