from datetime import datetime, timedelta

def to_epoch(d):
    return int((d - datetime(1970,1,1)).total_seconds())

def get_previous_day_of_week(weekday, date):
    diff_days = weekday - date.isoweekday()
    new_date = date + timedelta(days=diff_days)
    return new_date + timedelta(days=-7)

def get_next_day_of_week(weekday, date):
    diff_days = weekday - date.isoweekday()
    return date + timedelta(days=diff_days)