setwd("C:/Users/michael/Documents/GitHub/ii2013-weather-tunes/statistics/weekly-wf")
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
mos <- rename(mos, c("weather.hail"="hail", "weather.snow"="snow", "weather.thunder"="thunder", "weather.fog"="fog", "weather.rain"="rain", "weather.maxpressurem"="presh", "weather.minpressurem"="presl", "weather.meanpressurem"="press", "weather.maxtempm"="temph", "weather.mintempm"="templ", "weather.meantempm"="temp", "weather.minwspdm"="windl", "weather.maxdewptm"="dewh", "weather.mindewptm"="dewl", "weather.meandewptm"="dew", "weather.maxvism"="vish", "weather.minvism"="visl", "weather.meanvism"="vis", "weather.maxwspdm"="windh", "weather.meanwindspdm"="wind", "weather.maxhumidity"="humh", "weather.minhumidity"="huml", "weather.precipm"="precip", "music.artist.name"="artist", "music.title"="title", "music.listeners"="listeners", "music.artist.familiarity"="art.fam", "music.artist.location.latitude"="art.lat", "music.artist.location.longitude"="art.long", "music.features.audiosummary.key"="key", "music.features.audiosummary.energy"="energy", "music.features.audiosummary.liveness"="liveness", "music.features.audiosummary.tempo"="tempo", "music.features.audiosummary.speechiness"="speechiness", "music.features.audiosummary.danceability"="dancability", "music.features.audiosummary.mode"="mode", "music.features.audiosummary.time_signature"="t_sig", "music.features.audiosummary.loudness"="loudness", "music.features.audiosummary.duration"="duration", "music.features.hotttnesss"="hotttness"))

# start aggregate
library("reshape")

# specify cols for aggregation
id <- c("metro","artist","title","listeners","energy","tempo","speechiness","dancability","loudness")

# specify cols for aggregate functions
max.wfs <- c("fog","rain","hail","snow","thunder", "temph","presh","vish","humh","dewh","windh")
min.wfs <- c("templ","presl","visl","huml","dewl","windl")
mean.wfs <- c("temp","press","vis","dew","wind")
sum.wfs <- c("precip")

# melt data
mmax.wfs <- melt(mos, id, max.wfs)
mmin.wfs <- melt(mos, id, min.wfs)
mmean.wfs <- melt(mos, id, mean.wfs)
msum.wfs <- melt(mos, id, sum.wfs)

cmax.wfs <- cast(mmax.wfs, ... ~ variable, max)
cmin.wfs <- cast(mmin.wfs, ... ~ variable, min)
cmean.wfs <- cast(mmean.wfs, ... ~ variable, mean)
csum.wfs <- cast(msum.wfs, ... ~ variable, sum)
merged <- merge(cmax.wfs, cmin.wfs, by=id)
merged <- merge(merged, cmean.wfs, by=id)
merged <- merge(merged, csum.wfs, by=id)

# adjust listener count and duplicate data
merged$listeners_adj <- merged$listeners / 28 # should be /7, but this is more efficient
mos.wt <- merged[rep(1:nrow(merged),merged$listeners_adj),]

cat("\nHow many observations?\n")
str(mos.wt) #how many observations?
mos.wt <- mos.wt[complete.cases(mos.wt), ]
cat("\nHow many complete observations?\n")
str(mos.wt) #how many complete observations?

# save
save(mos.wt, file="mos_train1.saved")