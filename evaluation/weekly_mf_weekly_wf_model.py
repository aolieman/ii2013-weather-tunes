#KEY
key = {}
key['New York'] = { 'normal':{'vis': -0.525, 'snow': 0.0448, 'visl': 0.188, 'vish': 0.592, 'intercept': 0.995},
'min': { 'vis': -0.893, 'snow': 0.132, 'visl': 0.002, 'vish': -0.449, 'intercept': -13.727},
'max': {'vis': -0.157, 'snow': 0.764, 'visl': 0.373, 'vish': 1.633, 'intercept': 15.716}}

key['Moscow'] = {'normal':{'vis': 0.433, 'vish': -1.217, 'hail': -0.107, 'precip': 0.138, 'wind': 0.073, 'intercept': 13.031},
'min': {'vis': 0.060, 'vish': -2.625, 'hail': -0.949, 'precip': -0.058, 'wind': -0.035, 'intercept': 0.424},
'max': {'vis': 0.807, 'vish': 0.190, 'hail': 0.135, 'precip': 0.334, 'wind': 0.181, 'intercept': 25.637}}

key['Sao Paulo'] = {'normal': {'humh': -0.132, 'presh': 0.243, 'presl': -0.167, 'precip': 0.082, 'intercept': -60.458},
'min': {'humh': -0.209, 'presh': 0.012, 'presl': -0.401, 'precip': -0.051, 'intercept': -205.332},
'max': {'humh': -0.055, 'presh': 0.473, 'presl': 0.066, 'precip': 0.215, 'intercept': 84.416}}

#ENERGY:
#rain/snow_max??? rain_max
energy = {}
energy['New York'] = {'normal': {'windl': -0.034, 'wind': 0.033, 'vish': -0.078, 'precip': -0.007, 'snow': 0.021, 'snowdep': 0.006, 'rain': -0.052, 'windh': -0.008, 'dewl': 0.012, 'dew': -0.009, 'intercept': 1.680},
'min': {'windl': -0.051, 'wind': 0.016, 'vish': -0.124, 'precip': -0.011, 'snow': 0.002, 'snowdep': 0, 'rain': -0.101, 'windh': -0.017, 'dewl': -0.004, 'dew': -0.026, 'intercept': 0.968},
'max': {'windl': -0.018, 'wind': 0.050, 'vish': -0.032, 'precip': -0.003, 'snow': 0.04, 'snowdep': 0.011, 'rain': -0.003, 'windh': 0.002, 'dewl': 0.028, 'dew': 0.007, 'intercept': 2.374}}

energy['Moscow'] = {'normal': {'visl': -0.029, 'humh': -0.008, 'templ': 0.075, 'thunder': 0.047, 'rain': 0.064, 'presl': -0.003, 'temp': -0.117, 'snow': -0.048, 'vish': -0.11, 'temph': 0.054, 'intercept': 5.455},
'min': {'visl': -0.046, 'humh': -0.013, 'templ': 0.025, 'thunder': 0.014, 'rain': 0.020, 'presl': -0.006, 'temp': -0.218, 'snow': -0.091, 'vish': -0.213, 'temph': 0.001, 'intercept': 2.206},
'max': {'visl': -0.011, 'humh': -0.003, 'templ': 0.125, 'thunder': 0.079, 'rain': 0.108, 'presl': -0, 'temp': -0.015, 'snow': -0.004, 'vish': -0.006, 'temph': 0.107, 'intercept': 8.705}}

energy['Sao Paulo'] = {'normal': {'presh': -0.1, 'press': 0.104, 'hum': -0.036, 'dew': 0.155, 'vis': -0.085, 'windl': -0.035, 'templ': -0.068, 'precip': -0.013, 'humh': 0.019, 'wind': 0.028, 'intercept': 18.660},
'min': {'presh': -0.141, 'press': 0.057, 'hum': -0.053, 'dew': 0.082, 'vis': -0.134, 'windl': -0.058, 'templ': -0.115, 'precip': -0.022, 'humh': 0.005, 'wind': 0.005, 'intercept': 6.475},
'max': {'presh': -0.060, 'press': 0.151, 'hum': -0.020, 'dew': 0.228, 'vis': -0.036, 'windl': -0.012, 'templ': -0.021, 'precip': -0.003, 'humh': 0.034, 'wind': 0.05, 'intercept': 30.845}}

