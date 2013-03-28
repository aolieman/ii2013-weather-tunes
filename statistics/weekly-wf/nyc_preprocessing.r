setwd("C:/Users/michael/Documents/GitHub/ii2013-weather-tunes/statistics/weekly-wf")
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
nyc <- rename(nyc, c("weather.snow"="snow", "weather.thunder"="thunder", "weather.fog"="fog", "weather.rain"="rain", "weather.maxpressurem"="presh", "weather.minpressurem"="presl", "weather.meanpressurem"="press", "weather.maxtempm"="temph", "weather.mintempm"="templ", "weather.meantempm"="temp", "weather.minwspdm"="windl", "weather.maxdewptm"="dewh", "weather.mindewptm"="dewl", "weather.meandewptm"="dew", "weather.snowdepthm"="snowd", "weather.maxvism"="vish", "weather.minvism"="visl", "weather.meanvism"="vis", "weather.maxwspdm"="windh", "weather.meanwindspdm"="wind", "weather.maxhumidity"="humh", "weather.minhumidity"="huml", "weather.precipm"="precip", "weather.snowfallm"="snowf", "music.artist.name"="artist", "music.title"="title", "music.listeners"="listeners", "music.artist.familiarity"="art.fam", "music.artist.location.latitude"="art.lat", "music.artist.location.longitude"="art.long", "music.features.audiosummary.key"="key", "music.features.audiosummary.energy"="energy", "music.features.audiosummary.liveness"="liveness", "music.features.audiosummary.tempo"="tempo", "music.features.audiosummary.speechiness"="speechiness", "music.features.audiosummary.danceability"="dancability", "music.features.audiosummary.mode"="mode", "music.features.audiosummary.time_signature"="t_sig", "music.features.audiosummary.loudness"="loudness", "music.features.audiosummary.duration"="duration", "music.features.hotttnesss"="hotttnesss"))

# start aggregate
library("reshape")

# specify cols for aggregation
id <- c("metro","artist","title","listeners","energy","tempo","speechiness","dancability","loudness")

# specify cols for aggregate functions
max.wfs <- c("fog","rain","snow","thunder", "temph","presh","vish","humh","dewh","windh")
min.wfs <- c("templ","presl","visl","huml","dewl","windl")
mean.wfs <- c("temp","press","vis","dew","wind")
sum.wfs <- c("precip","snowd","snowf")

# melt data
mmax.wfs <- melt(nyc, id, max.wfs)
mmin.wfs <- melt(nyc, id, min.wfs)
mmean.wfs <- melt(nyc, id, mean.wfs)
msum.wfs <- melt(nyc, id, sum.wfs)

cmax.wfs <- cast(mmax.wfs, ... ~ variable, max)
cmin.wfs <- cast(mmin.wfs, ... ~ variable, min)
cmean.wfs <- cast(mmean.wfs, ... ~ variable, mean)
csum.wfs <- cast(msum.wfs, ... ~ variable, sum)
merged <- merge(cmax.wfs, cmin.wfs, by=id)
merged <- merge(merged, cmean.wfs, by=id)
merged <- merge(merged, csum.wfs, by=id)

# adjust listener count and duplicate data
merged$listeners_adj <- merged$listeners / 28 # should be /7, but this is more efficient
nyc.wt <- merged[rep(1:nrow(merged),merged$listeners_adj),]

cat("\nHow many observations?\n")
str(nyc.wt) #how many observations?
nyc.wt <- nyc.wt[complete.cases(nyc.wt), ]
cat("\nHow many complete observations?\n")
str(nyc.wt) #how many complete observations?

# save
save(nyc.wt, file="nyc_train1.saved")