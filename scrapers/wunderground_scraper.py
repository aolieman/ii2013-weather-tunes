#!/usr/bin/env python
import urllib2
import json
from datetime import datetime, timedelta, date, time
from time import time, sleep
from helpers.datetimehelper import *
from helpers.mongohelper import *

WOUNDERGROUND_DAILY_SUMMARY = 'wounderground_daily_summary'

def scrape_weather_data(db, api_key, from_date, to_date, locations):
    # generate a list of days from the previous to next sundays to of the incoming dates respectively
    start = get_previous_day_of_week(7, from_date) # will be previous sunday (7) from the from_date
    end = get_next_day_of_week(7, to_date)
    dates = [start+timedelta(days=d) for d in range(1, (end - start).days)]
    for location in locations:
	for date in dates:
	    # check mongo if mongo_index is present for parameters
            cache = db[WOUNDERGROUND_DAILY_SUMMARY].find_one({'cache_index' : {'metro' : location[1], 'date' : to_epoch(date)}})
            # if true, no need to download
            if cache != None:            
                print 'Weather data of location %s of %s already in cache' % (location[1], date)
                continue
	    
	    d_clean = date.strftime("%Y%m%d") #convert to YYYYMMDD
	    url = 'http://api.wunderground.com/api/%s/history_%s/q/%s/%s.json' % (api_key, d_clean, location[0], location[1])
	    result = urllib2.urlopen(url).read()
	    weather = append_mongo_index(json.loads(result), date=to_epoch(date), metro=location[1])
	    db[WOUNDERGROUND_DAILY_SUMMARY].insert(weather)
	    print 'Succesfully written weather for location %s on %s' % (location[1], date)
	    sleep(6) # laat het programma 6 seconden slapen zodat de API limiet van Wunderground niet wordt overschreden