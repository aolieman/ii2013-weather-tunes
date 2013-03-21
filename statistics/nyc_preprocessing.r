setwd("G:/MyData/Human Centered Multimedia/Internet Information/Project/statdata")
load("all_train.saved")
nyc <- subset(all_train, metro=="New York")

# drop humidity, get rid of "T", and rename the plottable variables
library(plyr)
nyc$weather.humidity <- NULL
nyc$weather.hail <- NULL
nyc$weather.torn <- NULL
nyc$weather.snowfallm <- revalue(nyc$weather.snowfallm, c("T"="2.5"))
nyc$weather.snowfallm <- as.numeric(levels(nyc$weather.snowfallm))[nyc$weather.snowfallm]
nyc$weather.precipm <- revalue(nyc$weather.precipm, c("T"="15"))
nyc$weather.precipm <- as.numeric(levels(nyc$weather.precipm))[nyc$weather.precipm]
nyc <- rename(nyc, c("weather.snow"="nyc.snow", "weather.thunder"="nyc.thunder", "weather.fog"="nyc.fog", "weather.rain"="nyc.rain", "weather.maxpressurem"="nyc.presh", "weather.minpressurem"="nyc.presl", "weather.meanpressurem"="nyc.press", "weather.maxtempm"="nyc.temph", "weather.mintempm"="nyc.templ", "weather.meantempm"="nyc.temp", "weather.minwspdm"="nyc.windl", "weather.maxdewptm"="nyc.dewh", "weather.mindewptm"="nyc.dewl", "weather.meandewptm"="nyc.dew", "weather.snowdepthm"="nyc.snowd", "weather.maxvism"="nyc.vish", "weather.minvism"="nyc.visl", "weather.meanvism"="nyc.vis", "weather.maxwspdm"="nyc.windh", "weather.meanwindspdm"="nyc.wind", "weather.maxhumidity"="nyc.humh", "weather.minhumidity"="nyc.huml", "weather.precipm"="nyc.precip", "weather.snowfallm"="nyc.snowf", "music.artist.familiarity"="art.fam", "music.artist.location.latitude"="art.lat", "music.artist.location.longitude"="art.long", "music.features.audiosummary.key"="m.key", "music.features.audiosummary.energy"="m.energy", "music.features.audiosummary.liveness"="m.live", "music.features.audiosummary.tempo"="m.tempo", "music.features.audiosummary.speechiness"="m.speech", "music.features.audiosummary.danceability"="m.dance", "music.features.audiosummary.mode"="m.mode", "music.features.audiosummary.time_signature"="m.t_sig", "music.features.audiosummary.loudness"="m.loud", "music.features.audiosummary.duration"="m.dura", "music.features.hotttnesss"="m.hott"))

# adjust listener count and duplicate data
nyc$music.listeners / 28 -> nyc$music.listn_adj # should be /7, but this is more efficient
nyc.wt <- nyc[rep(1:nrow(nyc),nyc$music.listn_adj),]

cat("\nHow many observations?\n")
str(nyc.wt) #how many observations?
nyc.wt <- nyc.wt[complete.cases(nyc.wt), ]
cat("\nHow many complete observations?\n")
str(nyc.wt) #how many complete observations?

# save
save(nyc.wt, file="nyc_train1.saved")