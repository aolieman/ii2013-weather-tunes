#!/usr/bin/env python
from __future__ import division
import csv, os, gc
from scipy.spatial.distance import cosine
from scipy.spatial.distance import cityblock
from scipy.stats import spearmanr

# model to load
model_type = 'daily'

# simple translate dictionary for R's daily model weather feature prefixes
metro_translate = {'Moscow':'mos','New York':'nyc','Sao Paulo':'sao'}

# naive R model initialization
dance = {}
energy = {}
loud = {}
speech = {}
tempo = {}

import rpy2.robjects as robjects
r = robjects.r
predict = r['predict']
ListVector = robjects.vectors.ListVector

def init_r(model_type):
    py_path = '/'.join(s for s in os.path.realpath(__file__).split('\\')[:-1])
    r_model_path = py_path + '/models/' + model_type
    
    if not os.path.exists(r_model_path):
        print 'Model directory does not exist.'
        return
    
    try:
        r.setwd(r_model_path)
    except Exception:
        print "Models for %s not defined yet." % model_type
        return
    
    global dance, energy, loud, speech, tempo
    
    r.load("sao_paulo/dancability_min.saved")
    dance['Sao Paulo'] = r['dancability_min']
    r.rm('dancability_min')
    gc.collect()
    r.gc()
    
    r.load("sao_paulo/energy_min.saved")
    energy['Sao Paulo'] = r['energy_min']
    r.rm('energy_min')
    gc.collect()
    r.gc()
        
    r.load("sao_paulo/loudness_min.saved")
    loud['Sao Paulo'] = r['loudness_min']
    r.rm('loudness_min')
    gc.collect()
    r.gc()
    
    r.load("sao_paulo/speech_min.saved")
    speech['Sao Paulo'] = r['speech_min']
    r.rm('speech_min')
    gc.collect()
    r.gc()
    
    r.load("sao_paulo/tempo_min.saved")
    tempo['Sao Paulo'] = r['tempo_min']
    r.rm('tempo_min')
    gc.collect()
    r.gc()
    
    r.load("moscow/dancability_min.saved")
    dance['Moscow'] = r['dancability_min']
    r.rm('dancability_min')
    gc.collect()
    r.gc()
    
    r.load("moscow/energy_min.saved")
    energy['Moscow'] = r['energy_min']
    r.rm('energy_min')
    gc.collect()
    r.gc()
    
    r.load("moscow/loudness_min.saved")
    loud['Moscow'] = r['loudness_min']
    r.rm('loudness_min')
    gc.collect()
    r.gc()    
    
    r.load("moscow/speech_min.saved")
    speech['Moscow'] = r['speech_min']
    r.rm('speech_min')
    gc.collect()    
    r.gc()    

    r.load("moscow/tempo_min.saved")
    tempo['Moscow'] = r['tempo_min']
    r.rm('tempo_min')
    gc.collect()    
    r.gc()
    
    r.load("new_york/dancability_min.saved")
    dance['New York'] = r['dancability_min']
    r.rm('dancability_min')
    gc.collect()    
    r.gc()
    
    r.load("new_york/energy_min.saved")
    energy['New York'] = r['energy_min']
    r.rm('energy_min')
    gc.collect()    
    r.gc()
    
    r.load("new_york/loudness_min.saved")
    loud['New York'] = r['loudness_min']
    r.rm('loudness_min')
    gc.collect()    
    r.gc()
    
    r.load("new_york/speech_min.saved")
    speech['New York'] = r['speech_min']
    r.rm('speech_min')
    gc.collect()    
    r.gc()
    
    r.load("new_york/tempo_min.saved")
    tempo['New York'] = r['tempo_min']
    r.rm('tempo_min')
    gc.collect()    
    r.gc()
    
    print "All R models loaded" 

def predict_r(model, model_type, metro, **wfs):
    # workaround for metro prefixes (mos, sao, nyc) in daily models
    if model_type == 'daily':        
        for k_wf in wfs.keys():
            k_wf_new = metro_translate[metro] + '.' + k_wf
            wfs[k_wf_new] = wfs[k_wf]
            del wfs[k_wf]
            
    wf_dict = ListVector(wfs)
    pred = predict(model, wf_dict, interval="predict")
    p_fit = pred[0]
    p_lwr = pred[1]
    p_upr = pred[2]
    return p_fit, p_upr, p_lwr

