setwd("G:/MyData/Human Centered Multimedia/Internet Information/Project/statdata")

# load data frame
load("sao_train1.saved")

# take a random sample for plotting
sao.wt.sample <- sao.wt[sample(1:nrow(sao.wt), 200, replace=FALSE),]
two_third_a4 <- 8.3 * 2/3 

# select weather features for regression
weather <- "sao.hail + sao.thunder + sao.rain + sao.fog + sao.presh + sao.presl + sao.press + sao.temph + sao.templ + sao.temp + sao.dewh + sao.dewl + sao.dew + sao.vish + sao.visl + sao.vis + sao.windh + sao.windl + sao.wind + sao.humh + sao.huml + sao.precip"
small_weather <- "sao.presl + sao.temph + sao.dew + sao.snowd + sao.vis + sao.wind"

## regression for key
sink("regressions/sao_paulo/sao_regression_key.out")

# make linear model
key_f <- as.formula(paste("m.key ~ ", paste(weather)))
key_max = lm(key_f, data=sao.wt)

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
#print(predict(key_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplots with regression line
png("plots/sao_paulo/key_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.key)
if(!is.na(coef(key_min)["sao.windl"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/key_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.key)
if(!is.na(coef(key_min)["sao.presh"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/key_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.key)
if(!is.na(coef(key_min)["sao.temph"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/key_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.key)
if(!is.na(coef(key_min)["sao.visl"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/key_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.key)
if(!is.na(coef(key_min)["sao.huml"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/key_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.key)
if(!is.na(coef(key_min)["sao.precip"])){abline(coef(key_min)["(Intercept)"], coef(key_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(key_min, file="models/sao_paulo/key_min.saved")
rm(key_f, key_max, key_min)

## regression for energy
sink("regressions/sao_paulo/sao_regression_energy.out")

# make linear model
energy_f <- as.formula(paste("m.energy ~ ", paste(weather)))
energy_max = lm(energy_f, data=sao.wt)

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
#print(predict(energy_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplot with regression line
png("plots/sao_paulo/energy_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.energy)
if(!is.na(coef(energy_min)["sao.windl"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/energy_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.energy)
if(!is.na(coef(energy_min)["sao.presh"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/energy_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.energy)
if(!is.na(coef(energy_min)["sao.temph"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/energy_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.energy)
if(!is.na(coef(energy_min)["sao.visl"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/energy_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.energy)
if(!is.na(coef(energy_min)["sao.huml"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/energy_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.energy)
if(!is.na(coef(energy_min)["sao.precip"])){abline(coef(energy_min)["(Intercept)"], coef(energy_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(energy_min, file="models/sao_paulo/energy_min.saved")
rm(energy_f, energy_max, energy_min)

## regression for liveness
sink("regressions/sao_paulo/sao_regression_liveness.out")

# make linear model
liveness_f <- as.formula(paste("m.live ~ ", paste(weather)))
liveness_max = lm(liveness_f, data=sao.wt)

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
#print(predict(liveness_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplot with regression line
png("plots/sao_paulo/liveness_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.live)
if(!is.na(coef(liveness_min)["sao.windl"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/liveness_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.live)
if(!is.na(coef(liveness_min)["sao.presh"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/liveness_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.live)
if(!is.na(coef(liveness_min)["sao.temph"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/liveness_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.live)
if(!is.na(coef(liveness_min)["sao.visl"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/liveness_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.live)
if(!is.na(coef(liveness_min)["sao.huml"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/liveness_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.live)
if(!is.na(coef(liveness_min)["sao.precip"])){abline(coef(liveness_min)["(Intercept)"], coef(liveness_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(liveness_min, file="models/sao_paulo/liveness_min.saved")
rm(liveness_f, liveness_max, liveness_min)

## regression for tempo
sink("regressions/sao_paulo/sao_regression_tempo.out")

# make linear model
tempo_f <- as.formula(paste("m.tempo ~ ", paste(weather)))
tempo_max = lm(tempo_f, data=sao.wt)

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
#print(predict(tempo_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplot with regression line
png("plots/sao_paulo/tempo_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["sao.windl"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/tempo_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["sao.presh"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/tempo_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["sao.temph"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/tempo_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["sao.visl"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/tempo_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["sao.huml"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/tempo_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.tempo)
if(!is.na(coef(tempo_min)["sao.precip"])){abline(coef(tempo_min)["(Intercept)"], coef(tempo_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(tempo_min, file="models/sao_paulo/tempo_min.saved")
rm(tempo_f, tempo_max, tempo_min)

## regression for speech
sink("regressions/sao_paulo/sao_regression_speech.out")

# make linear model
speech_f <- as.formula(paste("m.speech ~ ", paste(weather)))
speech_max = lm(speech_f, data=sao.wt)

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
#print(predict(speech_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplot with regression line
png("plots/sao_paulo/speech_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.speech)
if(!is.na(coef(speech_min)["sao.windl"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/speech_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.speech)
if(!is.na(coef(speech_min)["sao.presh"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/speech_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.speech)
if(!is.na(coef(speech_min)["sao.temph"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/speech_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.speech)
if(!is.na(coef(speech_min)["sao.visl"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/speech_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.speech)
if(!is.na(coef(speech_min)["sao.huml"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/speech_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.speech)
if(!is.na(coef(speech_min)["sao.precip"])){abline(coef(speech_min)["(Intercept)"], coef(speech_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(speech_min, file="models/sao_paulo/speech_min.saved")
rm(speech_f, speech_max, speech_min)

## regression for mode
sink("regressions/sao_paulo/sao_regression_mode.out")

# make linear model
mode_f <- as.formula(paste("m.mode ~ ", paste(weather)))
mode_max = lm(mode_f, data=sao.wt)

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
#print(predict(mode_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplot with regression line
png("plots/sao_paulo/mode_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.mode)
if(!is.na(coef(mode_min)["sao.windl"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/mode_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.mode)
if(!is.na(coef(mode_min)["sao.presh"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/mode_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.mode)
if(!is.na(coef(mode_min)["sao.temph"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/mode_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.mode)
if(!is.na(coef(mode_min)["sao.visl"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/mode_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.mode)
if(!is.na(coef(mode_min)["sao.huml"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/mode_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.mode)
if(!is.na(coef(mode_min)["sao.precip"])){abline(coef(mode_min)["(Intercept)"], coef(mode_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(mode_min, file="models/sao_paulo/mode_min.saved")
rm(mode_f, mode_max, mode_min)

## regression for time_signature
sink("regressions/sao_paulo/sao_regression_t_sig.out")

# make linear model
time_signature_f <- as.formula(paste("m.t_sig ~ ", paste(weather)))
time_signature_max = lm(time_signature_f, data=sao.wt)

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
#print(predict(time_signature_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplots with regression line
png("plots/sao_paulo/time_signature_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["sao.windl"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/time_signature_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["sao.presh"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/time_signature_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["sao.temph"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/time_signature_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["sao.visl"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/time_signature_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["sao.huml"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/time_signature_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.t_sig)
if(!is.na(coef(time_signature_min)["sao.precip"])){abline(coef(time_signature_min)["(Intercept)"], coef(time_signature_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(time_signature_min, file="models/sao_paulo/time_signature_min.saved")
rm(time_signature_f, time_signature_max, time_signature_min)

## regression for duration
sink("regressions/sao_paulo/sao_regression_dura.out")

# make linear model
duration_f <- as.formula(paste("m.dura ~ ", paste(weather)))
duration_max = lm(duration_f, data=sao.wt)

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
#print(predict(duration_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplots with regression line
png("plots/sao_paulo/duration_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.dura)
if(!is.na(coef(duration_min)["sao.windl"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/duration_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.dura)
if(!is.na(coef(duration_min)["sao.presh"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/duration_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.dura)
if(!is.na(coef(duration_min)["sao.temph"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/duration_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.dura)
if(!is.na(coef(duration_min)["sao.visl"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/duration_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.dura)
if(!is.na(coef(duration_min)["sao.huml"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/duration_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.dura)
if(!is.na(coef(duration_min)["sao.precip"])){abline(coef(duration_min)["(Intercept)"], coef(duration_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(duration_min, file="models/sao_paulo/duration_min.saved")
rm(duration_f, duration_max, duration_min)

## regression for loudness
sink("regressions/sao_paulo/sao_regression_loud.out")

# make linear model
loudness_f <- as.formula(paste("m.loud ~ ", paste(weather)))
loudness_max = lm(loudness_f, data=sao.wt)

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
#print(predict(loudness_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplots with regression line
png("plots/sao_paulo/loudness_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["sao.windl"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/loudness_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["sao.presh"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/loudness_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["sao.temph"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/loudness_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["sao.visl"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/loudness_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["sao.huml"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/loudness_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.loud)
if(!is.na(coef(loudness_min)["sao.precip"])){abline(coef(loudness_min)["(Intercept)"], coef(loudness_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(loudness_min, file="models/sao_paulo/loudness_min.saved")
rm(loudness_f, loudness_max, loudness_min)

## regression for dancability
sink("regressions/sao_paulo/sao_regression_dance.out")

# make linear model
dancability_f <- as.formula(paste("m.dance ~ ", paste(weather)))
dancability_max = lm(dancability_f, data=sao.wt)

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
#print(predict(dancability_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplots with regression line
png("plots/sao_paulo/dancability_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["sao.windl"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/dancability_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["sao.presh"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/dancability_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["sao.temph"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/dancability_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["sao.visl"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/dancability_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["sao.huml"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/dancability_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.dance)
if(!is.na(coef(dancability_min)["sao.precip"])){abline(coef(dancability_min)["(Intercept)"], coef(dancability_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(dancability_min, file="models/sao_paulo/dancability_min.saved")
rm(dancability_f, dancability_max, dancability_min)

## regression for hottnesss
sink("regressions/sao_paulo/sao_regression_hott.out")

# make linear model
hottnesss_f <- as.formula(paste("m.hott ~ ", paste(weather)))
hottnesss_max = lm(hottnesss_f, data=sao.wt)

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
#print(predict(hottnesss_min, list(sao.press=80, sao.temp=28, sao.wind=20, sao.humh=55)))

# make scatterplots with regression line
png("plots/sao_paulo/hottnesss_windl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.windl, sao.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["sao.windl"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["sao.windl"])}
dev.off()
png("plots/sao_paulo/hottnesss_presh.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.presh, sao.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["sao.presh"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["sao.presh"])}
dev.off()
png("plots/sao_paulo/hottnesss_temph.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.temph, sao.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["sao.temph"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["sao.temph"])}
dev.off()
png("plots/sao_paulo/hottnesss_visl.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.visl, sao.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["sao.visl"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["sao.visl"])}
dev.off()
png("plots/sao_paulo/hottnesss_huml.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.huml, sao.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["sao.huml"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["sao.huml"])}
dev.off()
png("plots/sao_paulo/hottnesss_precip.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
plot(sao.wt.sample$sao.precip, sao.wt.sample$m.hott)
if(!is.na(coef(hottnesss_min)["sao.precip"])){abline(coef(hottnesss_min)["(Intercept)"], coef(hottnesss_min)["sao.precip"])}
dev.off()

# close output file
sink()
save(hottnesss_min, file="models/sao_paulo/hottnesss_min.saved")
rm(hottnesss_f, hottnesss_max, hottnesss_min)

# regression diagnostic plots
# png("plots/sao_paulo/dancability_min_diag.png", width=two_third_a4, height=two_third_a4, units="in", res=300)
# layout(matrix(1:4, ncol = 2))
# plot(dancability_min)
# layout(1)
# dev.off()

# select features to plot
sao.sub <- subset(sao.wt, select=c(art.fam:art.long, sao.press, sao.temp, sao.wind, sao.humh, metro))

# plot a matrix of scatterplots / correlations (of samples)
# library(GGally)
# ggpairs(sao.sub.sample, diag=list(continuous="density", discrete="bar"), colour="metro", axisLabels="show")
# ggsave("plots/sao_paulo/sao_wt_sample.pdf")