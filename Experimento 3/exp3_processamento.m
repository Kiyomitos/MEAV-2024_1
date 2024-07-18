%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotina para processamento dos dados do experimento 3 de MEAV          %
% Autor: Victor Kiyomi                                                  %
% Prof.: Paulo Mareze                                                   %
% Disciplina: MEAV                                                      %
% Data: 26/05/2024                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Cleaning Service
clear all; clc; close all; clear memory;

%% Carregando os arquivos da medição
tic;
load("D:\GitHub\Faculdade\UFSM 2024.1\Métodos Experimentais em Acústica e Vibrações\Exp 3\Códigos\dados_experimento3_corrigido.mat");
toc

%% Som residual em bandas de 1/3 de oitava
dataInbands.Aspirador.residual = ita_spk2frequencybands(exp3_dados.Aspirador.Residual,'bandsperoctave',3,'method','added','freqRange',[100 10000]);
dataInbands.Fonte_ref.residual = ita_spk2frequencybands(exp3_dados.Fonte_ref.Residual,'bandsperoctave',3,'method','added','freqRange',[100 10000]);

%% NPS em 1/3 de oitava -- Irei utilziar o ITA Toolbox para calcular as médias logs. dos dados
tic;
% Aspirador
aspirador_pos1 = ita_merge(exp3_dados.Dados_brutos.Aspirador.Pos1.med1, exp3_dados.Dados_brutos.Aspirador.Pos1.med2, exp3_dados.Dados_brutos.Aspirador.Pos1.med3, ...
    exp3_dados.Dados_brutos.Aspirador.Pos1.med4, exp3_dados.Dados_brutos.Aspirador.Pos1.med5, exp3_dados.Dados_brutos.Aspirador.Pos1.med6, exp3_dados.Dados_brutos.Aspirador.Pos1.med7, ...
    exp3_dados.Dados_brutos.Aspirador.Pos1.med8, exp3_dados.Dados_brutos.Aspirador.Pos1.med9, exp3_dados.Dados_brutos.Aspirador.Pos1.med10);

aspirador_pos2 = ita_merge(exp3_dados.Dados_brutos.Aspirador.Pos2.med1, exp3_dados.Dados_brutos.Aspirador.Pos2.med2, exp3_dados.Dados_brutos.Aspirador.Pos2.med3, ...
    exp3_dados.Dados_brutos.Aspirador.Pos2.med4, exp3_dados.Dados_brutos.Aspirador.Pos2.med5, exp3_dados.Dados_brutos.Aspirador.Pos2.med6, exp3_dados.Dados_brutos.Aspirador.Pos2.med7, ...
    exp3_dados.Dados_brutos.Aspirador.Pos2.med8, exp3_dados.Dados_brutos.Aspirador.Pos2.med9, exp3_dados.Dados_brutos.Aspirador.Pos2.med10);

exp3_dados.Dados_brutos.Aspirador.Pos1.Media = ita_mean(aspirador_pos1); exp3_dados.Dados_brutos.Aspirador.Pos2.Media = ita_mean(aspirador_pos2);

dataInbands.Aspirador.Pos1 = ita_spk2frequencybands(exp3_dados.Dados_brutos.Aspirador.Pos1.Media,'bandsperoctave',3,'method','added','freqRange',[100 10000]);
dataInbands.Aspirador.Pos2 = ita_spk2frequencybands(exp3_dados.Dados_brutos.Aspirador.Pos2.Media,'bandsperoctave',3,'method','added','freqRange',[100 10000]);

dataInbands.Aspirador.NPS = ita_spk2frequencybands(exp3_dados.Aspirador.NPS,'bandsperoctave',3,'method','added','freqRange',[100 10000]);

% Fonte de referência

fonte_ref_pos1 = ita_merge(exp3_dados.Dados_brutos.Fonte_ref.Pos1.med1, exp3_dados.Dados_brutos.Fonte_ref.Pos1.med2, exp3_dados.Dados_brutos.Fonte_ref.Pos1.med3, ...
    exp3_dados.Dados_brutos.Fonte_ref.Pos1.med4, exp3_dados.Dados_brutos.Fonte_ref.Pos1.med5, exp3_dados.Dados_brutos.Fonte_ref.Pos1.med6);

