%%% MEAV 2024.1 - Experimento 2 - Pós processamento %%
%%% Cálculo de incertezas de medição                %%
%%% Aluno: Victor Kiyomi                            %%
%%% Matrícula: 201920089                            %%
%%% Data: 25/04/2024                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cleaning service

clear all; format long; clc; close all;

load("exp2_dados.mat");

[~, freqtick] = freqBands(3.5, 'range', [100 10000]);
%% Infos da medição
n = 2; % Número de decaimentos por posição de medição
N = 6; % Número de pares fonte-receptor
%% Cálculo de incerteza da medição de TR -- Ruído interrompido, desvio-padrão do T20
% Sem material
exp2_dados.Incerteza.Ruido_interrompido.Sem_material = [];

for i=1:length(exp2_dados.TR_abs.Ruido_interrompido.Sem_Material)
    exp2_dados.Incerteza.Ruido_interrompido.Sem_material(i) = 0.88*exp2_dados.TR_abs.Ruido_interrompido.Sem_Material(i)*sqrt( ...
        (1+(1.19/n))/(N*0.71*freqtick(i)*exp2_dados.TR_abs.Ruido_interrompido.Sem_Material(i)));
end

% Com material
exp2_dados.Incerteza.Ruido_interrompido.Com_material = [];

for i=1:length(exp2_dados.TR_abs.Ruido_interrompido.Com_Material)
    exp2_dados.Incerteza.Ruido_interrompido.Com_material(i) = 0.88*exp2_dados.TR_abs.Ruido_interrompido.Com_Material(i)*sqrt( ...
        (1+(1.19/n))/(N*0.71*freqtick(i)*exp2_dados.TR_abs.Ruido_interrompido.Com_Material(i)));
end
%% Cálculo de incerteza da medição de TR -- Sweep, desvio-padrão do T20