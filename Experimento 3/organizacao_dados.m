%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Código para organização dos dados do experimento 3    %
% Aluno: Victor Kiyomi                                  %
% Data: 27/04                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Cleaning service

clear all; clc; close all; clear memory;
%% TR
load("tr_exp3_fonte1_2.mat");

% Gravação do mic
for i=1:10
    exp3_dados.Dados_brutos.TR.Pos1.Sweeps_mic.(['med', num2str(i)]) = msNI{i, 1}.sweepInPascal;
    exp3_dados.Dados_brutos.TR.Pos1.Sweeps_NI.(['med', num2str(i)]) = msNI{i, 2}.sweepRecord;
    exp3_dados.Dados_brutos.TR.Pos1.Respostas_impulsivas.(['H', num2str(i)]) = H{i, 1};
end
clear msNI i; clc;

load("tr_exp3_fonte2.mat");
for i=1:10
    exp3_dados.Dados_brutos.TR.Pos2.Sweeps_mic.(['med', num2str(i)]) = msNI{i, 1}.sweepInPascal;
    exp3_dados.Dados_brutos.TR.Pos2.Sweeps_NI.(['med', num2str(i)]) = msNI{i, 2}.sweepRecord;
    exp3_dados.Dados_brutos.TR.Pos2.Respostas_impulsivas.(['H', num2str(i)]) = H{i, 1};
end

clear msNI i; clc;

% Média das RIs
media_ri = [];

for m=1:10
    for n=11:20
        media_ri(m, :) = exp3_dados.Dados_brutos.TR.Pos1.Respostas_impulsivas.(['H', num2str(m)]).timeData';
        media_ri(n, :) = exp3_dados.Dados_brutos.TR.Pos2.Respostas_impulsivas.(['H', num2str(m)]).timeData';
    end
end

exp3_dados.Dados_brutos.TR.H_medio = itaAudio(mean(media_ri)', 51200, 'time');

% Corte da RI

h_cut = exp3_dados.Dados_brutos.TR.H_medio.timeData(1:(end/2));
exp3_dados.TR.H = itaAudio(h_cut ,51200 ,'time');
T20 = ita_roomacoustics(exp3_dados.TR.H, 'freqRange', [100 10000], 'bandsPerOctave', 3, 'T20');

exp3_dados.TR.T20 = T20.T20;

clear msNI H h_cut media_ri i m n T20; clc;
%% Aspirador de pó
load("pot_aspirador_pos1.mat");

% Dados de ajuste
exp3_dados.Ajuste.ajuste_gravado = msNI{1, 1}.sensitivity;
exp3_dados.Ajuste.FC = msNI{1, 1}.REF_FC;
% Dados de som residual
exp3_dados.Aspirador.Residual = msNI{1, 1}.somResidualInPascal;

for i=1:10
    exp3_dados.Dados_brutos.Aspirador.Pos1.(['med', num2str(i)]) = msNI{i, 1}.NPSInPascal;
end
clear msNI; clc;

load("pot_aspirador_pos2.mat");
for i=1:10
    exp3_dados.Dados_brutos.Aspirador.Pos2.(['med', num2str(i)]) = msNI{i, 1}.NPSInPascal;
end
clear msNI; clc;

% Média das medições de NPS
media_aspirador = [];

for m=1:10
    for n=11:20
        media_aspirador(m, :) = exp3_dados.Dados_brutos.Aspirador.Pos1.(['med', num2str(m)]).timeData';
        media_aspirador(n, :) = exp3_dados.Dados_brutos.Aspirador.Pos2.(['med', num2str(m)]).timeData';
    end
end

exp3_dados.Aspirador.NPS = itaAudio(mean(media_aspirador)', 51200, 'time');

clear msNI ans i m n media_aspirador; clc;

% for i=1:10
%     figure();
%     plot(exp3_dados.Dados_brutos.Aspirador.Pos1.(['med', num2str(i)]).freqVector, 20*log10(abs(exp3_dados.Dados_brutos.Aspirador.Pos1.(['med', num2str(i)]).freqData)/20e-6)); grid on
%     title(['Aspirador posição 1, medição ', num2str(i)]);
%     xlim([650 670]);
% 
%     figure();
%     plot(exp3_dados.Dados_brutos.Aspirador.Pos2.(['med', num2str(i)]).freqVector, 20*log10(abs(exp3_dados.Dados_brutos.Aspirador.Pos2.(['med', num2str(i)]).freqData)/20e-6)); grid on
%     title(['Aspirador posição 2, medição ', num2str(i)]);
%     xlim([650 670]);
% end
%% Fonte de referência
load("pot_refSource_pos1.mat");

% Dados de som residual
exp3_dados.Fonte_ref.Residual = msNI{1, 1}.somResidualInPascal;

for i=1:6
    exp3_dados.Dados_brutos.Fonte_ref.Pos1.(['med', num2str(i)]) = msNI{i, 1}.NPSInPascal;
end
clear msNI; clc;

load("pot_refSource_pos2.mat");
for i=1:6
    exp3_dados.Dados_brutos.Fonte_ref.Pos2.(['med', num2str(i)]) = msNI{i, 1}.NPSInPascal;
end
clear msNI; clc;

% Média das medições de NPS
media_fonte_ref = [];

for m=1:6
    for n=7:12
        media_fonte_ref(m, :) = exp3_dados.Dados_brutos.Fonte_ref.Pos1.(['med', num2str(m)]).timeData';
        media_fonte_ref(n, :) = exp3_dados.Dados_brutos.Fonte_ref.Pos2.(['med', num2str(m)]).timeData';
    end
end

exp3_dados.Fonte_ref.NPS = itaAudio(mean(media_fonte_ref)', 51200, 'time');


figure();
plot(exp3_dados.Fonte_ref.NPS.freqVector, 20*log10(abs(exp3_dados.Fonte_ref.NPS.freqData)/20e-6)); grid on
%% Salvar os dados

save('dados_experimento3_corrigido', "exp3_dados", '-v7.3');