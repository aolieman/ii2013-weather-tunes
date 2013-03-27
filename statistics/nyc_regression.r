setwd("G:/MyData/Human Centered Multimedia/Internet Information/Project/statdata")

# load data frame
load("nyc_train1.saved")

# take a random sample for plotting
nyc.wt.sample <- nyc.wt[sample(1:nrow(nyc.wt), 200, replace=FALSE),]
two_third_a4 <- 8.3 * 2/3 

# select weather features for regression (excl. hail and tornado)
weather <- "nyc.snow + nyc.thunder + nyc.rain + nyc.fog + nyc.presh + nyc.presl + nyc.press + nyc.temph + nyc.templ + nyc.temp + nyc.dewh + nyc.dewl + nyc.dew + nyc.snowd + nyc.vish + nyc.visl + nyc.vis + nyc.windh + nyc.windl + nyc.wind + nyc.humh + nyc.huml + nyc.precip + nyc.snowf"
small_weather <- "nyc.presl + nyc.temph + nyc.dew + nyc.snowd + nyc.vis + nyc.wind"

## regression for key
sink("regressions/new_york/nyc_regression_key.out")

# make linear model
key_f <- as.formula(paste("m.key ~ ", paste(weather)))
key_max = lm(key_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for key\n")
print(summary(key_max))

# stepwise regression on model
cat("\nMulti-regression for key\n")
(key_min = step(key_max, direction="backward"))
print(summary(key_min))
print(confint(key_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(energy_min, list(nyc.windh=25, nyc.windl=0, nyc.hail=0, nyc.snowf=0, nyc.vis=8.6, nyc.vish=10, nyc.dewh=-8, nyc.thunder=0, nyc.dewl=-12, nyc.snow=1, nyc.humh=93, nyc.fog=1, nyc.huml=74, nyc.presh=1032, nyc.presl=1017, nyc.hum=86, nyc.temph=-6, nyc.rain=1, nyc.templ=-10, nyc.press=1025.8, nyc.snowd=3, nyc.visl=3, nyc.temp=-8, nyc.dew=-10, nyc.precip=5, nyc.wind=15), interval="pred"))

# make scatterplots with regression line
png("plots/new_york/key_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.key)
if(!is.na(coef(key_min)["nyc.windl"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["nyc.windl"])}
dev.off()
png("plots/new_york/key_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.key)
if(!is.na(coef(key_min)["nyc.presh"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["nyc.presh"])}
dev.off()
png("plots/new_york/key_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.key)
if(!is.na(coef(key_min)["nyc.temph"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["nyc.temph"])}
dev.off()
png("plots/new_york/key_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.key)
if(!is.na(coef(key_min)["nyc.visl"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["nyc.visl"])}
dev.off()
png("plots/new_york/key_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.key)
if(!is.na(coef(key_min)["nyc.huml"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["nyc.huml"])}
dev.off()
png("plots/new_york/key_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.key)
if(!is.na(coef(key_min)["nyc.precip"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(key_min, file="models/new_york/key_min.saved")
rm(key_f, key_max, key_min)

## regression for energy
sink("regressions/new_york/nyc_regression_energy.out")

# make linear model
energy_f <- as.formula(paste("m.energy ~ ", paste(weather)))
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
#print(predict(energy_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplot with regression line
png("plots/new_york/energy_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.energy)
if(!is.na(coef(energy_min)["nyc.windl"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["nyc.windl"])}
dev.off()
png("plots/new_york/energy_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.energy)
if(!is.na(coef(energy_min)["nyc.presh"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["nyc.presh"])}
dev.off()
png("plots/new_york/energy_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.energy)
if(!is.na(coef(energy_min)["nyc.temph"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["nyc.temph"])}
dev.off()
png("plots/new_york/energy_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.energy)
if(!is.na(coef(energy_min)["nyc.visl"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["nyc.visl"])}
dev.off()
png("plots/new_york/energy_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.energy)
if(!is.na(coef(energy_min)["nyc.huml"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["nyc.huml"])}
dev.off()
png("plots/new_york/energy_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.energy)
if(!is.na(coef(energy_min)["nyc.precip"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(energy_min, file="models/new_york/energy_min.saved")
rm(energy_f, energy_max, energy_min)

## regression for liveness
sink("regressions/new_york/nyc_regression_liveness.out")

# make linear model
liveness_f <- as.formula(paste("m.live ~ ", paste(weather)))
liveness_max = lm(liveness_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for liveness\n")
print(summary(liveness_max))

# stepwise regression on model
cat("\nMulti-regression for liveness\n")
(liveness_min = step(liveness_max, direction="backward"))
print(summary(liveness_min))
print(confint(liveness_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(liveness_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplot with regression line
png("plots/new_york/liveness_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.live)
if(!is.na(coef(liveness_min)["nyc.windl"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["nyc.windl"])}
dev.off()
png("plots/new_york/liveness_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.live)
if(!is.na(coef(liveness_min)["nyc.presh"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["nyc.presh"])}
dev.off()
png("plots/new_york/liveness_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.live)
if(!is.na(coef(liveness_min)["nyc.temph"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["nyc.temph"])}
dev.off()
png("plots/new_york/liveness_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.live)
if(!is.na(coef(liveness_min)["nyc.visl"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["nyc.visl"])}
dev.off()
png("plots/new_york/liveness_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.live)
if(!is.na(coef(liveness_min)["nyc.huml"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["nyc.huml"])}
dev.off()
png("plots/new_york/liveness_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.live)
if(!is.na(coef(liveness_min)["nyc.precip"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(liveness_min, file="models/new_york/liveness_min.saved")
rm(liveness_f, liveness_max, liveness_min)

## regression for tempo
sink("regressions/new_york/nyc_regression_tempo.out")

# make linear model
tempo_f <- as.formula(paste("m.tempo ~ ", paste(weather)))
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
#print(predict(tempo_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplot with regression line
png("plots/new_york/tempo_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["nyc.windl"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["nyc.windl"])}
dev.off()
png("plots/new_york/tempo_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["nyc.presh"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["nyc.presh"])}
dev.off()
png("plots/new_york/tempo_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["nyc.temph"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["nyc.temph"])}
dev.off()
png("plots/new_york/tempo_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["nyc.visl"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["nyc.visl"])}
dev.off()
png("plots/new_york/tempo_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["nyc.huml"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["nyc.huml"])}
dev.off()
png("plots/new_york/tempo_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["nyc.precip"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(tempo_min, file="models/new_york/tempo_min.saved")
rm(tempo_f, tempo_max, tempo_min)

## regression for speech
sink("regressions/new_york/nyc_regression_speech.out")

# make linear model
speech_f <- as.formula(paste("m.speech ~ ", paste(weather)))
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
#print(predict(speech_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplot with regression line
png("plots/new_york/speech_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.speech)
if(!is.na(coef(speech_min)["nyc.windl"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["nyc.windl"])}
dev.off()
png("plots/new_york/speech_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.speech)
if(!is.na(coef(speech_min)["nyc.presh"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["nyc.presh"])}
dev.off()
png("plots/new_york/speech_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.speech)
if(!is.na(coef(speech_min)["nyc.temph"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["nyc.temph"])}
dev.off()
png("plots/new_york/speech_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.speech)
if(!is.na(coef(speech_min)["nyc.visl"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["nyc.visl"])}
dev.off()
png("plots/new_york/speech_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.speech)
if(!is.na(coef(speech_min)["nyc.huml"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["nyc.huml"])}
dev.off()
png("plots/new_york/speech_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.speech)
if(!is.na(coef(speech_min)["nyc.precip"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(speech_min, file="models/new_york/speech_min.saved")
rm(speech_f, speech_max, speech_min)

## regression for mode
sink("regressions/new_york/nyc_regression_mode.out")

# make linear model
mode_f <- as.formula(paste("m.mode ~ ", paste(weather)))
mode_max = lm(mode_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for mode\n")
print(summary(mode_max))

# stepwise regression on model
cat("\nMulti-regression for mode\n")
(mode_min = step(mode_max, direction="backward"))
print(summary(mode_min))
print(confint(mode_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(mode_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplot with regression line
png("plots/new_york/mode_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.mode)
if(!is.na(coef(mode_min)["nyc.windl"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["nyc.windl"])}
dev.off()
png("plots/new_york/mode_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.mode)
if(!is.na(coef(mode_min)["nyc.presh"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["nyc.presh"])}
dev.off()
png("plots/new_york/mode_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.mode)
if(!is.na(coef(mode_min)["nyc.temph"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["nyc.temph"])}
dev.off()
png("plots/new_york/mode_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.mode)
if(!is.na(coef(mode_min)["nyc.visl"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["nyc.visl"])}
dev.off()
png("plots/new_york/mode_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.mode)
if(!is.na(coef(mode_min)["nyc.huml"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["nyc.huml"])}
dev.off()
png("plots/new_york/mode_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.mode)
if(!is.na(coef(mode_min)["nyc.precip"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(mode_min, file="models/new_york/mode_min.saved")
rm(mode_f, mode_max, mode_min)

## regression for time_signature
sink("regressions/new_york/nyc_regression_t_sig.out")

# make linear model
time_signature_f <- as.formula(paste("m.t_sig ~ ", paste(weather)))
time_signature_max = lm(time_signature_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for time_signature\n")
print(summary(time_signature_max))

# stepwise regression on model
cat("\nMulti-regression for time_signature\n")
(time_signature_min = step(time_signature_max, direction="backward"))
print(summary(time_signature_min))
print(confint(time_signature_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(time_signature_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplots with regression line
png("plots/new_york/time_signature_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["nyc.windl"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["nyc.windl"])}
dev.off()
png("plots/new_york/time_signature_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["nyc.presh"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["nyc.presh"])}
dev.off()
png("plots/new_york/time_signature_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["nyc.temph"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["nyc.temph"])}
dev.off()
png("plots/new_york/time_signature_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["nyc.visl"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["nyc.visl"])}
dev.off()
png("plots/new_york/time_signature_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["nyc.huml"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["nyc.huml"])}
dev.off()
png("plots/new_york/time_signature_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["nyc.precip"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(time_signature_min, file="models/new_york/time_signature_min.saved")
rm(time_signature_f, time_signature_max, time_signature_min)

## regression for duration
sink("regressions/new_york/nyc_regression_dura.out")

# make linear model
duration_f <- as.formula(paste("m.dura ~ ", paste(weather)))
duration_max = lm(duration_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for duration\n")
print(summary(duration_max))

# stepwise regression on model
cat("\nMulti-regression for duration\n")
(duration_min = step(duration_max, direction="backward"))
print(summary(duration_min))
print(confint(duration_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(duration_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplots with regression line
png("plots/new_york/duration_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.dura)
if(!is.na(coef(duration_min)["nyc.windl"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["nyc.windl"])}
dev.off()
png("plots/new_york/duration_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.dura)
if(!is.na(coef(duration_min)["nyc.presh"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["nyc.presh"])}
dev.off()
png("plots/new_york/duration_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.dura)
if(!is.na(coef(duration_min)["nyc.temph"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["nyc.temph"])}
dev.off()
png("plots/new_york/duration_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.dura)
if(!is.na(coef(duration_min)["nyc.visl"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["nyc.visl"])}
dev.off()
png("plots/new_york/duration_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.dura)
if(!is.na(coef(duration_min)["nyc.huml"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["nyc.huml"])}
dev.off()
png("plots/new_york/duration_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.dura)
if(!is.na(coef(duration_min)["nyc.precip"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(duration_min, file="models/new_york/duration_min.saved")
rm(duration_f, duration_max, duration_min)

## regression for loudness
sink("regressions/new_york/nyc_regression_loud.out")

# make linear model
loudness_f <- as.formula(paste("m.loud ~ ", paste(weather)))
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
#print(predict(loudness_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplots with regression line
png("plots/new_york/loudness_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["nyc.windl"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["nyc.windl"])}
dev.off()
png("plots/new_york/loudness_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["nyc.presh"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["nyc.presh"])}
dev.off()
png("plots/new_york/loudness_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["nyc.temph"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["nyc.temph"])}
dev.off()
png("plots/new_york/loudness_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["nyc.visl"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["nyc.visl"])}
dev.off()
png("plots/new_york/loudness_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["nyc.huml"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["nyc.huml"])}
dev.off()
png("plots/new_york/loudness_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["nyc.precip"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(loudness_min, file="models/new_york/loudness_min.saved")
rm(loudness_f, loudness_max, loudness_min)

## regression for dancability
sink("regressions/new_york/nyc_regression_dance.out")

# make linear model
dancability_f <- as.formula(paste("m.dance ~ ", paste(weather)))
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
#print(predict(dancability_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplots with regression line
png("plots/new_york/dancability_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["nyc.windl"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["nyc.windl"])}
dev.off()
png("plots/new_york/dancability_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["nyc.presh"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["nyc.presh"])}
dev.off()
png("plots/new_york/dancability_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["nyc.temph"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["nyc.temph"])}
dev.off()
png("plots/new_york/dancability_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["nyc.visl"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["nyc.visl"])}
dev.off()
png("plots/new_york/dancability_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["nyc.huml"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["nyc.huml"])}
dev.off()
png("plots/new_york/dancability_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["nyc.precip"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(dancability_min, file="models/new_york/dancability_min.saved")
rm(dancability_f, dancability_max, dancability_min)

## regression for hottnesss
sink("regressions/new_york/nyc_regression_hott.out")

# make linear model
hottnesss_f <- as.formula(paste("m.hott ~ ", paste(weather)))
hottnesss_max = lm(hottnesss_f, data=nyc.wt)

# summarize linear model
cat("\nSummary for hottnesss\n")
print(summary(hottnesss_max))

# stepwise regression on model
cat("\nMulti-regression for hottnesss\n")
(hottnesss_min = step(hottnesss_max, direction="backward"))
print(summary(hottnesss_min))
print(confint(hottnesss_min))

# try to predict for given weather
cat("\nPrediction for given weather\n")
#print(predict(hottnesss_min, list(nyc.press=80, nyc.temp=28, nyc.wind=20, nyc.humh=55)))

# make scatterplots with regression line
png("plots/new_york/hottnesss_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.windl, nyc.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["nyc.windl"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["nyc.windl"])}
dev.off()
png("plots/new_york/hottnesss_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.presh, nyc.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["nyc.presh"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["nyc.presh"])}
dev.off()
png("plots/new_york/hottnesss_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.temph, nyc.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["nyc.temph"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["nyc.temph"])}
dev.off()
png("plots/new_york/hottnesss_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.visl, nyc.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["nyc.visl"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["nyc.visl"])}
dev.off()
png("plots/new_york/hottnesss_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.huml, nyc.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["nyc.huml"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["nyc.huml"])}
dev.off()
png("plots/new_york/hottnesss_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(nyc.wt.sample$nyc.precip, nyc.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["nyc.precip"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["nyc.precip"])}
dev.off()

# close output file
sink()
save(hottnesss_min, file="models/new_york/hottnesss_min.saved")
rm(hottnesss_f, hottnesss_max, hottnesss_min)

# regression diagnostic plots
# png("plots/new_york/dancability_min_diag.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
# layout(matrix(1:4, ncol = 2))
# plot(dancability_min)
# layout(1)
# dev.off()

# select features to plot
nyc.sub <- subset(nyc.wt, select=c(art.fam:art.long, nyc.press, nyc.temp, nyc.wind, nyc.humh, metro))

# plot a matrix of scatterplots / correlations (of samples)
# library(GGally)
# ggpairs(nyc.sub.sample, diag=list(continuous="density", discrete="bar"), colour="metro", axisLabels="show")
# ggsave("plots/new_york/nyc_wt_sample.pdf")