#LIVENESS
live = {}
live['New York'] = {'normal': {'fog': -0.034, 'visl': 0.010, 'presl': -0.011, 'precip': -0.006, 'templ': -0.059, 'humh': 0.005, 'windl': -0.014, 'dewl': 0.014, 'dewh': -0.016, 'temp': 0.085, 'intercept': 2.142},
'min': {'fog': -0.052, 'visl': 0.004, 'presl': -0.019, 'precip': -0.010, 'templ': -0.103, 'humh': 0.001, 'windl': -0.024, 'dewl': 0.003, 'dewh': -0.03, 'temp': 0.008, 'intercept': -0.564},
'max': {'fog': -0.016, 'visl': 0.016, 'presl': -0.003, 'precip': -0.002, 'templ': -0.016, 'humh': 0.009, 'windl': -0.003, 'dewl': 0.025, 'dewh': --0.003, 'temp': 0.162, 'intercept': 4.848}}

live['Moscow'] = {'normal': {'vish': -0.122, 'wind': 0.011, 'dewh': -0.029, 'huml': 0.005, 'dew': -0.030, 'templ': 0.059, 'temph': 0.056, 'hail': -0.025, 'humh': 0.005, 'vis': -0.019, 'intercept': 0.567},
'min': {'vish': -0.210, 'wind': 0.003, 'dewh': -0.052, 'huml': 0.001, 'dew': -0.056, 'templ': 0.004, 'temph': -0.001, 'hail': -0.055, 'humh': -0.001, 'vis': -0.044, 'intercept': -0.527},
'max': {'vish': -0.035, 'wind': 0.019, 'dewh': -0.005, 'huml': 0.008, 'dew': -0.004, 'templ': 0.113, 'temph': 0.114, 'hail': 0.004, 'humh': 0.012, 'vis': 0.005, 'intercept': 1.661}}

live['Sao Paulo'] = {'normal': {'huml': -0.013, 'precip': -0.017,  'presh': -0.073, 'windl': 0.015, 'humh': 0.014, 'press': 0.047, 'hum': 0.010, 'windh': 0.005, 'presl': 0.010, 'intercept': 14.444},
'min': {'huml': -0.019, 'precip': -0.025,  'presh': -0.112, 'windl': 0.002, 'humh': 0.002, 'press': -0.000, 'hum': -0.002, 'windh': -0.001, 'presl': -0.008, 'intercept': 5.714},
'max': {'huml': -0.007, 'precip': -0.009,  'presh': -0.033, 'windl': 0.028, 'humh': 0.025, 'press': 0.095, 'hum': 0.022, 'windh': 0.011, 'presl': 0.029, 'intercept': 23.174}}

#TEMPO
tempo = {}
tempo['New York'] = {'normal': {'presh': -0.477, 'visl': 0.861, 'snowf': 5.139, 'vish': -5.154, 'rain': -4.778, 'intercept': 666.061},
'min': {'presh': -0.763, 'visl': 0.251, 'snowf': -0.041, 'vish': -11.199, 'rain': -10.390, 'intercept': 332.613},
'max': {'presh': -0.190, 'visl': 1.471, 'snowf': 10.688, 'vish': 0.891, 'rain': 0.833, 'intercept': 999.508}}

tempo['Moscow'] = {'normal': {'presl': -2.608, 'presh': 2.768, 'precip': -4.039, 'temp': 1.741, 'vis': -3.155, 'hail': -3.495, 'dewh': -1.081, 'intercept': -41.498},
'min': {'presl': -3.601, 'presh': 1.661, 'precip': -5.987, 'temp': 0.386, 'vis': -6.241, 'hail': -7.246, 'dewh': -2.418, 'intercept': -369.179},
'max': {'presl': -1.615, 'presh': 3.876, 'precip': -2.092, 'temp': 3.097, 'vis': -0.069, 'hail': 0.257, 'dewh': 0.256, 'intercept': 286.182}}

