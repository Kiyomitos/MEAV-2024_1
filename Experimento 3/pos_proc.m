%% Cleaning Service
clear all; clc; close all; clear memory;
%%
load("dados_experimento3.mat");
%%
plot(exp3_dados.Aspirador.NPS.freqVector, 20*log10(abs(exp3_dados.Aspirador.NPS.freqData)/(20e-6)));


%%
NPSlevel = ita_spk2frequencybands(exp3_dados.Aspirador.NPS,'bandsperoctave',3,'freqRange',[100 10000]);

plot(1:21, 20*log10(abs(NPSlevel.freqData/(20e-6))));
grid on;
xlim([1 21]);
ylim([0 85]);