fonte_ref_pos2 = ita_merge(exp3_dados.Dados_brutos.Fonte_ref.Pos2.med1, exp3_dados.Dados_brutos.Fonte_ref.Pos2.med2, exp3_dados.Dados_brutos.Fonte_ref.Pos2.med3, ...
    exp3_dados.Dados_brutos.Fonte_ref.Pos2.med4, exp3_dados.Dados_brutos.Fonte_ref.Pos2.med5, exp3_dados.Dados_brutos.Fonte_ref.Pos2.med6);

exp3_dados.Dados_brutos.Fonte_ref.Pos1.Media = ita_mean(fonte_ref_pos1); exp3_dados.Dados_brutos.Fonte_ref.Pos2.Media = ita_mean(fonte_ref_pos2);

dataInbands.Fonte_ref.Pos1 = ita_spk2frequencybands(exp3_dados.Dados_brutos.Fonte_ref.Pos1.Media,'bandsperoctave',3,'method','added','freqRange',[100 10000]);
dataInbands.Fonte_ref.Pos2 = ita_spk2frequencybands(exp3_dados.Dados_brutos.Fonte_ref.Pos2.Media,'bandsperoctave',3,'method','added','freqRange',[100 10000]);

dataInbands.Fonte_ref.NPS = ita_spk2frequencybands(exp3_dados.Fonte_ref.NPS,'bandsperoctave',3,'method','added','freqRange',[100 10000]);

toc
%% Dados para cálculo da pot. sonora através do método direto
tic;
p_ref = 20e-6;
v = 207; % Volume da câmara
s_par = 125.4; % Soma das áreas totais de paredes
s_piso = 44.42; % Soma das áreas totais do piso
s_teto = s_piso; % Soma das áreas totais do teto
S = s_par+s_piso+s_teto;
B = 99500; % Pressão atmosférica medida durante o experimento REVISAR --------------------
B0 = 101300; % Pressão atm. de ref.
T = 23; % Temperatura média em °C REVISAR --------------------
RH = 81; % Umidade relativa média em % REVISAR ------------------
c = 331+0.6*T;

[~, freqVec] = freqBands(3.5, 'range', [100 10000]);

pondA = [-19.1, -16.1, -13.4, -10.9, -8.6, -6.6, -4.8, -3.2, -1.9, -0.8, 0, 0.6, 1, 1.2, 1.3, 1.2, 1, 0.5, -0.1, -1.1, -2.5];

% Valores em dB
for i=1:21
    Lp.Aspirador.NPS.NPS(i) = 20*log10(abs(dataInbands.Aspirador.NPS.freqData(i)/p_ref));
    Lp.Fonte_ref.NPS.NPS(i) = 20*log10(abs(dataInbands.Fonte_ref.NPS.freqData(i)/p_ref));

    Lp.Aspirador.NPS.NPS_A(i) = 20*log10(abs(dataInbands.Aspirador.NPS.freqData(i)/p_ref))+pondA(i);
    Lp.Fonte_ref.NPS.NPS_A(i) = 20*log10(abs(dataInbands.Fonte_ref.NPS.freqData(i)/p_ref))+pondA(i);
end

A = zeros(21, 1);
A_m = zeros(21, 1);
Pot.Aspirador.Z = zeros(21, 1);
Pot.Aspirador.A = zeros(21, 1);
Pot.Fonte_ref.Z = zeros(21, 1);
Pot.Fonte_ref.A = zeros(21, 1);