tempo['Sao Paulo'] = {'normal': {'windh': -1.006, 'fog': -3.751, 'precip': -0.550, 'hail': -2.321, 'intercept': 142.646},
'min': {'windh': -1.638, 'fog': -7.292, 'precip': -1.182, 'hail': -6.261, 'intercept': 127.202},
'max': {'windh': -0.374, 'fog': -0.210, 'precip': 0.083, 'hail': 1.619, 'intercept': 158.090}}

#SPEECHINESS
speech = {}
speech['New York'] = {'normal': {'huml': 0.002, 'windh': 0.005, 'windl': -0.009, 'presl': 0.009, 'press': -0.008, 'visl': 0.002, 'intercept': -1.209},
'min': {'huml': 0.001, 'windh': 0.003, 'windl': -0.015, 'presl': 0.003, 'press': -0.003, 'visl': -0, 'intercept': -2.356},
'max': {'huml': 0.003, 'windh': 0.008, 'windl': -0.004, 'presl': 0.015, 'press': -0.002, 'visl': 0.005, 'intercept': -0.061}}

speech['Moscow'] = {'normal': {'humh': -0.003, 'windl': -0.010, 'hail': 0.011, 'dew': 0.014, 'temph': -0.004, 'vish': -0.028, 'visl': -0.005, 'rain': 0.011, 'vis': 0.008, 'windh': -0.002, 'intercept': 0.550},
'min': {'humh': -0.005, 'windl': -0.018, 'hail': 0.003, 'dew': 0.003, 'temph': -0.007, 'vish': -0.052, 'visl': -0.010, 'rain': 0, 'vis': -0.001, 'windh': -0.004, 'intercept': 0.0283},
'max': {'humh': -0.001, 'windl': -0.003, 'hail': 0.020, 'dew': 0.024, 'temph': -0.001, 'vish': -0.005, 'visl': -0, 'rain': 0.021, 'vis': 0.017, 'windh': 0, 'intercept': 0.816}}

speech['Sao Paulo'] = {'normal': {'fog': 0.010, 'presh': -0.012, 'vis': -0.007, 'dewh': 0.017, 'dewh': -0.006, 'press': 0.010, 'windh': -0.001, 'dew': -0.011, 'temph': -0.002, 'intercept': 2.381},
'min': {'fog': 0.003, 'presh': -0.022, 'vis': -0.013, 'dewh': 0.003, 'dewh': -0.011, 'press': -0.000, 'windh': -0.003, 'dew': -0.024, 'temph': -0.006, 'intercept': -0.524},
'max': {'fog': 0.017, 'presh': -0.002, 'vis': -0.001, 'dewh': 0.030, 'dewh': -0.000, 'press': 0.020, 'windh': 0.000, 'dew': 0.001, 'temph': 0.002, 'intercept': 5.287}}

#MODE
mode = {}
mode['New York'] = {'normal': {'press': -0.007, 'thunder': 0.086, 'vis': 0.012, 'intercept': 8.011},
'min': {'press': -0.013, 'thunder': 0.007, 'vis': -0.007, 'intercept': 2.046},
'max': {'press': -0.002, 'thunder': 0.165, 'vis': 0.031, 'intercept': 13.976}}

mode['Moscow'] = {'normal': {'snow': 0.201, 'windl': -0.036, 'temp': -0.007, 'thunder': 0.057, 'huml': 0.002, 'visl': -0.033, 'intercept': 0.747},
'min': {'snow': 0.103, 'windl': -0.060, 'temp': -0.013, 'thunder': -0.016, 'huml': -0.001, 'visl': -0.093, 'intercept': 0.183},
'max': {'snow': 0.299, 'windl': -0.012, 'temp': 0.000, 'thunder': 0.131, 'huml': 0.005, 'visl': 0.027, 'intercept': 1.312}}

