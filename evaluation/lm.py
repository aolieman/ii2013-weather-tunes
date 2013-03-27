#!/usr/bin/env python
#from weekly_mf_weekly_wf_model import *
from weekly_mf_daily_wf_model import *
import csv

def predict_linear(coeffs, **kwargs):
    p = coeffs['normal']['intercept']
    p_max = coeffs['max']['intercept']
    p_min = coeffs['min']['intercept']
    for arg in kwargs:
        try:
            p += coeffs['normal'][arg] * kwargs[arg]
            p_max += coeffs['max'][arg] * kwargs[arg]
            p_min += coeffs['min'][arg] * kwargs[arg]
        except KeyError:
            print '?? Coefficient %s not defined in model, omitted %s' % (arg, arg) 
    return p, p_max, p_min

def get_features():
    features = {}
    with open('moscow_ny_sao_paolo_2011_2012_test.csv') as f:
        reader = csv.reader(f)
        reader.next() # skip first row with col names
        
        for row in reader:
            if row[40] == '':
                print 'No mfs for track %s - %s' % (row[31], row[32])
                continue
            
            wf = tuple(row[4:31])            
            mf_artist = row[31]
            mf_title = row[32]
            mf_listeners = int(row[33])
            mf_energy = float(row[38])
            mf_tempo = float(row[40])            
            mf_speech = float(row[41])
            mf_loud = float(row[45])
            mf_dance = float(row[46])
            mf = [mf_artist, mf_title, mf_listeners, mf_energy, mf_tempo, mf_speech, mf_loud, mf_dance]
            
            key = '%s_%s_%s_%s' % (row[0], row[1], row[2], row[3]) # unique identifier: metro + date
            features.setdefault(key, {'metro':row[0], 'wf':wf, 'mf':[]})            
            features[key]['mf'].append(mf)
    return features

def predict_mf_features(features):
    prediction = {}
    for k in features.keys():
        metro = features[k]['metro']
        wf = features[k]['wf']
        hail = int(wf[0])
        snow = int(wf[1])
        thunder = int(wf[2])
        tornado = int(wf[3])
        rain = int(wf[4])
        fog = int(wf[5])
        presh = float(wf[6])
        presl = float(wf[7])
        press = float(wf[8])
        temph = float(wf[9])
        templ =  float(wf[10])
        temp = float(wf[11])
        dewh =  float(wf[12])
        dewl = float(wf[13])
        dew = float(wf[14])
        snowd = 0.0 if wf[15] == '' else float(wf[15])
        vish = 0.0 if wf[16] == '' else float(wf[16])
        visl = 0.0 if wf[17] == '' else float(wf[17])
        vis = 0.0 if wf[18] == '' else float(wf[18])
        windh = float(wf[19])
        windl = float(wf[20])
        wind = float(wf[21])
        humh = float(wf[22])
        huml = float(wf[23])
        hum = 0.0 if wf[24] == '' else float(wf[24])
        precip = 0.0 if wf[25] in ['', 'T'] else float(wf[25])
        snowf = 0.0 if wf[26] in ['', 'T'] else float(wf[26])
        
        print '++ Predicting energy with wfs for', k
        p_energy = predict_linear(energy[metro],hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        print '++ Predicting tempo with wfs for', k
        p_tempo = predict_linear(tempo[metro],hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        print '++ Predicting speechiness with wfs for', k
        p_speech = predict_linear(speech[metro],hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        print '++ Predicting loudness with wfs for', k
        p_loud = predict_linear(loud[metro], hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        print '++ Predicting danceability with wfs for', k
        p_dance = predict_linear(dance[metro], hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        prediction[k] = [p_energy, p_tempo, p_speech, p_loud, p_dance]
    return prediction

def get_mf_distances(features, predictions):
    from scipy.spatial.distance import cosine
    distances = {}
    for k in features.keys():
        mfs = features[k]['mf']
        distances[k] = []
        for mf in mfs:
            listeners = mf[2]            
            v_mf = mf[3:] # energy, tempo, speech, loud, dance
            v_p_mf = [p[0] for p in predictions[k]] # build a list of predictions
            
            track = mf[0] + ' - '  + mf[1]            
            distances[k].append((track, listeners, cosine(v_mf, v_p_mf), v_mf, v_p_mf))
    return distances
    
def print_ranking(metro_date, ranked_by, tracks):
    print '#### chart %s ranked by %s' % (metro_date, ranked_by)
    for i, t in enumerate(tracks):
        print '#%s %s (listeners=%s, cosine=%s), ' % (i+1, t[0], t[1], t[2])

def get_ranking_correlation(n_tracks=100):
    features = get_features()
    predictions = predict_mf_features(features)
    distances = get_mf_distances(features, predictions)
    chart_rs = {}
    for key in distances.keys():
        # distances[key] holds list tuple(track, listeners, distance)
        tracks = distances[key][:n_tracks]
        print '############'
        # sort on listeners and print
        tracks.sort(key=lambda t: t[1], reverse=True)
        print_ranking(key, 'listeners', tracks)        
        distances_ranked_by_listeners = [t[2] for t in tracks]
        
        # sort on sim and print
        tracks.sort(key=lambda t: t[2])    
        print_ranking(key, 'distance', tracks)
        distances_ranked_by_distance = [t[2] for t in tracks]
        
        from scipy.stats import spearmanr
        chart_rs[key] = spearmanr(distances_ranked_by_listeners, distances_ranked_by_distance)
    return chart_rs
    
def print_predictions(metro, **wfs):
    p_energy = predict_linear(energy[metro], **wfs)
    p_tempo = predict_linear(tempo[metro], **wfs)
    p_speech = predict_linear(speech[metro], **wfs)
    p_loud = predict_linear(loud[metro], **wfs)
    p_dance = predict_linear(dance[metro], **wfs)
    
    print '%s=%s' % ('energy', p_energy)
    print '%s=%s' % ('tempo', p_tempo)
    print '%s=%s' % ('speechiness', p_speech)
    print '%s=%s' % ('loudness', p_loud)
    print '%s=%s' % ('dancability', p_dance)
        
if __name__ == '__main__':
    # demo 1 radio dj
    #print_predictions('New York', hail=0, snow=0, thunder=0, tornado=0,rain=0, fog=0, presh=1021, presl=1019, press=1020, temph=28, templ=20, temp=24, dewh=18, dewl=13, dew=16, snowd=0, vish=16, visl=13, vis=16, windh=14, windl=0, wind=3, humh=87, huml=45, hum=0, precip=0, snowf=0)
    # demo 2 ranking/evaluation    
    rs = get_ranking_correlation(n_tracks=25)
    print rs
    