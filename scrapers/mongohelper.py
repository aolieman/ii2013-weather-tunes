import json
def append_mongo_index(json, name='cache_index', **kwargs):
    d = {}
    for a in kwargs:
        d[a] = kwargs[a]
    json[name] = d
    return json