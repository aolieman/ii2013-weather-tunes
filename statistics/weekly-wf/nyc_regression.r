setwd("C:/Users/michael/Documents/GitHub/ii2013-weather-tunes/statistics/weekly-wf")

# load data frame
load("nyc_train1.saved")

# take a random sample for plotting
wt.sample <- nyc.wt[sample(1:nrow(nyc.wt), 200, replace=FALSE),]
two_third_a4 <- 8.3 * 2/3 

# select weather features for regression (excl. hail and tornado)
weather <- "snow + thunder + rain + fog + presh + presl + press + temph + templ + temp + dewh + dewl + dew + snowd + vish + visl + vis + windh + windl + wind + humh + huml + precip + snowf"
small_weather <- "presl + temph + dew + snowd + vis + wind"

## regression for energy
sink("regressions/new_york/nyc_regression_energy.out")

# make linear model
energy_f <- as.formula(paste("energy ~ ", paste(weather)))
energy_max = lm(energy_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for energy\n")
print(summary(energy_max))

# stepwise regression on model
cat("\nMulti-regression for energy\n")
(energy_min = step(energy_max, direction="backward"))
print(summary(energy_min))
print(confint(energy_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(energy_min, list(press=80, temp=28, wind=20, humh=55)))

# make scatterplot with regression line
png("plots/new_york/energy_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$windl, wt.sample$energy)
if(!is.na(coef(energy_min)["windl"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["windl"])}
dev.off()
png("plots/new_york/energy_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$presh, wt.sample$energy)
if(!is.na(coef(energy_min)["presh"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["presh"])}
dev.off()
png("plots/new_york/energy_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$temph, wt.sample$energy)
if(!is.na(coef(energy_min)["temph"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["temph"])}
dev.off()
png("plots/new_york/energy_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$visl, wt.sample$energy)
if(!is.na(coef(energy_min)["visl"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["visl"])}
dev.off()
png("plots/new_york/energy_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$huml, wt.sample$energy)
if(!is.na(coef(energy_min)["huml"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["huml"])}
dev.off()
png("plots/new_york/energy_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$precip, wt.sample$energy)
if(!is.na(coef(energy_min)["precip"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["precip"])}
dev.off()

# close output file
sink()
save(energy_min, file="models/new_york/energy_min.saved")
rm(energy_f, energy_max, energy_min)

## regression for tempo
sink("regressions/new_york/nyc_regression_tempo.out")

# make linear model
tempo_f <- as.formula(paste("tempo ~ ", paste(weather)))
tempo_max = lm(tempo_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for tempo\n")
print(summary(tempo_max))

# stepwise regression on model
cat("\nMulti-regression for tempo\n")
(tempo_min = step(tempo_max, direction="backward"))
print(summary(tempo_min))
print(confint(tempo_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(tempo_min, list(press=80, temp=28, wind=20, humh=55)))

# make scatterplot with regression line
png("plots/new_york/tempo_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$windl, wt.sample$tempo)
if(!is.na(coef(tempo_min)["windl"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["windl"])}
dev.off()
png("plots/new_york/tempo_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$presh, wt.sample$tempo)
if(!is.na(coef(tempo_min)["presh"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["presh"])}
dev.off()
png("plots/new_york/tempo_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$temph, wt.sample$tempo)
if(!is.na(coef(tempo_min)["temph"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["temph"])}
dev.off()
png("plots/new_york/tempo_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$visl, wt.sample$tempo)
if(!is.na(coef(tempo_min)["visl"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["visl"])}
dev.off()
png("plots/new_york/tempo_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$huml, wt.sample$tempo)
if(!is.na(coef(tempo_min)["huml"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["huml"])}
dev.off()
png("plots/new_york/tempo_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$precip, wt.sample$tempo)
if(!is.na(coef(tempo_min)["precip"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["precip"])}
dev.off()

# close output file
sink()
save(tempo_min, file="models/new_york/tempo_min.saved")
rm(tempo_f, tempo_max, tempo_min)

## regression for speech
sink("regressions/new_york/nyc_regression_speech.out")

# make linear model
speech_f <- as.formula(paste("speechiness ~ ", paste(weather)))
speech_max = lm(speech_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for speech\n")
print(summary(speech_max))

# stepwise regression on model
cat("\nMulti-regression for speech\n")
(speech_min = step(speech_max, direction="backward"))
print(summary(speech_min))
print(confint(speech_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(speech_min, list(press=80, temp=28, wind=20, humh=55)))

# make scatterplot with regression line
png("plots/new_york/speech_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$windl, wt.sample$speechiness)
if(!is.na(coef(speech_min)["windl"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["windl"])}
dev.off()
png("plots/new_york/speech_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$presh, wt.sample$speechiness)
if(!is.na(coef(speech_min)["presh"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["presh"])}
dev.off()
png("plots/new_york/speech_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$temph, wt.sample$speechiness)
if(!is.na(coef(speech_min)["temph"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["temph"])}
dev.off()
png("plots/new_york/speech_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$visl, wt.sample$speechiness)
if(!is.na(coef(speech_min)["visl"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["visl"])}
dev.off()
png("plots/new_york/speech_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$huml, wt.sample$speechiness)
if(!is.na(coef(speech_min)["huml"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["huml"])}
dev.off()
png("plots/new_york/speech_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$precip, wt.sample$speechiness)
if(!is.na(coef(speech_min)["precip"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["precip"])}
dev.off()

# close output file
sink()
save(speech_min, file="models/new_york/speech_min.saved")
rm(speech_f, speech_max, speech_min)

## regression for loudness
sink("regressions/new_york/nyc_regression_loud.out")

# make linear model
loudness_f <- as.formula(paste("loudness ~ ", paste(weather)))
loudness_max = lm(loudness_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for loudness\n")
print(summary(loudness_max))

# stepwise regression on model
cat("\nMulti-regression for loudness\n")
(loudness_min = step(loudness_max, direction="backward"))
print(summary(loudness_min))
print(confint(loudness_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(loudness_min, list(press=80, temp=28, wind=20, humh=55)))

# make scatterplots with regression line
png("plots/new_york/loudness_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$windl, wt.sample$loudness)
if(!is.na(coef(loudness_min)["windl"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["windl"])}
dev.off()
png("plots/new_york/loudness_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$presh, wt.sample$loudness)
if(!is.na(coef(loudness_min)["presh"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["presh"])}
dev.off()
png("plots/new_york/loudness_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$temph, wt.sample$loudness)
if(!is.na(coef(loudness_min)["temph"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["temph"])}
dev.off()
png("plots/new_york/loudness_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$visl, wt.sample$loudness)
if(!is.na(coef(loudness_min)["visl"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["visl"])}
dev.off()
png("plots/new_york/loudness_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$huml, wt.sample$loudness)
if(!is.na(coef(loudness_min)["huml"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["huml"])}
dev.off()
png("plots/new_york/loudness_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$precip, wt.sample$loudness)
if(!is.na(coef(loudness_min)["precip"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["precip"])}
dev.off()

# close output file
sink()
save(loudness_min, file="models/new_york/loudness_min.saved")
rm(loudness_f, loudness_max, loudness_min)

## regression for dancability
sink("regressions/new_york/nyc_regression_dance.out")

# make linear model
dancability_f <- as.formula(paste("dancability ~ ", paste(weather)))
dancability_max = lm(dancability_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for dancability\n")
print(summary(dancability_max))

# stepwise regression on model
cat("\nMulti-regression for dancability\n")
(dancability_min = step(dancability_max, direction="backward"))
print(summary(dancability_min))
print(confint(dancability_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(dancability_min, list(press=80, temp=28, wind=20, humh=55)))

# make scatterplots with regression line
png("plots/new_york/dancability_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$windl, wt.sample$dancability)
if(!is.na(coef(dancability_min)["windl"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["windl"])}
dev.off()
png("plots/new_york/dancability_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$presh, wt.sample$dancability)
if(!is.na(coef(dancability_min)["presh"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["presh"])}
dev.off()
png("plots/new_york/dancability_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$temph, wt.sample$dancability)
if(!is.na(coef(dancability_min)["temph"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["temph"])}
dev.off()
png("plots/new_york/dancability_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$visl, wt.sample$dancability)
if(!is.na(coef(dancability_min)["visl"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["visl"])}
dev.off()
png("plots/new_york/dancability_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$huml, wt.sample$dancability)
if(!is.na(coef(dancability_min)["huml"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["huml"])}
dev.off()
png("plots/new_york/dancability_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(wt.sample$precip, wt.sample$dancability)
if(!is.na(coef(dancability_min)["precip"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["precip"])}
dev.off()

# close output file
sink()
save(dancability_min, file="models/new_york/dancability_min.saved")
rm(dancability_f, dancability_max, dancability_min)