setwd("G:/MyData/Human Centered Multimedia/Internet Information/Project/statdata")
read.csv("moscow_ny_sao_paolo_2011_2012_train.csv") -> all_train
save(all_train, file="all_train.saved")
sao <- subset(all_train, metro=="Sao Paulo")

# drop missing variables, and rename the plottable variables
library(plyr)
sao$weather.humidity <- NULL
sao$weather.tornado <- NULL
sao$weather.snow <- NULL
sao$weather.snowdepthm <- NULL
sao$weather.snowfallm <- NULL
sao$weather.precipm <- revalue(sao$weather.precipm, c("T"="20"))
sao$weather.precipm <- as.numeric(levels(sao$weather.precipm))[sao$weather.precipm]
sao <- rename(sao, c("weather.hail"="sao.hail", "weather.thunder"="sao.thunder", "weather.fog"="sao.fog", "weather.rain"="sao.rain", "weather.maxpressurem"="sao.presh", "weather.minpressurem"="sao.presl", "weather.meanpressurem"="sao.press", "weather.maxtempm"="sao.temph", "weather.mintempm"="sao.templ", "weather.meantempm"="sao.temp", "weather.minwspdm"="sao.windl", "weather.maxdewptm"="sao.dewh", "weather.mindewptm"="sao.dewl", "weather.meandewptm"="sao.dew", "weather.maxvism"="sao.vish", "weather.minvism"="sao.visl", "weather.meanvism"="sao.vis", "weather.maxwspdm"="sao.windh", "weather.meanwindspdm"="sao.wind", "weather.maxhumidity"="sao.humh", "weather.minhumidity"="sao.huml", "weather.precipm"="sao.precip", "music.artist.familiarity"="art.fam", "music.artist.location.latitude"="art.lat", "music.artist.location.longitude"="art.long", "music.features.audiosummary.key"="m.key", "music.features.audiosummary.energy"="m.energy", "music.features.audiosummary.liveness"="m.live", "music.features.audiosummary.tempo"="m.tempo", "music.features.audiosummary.speechiness"="m.speech", "music.features.audiosummary.danceability"="m.dance", "music.features.audiosummary.mode"="m.mode", "music.features.audiosummary.time_signature"="m.t_sig", "music.features.audiosummary.loudness"="m.loud", "music.features.audiosummary.duration"="m.dura", "music.features.hotttnesss"="m.hott"))

# adjust listener count and duplicate data
sao$music.listeners / 28 -> sao$music.listn_adj # should be /7, but this is more efficient
sao.wt <- sao[rep(1:nrow(sao),sao$music.listn_adj),]

cat("\nHow many observations?\n")
str(sao.wt) #how many observations?
sao.wt <- sao.wt[complete.cases(sao.wt), ]
cat("\nHow many complete observations?\n")
str(sao.wt) #how many complete observations?

# save
save(sao.wt, file="sao_train1.saved")