for i=1:length(freqVec)
    A(i) = 55.3*v*(1/(c*exp3_dados.TR.T20.freqData(i)));
    A_m(i) = 55.3*v*(1/(c*exp3_dados.TR.T20.freqData(i)))-4*v*airAbs(freqVec(i), T, RH, B);
    
    Pot.Aspirador.Z_m(i) = 20*log10(abs(dataInbands.Aspirador.NPS.freqData(i))/p_ref)+10*log10(A_m(i))+4.34*(A_m(i)/S)+...
    10*log10(1+(((S*c)/(8*v*freqVec(i)))))-25*log10((427/400)*sqrt(273/(273+T))*(B/B0))-6;
    Pot.Fonte_ref.Z_m(i) = 20*log10(abs(dataInbands.Fonte_ref.NPS.freqData(i))/p_ref)+10*log10(A_m(i))+4.34*(A_m(i)/S)+...
    10*log10(1+(((S*c)/(8*v*freqVec(i)))))-25*log10((427/400)*sqrt(273/(273+T))*(B/B0))-6;

    Pot.Aspirador.A_m(i) = (20*log10(abs(dataInbands.Aspirador.NPS.freqData(i))/p_ref)+pondA(i))+10*log10(A_m(i)/1)+4.34*(A_m(i)/S)+...
    10*log10(1+(((S*c)/(8*v*freqVec(i)))))-25*log10((427/400)*sqrt(273/(273+T))*(B/B0))-6;
    Pot.Fonte_ref.A_m(i) = (20*log10(abs(dataInbands.Fonte_ref.NPS.freqData(i))/p_ref)+pondA(i))+10*log10(A_m(i))+4.34*(A_m(i)/S)+...
    10*log10(1+(((S*c)/(8*v*freqVec(i)))))-25*log10((427/400)*sqrt(273/(273+T))*(B/B0))-6;

    Pot.Aspirador.Z(i) = 20*log10(abs(dataInbands.Aspirador.NPS.freqData(i))/p_ref)+10*log10(A(i))+4.34*(A(i)/S)+...
    10*log10(1+(((S*c)/(8*v*freqVec(i)))))-25*log10((427/400)*sqrt(273/(273+T))*(B/B0))-6;
    Pot.Fonte_ref.Z(i) = 20*log10(abs(dataInbands.Fonte_ref.NPS.freqData(i))/p_ref)+10*log10(A(i))+4.34*(A(i)/S)+...
    10*log10(1+(((S*c)/(8*v*freqVec(i)))))-25*log10((427/400)*sqrt(273/(273+T))*(B/B0))-6;

    Pot.Aspirador.A(i) = (20*log10(abs(dataInbands.Aspirador.NPS.freqData(i))/p_ref)+pondA(i))+10*log10(A(i)/1)+4.34*(A(i)/S)+...
    10*log10(1+(((S*c)/(8*v*freqVec(i)))))-25*log10((427/400)*sqrt(273/(273+T))*(B/B0))-6;
    Pot.Fonte_ref.A(i) = (20*log10(abs(dataInbands.Fonte_ref.NPS.freqData(i))/p_ref)+pondA(i))+10*log10(A(i))+4.34*(A(i)/S)+...
    10*log10(1+(((S*c)/(8*v*freqVec(i)))))-25*log10((427/400)*sqrt(273/(273+T))*(B/B0))-6;
end
toc

%% Plot metodo direto
[vec, freqVecTick] = freqBands(3, 'range', [100 10000]);

