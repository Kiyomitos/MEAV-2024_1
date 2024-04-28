%%% MEAV 2024.1 - Experimento 2 - Pós processamento %%
%%% Aluno: Victor Kiyomi                            %%
%%% Matrícula: 201920089                            %%
%%% Data: 25/04/2024                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cleaning Service
clear all; close all; clc;

%% Organização dos dados
% Como a medição é composta por três posições de microfone, duas posições
% de fonte, duas medições com e sem material, em cada situação, além de dois métodos distintos, temos muitos dados para
% processar. Dessa maneira, acredito que organizar tudo em um sistema de
% structures irá facilitar a leitura do código e processamento dos dados.

% Resultados -- ITAToolbox

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SEM MATERIAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Método Sweep - Sem Material - Fonte 1 - Medição 1
load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F1_m1_m2_m3__1\metodo_para_obter_TR_usando_ITA\sweep_ITA_calculation_F1_m1_m2_m3__1.mat");

Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic1.ITA = TR_1;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic2.ITA = TR_2;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic3.ITA = TR_3;

% Método Sweep - Sem Material - Fonte 1 - Medição 2
load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F1_m1_m2_m3__2\metodo_para_obter_TR_usando_ITA\sweep_ITA_calculation_F1_m1_m2_m3__2.mat");

Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic1.ITA = TR_1;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic2.ITA = TR_2;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic3.ITA = TR_3;

% Método Sweep - Sem Material - Fonte 2 - Medição 1
load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F2_m1_m2_m3__1\metodo_para_obter_TR_usando_ITA\sweep_ITA_calculation_F2_m1_m2_m3__1.mat");

Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic1.ITA = TR_1;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic2.ITA = TR_2;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic3.ITA = TR_3;

% Método Sweep - Sem Material - Fonte 2 - Medição 2
load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F2_m1_m2_m3__2\metodo_para_obter_TR_usando_ITA\sweep_ITA_calculation_F2_m1_m2_m3__2.mat");

Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic1.ITA = TR_1;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic2.ITA = TR_2;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic3.ITA = TR_3;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COM MATERIAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Método Sweep - Com Material - Fonte 1 - Medição 1
load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F1_m1_m2_m3__1\metodo_para_obter_TR_usando_ITA\sweep_ITA_calculation_F1_m1_m2_m3__1.mat");

Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic1.ITA = TR_1;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic2.ITA = TR_2;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic3.ITA = TR_3;

% Método Sweep - Com Material - Fonte 1 - Medição 2
load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F1_m1_m2_m3__2\metodo_para_obter_TR_usando_ITA\sweep_ITA_calculation_F1_m1_m2_m3__2.mat");

Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic1.ITA = TR_1;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic2.ITA = TR_2;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic3.ITA = TR_3;

% Método Sweep - Com Material - Fonte 2 - Medição 1
load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F2_m1_m2_m3__1\metodo_para_obter_TR_usando_ITA\sweep_ITA_calculation_F2_m1_m2_m3__1.mat");

Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic1.ITA = TR_1;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic2.ITA = TR_2;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic3.ITA = TR_3;

% Método Sweep - Com Material - Fonte 2 - Medição 2
load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F2_m1_m2_m3__2\metodo_para_obter_TR_usando_ITA\sweep_ITA_calculation_F2_m1_m2_m3__2.mat");

Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic1.ITA = TR_1;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic2.ITA = TR_2;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic3.ITA = TR_3;

%% Resultados -- Integral reversa cumulativa (IRC)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SEM MATERIAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Método Sweep - Sem Material - Fonte 1 - Medição 1
TR_1 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F1_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m1_1.mat", ...
    "T60");
TR_2 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F1_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m2_1.mat", ...
    "T60");
TR_3 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F1_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m3_1.mat", ...
    "T60");

Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med1.Mic3.IRC = TR_3;

% Método Sweep - Sem Material - Fonte 1 - Medição 2
TR_1 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F1_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m1_2.mat", ...
    "T60");
TR_2 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F1_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m2_2.mat", ...
    "T60");
TR_3 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F1_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m3_2.mat", ...
    "T60");

Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte1.Med2.Mic3.IRC = TR_3;

% Método Sweep - Sem Material - Fonte 2 - Medição 1
TR_1 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F2_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m1_1.mat", ...
    "T60");
TR_2 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F2_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m2_1.mat", ...
    "T60");
TR_3 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F2_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m3_1.mat", ...
    "T60");

Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med1.Mic3.IRC = TR_3;

% Método Sweep - Sem Material - Fonte 2 - Medição 2
TR_1 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F2_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m1_2.mat", ...
    "T60");
TR_2 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F2_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m2_2.mat", ...
    "T60");
TR_3 = load("Dados\ITA_sweep_TR\SEM_MATERIAL\sweep_F2_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m3_2.mat", ...
    "T60");

Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Sweep.Sem_material.Fonte2.Med2.Mic3.IRC = TR_3;

