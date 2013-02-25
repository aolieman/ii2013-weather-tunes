import pymongo
from helpers.datetimehelper import *
from scrapers.lastfm_scraper import METRO_WEEKLY_TRACKCHART

# setup db
db = pymongo.Connection('localhost', 27017)['internet_information']

# get and list some charts for a datetime interval
charts = db[METRO_WEEKLY_TRACKCHART].find({'cache_index.from_date':{'$gte':to_epoch(datetime(2009, 12, 1))}, 'cache_index.to_date':{'$lte':to_epoch(datetime(2010, 2, 1))}})    
for chart in charts:
    print 'Chart for location %s of date interval %s to %s' % (chart['cache_index']['metro'], chart['cache_index']['from_date'], chart['cache_index']['to_date'])
    for track in chart['toptracks']['track']:        
        print '#%d for %s - %s listeners = %d' % (int(track['@attr']['rank']), track['artist']['name'], track['name'], int(track['listeners']))