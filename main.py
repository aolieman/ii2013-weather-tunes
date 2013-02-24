#!/usr/bin/env python
import pymongo
import json

import lastfm_scraper
import wunderground_scraper

from wunderground_scraper import scrape_weather_data, WOUNDERGROUND_DAILY_SUMMARY
from lastfm_scraper import scrape_weekly_charts, scrape_weekly_chart_availability, METRO_WEEKLY_CHARTLIST, METRO_WEEKLY_TRACKCHART

db = pymongo.Connection('localhost', 27017)['internet_information']

last_fm_api_key = '5a1035fcc3d47cc61a59b799eb66e377'
last_fm_locations = [('Spain','Madrid')]

wounderground_api_key = '8838f153d3fee4f8'
wounderground_locations = ['ES/Madrid']
start_date = 1329919273 # TODO: we should use datetime(2009, 11, 22) for readability, we can convert it to the Epoch time in each function
n_days = 2 # TODO: to_date -> same as above

def main():
    # !!! comment scrape call to avoid API limit issue
    print 'Downloading and storing weather data for ', start_date, n_days, wounderground_locations
    scrape_weather_data(db, wounderground_api_key, start_date, n_days, wounderground_locations)

    print 'Downloading and storing last.fm chart availability for ', last_fm_locations
    scrape_weekly_chart_availability(db, last_fm_api_key, last_fm_locations)
    
    print 'Downloading and storing last.fm chart top tracks', last_fm_locations
    scrape_weekly_charts(db, last_fm_api_key, start_date, n_days, last_fm_locations)
    
    # do mongo stuff ... 
    chart_availability = db[METRO_WEEKLY_TRACKCHART].find()
    for c in chart_availability: print c
    
if __name__ == '__main__':
    main()