mode['Sao Paulo'] = {'normal': {'dewl': 0.061, 'press': 0.052, 'huml': -0.017, 'presl': -0.045, 'temp': -0.046, 'fog': 0.058, 'intercept': -5.499},
'min': {'dewl': 0.023, 'press': 0.013, 'huml': -0.030, 'presl': -0.085, 'temp': -0.093, 'fog': -0.003, 'intercept': -34.292},
'max': {'dewl': 0.100, 'press': 0.091, 'huml': -0.004, 'presl': -0.005, 'temp': 0.001, 'fog': 0.120, 'intercept': 23.293}}

#LOUDNESS
loud = {}
loud['New York'] = {'normal': {'windl': -1.059, 'wind': 0.536, 'dew': 0.591, 'presh': 0.104, 'snow': 0.727, 'dewh': -0.522, 'humh': -0.091, 'precip': 0.063, 'vis': -0.155, 'huml': -0.02, 'intercept': -108.054},
'min': {'windl': -1.442, 'wind': 0.282, 'dew': 0.263, 'presh': 0.04, 'snow': 0.280, 'dewh': -0.870, 'humh': -0.168, 'precip': -0.048, 'vis': -0.569, 'huml': -0.074, 'intercept': -172.583},
'max': {'windl': -0.677, 'wind': 0.789, 'dew': 0.919, 'presh': 0.167, 'snow': 1.174, 'dewh': -0.175, 'humh': -0.015, 'precip': 0.174, 'vis': 0.129, 'huml': 0.033, 'intercept': -43.526}}

loud['Moscow'] = {'normal': {'huml': -0.212, 'dew': 1.126, 'vish': -4.338, 'presl': -0.973, 'windh': -0.324, 'rain': 1.185, 'thunder': 1.010, 'press': 1.362, 'wind': 0.390, 'temp': -0.465, 'intercept': 194.963},
'min': {'huml': -0.301, 'dew': 0.568, 'vish': -6.721, 'presl': -1.566, 'windh': -0.537, 'rain': 0.487, 'thunder': 0.318, 'press': 0.245, 'wind': 0.029, 'temp': -0.965, 'intercept': 107.141},
'max': {'huml': -0.122, 'dew': 1.683, 'vish': -1.956, 'presl': -0.380, 'windh': -0.111, 'rain': 2.482, 'thunder': 1.701, 'press': 2.479, 'wind': 0.750, 'temp': 0.035, 'intercept': 282.786}}

loud['Sao Paulo'] = {'normal': {'temp': -0.491, 'windl': -0.789, 'presl': -0.404, 'thunder': 1.128, 'wind': 0.373, 'visl': -0.228, 'intercept': 421.666},
'min': {'temp': -0.686, 'windl': -1.131, 'presl': -0.595, 'thunder': 0.332, 'wind': 0.081, 'visl': -0.557, 'intercept': 215.562},
'max': {'temp': -0.297, 'windl': -0.447, 'presl': -0.212, 'thunder': 1.924, 'wind': 0.666, 'visl': 0.101, 'intercept': 609.770}}

#DANCEABILITY
dance = {}
dance['New York'] = {'normal': {'humh': -0.004, 'snowf': -0.108, 'visl': -0.009, 'windh': -0.009, 'thunder': -0.033, 'snowd': 0.008, 'vish': -0.04, 'rain': -0.033, 'wind': 0.007, 'intercept': 1.760},
'min': {'humh': -0.006, 'snowf': -0.176, 'visl': -0.015, 'windh': -0.016, 'thunder': -0.059, 'snowd': 0.001, 'vish': -0.08, 'rain': -0.071, 'wind': -0.003, 'intercept': 1.152},
'max': {'humh': -0.002, 'snowf': -0.041, 'visl': -0.003, 'windh': -0.003, 'thunder': -0.007, 'snowd': 0.015, 'vish': -0, 'rain': 0.006, 'wind': 0.018, 'intercept': 2.369}}

