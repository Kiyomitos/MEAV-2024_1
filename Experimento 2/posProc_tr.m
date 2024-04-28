%%% MEAV 2024.1 - Experimento 2 - Pós processamento %%
%%% Processamento de médias dos TRs                 %%
%%% Aluno: Victor Kiyomi                            %%
%%% Matrícula: 201920089                            %%
%%% Data: 25/04/2024                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Esse código irá realizar as médias dos tempos de reverberação. A
% structure gerada, TRs_medios, contém as médias por fonte (12
% resultados). Ademais, será feita outra structure,  TR_abs, com as médias das fontes
% para ambos os métodos e será diferenciado pela forma de calcular: ITA
% Toolbox ou Integral Reversa Cumulativa. Com isso, temos para o Sweep 4
% resultados (ITA e IRC) e para o ruído interrompido 2 (com e sem material
% de abs).
%% Cleaning service

clear all; format long; clc; close all;
%% Processamento de tempo de reverberação -- Médias
load("Experimento2_corrigido.mat"); % Structure que inclui o valor do Microfone 3 que foi perdido.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SWEEP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sem material
% Integral Reversa Cumulativa (IRC) -- Fonte 1
vec = [Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic1.IRC.T60; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic2.IRC.T60; 
    Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic3.IRC.T60; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic1.IRC.T60;
    Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic2.IRC.T60; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic3.IRC.T60];
TR_medio.Sweep.IRC.Sem_material.Fonte1 = mean(vec);

% Integral Reversa Cumulativa (IRC) -- Fonte 2
vec = [Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic1.IRC.T60; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic2.IRC.T60; 
    Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic3.IRC.T60; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic1.IRC.T60;
    Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic2.IRC.T60; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic3.IRC.T60];
TR_medio.Sweep.IRC.Sem_material.Fonte2 = mean(vec);

% ITA Toolbox -- Fonte 1
vec = [Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic1.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic2.ITA.T20.freqData'; 
    Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic3.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic1.ITA.T20.freqData';
    Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic2.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic3.ITA.T20.freqData'];
TR_medio.Sweep.ITAToolbox.Sem_material.Fonte1 = mean(vec);

% ITA Toolbox -- Fonte 2
vec = [Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic1.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic2.ITA.T20.freqData'; 
    Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic3.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic1.ITA.T20.freqData';
    Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic2.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic3.ITA.T20.freqData'];
TR_medio.Sweep.ITAToolbox.Sem_material.Fonte2 = mean(vec);

% Com material
% Integral Reversa Cumulativa (IRC) -- Fonte 1
vec = [Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic1.IRC.T60; Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic2.IRC.T60; 
    Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic3.IRC.T60; Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic1.IRC.T60;
    Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic2.IRC.T60; Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic3.IRC.T60];
TR_medio.Sweep.IRC.Com_material.Fonte1 = mean(vec);

% Integral Reversa Cumulativa (IRC) -- Fonte 2
vec = [Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic1.IRC.T60; Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic2.IRC.T60; 
    Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic3.IRC.T60; Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic1.IRC.T60;
    Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic2.IRC.T60; Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic3.IRC.T60];
TR_medio.Sweep.IRC.Com_material.Fonte2 = mean(vec);

% ITA Toolbox -- Fonte 1
vec = [Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic1.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic2.ITA.T20.freqData'; 
    Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic3.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic1.ITA.T20.freqData';
    Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic2.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic3.ITA.T20.freqData'];
TR_medio.Sweep.ITAToolbox.Com_material.Fonte1 = mean(vec);

% ITA Toolbox -- Fonte 2
vec = [Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic1.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic2.ITA.T20.freqData'; 
    Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic3.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic1.ITA.T20.freqData';
    Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic2.ITA.T20.freqData'; Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic3.ITA.T20.freqData'];
TR_medio.Sweep.ITAToolbox.Com_material.Fonte2 = mean(vec);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RUÍDO INTERROMPIDO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sem material
% Integral Reversa Cumulativa (IRC) -- Fonte 1
vec = [Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med1.Mic1.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med1.Mic2.IRC.T60; 
    Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med1.Mic3.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med2.Mic1.IRC.T60;
    Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med2.Mic2.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med2.Mic3.IRC.T60];
TR_medio.Ruido_interrompido.IRC.Sem_material.Fonte1 = mean(vec);

% Integral Reversa Cumulativa (IRC) -- Fonte 2
vec = [Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med1.Mic1.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med1.Mic2.IRC.T60; 
    Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med1.Mic3.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med2.Mic1.IRC.T60;
    Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med2.Mic2.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med2.Mic3.IRC.T60];
TR_medio.Ruido_interrompido.IRC.Sem_material.Fonte2 = mean(vec);

% Com material
% Integral Reversa Cumulativa (IRC) -- Fonte 1
vec = [Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med1.Mic1.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med1.Mic2.IRC.T60; 
    Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med1.Mic3.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med2.Mic1.IRC.T60;
    Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med2.Mic2.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med2.Mic3.IRC.T60];
TR_medio.Ruido_interrompido.IRC.Com_material.Fonte1 = mean(vec);

% Integral Reversa Cumulativa (IRC) -- Fonte 2
vec = [Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med1.Mic1.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med1.Mic2.IRC.T60; 
    Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med1.Mic3.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med2.Mic1.IRC.T60;
    Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med2.Mic2.IRC.T60; Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med2.Mic3.IRC.T60];
TR_medio.Ruido_interrompido.IRC.Com_material.Fonte2 = mean(vec);

%% Structure com os TRs médios
Experimento2.TRs_medios = TR_medio; %
%% Média de TR para cálculo do coef. de abs. do material
load("exp2_dados.mat");
% Sweep -- ITA Toolbox
% Sem material
vec = [exp2_dados.TRs_medios.Sweep.ITAToolbox.Sem_material.Fonte1; exp2_dados.TRs_medios.Sweep.ITAToolbox.Sem_material.Fonte2];

exp2_dados.TR_abs.Sweep.ITAToolbox.Sem_material = mean(vec);

% Com material
vec = [exp2_dados.TRs_medios.Sweep.ITAToolbox.Com_material.Fonte1; exp2_dados.TRs_medios.Sweep.ITAToolbox.Com_material.Fonte2];

exp2_dados.TR_abs.Sweep.ITAToolbox.Com_material = mean(vec);

% Sweep -- IRC
% Sem material
vec = [exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte1; exp2_dados.TRs_medios.Sweep.IRC.Sem_material.Fonte2];

exp2_dados.TR_abs.Sweep.IRC.Sem_material = mean(vec);

% Com material
vec = [exp2_dados.TRs_medios.Sweep.IRC.Com_material.Fonte1; exp2_dados.TRs_medios.Sweep.IRC.Com_material.Fonte2];

exp2_dados.TR_abs.Sweep.IRC.Com_material = mean(vec);

% Ruído interrompido -- IRC
% Sem material
vec = [exp2_dados.TRs_medios.Ruido_interrompido.IRC.Sem_material.Fonte1; exp2_dados.TRs_medios.Ruido_interrompido.IRC.Sem_material.Fonte2];

exp2_dados.TR_abs.Ruido_interrompido.Sem_Material = mean(vec);

% Com material
vec = [exp2_dados.TRs_medios.Ruido_interrompido.IRC.Com_material.Fonte1; exp2_dados.TRs_medios.Ruido_interrompido.IRC.Com_material.Fonte2];

exp2_dados.TR_abs.Ruido_interrompido.Com_Material = mean(vec); % Aqui trocamos o nome da strcture
%%
% save('exp2_dados.mat', "exp2_dados", '-mat');