Lweq.Aspirador.Z = splSum(Pot.Aspirador.Z');
Lweq.Fonte_ref.Z = splSum(Pot.Fonte_ref.Z');

Lweq.Aspirador.A = splSum(Pot.Aspirador.A');
Lweq.Fonte_ref.A = splSum(Pot.Fonte_ref.A');

Lweq.Aspirador.Z_m = splSum(Pot.Aspirador.Z_m');
Lweq.Fonte_ref.Z_m = splSum(Pot.Fonte_ref.Z_m');

Lweq.Aspirador.A_m = splSum(Pot.Aspirador.A_m');
Lweq.Fonte_ref.A_m = splSum(Pot.Fonte_ref.A_m');

fig = figure();
t = tiledlayout(2, 1);

nexttile
plot(vec, Pot.Aspirador.Z, 'Color', '#03f0fc', 'LineWidth', 2.5); hold on;
plot(vec, Pot.Fonte_ref.Z, 'Color', '#fc03d3', 'LineWidth', 2.5);
plot(vec, Pot.Aspirador.Z_m, 'Color', '#03f0fc', 'LineStyle', '--', 'LineWidth', 1.5);
plot(vec, Pot.Fonte_ref.Z_m, 'Color', '#fc03d3', 'LineStyle', '--', 'LineWidth', 1.5);
grid on;
legend(['Aspirador de pó ' char(8212) ' L_{w,Z,eq} = ' num2str(round(Lweq.Aspirador.Z)) ' dB'],...
    ['Fonte de referência ' char(8212) ' L_{w,Z,eq} = ' num2str(round(Lweq.Fonte_ref.Z)) ' dB'],...
    ['Aspirador de pó ' char(8212) ' L_{w,Z,eq} = ' num2str(round(Lweq.Aspirador.Z_m)) ' dB (com {\itm})'],...
    ['Fonte de referência ' char(8212) ' L_{w,Z,eq} = ' num2str(round(Lweq.Fonte_ref.Z_m)) ' dB (com {\itm})'],...
    'Location', 'best');
xlim([vec(1) vec(end)]);
ylim([25 85]);
xticks(vec);
yticks(25:5:85);
xticklabels(freqVecTick);
title('Ponderação Z');
rectPlot(fig);

nexttile
plot(vec, Pot.Aspirador.A, 'Color', '#03f0fc', 'LineWidth', 2.5); hold on;
plot(vec, Pot.Fonte_ref.A, 'Color', '#fc03d3', 'LineWidth', 2.5);
plot(vec, Pot.Aspirador.A_m, 'Color', '#03f0fc', 'LineStyle', '--', 'LineWidth', 1.5);
plot(vec, Pot.Fonte_ref.A_m, 'Color', '#fc03d3', 'LineStyle', '--', 'LineWidth', 1.5);

grid on;
legend(['Aspirador de pó ' char(8212) ' L_{w,A,eq} = ' num2str(round(Lweq.Aspirador.A)) ' dB'],...
    ['Fonte de referência ' char(8212) ' L_{w,A,eq} = ' num2str(round(Lweq.Fonte_ref.A)) ' dB'],...
    ['Aspirador de pó ' char(8212) ' L_{w,A,eq} = ' num2str(round(Lweq.Aspirador.A_m)) ' dB (com {\itm})'],...
    ['Fonte de referência ' char(8212) ' L_{w,A,eq} = ' num2str(round(Lweq.Fonte_ref.A_m)) ' dB (com {\itm})'],...
    'Location', 'best');
xlim([vec(1) vec(end)]);
ylim([25 85]);
xticks(vec);
yticks(25:5:85);
xticklabels(freqVecTick);
title('Ponderação A');
rectPlot(fig);

xlabel(t, 'Frequência (Hz)', 'FontSize', 24);
ylabel(t, 'Nível de potência sonora (dB)', 'FontSize', 24);
title(t, ['Nível de potência sonora ' char(8212) ' Medição em câmara reverberante (ISO 3741)'], 'FontSize', 30);
subtitle(t, ['Método direto ' char(8212) ' Cálculo com coef. de atenuação do ar {\itvs} sem coef.'], 'FontSize', 18);

print('pot_metodo_direto.pdf', '-dpdf', '-fillpage')

%% Método da comparação
% Dados fonte de ref -- 100 Hz a 10 kHz
%
% Lw = Lw_ref+(Lp-Lp_ref)

Fonte_ref.NPS_ref = [81.49, 81.52, 81.63, 83.34, 82.52, 83.43, 82.9, 83.22, 83.57, 85.28, 85.66, 86.27, 86.43, 86.47, 84.56, 82.01, 80.69, ...
    79.08, 76.31, 73.23, 69.61];

Fonte_ref.NWS_ref = [79.27, 79.5, 79.3, 80.64, 80.24, 80.87, 80.71, 81.09, 81.72, 83.71, 84.61, 85.79, 86.27, 86.91, 85.75, 84.13, 83.84, ...
    83.24, 82.11, 79.69, 76.01];

for ii=1:21
    Pot_comp.Aspirador(ii) = Fonte_ref.NWS_ref(ii)+(20*log10(abs(dataInbands.Aspirador.NPS.freqData(ii))/p_ref)-Fonte_ref.NPS_ref(ii));
end

%% Plot
fig = figure();
plot(vec, Pot_comp.Aspirador, 'Color', '#ebfc65', 'LineWidth', 1.5);
grid on;
legend(['Aspirador de pó ' char(8212) ' L_{w,eq} = ' num2str(round(splSum(Pot_comp.Aspirador))) ' dB'],...
    'Location', 'southeast');
title(['Nível de potência sonora ' char(8212) ' Medição em câmara reverberante (ISO 3741)'], 'FontSize', 30);
subtitle('Método de comparação', 'FontSize', 25);
xlim([vec(1) vec(end)]);
ylim([25 80]);
xticks(vec);
yticks(25:5:80);
xticklabels(freqVecTick);
rectPlot(fig);
xlabel('Frequência (Hz)');
ylabel('Nível de potência sonora (dB)');
rectPlot(fig);

% print('pot_metodo_comparacao.pdf', '-dpdf', '-fillpage')

%% Plot residual

% Foi realizada apenas uma medição de som residual
for i=1:21
    Lp.eq.Residual(i) = 20*log10(abs(dataInbands.Aspirador.residual.freqData(i)/p_ref));
    Lp.eq.Residual_A(i) = 20*log10(abs(dataInbands.Aspirador.residual.freqData(i)/p_ref))+pondA(i);
end

fig = figure();
t = tiledlayout(2, 1);

nexttile
plot(vec, Lp.eq.Residual, 'b', 'LineWidth', 1.5); hold on;
grid on;
xlim([vec(1) vec(end)]);
ylim([0 25]);
xticks(vec);
yticks(0:5:25);
xticklabels(freqVecTick);
rectPlot(fig);
title('Ponderação Z');

nexttile
plot(vec, Lp.eq.Residual_A, 'b', 'LineWidth', 1.5); hold on;
grid on;
xlim([vec(1) vec(end)]);
ylim([0 25]);
xticks(vec);
yticks(0:5:25);
xticklabels(freqVecTick);
rectPlot(fig);
title('Ponderação A');

xlabel(t, 'Frequência (Hz)', 'FontSize', 24);
ylabel(t, 'Nível de pressão sonora (dB ref. 20 μPa)', 'FontSize', 24);
title(t, ['Nível de pressão sonora do som residual ' char(8212) ' Medição em câmara reverberante'], 'FontSize', 30);
subtitle(t, 'Ponderação Z e A', 'FontSize', 18);

% print('residual_fontes.pdf', '-dpdf', '-fillpage')

%% Plot NPS
fig = figure();
t = tiledlayout(2, 1);

nexttile
plot(vec, Lp.Aspirador.NPS.NPS, 'k', 'LineWidth', 1.5); hold on;
plot(vec, Lp.Fonte_ref.NPS.NPS, 'r', 'LineWidth', 1.5);
grid on;
legend('Aspirador de pó',...
    'Fonte de referência',...
    'Location', 'best');
xlim([vec(1) vec(end)]);
ylim([25 90]);
xticks(vec);
yticks(25:5:90);
xticklabels(freqVecTick);
title('Ponderação Z');
rectPlot(fig);

nexttile
plot(vec, Lp.Aspirador.NPS.NPS_A, 'k', 'LineWidth', 1.5); hold on;
plot(vec, Lp.Fonte_ref.NPS.NPS_A, 'r', 'LineWidth', 1.5);
grid on;
legend('Aspirador de pó',...
    'Fonte de referência',...
    'Location', 'best');
xlim([vec(1) vec(end)]);
ylim([25 90]);
xticks(vec);
yticks(25:5:90);
xticklabels(freqVecTick);
title('Ponderação A');
rectPlot(fig);

xlabel(t, 'Frequência (Hz)', 'FontSize', 24);
ylabel(t, 'Nível de pressão sonora (dB ref. 20 μPa)', 'FontSize', 24);
title(t, ['Nível de pressão sonora ' char(8212) ' Medição em câmara reverberante'], 'FontSize', 30);
subtitle(t, 'Medição de NPS de cada fonte sonora', 'FontSize', 18);

% print('nps_fontes.pdf', '-dpdf', '-fillpage')

%% TR
fig = figure();
plot(vec, exp3_dados.TR.T20.freqData, 'k', 'LineWidth', 2.5);
grid on
xlabel('Frequência (Hz)');
ylabel('Tempo de reverberação (s)');
xticklabels(freqVecTick);
xticks(vec);
yticks(0:1:15);
ylim([0 15]);
xlim([vec(1) vec(end)]);

title('Tempo de reverberação (T20)');
subtitle('Medição com {\itrotating boom}');
rectPlot(fig);

% print('tr.pdf', '-dpdf', '-fillpage');

%% Plot do ajuste
fig = figure();
p = plot(teste.freqVector, 20*log10(abs(teste.freqData)/20e-6), 'k', 'LineWidth', 2.5);
grid on
xlabel('Frequência (Hz)');
ylabel('Nível de pressão sonora (dB ref. 20 μPa)');
% ylim([0 15]);
xlim([995 1005]);
datatip(p, 1000, 93.97);

title('Curva de ajuste de sensibilidade do microfone');
rectPlot(fig);

print('ajuste.pdf', '-dpdf', '-fillpage');