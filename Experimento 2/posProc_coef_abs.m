%%% MEAV 2024.1 - Experimento 2 - Pós processamento %%
%%% Cálculo do coeficiente de absorção do material  %%
%%% Aluno: Victor Kiyomi                            %%
%%% Matrícula: 201920089                            %%
%%% Data: 25/04/2024                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cleaning service

clear all; format long; clc; close all;
%% Parâmetros
p_atm = 1008e2; % Pressão atmosférica (medida no barometro estava em hPa) [Pa]
u0 = 74; % Umidade relativa dentro da câmara no início da medição de TR (sem a amostra) [%]
uf = 75; % Umidade relativa dentro da câmara no final da medição de TR (com a amostra) [%]
t0 = 23; % Temperatura dentro da câmara no início da medição de TR (sem a amostra) [°C]
tf = 22; % Temperatura dentro da câmara no final da medição de TR (com a amostra) [°C]
c0 = 331+0.6*t0; % Velocidade do som no início da medição de TR (sem a amostra) [m/s]
cf = 331+0.6*tf; % Velocidade do som no final da medição de TR (com a amostra) [m/s]
v_cr = 206; % Volume da câmara revereberante
h_amostra = 25e-3; % Altura (height) da amostra [m]
w_amostra = 4.4; % Profundidade (width) da amostra [m]
l_amostra = 2.5; % Comprimento (length) da amostra [m]
area_superficial_amostra = w_amostra*l_amostra; % [m^2]
area_bordas_amostra = 2*h_amostra*(w_amostra+l_amostra); % [m^2]
area_total = area_superficial_amostra+area_bordas_amostra; % (S) [m^2]

%% Cálculo do coeficiente de abs. sonora
% Como houve variação de 1°C e a variação de umidade foi de 2%,
% não serão calculados os parâmetros m1 e m2 de absorção sonora do ar.
%% Processamento de tempo de reverberação -- Médias
load("exp2_dados.mat");

%%
% Método Sweep -- ITA Toolbox
exp2_dados.Coef_abs.Sweep.ITAToolbox = [];
for i=1:length(exp2_dados.TR_abs.Sweep.ITAToolbox.Sem_material)
    exp2_dados.Coef_abs.Sweep.ITAToolbox(i) = 55.3*v_cr*(1/(cf.*exp2_dados.TR_abs.Sweep.ITAToolbox.Com_material(i))- ...
        (1/(c0.*exp2_dados.TR_abs.Sweep.ITAToolbox.Sem_material(i))))./area_superficial_amostra;
end

% Método Sweep -- Integral Cumulativa Reversa
exp2_dados.Coef_abs.Sweep.IRC = [];
for i=1:length(exp2_dados.TR_abs.Sweep.IRC.Sem_material)
    exp2_dados.Coef_abs.Sweep.IRC(i) = 55.3*v_cr*(1/(cf.*exp2_dados.TR_abs.Sweep.IRC.Com_material(i))- ...
        (1/(c0.*exp2_dados.TR_abs.Sweep.IRC.Sem_material(i))))./area_superficial_amostra;
end

% Método Sweep -- Integral Cumulativa Reversa
exp2_dados.Coef_abs.Ruido_interrompido = [];
for i=1:length(exp2_dados.TR_abs.Ruido_interrompido.Sem_Material)
    exp2_dados.Coef_abs.Ruido_interrompido(i) = 55.3*v_cr*(1/(cf.*exp2_dados.TR_abs.Ruido_interrompido.Com_Material(i))- ...
        (1/(c0.*exp2_dados.TR_abs.Ruido_interrompido.Sem_Material(i))))./area_superficial_amostra;
end

%%
% save('exp2_dados.mat', "exp2_dados", '-mat');

%% Coef. de abs prático
[vec, freqtick] = freqBands(1, 'range', [250 4000]);
alpha = []; 
alpha(1, 1) = round(mean(exp2_dados.Coef_abs.Sweep.ITAToolbox(4:6, :))*20)/20; 
alpha(2, 1) = round(mean(exp2_dados.Coef_abs.Sweep.ITAToolbox(7:9, :))*20)/20; 
alpha(3, 1) = round(mean(exp2_dados.Coef_abs.Sweep.ITAToolbox(10:12, :))*20)/20; 
alpha(4, 1) = round(mean(exp2_dados.Coef_abs.Sweep.ITAToolbox(13:15, :))*20)/20; 
alpha(5, 1) = round(mean(exp2_dados.Coef_abs.Sweep.ITAToolbox(16:18, :))*20)/20;

% Curvas de ref
alpha_ref = [
    0.05 0.25 0.25 0.25 0.15;
    0.1 0.3 0.3 0.3 0.2;
    0.15 0.35 0.35 0.35 0.25;
    0.2 0.4 0.4 0.4 0.3;
    0.25 0.45 0.45 0.45 0.35;
    0.3 0.5 0.5 0.5 0.4;
    0.35 0.55 0.55 0.55 0.45;
    0.4 0.6 0.6 0.6 0.5;
    0.45 0.65 0.65 0.65 0.55;
    0.5 0.7 0.7 0.7 0.6;
    0.55 0.75 0.75 0.75 0.65;
    0.6 0.8 0.8 0.8 0.7;
    0.65 0.85 0.85 0.85 0.75;
    0.7 0.9 0.9 0.9 0.8;
    0.75 0.95 0.95 0.95 0.85;
    0.8 1 1 1 0.9;
    ];

% Plot da curva de abs. prática
fig = figure();
plot(vec, alpha, 'r', 'LineWidth', 2); hold on;
plot (vec, alpha_ref(1, :));
plot (vec, alpha_ref(2, :));
plot (vec, alpha_ref(3, :));
plot (vec, alpha_ref(4, :));
plot (vec, alpha_ref(5, :));
plot (vec, alpha_ref(6, :));
plot (vec, alpha_ref(7, :));
plot (vec, alpha_ref(8, :));
plot (vec, alpha_ref(9, :));
plot (vec, alpha_ref(10, :));
plot (vec, alpha_ref(11, :));
plot (vec, alpha_ref(12, :));
plot (vec, alpha_ref(13, :));
plot (vec, alpha_ref(14, :));
plot (vec, alpha_ref(15, :));
plot (vec, alpha_ref(16, :));
xticks(vec);
yticks(0:0.05:1);
xticklabels(freqtick);
ylim([0 1.1]);
xlim([0 6]);
grid on;

rectPlot(fig);

NRC = round(mean(alpha(1:4))*20)/20;

% Média de coeficiente SAA
SAA = round(mean(exp2_dados.Coef_abs.Sweep.ITAToolbox(4:15))*100)/100;