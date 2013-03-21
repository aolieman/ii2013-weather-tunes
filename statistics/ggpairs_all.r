setwd("G:/MyData/Human Centered Multimedia/Internet Information/Project/statdata")
read.csv("moscow_ny_sao_paulo_2011_2012.csv") -> all3

library(plyr)
library(GGally)

all3$weather.snowfallm <- revalue(all3$weather.snowfallm, c("T"="2.5"))
all3$weather.snowfallm <- as.numeric(levels(all3$weather.snowfallm))[all3$weather.snowfallm]
all3$weather.precipm <- revalue(all3$weather.precipm, c("T"="15"))
all3$weather.precipm <- as.numeric(levels(all3$weather.precipm))[all3$weather.precipm]
all3 <- rename(all3, c("weather.hail"="w.hail", "weather.snow"="w.snow", "weather.thunder"="w.thunder", "weather.fog"="w.fog", "weather.rain"="w.rain", "weather.maxpressurem"="w.presh", "weather.minpressurem"="w.presl", "weather.meanpressurem"="w.press", "weather.maxtempm"="w.temph", "weather.mintempm"="w.templ", "weather.meantempm"="w.temp", "weather.minwspdm"="w.windl", "weather.maxdewptm"="w.dewh", "weather.mindewptm"="w.dewl", "weather.meandewptm"="w.dew", "weather.snowdepthm"="w.snowd", "weather.maxvism"="w.vish", "weather.minvism"="w.visl", "weather.meanvism"="w.vis", "weather.maxwspdm"="w.windh", "weather.meanwindspdm"="w.wind", "weather.maxhumidity"="w.humh", "weather.minhumidity"="w.huml", "weather.precipm"="w.precip", "weather.snowfallm"="w.snowf", "music.artist.familiarity"="art.fam", "music.artist.location.latitude"="art.lat", "music.artist.location.longitude"="art.long", "music.features.audiosummary.key"="m.key", "music.features.audiosummary.energy"="m.energy", "music.features.audiosummary.liveness"="m.live", "music.features.audiosummary.tempo"="m.tempo", "music.features.audiosummary.speechiness"="m.speech", "music.features.audiosummary.danceability"="m.dance", "music.features.audiosummary.mode"="m.mode", "music.features.audiosummary.time_signature"="m.t_sig", "music.features.audiosummary.loudness"="m.loud", "music.features.audiosummary.duration"="m.dura", "music.features.hotttnesss"="m.hott"))
levels(all3$metro) <- c("Mc", "NY", "SP")

# adjust listener count and duplicate data
all3$music.listeners / 7 -> all3$music.listn_adj # should be /7, but this is more efficient
all3.wt <- all3[rep(1:nrow(all3),all3$music.listn_adj),]

# take a random sample for plotting
all3.sample <- all3.wt[sample(1:nrow(all3.wt), 300, replace=FALSE),]
rm(all3.wt) #save memory
two_third_a4 <- 8.3 * 2/3

# select features to plot
all3.sample.hott_loud <- subset(all3.sample, select=c(m.hott, m.loud, w.windh, w.temp, w.vis, metro))

print(str(all3.sample.hott_loud))

# plot a matrix of scatterplots / correlations (of samples)
pdf("plots/all3.sample.hott_loud.pdf")
ggpairs(all3.sample.hott_loud, diag=list(continuous="density", discrete="bar"), colour="metro", axisLabels="show")
dev.off()