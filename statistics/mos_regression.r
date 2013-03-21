setwd("G:/MyData/Human Centered Multimedia/Internet Information/Project/statdata")

# load data frame
load("mos_train1.saved")

# take a random sample for plotting
mos.wt.sample <- mos.wt[sample(1:nrow(mos.wt), 200, replace=FALSE),]
two_third_a4 <- 8.3 * 2/3 

# select weather features for regression
weather <- "mos.hail + mos.snow + mos.thunder + mos.rain + mos.fog + mos.presh + mos.presl + mos.press + mos.temph + mos.templ + mos.temp + mos.dewh + mos.dewl + mos.dew + mos.vish + mos.visl + mos.vis + mos.windh + mos.windl + mos.wind + mos.humh + mos.huml + mos.precip"
small_weather <- "mos.presl + mos.temph + mos.dew + mos.snowd + mos.vis + mos.wind"

## regression for key
sink("regressions/moscow/mos_regression_key.out")

# make linear model
key_f <- as.formula(paste("m.key ~ ", paste(weather)))
key_max = lm(key_f, data=mos.wt)

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
#print(predict(key_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplots with regression line
png("plots/moscow/key_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.key)
if(!is.na(coef(key_min)["mos.windl"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["mos.windl"])}
dev.off()
png("plots/moscow/key_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.key)
if(!is.na(coef(key_min)["mos.presh"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["mos.presh"])}
dev.off()
png("plots/moscow/key_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.key)
if(!is.na(coef(key_min)["mos.temph"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["mos.temph"])}
dev.off()
png("plots/moscow/key_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.key)
if(!is.na(coef(key_min)["mos.visl"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["mos.visl"])}
dev.off()
png("plots/moscow/key_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.key)
if(!is.na(coef(key_min)["mos.huml"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["mos.huml"])}
dev.off()
png("plots/moscow/key_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.key)
if(!is.na(coef(key_min)["mos.precip"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(key_min, file="models/moscow/key_min.saved")
rm(key_f, key_max, key_min)

## regression for energy
sink("regressions/moscow/mos_regression_energy.out")

# make linear model
energy_f <- as.formula(paste("m.energy ~ ", paste(weather)))
energy_max = lm(energy_f, data=mos.wt)

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
#print(predict(energy_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplot with regression line
png("plots/moscow/energy_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.energy)
if(!is.na(coef(energy_min)["mos.windl"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["mos.windl"])}
dev.off()
png("plots/moscow/energy_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.energy)
if(!is.na(coef(energy_min)["mos.presh"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["mos.presh"])}
dev.off()
png("plots/moscow/energy_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.energy)
if(!is.na(coef(energy_min)["mos.temph"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["mos.temph"])}
dev.off()
png("plots/moscow/energy_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.energy)
if(!is.na(coef(energy_min)["mos.visl"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["mos.visl"])}
dev.off()
png("plots/moscow/energy_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.energy)
if(!is.na(coef(energy_min)["mos.huml"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["mos.huml"])}
dev.off()
png("plots/moscow/energy_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.energy)
if(!is.na(coef(energy_min)["mos.precip"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(energy_min, file="models/moscow/energy_min.saved")
rm(energy_f, energy_max, energy_min)

## regression for liveness
sink("regressions/moscow/mos_regression_liveness.out")

# make linear model
liveness_f <- as.formula(paste("m.live ~ ", paste(weather)))
liveness_max = lm(liveness_f, data=mos.wt)

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
#print(predict(liveness_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplot with regression line
png("plots/moscow/liveness_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.live)
if(!is.na(coef(liveness_min)["mos.windl"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["mos.windl"])}
dev.off()
png("plots/moscow/liveness_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.live)
if(!is.na(coef(liveness_min)["mos.presh"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["mos.presh"])}
dev.off()
png("plots/moscow/liveness_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.live)
if(!is.na(coef(liveness_min)["mos.temph"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["mos.temph"])}
dev.off()
png("plots/moscow/liveness_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.live)
if(!is.na(coef(liveness_min)["mos.visl"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["mos.visl"])}
dev.off()
png("plots/moscow/liveness_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.live)
if(!is.na(coef(liveness_min)["mos.huml"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["mos.huml"])}
dev.off()
png("plots/moscow/liveness_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.live)
if(!is.na(coef(liveness_min)["mos.precip"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(liveness_min, file="models/moscow/liveness_min.saved")
rm(liveness_f, liveness_max, liveness_min)

## regression for tempo
sink("regressions/moscow/mos_regression_tempo.out")

# make linear model
tempo_f <- as.formula(paste("m.tempo ~ ", paste(weather)))
tempo_max = lm(tempo_f, data=mos.wt)

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
#print(predict(tempo_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplot with regression line
png("plots/moscow/tempo_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["mos.windl"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["mos.windl"])}
dev.off()
png("plots/moscow/tempo_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["mos.presh"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["mos.presh"])}
dev.off()
png("plots/moscow/tempo_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["mos.temph"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["mos.temph"])}
dev.off()
png("plots/moscow/tempo_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["mos.visl"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["mos.visl"])}
dev.off()
png("plots/moscow/tempo_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["mos.huml"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["mos.huml"])}
dev.off()
png("plots/moscow/tempo_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["mos.precip"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(tempo_min, file="models/moscow/tempo_min.saved")
rm(tempo_f, tempo_max, tempo_min)

## regression for speech
sink("regressions/moscow/mos_regression_speech.out")

# make linear model
speech_f <- as.formula(paste("m.speech ~ ", paste(weather)))
speech_max = lm(speech_f, data=mos.wt)

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
#print(predict(speech_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplot with regression line
png("plots/moscow/speech_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.speech)
if(!is.na(coef(speech_min)["mos.windl"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["mos.windl"])}
dev.off()
png("plots/moscow/speech_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.speech)
if(!is.na(coef(speech_min)["mos.presh"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["mos.presh"])}
dev.off()
png("plots/moscow/speech_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.speech)
if(!is.na(coef(speech_min)["mos.temph"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["mos.temph"])}
dev.off()
png("plots/moscow/speech_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.speech)
if(!is.na(coef(speech_min)["mos.visl"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["mos.visl"])}
dev.off()
png("plots/moscow/speech_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.speech)
if(!is.na(coef(speech_min)["mos.huml"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["mos.huml"])}
dev.off()
png("plots/moscow/speech_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.speech)
if(!is.na(coef(speech_min)["mos.precip"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(speech_min, file="models/moscow/speech_min.saved")
rm(speech_f, speech_max, speech_min)

## regression for mode
sink("regressions/moscow/mos_regression_mode.out")

# make linear model
mode_f <- as.formula(paste("m.mode ~ ", paste(weather)))
mode_max = lm(mode_f, data=mos.wt)

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
#print(predict(mode_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplot with regression line
png("plots/moscow/mode_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.mode)
if(!is.na(coef(mode_min)["mos.windl"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["mos.windl"])}
dev.off()
png("plots/moscow/mode_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.mode)
if(!is.na(coef(mode_min)["mos.presh"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["mos.presh"])}
dev.off()
png("plots/moscow/mode_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.mode)
if(!is.na(coef(mode_min)["mos.temph"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["mos.temph"])}
dev.off()
png("plots/moscow/mode_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.mode)
if(!is.na(coef(mode_min)["mos.visl"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["mos.visl"])}
dev.off()
png("plots/moscow/mode_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.mode)
if(!is.na(coef(mode_min)["mos.huml"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["mos.huml"])}
dev.off()
png("plots/moscow/mode_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.mode)
if(!is.na(coef(mode_min)["mos.precip"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(mode_min, file="models/moscow/mode_min.saved")
rm(mode_f, mode_max, mode_min)

## regression for time_signature
sink("regressions/moscow/mos_regression_t_sig.out")

# make linear model
time_signature_f <- as.formula(paste("m.t_sig ~ ", paste(weather)))
time_signature_max = lm(time_signature_f, data=mos.wt)

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
#print(predict(time_signature_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplots with regression line
png("plots/moscow/time_signature_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["mos.windl"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["mos.windl"])}
dev.off()
png("plots/moscow/time_signature_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["mos.presh"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["mos.presh"])}
dev.off()
png("plots/moscow/time_signature_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["mos.temph"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["mos.temph"])}
dev.off()
png("plots/moscow/time_signature_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["mos.visl"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["mos.visl"])}
dev.off()
png("plots/moscow/time_signature_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["mos.huml"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["mos.huml"])}
dev.off()
png("plots/moscow/time_signature_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["mos.precip"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(time_signature_min, file="models/moscow/time_signature_min.saved")
rm(time_signature_f, time_signature_max, time_signature_min)

## regression for duration
sink("regressions/moscow/mos_regression_dura.out")

# make linear model
duration_f <- as.formula(paste("m.dura ~ ", paste(weather)))
duration_max = lm(duration_f, data=mos.wt)

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
#print(predict(duration_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplots with regression line
png("plots/moscow/duration_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.dura)
if(!is.na(coef(duration_min)["mos.windl"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["mos.windl"])}
dev.off()
png("plots/moscow/duration_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.dura)
if(!is.na(coef(duration_min)["mos.presh"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["mos.presh"])}
dev.off()
png("plots/moscow/duration_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.dura)
if(!is.na(coef(duration_min)["mos.temph"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["mos.temph"])}
dev.off()
png("plots/moscow/duration_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.dura)
if(!is.na(coef(duration_min)["mos.visl"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["mos.visl"])}
dev.off()
png("plots/moscow/duration_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.dura)
if(!is.na(coef(duration_min)["mos.huml"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["mos.huml"])}
dev.off()
png("plots/moscow/duration_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.dura)
if(!is.na(coef(duration_min)["mos.precip"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(duration_min, file="models/moscow/duration_min.saved")
rm(duration_f, duration_max, duration_min)

## regression for loudness
sink("regressions/moscow/mos_regression_loud.out")

# make linear model
loudness_f <- as.formula(paste("m.loud ~ ", paste(weather)))
loudness_max = lm(loudness_f, data=mos.wt)

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
#print(predict(loudness_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplots with regression line
png("plots/moscow/loudness_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["mos.windl"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["mos.windl"])}
dev.off()
png("plots/moscow/loudness_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["mos.presh"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["mos.presh"])}
dev.off()
png("plots/moscow/loudness_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["mos.temph"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["mos.temph"])}
dev.off()
png("plots/moscow/loudness_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["mos.visl"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["mos.visl"])}
dev.off()
png("plots/moscow/loudness_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["mos.huml"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["mos.huml"])}
dev.off()
png("plots/moscow/loudness_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["mos.precip"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(loudness_min, file="models/moscow/loudness_min.saved")
rm(loudness_f, loudness_max, loudness_min)

## regression for dancability
sink("regressions/moscow/mos_regression_dance.out")

# make linear model
dancability_f <- as.formula(paste("m.dance ~ ", paste(weather)))
dancability_max = lm(dancability_f, data=mos.wt)

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
#print(predict(dancability_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplots with regression line
png("plots/moscow/dancability_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["mos.windl"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["mos.windl"])}
dev.off()
png("plots/moscow/dancability_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["mos.presh"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["mos.presh"])}
dev.off()
png("plots/moscow/dancability_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["mos.temph"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["mos.temph"])}
dev.off()
png("plots/moscow/dancability_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["mos.visl"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["mos.visl"])}
dev.off()
png("plots/moscow/dancability_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["mos.huml"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["mos.huml"])}
dev.off()
png("plots/moscow/dancability_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["mos.precip"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(dancability_min, file="models/moscow/dancability_min.saved")
rm(dancability_f, dancability_max, dancability_min)

## regression for hottnesss
sink("regressions/moscow/mos_regression_hott.out")

# make linear model
hottnesss_f <- as.formula(paste("m.hott ~ ", paste(weather)))
hottnesss_max = lm(hottnesss_f, data=mos.wt)

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
#print(predict(hottnesss_min, list(mos.press=80, mos.temp=28, mos.wind=20, mos.humh=55)))

# make scatterplots with regression line
png("plots/moscow/hottnesss_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.windl, mos.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["mos.windl"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["mos.windl"])}
dev.off()
png("plots/moscow/hottnesss_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.presh, mos.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["mos.presh"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["mos.presh"])}
dev.off()
png("plots/moscow/hottnesss_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.temph, mos.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["mos.temph"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["mos.temph"])}
dev.off()
png("plots/moscow/hottnesss_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.visl, mos.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["mos.visl"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["mos.visl"])}
dev.off()
png("plots/moscow/hottnesss_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.huml, mos.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["mos.huml"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["mos.huml"])}
dev.off()
png("plots/moscow/hottnesss_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(mos.wt.sample$mos.precip, mos.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["mos.precip"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["mos.precip"])}
dev.off()

# close output file
sink()
save(hottnesss_min, file="models/moscow/hottnesss_min.saved")
rm(hottnesss_f, hottnesss_max, hottnesss_min)

# regression diagnostic plots
# png("plots/moscow/dancability_min_diag.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
# layout(matrix(1:4, ncol = 2))
# plot(dancability_min)
# layout(1)
# dev.off()

# select features to plot
mos.sub <- subset(mos.wt, select=c(art.fam:art.long, mos.press, mos.temp, mos.wind, mos.humh, metro))

# plot a matrix of scatterplots / correlations (of samples)
# library(GGally)
# ggpairs(mos.sub.sample, diag=list(continuous="density", discrete="bar"), colour="metro", axisLabels="show")
# ggsave("plots/moscow/mos_wt_sample.pdf")