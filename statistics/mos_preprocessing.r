setwd("G:/MyData/Human Centered Multimedia/Internet Information/Project/statdata")
load("all_train.saved")
mos <- subset(all_train, metro=="Moscow")

# drop missing variables, and rename the plottable variables
library(plyr)
mos$weather.tornado <- NULL
mos$weather.humidity <- NULL
mos$weather.snowdepthm <- NULL
mos$weather.snowfallm <- NULL
mos$weather.precipm <- revalue(mos$weather.precipm, c("T"="5"))
mos$weather.precipm <- as.numeric(levels(mos$weather.precipm))[mos$weather.precipm]
mos <- rename(mos, c("weather.hail"="mos.hail", "weather.snow"="mos.snow", "weather.thunder"="mos.thunder", "weather.fog"="mos.fog", "weather.rain"="mos.rain", "weather.maxpressurem"="mos.presh", "weather.minpressurem"="mos.presl", "weather.meanpressurem"="mos.press", "weather.maxtempm"="mos.temph", "weather.mintempm"="mos.templ", "weather.meantempm"="mos.temp", "weather.minwspdm"="mos.windl", "weather.maxdewptm"="mos.dewh", "weather.mindewptm"="mos.dewl", "weather.meandewptm"="mos.dew", "weather.maxvism"="mos.vish", "weather.minvism"="mos.visl", "weather.meanvism"="mos.vis", "weather.maxwspdm"="mos.windh", "weather.meanwindspdm"="mos.wind", "weather.maxhumidity"="mos.humh", "weather.minhumidity"="mos.huml", "weather.precipm"="mos.precip", "music.artist.familiarity"="art.fam", "music.artist.location.latitude"="art.lat", "music.artist.location.longitude"="art.long", "music.features.audiosummary.key"="m.key", "music.features.audiosummary.energy"="m.energy", "music.features.audiosummary.liveness"="m.live", "music.features.audiosummary.tempo"="m.tempo", "music.features.audiosummary.speechiness"="m.speech", "music.features.audiosummary.danceability"="m.dance", "music.features.audiosummary.mode"="m.mode", "music.features.audiosummary.time_signature"="m.t_sig", "music.features.audiosummary.loudness"="m.loud", "music.features.audiosummary.duration"="m.dura", "music.features.hotttnesss"="m.hott"))

# adjust listener count and duplicate data
mos$music.listeners / 28 -> mos$music.listn_adj # should be /7, but this is more efficient
mos.wt <- mos[rep(1:nrow(mos),mos$music.listn_adj),]

cat("\nHow many observations?\n")
str(mos.wt) #how many observations?
mos.wt <- mos.wt[complete.cases(mos.wt), ]
cat("\nHow many complete observations?\n")
str(mos.wt) #how many complete observations?

# save
save(mos.wt, file="mos_train1.saved")