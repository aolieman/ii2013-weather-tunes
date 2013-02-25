#!/usr/bin/env python
import urllib2
import json
import pymongo
import datetime
from datetime import timedelta, datetime
from time import sleep
from helpers.mongohelper import append_mongo_index
from helpers.datetimehelper import *

METRO_WEEKLY_TRACKCHART = 'lastfm_metro_weekly_trackchart'
    
# TODO convert input dates to the dates present in weekly_chart_availability. Pick the closest date.
def scrape_weekly_charts(db, api_key, from_date, to_date, locations):    
    for location in locations:        
        # generate a list with all sundays between the two incoming days
        start = get_previous_day_of_week(7, from_date)
        end = get_next_day_of_week(7, to_date)
        dates = [start+timedelta(days=w*7) for w in range(0, ((end - start).days/7)+1)]
        
        # walk with steps of 2 weeks through the list and obtain the chartlist
        for d_index in range(0, len(dates)-1):
            from_date = dates[d_index]
            to_date = dates[d_index + 1]
            
            # check mongo if mongo_index is present for parameters
            cache = db[METRO_WEEKLY_TRACKCHART].find_one({'cache_index' : {'metro' : location[1], 'from_date' : to_epoch(from_date), 'to_date' : to_epoch(to_date)}})
            # if true, no need to download
            if cache != None:            
                print 'Weekly chart of %s already in cache for %s to %s' % (location[1], from_date, to_date)
                continue
                
            chart_url = str.format('http://ws.audioscrobbler.com/2.0/?method=geo.getmetrotrackchart&country={0}&metro={1}&start={2}&end={3}&api_key={4}&format=json', location[0], location[1], from_parameter, to_parameter, api_key)
            chart_data = urllib2.urlopen(chart_url).read()
            chart = append_mongo_index(json.loads(chart_data), metro=location[1], from_date=to_epoch(from_date), to_date=to_epoch(to_date))
            db[METRO_WEEKLY_TRACKCHART].insert(chart)
            print 'Succesfully written chart for metro %s and date interval %s to %s' % (location[1], from_date, to_date)
            sleep(0.25) # can make 4 calls every 4 seconds          
    
# TODO
def scrape_played_tracks(api_key, user):
    pass