#!/usr/bin/env python
import urllib2
import json
import pymongo
from time import sleep

METRO_WEEKLY_CHARTLIST = 'lastfm_metro_weekly_chartlist'
METRO_WEEKLY_TRACKCHART = 'lastfm_metro_weekly_trackchart'

# TODO, build caching 
def scrape_weekly_chart_availability(db, api_key, locations):
    # otherwise retrieve the items through an API call and store it in mongodb
    for location in locations:
        chart_availability_url = str.format('http://ws.audioscrobbler.com/2.0/?method=geo.getmetroweeklychartlist&metro={0}&api_key={1}&format=json', location[1], api_key)
        chart_availability_data = urllib2.urlopen(chart_availability_url).read()
        db[METRO_WEEKLY_CHARTLIST].insert(json.loads(chart_availability_data))
        sleep(5) # TODO: should be checked    
    
# TODO convert input dates to the dates present in weekly_chart_availability. Pick the closest date.
def scrape_weekly_charts(db, api_key, from_dates, to_dates, locations):
    for location in locations:
        chartlist = db[METRO_WEEKLY_CHARTLIST].find_one() # TODO: should map the from and to date, and location to the fields in mongo        
        dates = (chartlist['weeklychartlist']['chart'][0]['from'], chartlist['weeklychartlist']['chart'][0]['to'])
        
        chart_url = str.format('http://ws.audioscrobbler.com/2.0/?method=geo.getmetrotrackchart&country={0}&metro={1}&start={2}&end={3}&api_key={4}&format=json', location[0], location[1], dates[0], dates[1], api_key)
        chart_data = urllib2.urlopen(chart_url).read()
        db[METRO_WEEKLY_TRACKCHART].insert(json.loads(chart_data))       
        sleep(5) # TODO: should be checked            
    
# TODO
def scrape_played_tracks(api_key, user):
    pass