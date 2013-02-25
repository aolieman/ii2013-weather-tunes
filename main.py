#!/usr/bin/env python
import pymongo
import json

from datetime import datetime

from datetimehelper import to_epoch
import lastfm_scraper
import wunderground_scraper

from scrapers.wunderground_scraper import scrape_weather_data, WOUNDERGROUND_DAILY_SUMMARY
from scrapers.lastfm_scraper import scrape_weekly_charts, METRO_WEEKLY_TRACKCHART

db = pymongo.Connection('localhost', 27017)['internet_information']

last_fm_api_key = '5a1035fcc3d47cc61a59b799eb66e377'
last_fm_locations = [('Spain','Madrid')]

wounderground_api_key = '8838f153d3fee4f8'
wounderground_locations = [('ES', 'Madrid')]

from_date = datetime(2010, 1, 1)
to_date = datetime(2010, 1, 7)

def main():
    # !!! comment scrape call to avoid API limit issue
    print 'Downloading and storing weather data..'
    #scrape_weather_data(db, wounderground_api_key, from_date, to_date, wounderground_locations)
    
    print 'Downloading and storing last.fm chart top tracks..'
    #scrape_weekly_charts(db, last_fm_api_key, from_date, to_date, last_fm_locations)
    
    # do mongo stuff ... 
    charts = db[METRO_WEEKLY_TRACKCHART].find({'cache_index.from_date':{'$gte':to_epoch(datetime(2009, 12, 1))}, 'cache_index.to_date':{'$lte':to_epoch(datetime(2010, 2, 1))}})
    print 'Retrieved %d charts for given date interval. ' % charts.count()
    
if __name__ == '__main__':
    main()