% Método Ruído Interrompido - Sem Material - Fonte 1 - Medição 1
TR_1 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F1_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f1_m1_1.mat", "T60");
TR_2 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F1_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f1_m2_1.mat", "T60");
TR_3 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F1_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f1_m3_1.mat", "T60");

Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med1.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med1.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med1.Mic3.IRC = TR_3;

% Método Ruído Interrompido - Sem Material - Fonte 1 - Medição 2
TR_1 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F1_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f1_m1_2.mat", "T60");
TR_2 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F1_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f1_m2_2.mat", "T60");
TR_3 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F1_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f1_m3_2.mat", "T60");

Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med2.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med2.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte1.Med2.Mic3.IRC = TR_3;

% Método Ruído Interrompido - Sem Material - Fonte 2 - Medição 1
TR_1 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F2_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f2_m1_1.mat", "T60");
TR_2 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F2_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f2_m2_1.mat", "T60");
TR_3 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F2_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f2_m3_1.mat", "T60");

Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med1.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med1.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med1.Mic3.IRC = TR_3;

% Método Ruído Interrompido - Sem Material - Fonte 2 - Medição 2
TR_1 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F2_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f2_m1_2.mat", "T60");
TR_2 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F2_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f2_m2_2.mat", "T60");
TR_3 = load("Dados\Ruido_INT\SEM_MATERIAL\ruido_int_F2_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f2_m3_2.mat", "T60");

Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med2.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med2.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Ruido_interrompido.Sem_material.Fonte2.Med2.Mic3.IRC = TR_3;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COM MATERIAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Método Sweep - Com Material - Fonte 1 - Medição 1
TR_1 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F1_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m1_1.mat", ...
    "T60");
TR_2 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F1_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m2_1.mat", ...
    "T60");
TR_3 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F1_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m3_1.mat", ...
    "T60");

Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med1.Mic3.IRC = TR_3;

% Método Sweep - Com Material - Fonte 1 - Medição 2
TR_1 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F1_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m1_2.mat", ...
    "T60");
TR_2 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F1_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m2_2.mat", ...
    "T60");
TR_3 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F1_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F1__m3_2.mat", ...
    "T60");

Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte1.Med2.Mic3.IRC = TR_3;

% Método Sweep - Com Material - Fonte 2 - Medição 1
TR_1 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F2_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m1_1.mat", ...
    "T60");
TR_2 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F2_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m2_1.mat", ...
    "T60");
TR_3 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F2_m1_m2_m3__1\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m3_1.mat", ...
    "T60");

Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med1.Mic3.IRC = TR_3;

% Método Sweep - Com Material - Fonte 2 - Medição 2
TR_1 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F2_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m1_2.mat", ...
    "T60");
TR_2 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F2_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m2_2.mat", ...
    "T60");
TR_3 = load("Dados\ITA_sweep_TR\COM_MATERIAL\sweep_F2_m1_m2_m3__2\metodo_para_obter_TR_usando_codigo_Paulo\sweep_paulo_eric_calculation_T60_F2__m3_2.mat", ...
    "T60");

Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Sweep.Com_material.Fonte2.Med2.Mic3.IRC = TR_3;

% Método Ruído Interrompido - Com Material - Fonte 1 - Medição 1
% Não foi salvo, durante o experimento, o resultado do T60 através da IRC.
% Portanto, será feito no código de proc. de dados.
TR_1 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F1_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f2_m1_1.mat", "T60");
TR_2 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F1_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f2_m2_1.mat", "T60");

Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med1.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med1.Mic2.IRC = TR_2;

% Método Ruído Interrompido - Com Material - Fonte 1 - Medição 2
TR_1 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F1_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f2_m1_1.mat");
TR_2 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F1_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f2_m2_1.mat");
TR_3 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F1_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f2_m3_1.mat");

Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med2.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med2.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte1.Med2.Mic3.IRC = TR_3;

% Método Ruído Interrompido - Com Material - Fonte 2 - Medição 1
TR_1 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F2_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f2_m1_1.mat");
TR_2 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F2_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f2_m2_1.mat");
TR_3 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F2_m1_m2_m3__1\ruido_int_paulo_eric_calculation_T60_f2_m3_1.mat");

Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med1.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med1.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med1.Mic3.IRC = TR_3;

% Método Ruído Interrompido - Com Material - Fonte 2 - Medição 2
TR_1 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F2_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f2_m1_1.mat");
TR_2 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F2_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f2_m2_1.mat");
TR_3 = load("Dados\Ruido_INT\COM_MATERIAL\ruido_int_F2_m1_m2_m3__2\ruido_int_paulo_eric_calculation_T60_f2_m3_1.mat");

Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med2.Mic1.IRC = TR_1;
Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med2.Mic2.IRC = TR_2;
Experimento2.Dados_brutos.Ruido_interrompido.Com_material.Fonte2.Med2.Mic3.IRC = TR_3;

%%
% Experimento2.Dados_brutos.Dados_brutos.Sweep = Experimento2.Dados_brutos.Sweep;
% Experimento2.Dados_brutos.Dados_brutos.Ruido_interrompido = Experimento2.Dados_brutos.Ruido_interrompido;
%% Salvar a structure inteira
save('Experimento2_corrigido.mat', "Experimento2", '-mat');