def get_features():
    features = {}
    with open('C:\Users\michael\Documents\GitHub\ii2013-weather-tunes\evaluation\moscow_ny_sao_paolo_2011_2012_test.csv') as f:
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
        precip = 1.0 if wf[25] in ['', 'T'] else float(wf[25])
        snowf = 1.0 if wf[26] in ['', 'T'] else float(wf[26])
        
        print '++ Predicting energy with wfs for', k
        p_energy = predict_r(energy[metro], model_type, metro, hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        print '++ Predicting tempo with wfs for', k
        p_tempo = predict_r(tempo[metro], model_type, metro, hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        print '++ Predicting speechiness with wfs for', k
        p_speech = predict_r(speech[metro], model_type, metro, hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        print '++ Predicting loudness with wfs for', k
        p_loud = predict_r(loud[metro], model_type, metro, hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        print '++ Predicting danceability with wfs for', k
        p_dance = predict_r(dance[metro], model_type, metro, hail=hail, snow=snow, thunder=thunder,tornado=tornado,rain=rain, fog=fog, presh=presh, presl=presl, press=press, temph=temph, templ=templ, temp=temp, dewh=dewh, dewl=dewl, dew=dew, snowd=snowd, vish=vish, visl=visl, vis=vis,
    windh=windh, windl=windl, wind=wind, humh=humh, huml=huml, hum=hum, precip=precip, snowf=snowf)
    
        prediction[k] = [p_energy, p_tempo, p_speech, p_loud, p_dance]
    return prediction

def get_mf_distances(features, predictions):
    distances = {}
    for k in features.keys():
        mfs = features[k]['mf']
        distances[k] = []
        for mf in mfs:
            listeners = mf[2]            
            v_mf = mf[3:] # energy, tempo, speech, loud, dance
            v_p_mf = [p[0] for p in predictions[k]] # build a list of standard prediction
            
            track = mf[0] + ' - '  + mf[1]            
            distances[k].append((track, listeners, cosine(v_mf, v_p_mf), cityblock(v_mf, v_p_mf)))
    return distances
    
def print_ranking(metro_date, ranked_by, tracks):
    print '#### chart %s ranked by %s' % (metro_date, ranked_by)
    for i, t in enumerate(tracks):
        print '#%s %s (%s, %s, %s)' % (i+1, t[0], t[1], t[2], t[3])

def get_ranking():
    features = get_features()
    predictions = predict_mf_features(features)
    distances = get_mf_distances(features, predictions)

    chart_count = {'mos': 0, 'sao': 0, 'nyc': 0}
    significant_cosine = []
    significant_cityblock = []
    
    for key in distances.keys():
        # distances[key] holds list tuple(track, listeners, cosine, cityblock)
        tracks = distances[key][:200]
        print '############'
        # sort on listeners and print
        tracks.sort(key=lambda t: t[1], reverse=True)
        print_ranking(key, 'listeners', tracks)        
        distances_ranked_by_listeners = [t[2] for t in tracks]
        
        # sort on cosine and print
        tracks.sort(key=lambda t: t[2])    
        print_ranking(key, 'cosine', tracks)
        distances_ranked_by_cosine = [t[2] for t in tracks]

        # sort on cityblock and print
        tracks.sort(key=lambda t: t[3])    
        print_ranking(key, 'cityblock', tracks)
        distances_ranked_by_cityblock = [t[2] for t in tracks]

        spearmanr_cosine = spearmanr(distances_ranked_by_listeners, distances_ranked_by_cosine)
        spearmanr_cityblock = spearmanr(distances_ranked_by_listeners, distances_ranked_by_cityblock)
        
        print '### Spearman\'s (rho, sig) for cosine:', spearmanr_cosine
        print '### Spearman\'s (rho, sig) for cityblock:', spearmanr_cityblock

        if 'Moscow' in key: chart_count['mos'] += 1
        if 'Sao' in key: chart_count['sao'] += 1
        if 'New' in key: chart_count['nyc'] += 1
        # append significant rankings to lists
        if spearmanr_cosine[1] <= 0.05: significant_cosine.append((key, spearmanr_cosine))
        if spearmanr_cityblock[1] <= 0.05: significant_cityblock.append((key, spearmanr_cityblock))

    return chart_count, significant_cosine, significant_cityblock

def print_prediction(p, name):
    print '%s > %s < %s (%s=%s)' % (p[2], name, p[1], name, p[0])
    
def print_predictions(metro, **wfs):
    print '++ Predicting energy with wfs', wfs
    p_energy = predict_r(energy[metro], model_type, metro, **wfs)
    
    print '++ Predicting tempo with wfs', wfs
    p_tempo = predict_r(tempo[metro],  model_type, metro, **wfs)
    
    print '++ Predicting speechiness with wfs', wfs
    p_speech = predict_r(speech[metro], model_type, metro, **wfs)
    
    print '++ Predicting loudness with wfs', wfs
    p_loud = predict_r(loud[metro], model_type, metro, **wfs)
    
    print '++ Predicting danceability with wfs', wfs
    p_dance = predict_r(dance[metro], model_type, metro, **wfs)
    
    print_prediction(p_energy, 'energy')
    print_prediction(p_tempo, 'tempo')
    print_prediction(p_speech, 'speechiness')
    print_prediction(p_loud, 'loudness')
    print_prediction(p_dance, 'dancability')
        
if __name__ == '__main__':
    # demo 1 radio dj
    #print_predictions('New York', hail=0, snow=1, thunder=0, tornado=0,rain=1, fog=1, presh=1032, presl=1017, press=1025.8, temph=-6, templ=-10, temp=-8, dewh=-8, dewl=-12, dew=-10, snowd=3, vish=10, visl=3, vis=8.6, windh=25, windl=0, wind=15, humh=93, huml=74, hum=86, precip=5, snowf=0)
    # demo 2 ranking/evaluation
    init_r(model_type)
    chart_count, significant_cosine, significant_cityblock = get_ranking()

    print "\n\n", chart_count, "charts in test data \n"
    sum_chart_count = sum(chart_count.values())

    sum_rho_cosine = sum([ranking[1][0] for ranking in significant_cosine])
    average_rho_cosine = sum_rho_cosine / sum_chart_count
    print "\nAverage Spearman's Rho by cosine:", average_rho_cosine
    sum_rho_cos_mos = sum([ranking[1][0] for ranking in significant_cosine if 'Moscow' in ranking[0]])
    average_rho_cos_mos = sum_rho_cos_mos / chart_count['mos']
    print "Average Rho by cosine for Moscow:", average_rho_cos_mos
    sum_rho_cos_sao = sum([ranking[1][0] for ranking in significant_cosine if 'Sao' in ranking[0]])
    average_rho_cos_sao = sum_rho_cos_sao / chart_count['sao']
    print "Average Rho by cosine for Sao Paulo:", average_rho_cos_sao
    sum_rho_cos_nyc = sum([ranking[1][0] for ranking in significant_cosine if 'New' in ranking[0]])
    average_rho_cos_nyc = sum_rho_cos_nyc / chart_count['nyc']
    print "Average Rho by cosine for New York:", average_rho_cos_nyc

    sum_rho_cityblock = sum([ranking[1][0] for ranking in significant_cityblock])
    average_rho_cityblock = sum_rho_cityblock / sum_chart_count
    print "Average Spearman's Rho by cityblock:", average_rho_cityblock
    sum_rho_city_mos = sum([ranking[1][0] for ranking in significant_cityblock if 'Moscow' in ranking[0]])
    average_rho_city_mos = sum_rho_city_mos / chart_count['mos']
    print "Average Rho by cityblock for Moscow:", average_rho_city_mos
    sum_rho_city_sao = sum([ranking[1][0] for ranking in significant_cityblock if 'Sao' in ranking[0]])
    average_rho_city_sao = sum_rho_city_sao / chart_count['sao']
    print "Average Rho by cityblock for Sao Paulo:", average_rho_city_sao
    sum_rho_city_nyc = sum([ranking[1][0] for ranking in significant_cityblock if 'New' in ranking[0]])
    average_rho_city_nyc = sum_rho_city_nyc / chart_count['nyc']
    print "Average Rho by cityblock for New York:", average_rho_city_nyc
