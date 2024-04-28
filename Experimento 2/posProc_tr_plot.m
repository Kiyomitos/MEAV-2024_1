%%% MEAV 2024.1 - Experimento 2 - Pós processamento %%
%%% Plot de curvas -- Tempo de reverberação         %%
%%% Aluno: Victor Kiyomi                            %%
%%% Matrícula: 201920089                            %%
%%% Data: 25/04/2024                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cleaning service

clear all; format long; clc; close all;

[vec, freqtick] = freqBands(3, 'range', [100 10000]);
cores = [
    1, 0, 0;
    237/255, 245/255, 5/255;
    21/255, 245/255, 5/255;
    97/255, 242/255, 157/255;
    7/255, 250/255, 230/255;
    7/255, 52/255, 250/255;
    169/255, 7/255, 250/255
];
%% Plot dos tempos de reverberação
% A partir dos diversos tempos de reverberação (12 pares fonte-receptor e
% dois métodos distintos), esse código realizará o plot das curvas de TR em
% plots de linha e barras.
load("exp2_dados.mat");
%%
fig = figure();
t = tiledlayout(2, 1);

nexttile
bar(vec, exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte1, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(3, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte1;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

nexttile
plot(vec, exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte1, ...
    'LineWidth', 1.5, 'Color', cores(3, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlim([0.9 21.2]);
ylim([0 20]);

title(t, 'Teste', 'FontSize', 24);
subtitle(t, 'Teste 2', 'FontSize', 18);
xlabel(t, 'Frequência (Hz)', 'FontSize', 22);
ylabel(t, 'Tempo de reverberação (s)', 'FontSize', 22);

rectPlot(fig);

% print(gcf, 'teste_tiled.pdf', '-dpdf', '-fillpage');
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SWEEP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sem material
% Integral Reversa Cumulativa (IRC) -- Fonte 1
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Reversa Cumulativa'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte1, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(3, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte1;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte1, ...
    'LineWidth', 1.5, 'Color', cores(3, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Sweep ' char(8212) ' Sem material ' char(8212) ' Fonte 1'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'sweep_irc_semmaterial_fonte1.pdf', '-dpdf', '-fillpage');
%%

% Integral Reversa Cumulativa (IRC) -- Fonte 2
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Reversa Cumulativa'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte2, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(3, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte2;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte2, ...
    'LineWidth', 1.5, 'Color', cores(3, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Sweep ' char(8212) ' Sem material ' char(8212) ' Fonte 2'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'sweep_irc_semmaterial_fonte2.pdf', '-dpdf', '-fillpage');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ITA Toolbox -- Fonte 1
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' ITA Toolbox'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Sweep.ITAToolbox.Sem_material.Fonte1, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(1, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Sweep.ITAToolbox.Sem_material.Fonte1;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Sweep.ITAToolbox.Sem_material.Fonte1, ...
    'LineWidth', 1.5, 'Color', cores(1, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Sweep ' char(8212) ' Sem material ' char(8212) ' Fonte 1'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'sweep_ita_semmaterial_fonte1.pdf', '-dpdf', '-fillpage');

% ITA Toolbox -- Fonte 2
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' ITA Toolbox'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Sweep.ITAToolbox.Sem_material.Fonte2, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(1, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Sweep.ITAToolbox.Sem_material.Fonte2;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Sweep.ITAToolbox.Sem_material.Fonte2, ...
    'LineWidth', 1.5, 'Color', cores(1, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Sweep ' char(8212) ' Sem material ' char(8212) ' Fonte 2'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'sweep_ita_semmaterial_fonte2.pdf', '-dpdf', '-fillpage');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Com material

% Integral Reversa Cumulativa -- Fonte 1
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Reversa Cumulativa'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Sweep.IRC.Com_material.Fonte1, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(3, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Sweep.IRC.Com_material.Fonte1;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Sweep.IRC.Com_material.Fonte1, ...
    'LineWidth', 1.5, 'Color', cores(3, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Sweep ' char(8212) ' Com material ' char(8212) ' Fonte 1'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'sweep_irc_commaterial_fonte1.pdf', '-dpdf', '-fillpage');


% Integral Reversa Cumulativa -- Fonte 2
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Reversa Cumulativa'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Sweep.IRC.Com_material.Fonte2, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(3, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Sweep.IRC.Com_material.Fonte2;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Sweep.IRC.Com_material.Fonte2, ...
    'LineWidth', 1.5, 'Color', cores(3, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Sweep ' char(8212) ' Com material ' char(8212) ' Fonte 2'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'sweep_irc_commaterial_fonte2.pdf', '-dpdf', '-fillpage');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Com material
% ITA Toolbox -- Fonte 1
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' ITA Toolbox'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Sweep.ITAToolbox.Com_material.Fonte1, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(3, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Sweep.ITAToolbox.Com_material.Fonte1;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Sweep.ITAToolbox.Com_material.Fonte1, ...
    'LineWidth', 1.5, 'Color', cores(3, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Sweep ' char(8212) ' Com material ' char(8212) ' Fonte 1'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'sweep_ita_commaterial_fonte1.pdf', '-dpdf', '-fillpage');

% ITA Toolbox -- Fonte 2
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' ITA Toolbox'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Sweep.ITAToolbox.Com_material.Fonte2, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(3, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Sweep.ITAToolbox.Com_material.Fonte2;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Sweep.ITAToolbox.Com_material.Fonte2, ...
    'LineWidth', 1.5, 'Color', cores(3, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Sweep ' char(8212) ' Com material ' char(8212) ' Fonte 2'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'sweep_ita_commaterial_fonte2.pdf', '-dpdf', '-fillpage');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RUÍDO INTERROMPIDO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sem material
% ICR -- Fonte 1
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Reversa Cumulativa'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Ruido_interrompido.IRC.Sem_material.Fonte1, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(2, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Ruido_interrompido.IRC.Sem_material.Fonte1;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Ruido_interrompido.IRC.Sem_material.Fonte1, ...
    'LineWidth', 1.5, 'Color', cores(2, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Ruído Interrompido ' char(8212) ' Sem material ' char(8212) ' Fonte 1'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'ruidointerr_irc_semmaterial_fonte1.pdf', '-dpdf', '-fillpage');

% ICR -- Fonte 2
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Reversa Cumulativa'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Ruido_interrompido.IRC.Sem_material.Fonte2, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(2, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Ruido_interrompido.IRC.Sem_material.Fonte2;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Ruido_interrompido.IRC.Sem_material.Fonte2, ...
    'LineWidth', 1.5, 'Color', cores(2, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Ruído Interrompido ' char(8212) ' Sem material ' char(8212) ' Fonte 2'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'ruidointerr_irc_semmaterial_fonte2.pdf', '-dpdf', '-fillpage');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Com material
% ICR -- Fonte 1
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Reversa Cumulativa'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Ruido_interrompido.IRC.Com_material.Fonte1, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(4, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Ruido_interrompido.IRC.Com_material.Fonte1;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Ruido_interrompido.IRC.Com_material.Fonte1, ...
    'LineWidth', 1.5, 'Color', cores(4, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Ruído Interrompido ' char(8212) ' Com material ' char(8212) ' Fonte 1'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'ruidointerr_irc_commaterial_fonte1.pdf', '-dpdf', '-fillpage');


% ICR -- Fonte 2
fig = figure();
sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Reversa Cumulativa'], 'FontSize', 24);

subplot(2, 1, 1);
bar(vec, exp2_dados.TRs_medios.Ruido_interrompido.IRC.Com_material.Fonte2, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(4, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TRs_medios.Ruido_interrompido.IRC.Com_material.Fonte2;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 12);

subplot(2, 1, 2);
plot(vec, exp2_dados.TRs_medios.Ruido_interrompido.IRC.Com_material.Fonte2, ...
    'LineWidth', 1.5, 'Color', cores(4, :)); hold on;
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
%legend('Mic. 1', Location='best');
rectPlot(fig);

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);
text(11, 51.1, ['Método Ruído Interrompido ' char(8212) ' Com material ' char(8212) ' Fonte 1'], 'FontSize', 18, 'HorizontalAlignment', 'center');

% print(gcf, 'ruidointerr_irc_commaterial_fonte2.pdf', '-dpdf', '-fillpage');

%% Plot de comparação de TR
% Sweep -- Sem vs Com material ITA
fig = figure();

subplot(2, 2, 1);
bar(vec, exp2_dados.TR_abs.Sweep.ITAToolbox.Sem_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(6, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.ITAToolbox.Sem_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

fig2 = subplot(2, 2, 2);
bar(vec, exp2_dados.TR_abs.Sweep.ITAToolbox.Com_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(4, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.ITAToolbox.Com_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 1, 2);
plot(vec, exp2_dados.TR_abs.Sweep.ITAToolbox.Sem_material, 'LineWidth', 1.5, 'Color', cores(6, :)); hold on;
plot(vec, exp2_dados.TR_abs.Sweep.ITAToolbox.Com_material, 'LineWidth', 1.5, 'Color', cores(4, :));
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
legend('Sem material', 'Com material', Location='best');

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);

sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' ITA Toolbox'], 'FontSize', 24);
text(11, 49, ['Método Sweep ' char(8212) ' Com material ' '{\itvs}' ' Sem material'], 'FontSize', 16, 'HorizontalAlignment', 'center');

rectPlot(fig);
% print(gcf, 'comparaçao_sweep_ita_comvssem.pdf', '-dpdf', '-fillpage');

%%
% Sweep -- Sem vs Com material ICR
fig = figure();

subplot(2, 2, 1);
bar(vec, exp2_dados.TR_abs.Sweep.IRC.Sem_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(1, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.IRC.Sem_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 2, 2);
bar(vec, exp2_dados.TR_abs.Sweep.IRC.Com_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(2, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.IRC.Com_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 1, 2);
plot(vec, exp2_dados.TR_abs.Sweep.IRC.Sem_material, 'LineWidth', 1.5, 'Color', cores(1, :)); hold on;
plot(vec, exp2_dados.TR_abs.Sweep.IRC.Com_material, 'LineWidth', 1.5, 'Color', cores(2, :));
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
legend('Sem material', 'Com material', Location='best');

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);

sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Cumulativa Reversa'], 'FontSize', 24);
text(11, 49, ['Método Sweep ' char(8212) ' Com material ' '{\itvs}' ' Sem material'], 'FontSize', 16, 'HorizontalAlignment', 'center');

rectPlot(fig);
% print(gcf, 'comparaçao_sweep_icr_comvssem.pdf', '-dpdf', '-fillpage');

%% Sweep -- Sem material -- ITA vs ICR
fig = figure();

subplot(2, 2, 1);
bar(vec, exp2_dados.TR_abs.Sweep.IRC.Sem_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(1, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.IRC.Sem_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 2, 2);
bar(vec, exp2_dados.TR_abs.Sweep.ITAToolbox.Sem_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(6, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.ITAToolbox.Sem_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 1, 2);
plot(vec, exp2_dados.TR_abs.Sweep.IRC.Sem_material, 'LineWidth', 1.5, 'Color', cores(1, :)); hold on;
plot(vec, exp2_dados.TR_abs.Sweep.ITAToolbox.Sem_material, 'LineWidth', 1.5, 'Color', cores(6, :));
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
legend('Integral Cumulativa Reversa', 'ITA Toolbox', Location='best');

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);

sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Sem material'], 'FontSize', 24);
text(11, 49, ['Método Sweep ' char(8212) ' Integral Cumulativa Reversa ' '{\itvs}' ' ITA Toolbox'], 'FontSize', 16, 'HorizontalAlignment', 'center');

rectPlot(fig);
% print(gcf, 'comparaçao_sweep_icrvsita_semmaterial.pdf', '-dpdf', '-fillpage');
%% Sweep -- Com material -- ITA vs ICR
fig = figure();

subplot(2, 2, 1);
bar(vec, exp2_dados.TR_abs.Sweep.IRC.Com_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(2, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.IRC.Com_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 2, 2);
bar(vec, exp2_dados.TR_abs.Sweep.ITAToolbox.Com_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(4, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.ITAToolbox.Com_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 1, 2);
plot(vec, exp2_dados.TR_abs.Sweep.IRC.Com_material, 'LineWidth', 1.5, 'Color', cores(2, :)); hold on;
plot(vec, exp2_dados.TR_abs.Sweep.ITAToolbox.Com_material, 'LineWidth', 1.5, 'Color', cores(4, :));
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
legend('Integral Cumulativa Reversa', 'ITA Toolbox', Location='best');

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);

sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Com material'], 'FontSize', 24);
text(11, 49, ['Método Sweep ' char(8212) ' Integral Cumulativa Reversa ' '{\itvs}' ' ITA Toolbox'], 'FontSize', 16, 'HorizontalAlignment', 'center');

rectPlot(fig);
% print(gcf, 'comparaçao_sweep_icrvsita_commaterial.pdf', '-dpdf', '-fillpage');

%% Ruido interrompido -- Sem material vs Com material
fig = figure();

subplot(2, 2, 1);
bar(vec, exp2_dados.TR_abs.Ruido_interrompido.Sem_Material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(2, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Ruido_interrompido.Sem_Material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 2, 2);
bar(vec, exp2_dados.TR_abs.Ruido_interrompido.Com_Material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(7, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Ruido_interrompido.Com_Material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 1, 2);
plot(vec, exp2_dados.TR_abs.Sweep.IRC.Sem_material, 'LineWidth', 1.5, 'Color', cores(2, :)); hold on;
plot(vec, exp2_dados.TR_abs.Sweep.ITAToolbox.Com_material, 'LineWidth', 1.5, 'Color', cores(7, :));
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
legend('Sem material', 'Com material', Location='best');

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);

sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Integral Cumulativa Reversa'], 'FontSize', 24);
text(11, 49, ['Método Ruído interrompido ' char(8212) ' Sem material ' '{\itvs}' ' Com material'], 'FontSize', 16, 'HorizontalAlignment', 'center');

rectPlot(fig);
print(gcf, 'comparaçao_ruidointerr_semvscom_icr.pdf', '-dpdf', '-fillpage');

%% Sweep vs Ruido interrompido -- Sem material
fig = figure();

subplot(2, 2, 1);
bar(vec, exp2_dados.TR_abs.Sweep.IRC.Sem_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(5, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.IRC.Sem_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

fig2 = subplot(2, 2, 2);
bar(vec, exp2_dados.TR_abs.Ruido_interrompido.Sem_Material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(6, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Ruido_interrompido.Sem_Material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 1, 2);
plot(vec, exp2_dados.TR_abs.Sweep.IRC.Sem_material, 'LineWidth', 1.5, 'Color', cores(5, :)); hold on;
plot(vec, exp2_dados.TR_abs.Ruido_interrompido.Sem_Material, 'LineWidth', 1.5, 'Color', cores(6, :));
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
legend('Sweep', 'Ruído interrompido', Location='best');

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);

sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Sem material'], 'FontSize', 24);
text(11, 49, ['Integral cumulativa reversa ' char(8212) ' Sweep ' '{\itvs}' ' Ruído interrompido'], 'FontSize', 16, 'HorizontalAlignment', 'center');

rectPlot(fig);
% print(gcf, 'comparaçao_icr_sweepvsruido_semmaterial.pdf', '-dpdf', '-fillpage');

%% Sweep vs Ruido interrompido -- Com material
fig = figure();

subplot(2, 2, 1);
bar(vec, exp2_dados.TR_abs.Sweep.IRC.Com_material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(2, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Sweep.IRC.Com_material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

fig2 = subplot(2, 2, 2);
bar(vec, exp2_dados.TR_abs.Ruido_interrompido.Com_Material, 'LineWidth', 1.5, 'FaceColor', 'flat', 'CData', cores(7, :)); %hold on;
xticks(vec);
xticklabels(freqtick);
ylim([0 20]);
rectPlot(fig);
valores = exp2_dados.TR_abs.Ruido_interrompido.Com_Material;
text(vec, valores, num2str(valores','%0.2f'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 9);

subplot(2, 1, 2);
plot(vec, exp2_dados.TR_abs.Sweep.IRC.Com_material, 'LineWidth', 1.5, 'Color', cores(2, :)); hold on;
plot(vec, exp2_dados.TR_abs.Ruido_interrompido.Com_Material, 'LineWidth', 1.5, 'Color', cores(7, :));
xticks(vec);
xticklabels(freqtick);
xlabel('Frequência (Hz)');
xlim([0.9 21.2]);
ylim([0 20]);
legend('Sweep', 'Ruído interrompido', Location='best');

hYLabel = ylabel('Tempo de reverberação (s)');
set(hYLabel, 'Units', 'Normalized', 'Position', [-0.05, 1, 0]);

sgtitle(['Tempo de reverberação em câmara reverberante ' char(8212) ' Com material'], 'FontSize', 24);
text(11, 49, ['Integral cumulativa reversa ' char(8212) ' Sweep ' '{\itvs}' ' Ruído interrompido'], 'FontSize', 16, 'HorizontalAlignment', 'center');

rectPlot(fig);
% print(gcf, 'comparaçao_icr_sweepvsruido_commaterial.pdf', '-dpdf', '-fillpage');