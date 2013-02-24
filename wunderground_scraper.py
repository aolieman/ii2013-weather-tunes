#!/usr/bin/env python
import urllib2
import json
from datetime import datetime, timedelta, date, time
from time import time, sleep

WOUNDERGROUND_DAILY_SUMMARY = 'wounderground_daily_summary'

def scrape_weather_data(db, api_key, from_date, n_days, locations):		
	d = date.fromtimestamp(from_date) #convert POSIX to YYYY-MM-DD
	for n in range(n_days):
		for location in locations:
			d_clean = d.strftime("%Y%m%d") #convert to YYYYMMDD
			url = 'http://api.wunderground.com/api/%s/history_%s/q/%s.json' % (api_key, d_clean, location)
			result = urllib2.urlopen(url).read()            
			db[WOUNDERGROUND_DAILY_SUMMARY].insert(json.loads(result))
			sleep(6) # laat het programma 6 seconden slapen zodat de API limiet van Wunderground niet wordt overschreden
		d = d+timedelta(days=1)