dance['Moscow'] = {'normal': {'vis': -0.056, 'visl': 0.035, 'thunder': -0.050, 'fog': -0.032, 'humh': 0.004, 'presh': -0.002, 'rain': -0.025, 'precip': -0.007, 'intercept': 2.668},
'min': {'vis': -0.073, 'visl': 0.022, 'thunder': -0.070, 'fog': -0.053, 'humh': 0.001, 'presh': -0.004, 'rain': -0.056, 'precip': -0.017, 'intercept': 0.813},
'max': {'vis': -0.039, 'visl': 0.047, 'thunder': -0.030, 'fog': -0.010, 'humh': 0.007, 'presh': -0.000, 'rain': 0.006, 'precip': 0.004, 'intercept': 4.524}}

dance['Sao Paulo'] = {'normal': {'wind': -0.028, 'temp': 0.111, 'presh': 0.074, 'huml': 0.018, 'press': -0.068,  'vis': 0.059, 'dewl': -0.027, 'fog': -0.034, 'temph': -0.041, 'dewh': -0.051, 'intercept': 2.914},
'min': {'wind': -0.037, 'temp': 0.073, 'presh': 0.048, 'huml': 0.011, 'press': -0.099, 'vis': 0.032, 'dewl': -0.042, 'fog': -0.053, 'temph': -0.066, 'dewh': -0.085, 'intercept': -6.476},
'max': {'wind': -0.019, 'temp': 1.150, 'presh': 0.101, 'huml': 0.025, 'press': -0.037, 'vis': 0.087, 'dewl': -0.012, 'fog': -0.014, 'temph': -0.015, 'dewh': -0.017, 'intercept': 12.305}}

#HOTNESS
hot = {}
hot['New York'] = {'normal': {'snow': -0.0106, 'windh': -0.020, 'thunder': -0.077, 'rain': -0.099, 'humh': -0.007, 'dewh': 0.031, 'temph': -0.012, 'fog': -0.031, 'windl': 0.017, 'snowf': -0.0117, 'intercept': 6.475},
'min': {'snow': -0.122, 'windh': -0.024, 'thunder': -0.099, 'rain': -0.131, 'humh': -0.01, 'dewh': 0.019, 'temph': -0.017, 'fog': -0.046, 'windl': 0.008, 'snowf': -0.181, 'intercept': 4.398},
'max': {'snow': -0.09, 'windh': -0.015, 'thunder': -0.055, 'rain': -0.067, 'humh': -0.004, 'dewh': 0.044, 'temph': -0.006, 'fog': -0.016, 'windl': 0.026, 'snowf': 0.053, 'intercept': 8.552}}

hot['Moscow'] = {'normal': {'temph': 0.052, 'wind': 0.042, 'windh': -0.019, 'hum': 0.015, 'rain': -0.080, 'windl': -0.025, 'snow': -0.064, 'hail': -0.051, 'thunder': -0.049, 'visl': -0.022, 'intercept': -3.588},
'min': {'temph': 0.038, 'wind': 0.030, 'windh': -0.025, 'hum': 0.010, 'rain': -0.108, 'windl': -0.034, 'snow': -0.090, 'hail': -0.072, 'thunder': -0.070, 'visl': -0.033, 'intercept': -5.875},
'max': {'temph': 0.067, 'wind': 0.053, 'windh': -0.013, 'hum': 0.020, 'rain': -0.051, 'windl': -0.016, 'snow': -0.038, 'hail': -0.031, 'thunder': -0.027, 'visl': -0.011, 'intercept': -1.302}}

hot['Sao Paulo'] = {'normal': {'fog': -0.074, 'presl': 0.034, 'precip': 0.012, 'wind': 0.024, 'dewh': -0.071, 'temph': 0.038, 'templ': 0.044, 'hail': -0.035, 'humh': 0.012, 'thunder': -0.042, 'intercept': -18.661},
'min': {'fog': -0.099, 'presl': 0.021, 'precip': 0.007, 'wind': 0.013, 'dewh': -0.016, 'temph': 0.019, 'templ': 0.017, 'hail': -0.057, 'humh': 0.003, 'thunder': -0.074, 'intercept': -27.612},
'max': {'fog': -0.050, 'presl': 0.046, 'precip': 0.017, 'wind': 0.035, 'dewh': -0.036, 'temph': 0.057, 'templ': 0.071, 'hail': -0.013, 'humh': 0.021, 'thunder': -0.010, 'intercept': -9.710}}
