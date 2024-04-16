%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Métodos Experimentais em Acústica e Vibrações - MEAV
% Código para processamento do EXPERIMENTO 1
% Medição do nível de pressão sonora - MNPS/PULSE/NI/DOSÍMETRO
% Código de processamento elaborado por Yan Caproni Pereira
% Grupo: Yan Caproni, Victor Kiyomi e Wellington Veiga
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Limpeza

clear all; warning off; close all; clc;
%% Dados de entrada

ref= 20e-6; % Pressão de referência em Pa
numPontos= 3; % Número de pontos medidos
lower_freq= '20'; %frequência mais baixa avaliada
upper_freq= '20k'; %Frequência mais alta avaliada
pressao= 1012*100; % Pressão atmosférica em Pa
temp= 25.7; %temperatura em Celsius
umid= 56; %umidade em %
c= velsom(temp); % Função da velocidade do som em função da temperatura

% altere as strings para os paths desejados:
path_son = ['D:\Documentos\FACUL\MEAV\medicao_sonometro_exp1']; addpath(genpath(path_son)); 
path_pulse = ['D:\Documentos\FACUL\MEAV\BRUEL-20240403T171115Z-001\BRUEL']; addpath(genpath(path_pulse)); 
path_NI = ['D:\Documentos\FACUL\MEAV\NI-20240403T171133Z-001\NI']; addpath(genpath(path_NI));
% path_dosi = ['D:\Documentos\FACUL\MEAV\...']; addpath(genpath(path_dosi));

%% Carregando filtros

path_filtro= 'D:\Documentos\FACUL\Codigos_funcoes\Filtros_pond_A';
dado= fullfile(path_filtro,"Filtros_A_dB.mat");
filtroA= load(dado);

clear path_filtro dado

%% Importando dados do sonômetro

sonometro.freq= [20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 ...
    500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];

id_res_low = zeros(numPontos,1);
id_res_max = zeros(numPontos,1);
id_medio_low = zeros(numPontos,1);
id_medio_max = zeros(numPontos,1);
id_alto_low = zeros(numPontos,1);
id_alto_max = zeros(numPontos,1);

for i=1:numPontos
    %residual
    sonometro_res_path= ['residual-',num2str(i),'.xlsx']; % residual do sonômetro
    sonometro.(['res',num2str(i)]) = (readtable(sonometro_res_path,'Sheet','TotalSpectra')); % Planilha loc_AM_A
    id_res_low(i,1) = find(ismember(sonometro.(['res',num2str(i)]).Properties.VariableNames, ['LZeq',lower_freq,'Hz']));
    id_res_max(i,1) = find(ismember(sonometro.(['res',num2str(i)]).Properties.VariableNames, ['LZeq',upper_freq,'Hz']));
    sonometro.(['res',num2str(i)])= table2array(sonometro.(['res',num2str(i)])(1,id_res_low(i,1):id_res_max(i,1)));
    %medio
    sonometro_medio_path= ['medio-',num2str(i)]; % situação normal com sonômetro
    sonometro.(['medio',num2str(i)]) = (readtable(sonometro_medio_path,'Sheet','TotalSpectra'));
    id_medio_low(i,1) = find(ismember(sonometro.(['medio',num2str(i)]).Properties.VariableNames, ['LZeq',lower_freq,'Hz']));
    id_medio_max(i,1) = find(ismember(sonometro.(['medio',num2str(i)]).Properties.VariableNames, ['LZeq',upper_freq,'Hz']));
    sonometro.(['medio',num2str(i)])= table2array(sonometro.(['medio',num2str(i)])(1,id_medio_low(i,1):id_medio_max(i,1)));
    %alto
    sonometro_alto_path= ['alto-',num2str(i)]; % situação normal com sonômetro
    sonometro.(['alto',num2str(i)]) = (readtable(sonometro_alto_path,'Sheet','TotalSpectra'));
    id_alto_low(i,1) = find(ismember(sonometro.(['alto',num2str(i)]).Properties.VariableNames, ['LZeq',lower_freq,'Hz']));
    id_alto_max(i,1) = find(ismember(sonometro.(['alto',num2str(i)]).Properties.VariableNames, ['LZeq',upper_freq,'Hz']));
    sonometro.(['alto',num2str(i)])= table2array(sonometro.(['alto',num2str(i)])(1,id_alto_low(i,1):id_alto_max(i,1)));
end
clear sonometro_alto_path sonometro_medio_path sonometro_res_path...
    id_alto_max id_medio_max id_res_max id_alto_low id_medio_low...
    id_res_low i

%% Importando dados do Pulse

for n=1:numPontos
    %residual
    pulse_res_path= ['Autospectrum residual p',num2str(n),'.txt']; % residual do pulse
    pulse.(['res',num2str(n)])= readtable(pulse_res_path);
    pulse.(['res',num2str(n)])= pulse.(['res',num2str(n)])(84:(84+6400),:);
    pulse_res_terco_path= ['Autospectrum terco residual p',num2str(n),'.txt']; % residual do pulse
    pulse.(['res_terco',num2str(n)])= readtable(pulse_res_terco_path);
    pulse.(['res_terco',num2str(n)])= pulse.(['res_terco',num2str(n)])(84:(84+30),:);
    %medio
    pulse_medio_path= ['Autospectrum medio p',num2str(n),'.txt']; % medio do pulse
    pulse.(['medio',num2str(n)])= readtable(pulse_medio_path);
    pulse.(['medio',num2str(n)])= pulse.(['medio',num2str(n)])(84:(84+6400),:);
    pulse_medio_terco_path= ['Autospectrum terco medio p',num2str(n),'.txt']; % medio do pulse
    pulse.(['medio_terco',num2str(n)])= readtable(pulse_medio_terco_path);
    pulse.(['medio_terco',num2str(n)])= pulse.(['medio_terco',num2str(n)])(84:(84+30),:);
    %alto
    pulse_alto_path= ['Autospectrum alto p',num2str(n),'.txt']; % alto do pulse
    pulse.(['alto',num2str(n)])= readtable(pulse_alto_path);
    pulse.(['alto',num2str(n)])= pulse.(['alto',num2str(n)])(84:(84+6400),:);
    pulse_alto_terco_path= ['Autospectrum terco alto p',num2str(n),'.txt']; % alto do pulse
    pulse.(['alto_terco',num2str(n)])= readtable(pulse_alto_terco_path);
    pulse.(['alto_terco',num2str(n)])= pulse.(['alto_terco',num2str(n)])(84:(84+30),:);

end

clear pulse_alto_terco_path pulse_medio_terco_path pulse_res_terco_path pulse_alto_path...
    pulse_medio_path pulse_res_path n

%% Importando dados da NI

for m=1:numPontos
    %residual
    NI_res_path= fullfile(path_NI,['\residual\pto',num2str(m),'\NPS_1_sala_de_aula_National.mat']); % residual da NI
    NI.(['res',num2str(m)])= load(NI_res_path);
    %medio
    NI_medio_path= [path_NI,'\medio\pto',num2str(m),'\NPS_2_sala_de_aula_National.mat']; % medio da NI
    NI.(['medio',num2str(m)])= load(NI_medio_path);
    %alto
    NI_alto_path= [path_NI,'\full\pto',num2str(m),'\NPS_3_sala_de_aula_National.mat']; % ruidoso da NI
    NI.(['alto',num2str(m)])= load(NI_alto_path);
end

for m=1:numPontos
    %residual
    NI_res_path= fullfile(path_NI,['\residual\pto',num2str(m),'\input1.wav']); % residual da NI
    NI.(['wav_res',num2str(m)])= ita_read(NI_res_path);
    %medio
    NI_medio_path= [path_NI,'\medio\pto',num2str(m),'\input1.wav']; % medio da NI
    NI.(['wav_medio',num2str(m)])= ita_read(NI_medio_path);
    %alto
    NI_alto_path= [path_NI,'\full\pto',num2str(m),'\input1.wav']; % ruidoso da NI
    NI.(['wav_alto',num2str(m)])= ita_read(NI_alto_path);
end

%% Ajustando os dados da NI

%terco pascal
string={'res' 'medio' 'alto'};
pond= {'A' 'Z'};
for j= 1:length(string)
    for i= 1:numPontos 
            for n= 1:length(pond)
                var= [char(string(j)),num2str(i)];
                var2= ['ponderacao_',char(pond(n))];
                NI.(var).autoespectros.terco.(var2)= NI.(var).autoespectros.terco.(var2)(1,3:end);
            end
    end
end

%estreita pascal
string={'res' 'medio' 'alto'};
pond= {'A' 'Z'};
for j= 1:length(string)
    for i= 1:numPontos 
            for n= 1:length(pond)
                var= [char(string(j)),num2str(i)];
                var2= ['ponderacao_',char(pond(n))];
                NI.(var).autoespectros.estreita.(var2)= NI.(var).autoespectros.estreita.(var2)(1,1:6401);
            end
    end
end


%terco NPS
string={'res' 'medio' 'alto'};
pond= {'A' 'Z'};
for j= 1:length(string)
    for i= 1:numPontos 
            for n= 1:length(pond)
                var= [char(string(j)),num2str(i)];
                var2= [char(pond(n))];
                NI.(var).niveis_sonoros.terco.(var2)= NI.(var).niveis_sonoros.terco.(var2)(1,3:end);
            end
    end
end

%estreita NPS
string={'res' 'medio' 'alto'};
pond= {'A' 'Z'};
for j= 1:length(string)
    for i= 1:numPontos 
            for n= 1:length(pond)
                var= [char(string(j)),num2str(i)];
                var2= [char(pond(n))];
                NI.(var).niveis_sonoros.estreita.(var2)= NI.(var).niveis_sonoros.estreita.(var2)(1,1:6401);
            end
    end
end

clear NI_res_path NI_medio_path NI_alto_path var var2 i n u pond string j

%% Fim das importações - limpeza das variáveis de path

clear path_NI path_pulse path_son upper_freq lower_freq

%% Processamento sonômetro

sonometro.freqbar= 1:1:length(sonometro.res1);

% média dB espacial do sonometro (nesse caso e equação sem ponderação vale já que todas as gravações
% tem a mesma duração)

%residual
soma= zeros(numPontos);
for m= 1:length(sonometro.res1)
    
    for i=1:numPontos
        var= ['res',num2str(i)];
        soma(i,m)= 10^((sonometro.(var)(1,m))/10);
    end

end

sonometro.res_media_esp= mean(soma,1);
sonometro.res_media_esp= 10.*log10(sonometro.res_media_esp);

%medio

for m= 1:length(sonometro.medio1)
    
    for i=1:numPontos
        var= ['medio',num2str(i)];
        soma(i,m)= 10^((sonometro.(var)(1,m))/10);
    end

end

sonometro.medio_media_esp= mean(soma,1);
sonometro.medio_media_esp= 10.*log10(sonometro.medio_media_esp);

%alto

for m= 1:length(sonometro.alto1)
    
    for i=1:numPontos
        var= ['alto',num2str(i)];
        soma(i,m)= 10^((sonometro.(var)(1,m))/10);
    end

end

sonometro.alto_media_esp= mean(soma,1);
sonometro.alto_media_esp= 10.*log10(sonometro.alto_media_esp);

clear i m u var soma 

%% LZeq do sonômetro


% Residual
for n=1:numPontos
    var= ['res',num2str(n)];
    sonometro.Leq.(var)= 10*log10(sum(10.^((sonometro.(var))./10)));
end

sonometro.Leq.res_media= 10*log10(sum(10.^((sonometro.res_media_esp)./10)));

% Médio
for n=1:numPontos
    var= ['medio',num2str(n)];
    sonometro.Leq.(var)= 10*log10(sum(10.^((sonometro.(var))./10)));
end

sonometro.Leq.medio_media= 10*log10(sum(10.^((sonometro.medio_media_esp)./10)));

% Alto
for n=1:numPontos
    var= ['alto',num2str(n)];
    sonometro.Leq.(var)= 10*log10(sum(10.^((sonometro.(var))./10)));
end

sonometro.Leq.alto_media= 10*log10(sum(10.^((sonometro.alto_media_esp)./10)));


%% Ponderação A do Sonômetro

%residual
for n=1:numPontos
    var= ['res',num2str(n)];
    sonometro.pondA.(var)= sonometro.(var)' + filtroA.filtroA_dB_terco;
end

sonometro.pondA.res_media_esp= sonometro.res_media_esp' + filtroA.filtroA_dB_terco;

%medio
for n=1:numPontos
    var= ['medio',num2str(n)];
    sonometro.pondA.(var)= sonometro.(var)' + filtroA.filtroA_dB_terco;
end

sonometro.pondA.medio_media_esp= sonometro.medio_media_esp' + filtroA.filtroA_dB_terco;

%alto
for n=1:numPontos
    var= ['alto',num2str(n)];
    sonometro.pondA.(var)= sonometro.(var)' + filtroA.filtroA_dB_terco;
end

sonometro.pondA.alto_media_esp= sonometro.alto_media_esp' + filtroA.filtroA_dB_terco;

%% LAeq do Sonômetro

% Residual
for n=1:numPontos
    var= ['res',num2str(n)];
    sonometro.LAeq.(var)= 10*log10(sum(10.^((sonometro.pondA.(var))./10)));
end

sonometro.LAeq.res_media= 10*log10(sum(10.^((sonometro.pondA.res_media_esp)./10)));

% Médio
for n=1:numPontos
    var= ['medio',num2str(n)];
    sonometro.LAeq.(var)= 10*log10(sum(10.^((sonometro.pondA.(var))./10)));
end

sonometro.LAeq.medio_media= 10*log10(sum(10.^((sonometro.pondA.medio_media_esp)./10)));

% Alto
for n=1:numPontos
    var= ['alto',num2str(n)];
    sonometro.LAeq.(var)= 10*log10(sum(10.^((sonometro.pondA.(var))./10)));
end

sonometro.LAeq.alto_media= 10*log10(sum(10.^((sonometro.pondA.alto_media_esp)./10)));

% Expanda e descomente para os plots do sonômetro (A e Z)
% %% Plots Z Sonômetro
% 
% % Residual
% 
% figure();
% semilogx(sonometro.freq,sonometro.res1,'LineStyle','--','Linewidth',1.5, 'Color',[0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(sonometro.freq,sonometro.res2,'LineStyle','--','Linewidth',1.5, 'Color',[0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(sonometro.freq,sonometro.res3,'LineStyle','--','Linewidth',1.5, 'Color',[0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(sonometro.freq,sonometro.res_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p_1 — L_{Zeq} = ', num2str(round(sonometro.Leq.res1)),'dB'],['Condição 1 p_2 — L_{Zeq} = ', num2str(round(sonometro.Leq.res2)), 'dB'], ...
%     ['Condição 1 p_3 — L_{Zeq} = ', num2str(round(sonometro.Leq.res3)),'dB'], ...
%     ['Condição 1 média espacial — L_{Zeq} = ', num2str(round(sonometro.Leq.res_media)),'dB'],'location','southwest','Fontsize',22);
% title('Cadeia de medição 1 — Sem ponderação A','Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% xticks([20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000  ...
%     2500 3150 4000 5000 6300 8000 10000 12500 16000 20000]);
% xticklabels({'20' '25' '31.5' '40' '50' '63' '80' '100' '125' '160' '200' '250' '315' '400' '500' ...
%     '630' '800' '1k' '1,25k' '1,6k' '2k' '2,5k' '3,15k' '4k' '5k' '10k' '12,5k' '16k' '20k'});
% grid on;
% xlim([20 20000]);
% ylim([0 70])
% % arruma_fig('no','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Sonometro_C1Z','pdf');
% 
% % Médio
% 
% figure();
% semilogx(sonometro.freq,sonometro.medio1,'LineStyle','--','Linewidth',1.5, 'Color',[0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(sonometro.freq,sonometro.medio2,'LineStyle','--','Linewidth',1.5, 'Color',[0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(sonometro.freq,sonometro.medio3,'LineStyle','--','Linewidth',1.5, 'Color',[0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(sonometro.freq,sonometro.medio_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p_1 — L_{Zeq} = ', num2str(round(sonometro.Leq.medio1)),'dB'],['Condição 2 p_2 — L_{Zeq} = ', num2str(round(sonometro.Leq.medio2)), 'dB'], ...
%     ['Condição 2 p_3 — L_{Zeq} = ', num2str(round(sonometro.Leq.medio3)),'dB'], ...
%     ['Condição 2 média espacial — L_{Zeq} = ', num2str(round(sonometro.Leq.medio_media)),'dB'],'location','southwest','Fontsize',22);
% title('Cadeia de medição 1 — Sem ponderação A','Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28);
% set(gca, 'FontSize', 15);
% xticks([20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000  ...
%     2500 3150 4000 5000 6300 8000 10000 12500 16000 20000]);
% xticklabels({'20' '25' '31.5' '40' '50' '63' '80' '100' '125' '160' '200' '250' '315' '400' '500' ...
%     '630' '800' '1k' '1,25k' '1,6k' '2k' '2,5k' '3,15k' '4k' '5k' '10k' '12,5k' '16k' '20k'});
% grid on;
% xlim([20 20000]);
% ylim([0 70])
% % arruma_fig('spec2','no','virgula',2,0,[1 0]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Sonômetro_C2Z','pdf');
% 
% 
% % Alto
% 
% figure();
% semilogx(sonometro.freq,sonometro.alto1,'LineStyle','--','Linewidth',1.5, 'Color',[0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(sonometro.freq,sonometro.alto2,'LineStyle','--','Linewidth',1.5, 'Color',[0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(sonometro.freq,sonometro.alto3,'LineStyle','--','Linewidth',1.5, 'Color',[0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(sonometro.freq,sonometro.alto_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p_1 — L_{Zeq} = ', num2str(round(sonometro.Leq.alto1)),'dB'],['Condição 3 p_2 — L_{Zeq} = ', num2str(round(sonometro.Leq.alto2)), 'dB'], ...
%     ['Condição 3 p_3 — L_{Zeq} = ', num2str(round(sonometro.Leq.alto3)),'dB'], ...
%     ['Condição 3 média espacial — L_{Zeq} = ', num2str(round(sonometro.Leq.alto_media)),'dB'],'location','southwest','Fontsize',22);
% title('Cadeia de medição 1 — Sem ponderação A','Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% xticks([20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000  ...
%     2500 3150 4000 5000 6300 8000 10000 12500 16000 20000]);
% xticklabels({'20' '25' '31.5' '40' '50' '63' '80' '100' '125' '160' '200' '250' '315' '400' '500' ...
%     '630' '800' '1k' '1,25k' '1,6k' '2k' '2,5k' '3,15k' '4k' '5k' '10k' '12,5k' '16k' '20k'});
% grid on;
% xlim([20 20000]);
% ylim([30 75])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Sonômetro_C3Z','pdf');
% 
% 
% %% Plots A Sonômetro
% 
% % Residual
% 
% figure();
% semilogx(sonometro.freq,sonometro.pondA.res1,'LineStyle','--','Linewidth',1.5, 'Color',[0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(sonometro.freq,sonometro.pondA.res2,'LineStyle','--','Linewidth',1.5, 'Color',[0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(sonometro.freq,sonometro.pondA.res3,'LineStyle','--','Linewidth',1.5, 'Color',[0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(sonometro.freq,sonometro.pondA.res_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p_1 — L_{Aeq} = ', num2str(round(sonometro.LAeq.res1)),'dB'],['Condição 1 p_2 — L_{Aeq} = ', num2str(round(sonometro.LAeq.res2)), 'dB'], ...
%     ['Condição 1 p_3 — L_{Aeq} = ', num2str(round(sonometro.LAeq.res3)),'dB'], ...
%     ['Condição 1 média espacial — L_{Aeq} = ', num2str(round(sonometro.LAeq.res_media)),'dB'],'location','northeast','Fontsize',22);
% title('Cadeia de medição 1 — Com ponderação A','Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% xticks([20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000  ...
%     2500 3150 4000 5000 6300 8000 10000 12500 16000 20000]);
% xticklabels({'20' '25' '31.5' '40' '50' '63' '80' '100' '125' '160' '200' '250' '315' '400' '500' ...
%     '630' '800' '1k' '1,25k' '1,6k' '2k' '2,5k' '3,15k' '4k' '5k' '10k' '12,5k' '16k' '20k'});
% grid on;
% xlim([20 20000]);
% ylim([0 70])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Sonômetro_C1A','pdf');
% 
% % Médio
% 
% figure();
% semilogx(sonometro.freq,sonometro.pondA.medio1,'LineStyle','--','Linewidth',1.5, 'Color',[0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(sonometro.freq,sonometro.pondA.medio2,'LineStyle','--','Linewidth',1.5, 'Color',[0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(sonometro.freq,sonometro.pondA.medio3,'LineStyle','--','Linewidth',1.5, 'Color',[0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(sonometro.freq,sonometro.pondA.medio_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p_1 — L_{Aeq} = ', num2str(round(sonometro.LAeq.medio1)),'dB'],['Condição 2 p_2 — L_{Aeq} = ', num2str(round(sonometro.LAeq.medio2)), 'dB'], ...
%     ['Condição 2 p_3 — L_{Aeq} = ', num2str(round(sonometro.LAeq.medio3)),'dB'], ...
%     ['Condição 2 média espacial — L_{Aeq} = ', num2str(round(sonometro.LAeq.medio_media)),'dB'],'location','northeast','Fontsize',22);
% title('Cadeia de medição 1 — Com ponderação A','Avaliação em terço de oitava', 'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% xticks([20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000  ...
%     2500 3150 4000 5000 6300 8000 10000 12500 16000 20000]);
% xticklabels({'20' '25' '31.5' '40' '50' '63' '80' '100' '125' '160' '200' '250' '315' '400' '500' ...
%     '630' '800' '1k' '1,25k' '1,6k' '2k' '2,5k' '3,15k' '4k' '5k' '10k' '12,5k' '16k' '20k'});
% grid on;
% xlim([20 20000]);
% ylim([0 70])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Sonômetro_C2A','pdf');
% 
% % Alto
% 
% figure();
% semilogx(sonometro.freq,sonometro.pondA.alto1,'LineStyle','--','Linewidth',1.5, 'Color',[0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(sonometro.freq,sonometro.pondA.alto2,'LineStyle','--','Linewidth',1.5, 'Color',[0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(sonometro.freq,sonometro.pondA.alto3,'LineStyle','--','Linewidth',1.5, 'Color',[0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(sonometro.freq,sonometro.pondA.alto_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p_1 — L_{Aeq} = ', num2str(round(sonometro.LAeq.alto1)),'dB'],['Condição 3 p_2 — L_{Aeq} = ', num2str(round(sonometro.LAeq.alto2)), 'dB'], ...
%     ['Condição 3 p_3 — L_{Aeq} = ', num2str(round(sonometro.LAeq.alto3)),'dB'], ...
%     ['Condição 3 média espacial — L_{Aeq} = ', num2str(round(sonometro.LAeq.alto_media)),'dB'],'location','southwest','Fontsize',22);
% title('Cadeia de medição 1 — Com ponderação A','Avaliação em terço de oitava', 'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% xticks([20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000  ...
%     2500 3150 4000 5000 6300 8000 10000 12500 16000 20000]);
% xticklabels({'20' '25' '31.5' '40' '50' '63' '80' '100' '125' '160' '200' '250' '315' '400' '500' ...
%     '630' '800' '1k' '1,25k' '1,6k' '2k' '2,5k' '3,15k' '4k' '5k' '10k' '12,5k' '16k' '20k'});
% grid on;
% xlim([20 20000]);
% ylim([0 70])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Sonômetro_C3A','pdf');

%% Processamento Pulse

%% Convertendo os dados para arrays:
%Residual
for n=1:numPontos
    pulse.(['res',num2str(n)])= table2array(pulse.(['res',num2str(n)])(:,2:3));
end
for n=1:numPontos
    pulse.(['res_terco',num2str(n)])= table2array(pulse.(['res_terco',num2str(n)])(1:31,2:3));
end
%Medio
for n=1:numPontos
    pulse.(['medio',num2str(n)])= table2array(pulse.(['medio',num2str(n)])(:,2:3));
end
for n=1:numPontos
    pulse.(['medio_terco',num2str(n)])= table2array(pulse.(['medio_terco',num2str(n)])(1:31,2:3));
end
%Alto
for n=1:numPontos
    pulse.(['alto',num2str(n)])= table2array(pulse.(['alto',num2str(n)])(:,2:3));
end
for n=1:numPontos
    pulse.(['alto_terco',num2str(n)])= table2array(pulse.(['alto_terco',num2str(n)])(1:31,2:3));
end

%% NPS do pulse

pulse.freq= pulse.res1(:,1);
pulse.freq_terco= pulse.res_terco1(:,1);

%Residual NPS
for n=1:numPontos
    pulse.(['res',num2str(n)])= pulse.(['res',num2str(n)])(:,2);
    pulse.(['NPS_res',num2str(n)])= 10*log10((pulse.(['res',num2str(n)]))./(ref^2));
end

for n=1:numPontos
    pulse.(['res_terco',num2str(n)])= pulse.(['res_terco',num2str(n)])(:,2);
    pulse.(['NPS_res_terco',num2str(n)])= 10*log10((pulse.(['res_terco',num2str(n)]))./(ref^2));
end

%Medio NPS
for n=1:numPontos
    pulse.(['medio',num2str(n)])= pulse.(['medio',num2str(n)])(:,2);
    pulse.(['NPS_medio',num2str(n)])= 10*log10((pulse.(['medio',num2str(n)]))./(ref^2));
end

for n=1:numPontos
    pulse.(['medio_terco',num2str(n)])= pulse.(['medio_terco',num2str(n)])(:,2);
    pulse.(['NPS_medio_terco',num2str(n)])= 10*log10((pulse.(['medio_terco',num2str(n)]))./(ref^2));
end

%Alto NPS
for n=1:numPontos
    pulse.(['alto',num2str(n)])= pulse.(['alto',num2str(n)])(:,2);
    pulse.(['NPS_alto',num2str(n)])= 10*log10((pulse.(['alto',num2str(n)]))./(ref^2));
end

for n=1:numPontos
    pulse.(['alto_terco',num2str(n)])= pulse.(['alto_terco',num2str(n)])(:,2);
    pulse.(['NPS_alto_terco',num2str(n)])= 10*log10((pulse.(['alto_terco',num2str(n)]))./(ref^2));
end

%% Médias do pulse

% Residual
soma= zeros(numPontos);
for m= 1:length(pulse.res1)
    
    for i=1:numPontos
        var= ['NPS_res',num2str(i)];
        soma(i,m)= 10^((pulse.(var)(m,1))/10);
    end

end

pulse.res_media_esp= mean(soma,1);
pulse.res_media_esp= 10.*log10(pulse.res_media_esp);

%Terço
soma= zeros(numPontos);
for m= 1:length(pulse.res_terco1)
    
    for i=1:numPontos
        var= ['NPS_res_terco',num2str(i)];
        soma(i,m)= 10^((pulse.(var)(m,1))/10);
    end

end

pulse.res_terco_media_esp= mean(soma,1);
pulse.res_terco_media_esp= 10.*log10(pulse.res_terco_media_esp);


% Médio

soma= zeros(numPontos);
for m= 1:length(pulse.medio1)
    
    for i=1:numPontos
        var= ['NPS_medio',num2str(i)];
        soma(i,m)= 10^((pulse.(var)(m,1))/10);
    end

end

pulse.medio_media_esp= mean(soma,1);
pulse.medio_media_esp= 10.*log10(pulse.medio_media_esp);

%Terço
soma= zeros(numPontos);
for m= 1:length(pulse.medio_terco1)
    
    for i=1:numPontos
        var= ['NPS_medio_terco',num2str(i)];
        soma(i,m)= 10^((pulse.(var)(m,1))/10);
    end

end

pulse.medio_terco_media_esp= mean(soma,1);
pulse.medio_terco_media_esp= 10.*log10(pulse.medio_terco_media_esp);


% Alto

soma= zeros(numPontos);
for m= 1:length(pulse.alto1)
    
    for i=1:numPontos
        var= ['NPS_alto',num2str(i)];
        soma(i,m)= 10^((pulse.(var)(m,1))/10);
    end

end

pulse.alto_media_esp= mean(soma,1);
pulse.alto_media_esp= 10.*log10(pulse.alto_media_esp);

%Terço
soma= zeros(numPontos);
for m= 1:length(pulse.alto_terco1)
    
    for i=1:numPontos
        var= ['NPS_alto_terco',num2str(i)];
        soma(i,m)= 10^((pulse.(var)(m,1))/10);
    end

end

pulse.alto_terco_media_esp= mean(soma,1);
pulse.alto_terco_media_esp= 10.*log10(pulse.alto_terco_media_esp);

%% LZeq pulse

% Residual
for n=1:numPontos
    var= ['NPS_res',num2str(n)];
    pulse.Leq.(var)= 10*log10(sum(10.^((pulse.(var))./10)));
end

for n=1:numPontos
    var= ['NPS_res_terco',num2str(n)];
    pulse.Leq.terco.(var)= 10*log10(sum(10.^((pulse.(var))./10)));
end


pulse.Leq.res_media= 10*log10(sum(10.^((pulse.res_media_esp)./10)));
pulse.Leq.terco.res_media= 10*log10(sum(10.^((pulse.res_terco_media_esp)./10)));

% Médio
for n=1:numPontos
    var= ['NPS_medio',num2str(n)];
    pulse.Leq.(var)= 10*log10(sum(10.^((pulse.(var))./10)));
end

for n=1:numPontos
    var= ['NPS_medio_terco',num2str(n)];
    pulse.Leq.terco.(var)= 10*log10(sum(10.^((pulse.(var))./10)));
end

pulse.Leq.medio_media= 10*log10(sum(10.^((pulse.medio_media_esp)./10)));
pulse.Leq.terco.medio_media= 10*log10(sum(10.^((pulse.medio_terco_media_esp)./10)));

% Alto
for n=1:numPontos
    var= ['NPS_alto',num2str(n)];
    pulse.Leq.(var)= 10*log10(sum(10.^((pulse.(var))./10)));
end

for n=1:numPontos
    var= ['NPS_alto_terco',num2str(n)];
    pulse.Leq.terco.(var)= 10*log10(sum(10.^((pulse.(var))./10)));
end

pulse.Leq.alto_media= 10*log10(sum(10.^((pulse.alto_media_esp)./10)));
pulse.Leq.terco.alto_media= 10*log10(sum(10.^((pulse.alto_terco_media_esp)./10)));


%% Limpeza

clear soma var 

%% Pulse ponderado em A

%residual
for n=1:numPontos
    pulse.pondA.(['NPS_res',num2str(n)])= pulse.(['NPS_res',num2str(n)])+(filtroA.filtroA_dB_3p125);
end

pulse.pondA.('res_media_esp')= pulse.('res_media_esp')'+(filtroA.filtroA_dB_3p125);

%terco
for n=1:numPontos
    pulse.pondA.(['NPS_res_terco',num2str(n)])= pulse.(['NPS_res_terco',num2str(n)])+(filtroA.filtroA_dB_terco);
end

pulse.pondA.('res_terco_media_esp')= pulse.('res_terco_media_esp')'+(filtroA.filtroA_dB_terco);

%medio
for n=1:numPontos
    pulse.pondA.(['NPS_medio',num2str(n)])= pulse.(['NPS_medio',num2str(n)])+(filtroA.filtroA_dB_3p125);
end

pulse.pondA.('medio_media_esp')= pulse.('medio_media_esp')'+(filtroA.filtroA_dB_3p125);

%terco
for n=1:numPontos
    pulse.pondA.(['NPS_medio_terco',num2str(n)])= pulse.(['NPS_medio_terco',num2str(n)])+(filtroA.filtroA_dB_terco);
end

pulse.pondA.('medio_terco_media_esp')= pulse.('medio_terco_media_esp')'+(filtroA.filtroA_dB_terco);

%alto
for n=1:numPontos
    pulse.pondA.(['NPS_alto',num2str(n)])= pulse.(['NPS_alto',num2str(n)])+(filtroA.filtroA_dB_3p125);
end

pulse.pondA.('alto_media_esp')= pulse.('alto_media_esp')'+(filtroA.filtroA_dB_3p125);

%terco
for n=1:numPontos
    pulse.pondA.(['NPS_alto_terco',num2str(n)])= pulse.(['NPS_alto_terco',num2str(n)])+(filtroA.filtroA_dB_terco);
end

pulse.pondA.('alto_terco_media_esp')= pulse.('alto_terco_media_esp')'+(filtroA.filtroA_dB_terco);

%% LAeq pulse

% Residual
for n=1:numPontos
    var= ['NPS_res',num2str(n)];
    pulse.LAeq.(var)= 10*log10(sum(10.^((pulse.pondA.(var))./10)));
end

for n=1:numPontos
    var= ['NPS_res_terco',num2str(n)];
    pulse.LAeq.terco.(var)= 10*log10(sum(10.^((pulse.pondA.(var))./10)));
end


pulse.LAeq.res_media= 10*log10(sum(10.^((pulse.pondA.res_media_esp)./10)));
pulse.LAeq.terco.res_media= 10*log10(sum(10.^((pulse.pondA.res_terco_media_esp)./10)));

% Médio
for n=1:numPontos
    var= ['NPS_medio',num2str(n)];
    pulse.LAeq.(var)= 10*log10(sum(10.^((pulse.pondA.(var))./10)));
end

for n=1:numPontos
    var= ['NPS_medio_terco',num2str(n)];
    pulse.LAeq.terco.(var)= 10*log10(sum(10.^((pulse.pondA.(var))./10)));
end

pulse.LAeq.medio_media= 10*log10(sum(10.^((pulse.pondA.medio_media_esp)./10)));
pulse.LAeq.terco.medio_media= 10*log10(sum(10.^((pulse.pondA.medio_terco_media_esp)./10)));

% Alto
for n=1:numPontos
    var= ['NPS_alto',num2str(n)];
    pulse.LAeq.(var)= 10*log10(sum(10.^((pulse.pondA.(var))./10)));
end

for n=1:numPontos
    var= ['NPS_alto_terco',num2str(n)];
    pulse.LAeq.terco.(var)= 10*log10(sum(10.^((pulse.pondA.(var))./10)));
end

pulse.LAeq.alto_media= 10*log10(sum(10.^((pulse.pondA.alto_media_esp)./10)));
pulse.LAeq.terco.alto_media= 10*log10(sum(10.^((pulse.pondA.alto_terco_media_esp)./10)));


%% Limpeza

clear m i n ax var


% Expanda e descomente para os plots do pulse (A e Z -> estreita e terço)
% %% Plots estreita Pulse A
% 
% % Residual
% 
% figure();
% semilogx(pulse.freq,pulse.pondA.NPS_res1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq,pulse.pondA.NPS_res2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq,pulse.pondA.NPS_res3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq,pulse.pondA.res_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p_1 - L_{Aeq} = ', num2str(round(pulse.LAeq.NPS_res1)),'dB'],['Condição 1 p_2 - L_{Aeq}=', num2str(round(pulse.LAeq.NPS_res2)), 'dB'], ...
%     ['Condição 1 p_3 - L_{Aeq} = ', num2str(round(pulse.LAeq.NPS_res3)),'dB'], ...
%     ['Condição 1 média espacial - L_{Aeq} = ', num2str(round(pulse.LAeq.res_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Com ponderação A'],'Avaliação em banda estreita','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_est_C1A','pdf');
% 
% % Médio
% 
% figure();
% semilogx(pulse.freq,pulse.pondA.NPS_medio1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq,pulse.pondA.NPS_medio2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq,pulse.pondA.NPS_medio3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq,pulse.pondA.medio_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p_1 - L_{Aeq} = ', num2str(round(pulse.LAeq.NPS_medio1)),'dB'],['Condição 2 p_2 - L_{Aeq}=', num2str(round(pulse.LAeq.NPS_medio2)), 'dB'], ...
%     ['Condição 2 p_3 - L_{Aeq} = ', num2str(round(pulse.LAeq.NPS_medio3)),'dB'], ...
%     ['Condição 2 média espacial - L_{Aeq} = ', num2str(round(pulse.LAeq.medio_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Com ponderação A'],'Avaliação em banda estreita', 'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_est_C2A','pdf');
% 
% % Alto
% 
% figure();
% semilogx(pulse.freq,pulse.pondA.NPS_alto1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq,pulse.pondA.NPS_alto2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq,pulse.pondA.NPS_alto3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq,pulse.pondA.alto_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p_1 - L_{Aeq} = ', num2str(round(pulse.LAeq.NPS_alto1)),'dB'],['Condição 3 p_2 - L_{Aeq}=', num2str(round(pulse.LAeq.NPS_alto2)), 'dB'], ...
%     ['Condição 3 p_3 - L_{Aeq} = ', num2str(round(pulse.LAeq.NPS_alto3)),'dB'], ...
%     ['Condição 3 média espacial - L_{Aeq} = ', num2str(round(pulse.LAeq.alto_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Com ponderação A'],'Avaliação em banda estreita', 'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_est_C3A','pdf');
% 
% %% Plots estreita Pulse Z
% 
% % Residual
% 
% figure();
% semilogx(pulse.freq,pulse.NPS_res1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq,pulse.NPS_res2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq,pulse.NPS_res3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq,pulse.res_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p_1 - L_{Zeq} = ', num2str(round(pulse.Leq.NPS_res1)),'dB'],['Condição 1 p_2 - L_{Zeq}=', num2str(round(pulse.Leq.NPS_res2)), 'dB'], ...
%     ['Condição 1 p_3 - L_{Zeq} = ', num2str(round(pulse.Leq.NPS_res3)),'dB'], ...
%     ['Condição 1 média espacial - L_{Zeq} = ', num2str(round(pulse.Leq.res_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Sem ponderação'],'Avaliação em banda estreita','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_est_C1Z','pdf');
% 
% % Médio
% 
% figure();
% semilogx(pulse.freq,pulse.NPS_medio1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq,pulse.NPS_medio2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq,pulse.NPS_medio3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq,pulse.medio_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p_1 - L_{Zeq} = ', num2str(round(pulse.Leq.NPS_medio1)),'dB'],['Condição 2 p_2 - L_{Zeq}=', num2str(round(pulse.Leq.NPS_medio2)), 'dB'], ...
%     ['Condição 2 p_3 - L_{Zeq} = ', num2str(round(pulse.Leq.NPS_medio3)),'dB'], ...
%     ['Condição 2 média espacial - L_{Zeq} = ', num2str(round(pulse.Leq.medio_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Sem ponderação'],'Avaliação em banda estreita', 'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_est_C2Z','pdf');
% 
% % Alto
% 
% figure();
% semilogx(pulse.freq,pulse.NPS_alto1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq,pulse.NPS_alto2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq,pulse.NPS_alto3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq,pulse.alto_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p_1 - L_{Zeq} = ', num2str(round(pulse.Leq.NPS_alto1)),'dB'],['Condição 3 p_2 - L_{Zeq}=', num2str(round(pulse.Leq.NPS_alto2)), 'dB'], ...
%     ['Condição 3 p_3 - L_{Zeq} = ', num2str(round(pulse.Leq.NPS_alto3)),'dB'], ...
%     ['Condição 3 média espacial - L_{Zeq} = ', num2str(round(pulse.Leq.alto_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Sem ponderação'],'Avaliação em banda estreita', 'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_est_C3Z','pdf');
% 
% 
% %% Plots terço Pulse A
% 
% % Residual
% 
% figure();
% semilogx(pulse.freq_terco,pulse.pondA.NPS_res_terco1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq_terco,pulse.pondA.NPS_res_terco2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq_terco,pulse.pondA.NPS_res_terco3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq_terco,pulse.pondA.res_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p_1 - L_{Aeq} = ', num2str(round(pulse.LAeq.terco.NPS_res_terco1)),'dB'],['Condição 1 p_2 - L_{Aeq}=', num2str(round(pulse.LAeq.terco.NPS_res_terco3)), 'dB'], ...
%     ['Condição 1 p_3 - L_{Aeq} = ', num2str(round(pulse.LAeq.terco.NPS_res_terco3)),'dB'], ...
%     ['Condição 1 média espacial - L_{Aeq} = ', num2str(round(pulse.LAeq.terco.res_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Com ponderação A'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_terco_C1A','pdf');
% 
% % Médio
% 
% figure();
% semilogx(pulse.freq_terco,pulse.pondA.NPS_medio_terco1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq_terco,pulse.pondA.NPS_medio_terco2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq_terco,pulse.pondA.NPS_medio_terco3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq_terco,pulse.pondA.medio_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p_1 - L_{Aeq} = ', num2str(round(pulse.LAeq.terco.NPS_medio_terco1)),'dB'],['Condição 2 p_2 - L_{Aeq}=', num2str(round(pulse.LAeq.terco.NPS_medio_terco3)), 'dB'], ...
%     ['Condição 2 p_3 - L_{Aeq} = ', num2str(round(pulse.LAeq.terco.NPS_medio_terco3)),'dB'], ...
%     ['Condição 2 média espacial - L_{Aeq} = ', num2str(round(pulse.LAeq.terco.medio_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Com ponderação A'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_terco_C2A','pdf');
% 
% % Alto
% 
% figure();
% semilogx(pulse.freq_terco,pulse.pondA.NPS_alto_terco1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6] ); hold on
% semilogx(pulse.freq_terco,pulse.pondA.NPS_alto_terco2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq_terco,pulse.pondA.NPS_alto_terco3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq_terco,pulse.pondA.alto_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p_1 - L_{Aeq} = ', num2str(round(pulse.LAeq.terco.NPS_alto_terco1)),'dB'],['Condição 3 p_2 - L_{Aeq}=', num2str(round(pulse.LAeq.terco.NPS_alto_terco3)), 'dB'], ...
%     ['Condição 3 p_3 - L_{Aeq} = ', num2str(round(pulse.LAeq.terco.NPS_alto_terco3)),'dB'], ...
%     ['Condição 3 média espacial - L_{Aeq} = ', num2str(round(pulse.LAeq.terco.alto_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Com ponderação A'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_terco_C3A','pdf');
% %% Plots terço Pulse Z
% 
% % Residual
% 
% figure();
% semilogx(pulse.freq_terco,pulse.NPS_res_terco1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq_terco,pulse.NPS_res_terco2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq_terco,pulse.NPS_res_terco3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq_terco,pulse.res_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p_1 - L_{Zeq} = ', num2str(round(pulse.Leq.terco.NPS_res_terco1)),'dB'],['Condição 1 p_2 - L_{Zeq}=', num2str(round(pulse.Leq.terco.NPS_res_terco3)), 'dB'], ...
%     ['Condição 1 p_3 - L_{Zeq} = ', num2str(round(pulse.Leq.terco.NPS_res_terco3)),'dB'], ...
%     ['Condição 1 média espacial - L_{Zeq} = ', num2str(round(pulse.Leq.terco.res_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Sem ponderação A'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_terco_C1Z','pdf');
% 
% % Médio
% 
% figure();
% semilogx(pulse.freq_terco,pulse.NPS_medio_terco1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq_terco,pulse.NPS_medio_terco2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq_terco,pulse.NPS_medio_terco3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq_terco,pulse.medio_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p_1 - L_{Zeq} = ', num2str(round(pulse.Leq.terco.NPS_medio_terco1)),'dB'],['Condição 2 p_2 - L_{Zeq}=', num2str(round(pulse.Leq.terco.NPS_medio_terco3)), 'dB'], ...
%     ['Condição 2 p_3 - L_{Zeq} = ', num2str(round(pulse.Leq.terco.NPS_medio_terco3)),'dB'], ...
%     ['Condição 2 média espacial - L_{Zeq} = ', num2str(round(pulse.Leq.terco.medio_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Sem ponderação A'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 12 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [12 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_terco_C2Z','pdf');
% 
% % Alto
% 
% figure();
% semilogx(pulse.freq_terco,pulse.NPS_alto_terco1,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(pulse.freq_terco,pulse.NPS_alto_terco2,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(pulse.freq_terco,pulse.NPS_alto_terco3,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(pulse.freq_terco,pulse.alto_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p_1 - L_{Zeq} = ', num2str(round(pulse.Leq.terco.NPS_alto_terco1)),'dB'],['Condição 3 p_2 - L_{Zeq}=', num2str(round(pulse.Leq.terco.NPS_alto_terco3)), 'dB'], ...
%     ['Condição 3 p_3 - L_{Zeq} = ', num2str(round(pulse.Leq.terco.NPS_alto_terco3)),'dB'], ...
%     ['Condição 3 média espacial - L_{Zeq} = ', num2str(round(pulse.Leq.terco.alto_media)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 2 — Sem ponderação A'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 12 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [12 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Pulse_terco_C3Z','pdf');

%% Médias NI

%terco
string={'res' 'medio' 'alto'};
pond= {'A' 'Z'};
for j= 1:length(string)
    for n= 1:length(pond)
        for i= 1:numPontos
            for m= 1:length(NI.res1.niveis_sonoros.terco.Z)
                var= [char(string(j)),num2str(i)];
                var2= [char(pond(n))];
                soma(i,m)= 10^((NI.(var).niveis_sonoros.terco.(var2)(1,m))/10);
            end
        end
        NI.(var).(var2).terco_media_esp= mean(soma,1);
        NI.(var).(var2).terco_media_esp= 10.*log10(NI.(var).(var2).terco_media_esp);
    end
end

%estreita 
string={'res' 'medio' 'alto'};
pond= {'A' 'Z'};
for j= 1:length(string)
    for n= 1:length(pond)
        for i= 1:numPontos
            for m= 1:length(NI.res1.niveis_sonoros.estreita.Z)
                var= [char(string(j)),num2str(i)];
                var2= [char(pond(n))];
                soma(i,m)= 10^((NI.(var).niveis_sonoros.estreita.(var2)(1,m))/10);
            end
        end
        NI.(var).(var2).estreita_media_esp= mean(soma,1);
        NI.(var).(var2).estreita_media_esp= 10.*log10(NI.(var).(var2).estreita_media_esp);
    end
end

clear i j m n var var2 string soma pond

%% LZeq NI

%terco
string={'res' 'medio' 'alto'};
pond= {'A' 'Z'};
for j= 1:length(string)
    for n= 1:length(pond)
        for i= 1:numPontos
            for m= 1:length(NI.res1.niveis_sonoros.terco.Z)
                var= [char(string(j)),num2str(i)];
                var2= [char(pond(n))];
                NI.Leq.terco.(var).(var2)= 10*log10(sum(10.^((NI.(var).niveis_sonoros.terco.(var2))./10)));
            end
        end
    end
end

NI.Leq.terco.res_media_esp.Z= 10*log10(sum(10.^((NI.res3.Z.terco_media_esp)./10)));
NI.Leq.terco.medio_media_esp.Z= 10*log10(sum(10.^((NI.medio3.Z.terco_media_esp)./10)));
NI.Leq.terco.alto_media_esp.Z= 10*log10(sum(10.^((NI.alto3.Z.terco_media_esp)./10)));

NI.Leq.terco.res_media_esp.A= 10*log10(sum(10.^((NI.res3.A.terco_media_esp)./10)));
NI.Leq.terco.medio_media_esp.A= 10*log10(sum(10.^((NI.medio3.A.terco_media_esp)./10)));
NI.Leq.terco.alto_media_esp.A= 10*log10(sum(10.^((NI.alto3.A.terco_media_esp)./10)));

%estreita
string={'res' 'medio' 'alto'};
pond= {'A' 'Z'};
for j= 1:length(string)
    for n= 1:length(pond)
        for i= 1:numPontos
            for m= 1:length(NI.res1.niveis_sonoros.estreita.Z)
                var= [char(string(j)),num2str(i)];
                var2= [char(pond(n))];
                NI.Leq.estreita.(var).(var2)= 10*log10(sum(10.^((NI.(var).niveis_sonoros.estreita.(var2))./10)));
            end
        end
    end
end

NI.Leq.estreita.res_media_esp.Z= 10*log10(sum(10.^((NI.res3.Z.estreita_media_esp)./10)));
NI.Leq.estreita.medio_media_esp.Z= 10*log10(sum(10.^((NI.medio3.Z.estreita_media_esp)./10)));
NI.Leq.estreita.alto_media_esp.Z= 10*log10(sum(10.^((NI.alto3.Z.estreita_media_esp)./10)));

NI.Leq.estreita.res_media_esp.A= 10*log10(sum(10.^((NI.res3.A.estreita_media_esp)./10)));
NI.Leq.estreita.medio_media_esp.A= 10*log10(sum(10.^((NI.medio3.A.estreita_media_esp)./10)));
NI.Leq.estreita.alto_media_esp.A= 10*log10(sum(10.^((NI.alto3.A.estreita_media_esp)./10)));


%% Limpeza

clear i j m n pond string var var2


%% Expanda e descomente para os plots da NI (A e Z -> estreita e terço)
% %% Plots NI Z
% 
% % Residual
% 
% figure();
% semilogx(NI.res1.frequencias.estreita(:,1:6401), NI.res1.niveis_sonoros.estreita.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.res1.frequencias.estreita(:,1:6401), NI.res2.niveis_sonoros.estreita.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.res1.frequencias.estreita(:,1:6401), NI.res3.niveis_sonoros.estreita.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.res1.frequencias.estreita(:,1:6401), NI.res3.Z.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p1 - LZeq = ', num2str(round(NI.Leq.estreita.res1.Z)),'dB'],['Condição 1 p2 - LZeq=', num2str(round(NI.Leq.estreita.res2.Z)), 'dB'], ...
%     ['Condição 1 p3 - LZeq = ', num2str(round(NI.Leq.estreita.res3.Z)),'dB'], ...
%     ['Condição 1 média espacial - LZeq = ', num2str(round(NI.Leq.estreita.res_media_esp.Z)),'dB'],'location','northeast','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Sem ponderação'],'Avaliação em banda estreita','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_est_C1Z','pdf');
% 
% % Médio
% 
% figure();
% semilogx(NI.medio1.frequencias.estreita(:,1:6401), NI.medio1.niveis_sonoros.estreita.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.medio1.frequencias.estreita(:,1:6401), NI.medio2.niveis_sonoros.estreita.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.medio1.frequencias.estreita(:,1:6401), NI.medio3.niveis_sonoros.estreita.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.medio1.frequencias.estreita(:,1:6401), NI.medio3.Z.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p1 - LZeq = ', num2str(round(NI.Leq.estreita.medio1.Z)),'dB'],['Condição 2 p2 - LZeq=', num2str(round(NI.Leq.estreita.medio2.Z)), 'dB'], ...
%     ['Condição 2 p3 - LZeq = ', num2str(round(NI.Leq.estreita.medio3.Z)),'dB'], ...
%     ['Condição 2 média espacial - LZeq = ', num2str(round(NI.Leq.estreita.medio_media_esp.Z)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Sem ponderação'],'Avaliação em banda estreita','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_est_C2Z','pdf');
% 
% % Alto
% 
% figure();
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto1.niveis_sonoros.estreita.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto2.niveis_sonoros.estreita.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto3.niveis_sonoros.estreita.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto3.Z.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p1 - LZeq = ', num2str(round(NI.Leq.estreita.alto1.Z)),'dB'],['Condição 3 p2 - LZeq=', num2str(round(NI.Leq.estreita.alto2.Z)), 'dB'], ...
%     ['Condição 3 p3 - LZeq = ', num2str(round(NI.Leq.estreita.alto3.Z)),'dB'], ...
%     ['Condição 3 média espacial - LZeq = ', num2str(round(NI.Leq.estreita.alto_media_esp.Z)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Sem ponderação'],'Avaliação em banda estreita','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_est_C3Z','pdf');
% 
% % Residual terco
% 
% figure();
% semilogx(NI.res1.frequencias.terco(1,3:end), NI.res1.niveis_sonoros.terco.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.res1.frequencias.terco(1,3:end), NI.res2.niveis_sonoros.terco.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.res1.frequencias.terco(1,3:end), NI.res3.niveis_sonoros.terco.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.res1.frequencias.terco(1,3:end), NI.res3.Z.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p1 - LZeq = ', num2str(round(NI.Leq.terco.res1.Z)),'dB'],['Condição 1 p2 - LZeq=', num2str(round(NI.Leq.terco.res2.Z)), 'dB'], ...
%     ['Condição 1 p3 - LZeq = ', num2str(round(NI.Leq.terco.res3.Z)),'dB'], ...
%     ['Condição 1 média espacial - LZeq = ', num2str(round(NI.Leq.terco.res_media_esp.Z)),'dB'],'location','northeast','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Sem ponderação'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_terco_C1Z','pdf');
% 
% % Médio terco
% 
% figure();
% semilogx(NI.medio1.frequencias.terco(1,3:end), NI.medio1.niveis_sonoros.terco.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.medio1.frequencias.terco(1,3:end), NI.medio2.niveis_sonoros.terco.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.medio1.frequencias.terco(1,3:end), NI.medio3.niveis_sonoros.terco.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.medio1.frequencias.terco(1,3:end), NI.medio3.Z.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p1 - LZeq = ', num2str(round(NI.Leq.terco.medio1.Z)),'dB'],['Condição 2 p2 - LZeq=', num2str(round(NI.Leq.terco.medio2.Z)), 'dB'], ...
%     ['Condição 2 p3 - LZeq = ', num2str(round(NI.Leq.terco.medio3.Z)),'dB'], ...
%     ['Condição 2 média espacial - LZeq = ', num2str(round(NI.Leq.terco.medio_media_esp.Z)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Sem ponderação'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_terco_C2Z','pdf');
% 
% % Alto terco
% 
% figure();
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto1.niveis_sonoros.terco.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto2.niveis_sonoros.terco.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto3.niveis_sonoros.terco.Z,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto3.Z.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p1 - LZeq = ', num2str(round(NI.Leq.terco.alto1.Z)),'dB'],['Condição 3 p2 - LZeq=', num2str(round(NI.Leq.terco.alto2.Z)), 'dB'], ...
%     ['Condição 3 p3 - LZeq = ', num2str(round(NI.Leq.terco.alto3.Z)),'dB'], ...
%     ['Condição 3 média espacial - LZeq = ', num2str(round(NI.Leq.terco.alto_media_esp.Z)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Sem ponderação'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_terco_C3Z','pdf');
% 
% %% Plots NI A
% 
% % Residual
% 
% % Residual
% 
% figure();
% semilogx(NI.res1.frequencias.estreita(:,1:6401), NI.res1.niveis_sonoros.estreita.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.res1.frequencias.estreita(:,1:6401), NI.res2.niveis_sonoros.estreita.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.res1.frequencias.estreita(:,1:6401), NI.res3.niveis_sonoros.estreita.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.res1.frequencias.estreita(:,1:6401), NI.res3.A.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p1 - LAeq = ', num2str(round(NI.Leq.estreita.res1.A)),'dB'],['Condição 1 p2 - LAeq=', num2str(round(NI.Leq.estreita.res2.A)), 'dB'], ...
%     ['Condição 1 p3 - LAeq = ', num2str(round(NI.Leq.estreita.res3.A)),'dB'], ...
%     ['Condição 1 média espacial - LAeq = ', num2str(round(NI.Leq.estreita.res_media_esp.A)),'dB'],'location','northeast','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Com ponderação A'],'Avaliação em banda estreita','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_est_C1A','pdf');
% 
% % Médio
% 
% figure();
% semilogx(NI.medio1.frequencias.estreita(:,1:6401), NI.medio1.niveis_sonoros.estreita.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.medio1.frequencias.estreita(:,1:6401), NI.medio2.niveis_sonoros.estreita.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.medio1.frequencias.estreita(:,1:6401), NI.medio3.niveis_sonoros.estreita.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.medio1.frequencias.estreita(:,1:6401), NI.medio3.A.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p1 - LAeq = ', num2str(round(NI.Leq.estreita.medio1.A)),'dB'],['Condição 2 p2 - LAeq=', num2str(round(NI.Leq.estreita.medio2.A)), 'dB'], ...
%     ['Condição 2 p3 - LAeq = ', num2str(round(NI.Leq.estreita.medio3.A)),'dB'], ...
%     ['Condição 2 média espacial - LAeq = ', num2str(round(NI.Leq.estreita.medio_media_esp.A)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Com ponderação A'],'Avaliação em banda estreita','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_est_C2A','pdf');
% 
% % Alto
% 
% figure();
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto1.niveis_sonoros.estreita.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto2.niveis_sonoros.estreita.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto3.niveis_sonoros.estreita.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto3.A.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p1 - LAeq = ', num2str(round(NI.Leq.estreita.alto1.A)),'dB'],['Condição 3 p2 - LAeq=', num2str(round(NI.Leq.estreita.alto2.A)), 'dB'], ...
%     ['Condição 3 p3 - LAeq = ', num2str(round(NI.Leq.estreita.alto3.A)),'dB'], ...
%     ['Condição 3 média espacial - LAeq = ', num2str(round(NI.Leq.estreita.alto_media_esp.A)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Com ponderação A'],'Avaliação em banda estreita','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_est_C3A','pdf');
% 
% % Residual terco
% 
% figure();
% semilogx(NI.res1.frequencias.terco(1,3:end), NI.res1.niveis_sonoros.terco.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.res1.frequencias.terco(1,3:end), NI.res2.niveis_sonoros.terco.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.res1.frequencias.terco(1,3:end), NI.res3.niveis_sonoros.terco.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.res1.frequencias.terco(1,3:end), NI.res3.A.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 1 p1 - LAeq = ', num2str(round(NI.Leq.terco.res1.A)),'dB'],['Condição 1 p2 - LAeq=', num2str(round(NI.Leq.terco.res2.A)), 'dB'], ...
%     ['Condição 1 p3 - LAeq = ', num2str(round(NI.Leq.terco.res3.A)),'dB'], ...
%     ['Condição 1 média espacial - LAeq = ', num2str(round(NI.Leq.terco.res_media_esp.A)),'dB'],'location','northeast','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Com ponderação A'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_terco_C1A','pdf');
% 
% % Médio terco
% 
% figure();
% semilogx(NI.medio1.frequencias.terco(1,3:end), NI.medio1.niveis_sonoros.terco.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.medio1.frequencias.terco(1,3:end), NI.medio2.niveis_sonoros.terco.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.medio1.frequencias.terco(1,3:end), NI.medio3.niveis_sonoros.terco.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.medio1.frequencias.terco(1,3:end), NI.medio3.A.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 2 p1 - LAeq = ', num2str(round(NI.Leq.terco.medio1.A)),'dB'],['Condição 2 p2 - LAeq=', num2str(round(NI.Leq.terco.medio2.A)), 'dB'], ...
%     ['Condição 2 p3 - LAeq = ', num2str(round(NI.Leq.terco.medio3.A)),'dB'], ...
%     ['Condição 2 média espacial - LAeq = ', num2str(round(NI.Leq.terco.medio_media_esp.A)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Com ponderação A'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_terco_C2A','pdf');
% 
% % Alto terco
% 
% figure();
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto1.niveis_sonoros.terco.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.8500, 0.3250, 0.0980, 0.6]); hold on
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto2.niveis_sonoros.terco.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.9290, 0.6940, 0.1250, 0.6]);
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto3.niveis_sonoros.terco.A,'LineStyle','--','Linewidth',1.5, 'Color', [0.4940, 0.1840, 0.5560, 0.6]); 
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto3.A.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Condição 3 p1 - LAeq = ', num2str(round(NI.Leq.terco.alto1.A)),'dB'],['Condição 3 p2 - LAeq=', num2str(round(NI.Leq.terco.alto2.A)), 'dB'], ...
%     ['Condição 3 p3 - LAeq = ', num2str(round(NI.Leq.terco.alto3.A)),'dB'], ...
%     ['Condição 3 média espacial - LAeq = ', num2str(round(NI.Leq.terco.alto_media_esp.A)),'dB'],'location','southwest','Fontsize',22);
% title(['Cadeia de medição 3 ' char(8212) ' Com ponderação A'],'Avaliação em terço de oitava','FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NI_terco_C3A','pdf');

%% Expanda e descomente para os plots de comparação (A e Z -> estreita e terço)

% %% Plots comparação terço Z
% 
% % residual comparação
% figure()
% semilogx(NI.alto1.frequencias.terco(1,3:end), sonometro.res_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.terco(1,3:end), pulse.res_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.res3.Z.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Sonômetro — L_{Zeq} = ', num2str(round(sonometro.Leq.res_media)),'dB'],['B&K LanXI — L_{Zeq} =', num2str(round(pulse.Leq.terco.res_media)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.terco.res_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação ' char(8212) ' Condição 1'],['Avaliação em terço de oitava ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_C1Z','pdf');
% 
% % médio comparação
% figure()
% semilogx(NI.alto1.frequencias.terco(1,3:end), sonometro.medio_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.terco(1,3:end), pulse.medio_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.medio3.Z.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Sonômetro — L_{Zeq} = ', num2str(round(sonometro.Leq.medio_media)),'dB'],['B&K LanXI — L_{Zeq} = ', num2str(round(pulse.Leq.terco.medio_media)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.terco.medio_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação ' char(8212) ' Condição 2'],['Avaliação em terço de oitava ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_C2Z','pdf');
% 
% % alto comparação
% figure()
% semilogx(NI.alto1.frequencias.terco(1,3:end), sonometro.alto_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.terco(1,3:end), pulse.alto_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto3.Z.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Sonômetro — L_{Zeq} = ', num2str(round(sonometro.Leq.alto_media)),'dB'],['B&K LanXI — L_{Zeq} = ', num2str(round(pulse.Leq.terco.alto_media)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.terco.alto_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação' char(8212) ' Condição 3'],['Avaliação em terço de oitava ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_C3Z','pdf');
% 
% %% Comparação estreita Z
% 
% % residual comparação
% figure()
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), pulse.res_media_esp,'LineStyle','-','Linewidth',1.5); hold on
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.res3.Z.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['B&K LanXI — L_{Zeq} =', num2str(round(pulse.Leq.res_media)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.estreita.res_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação ' char(8212) ' Condição 1'],['Avaliação em banda estreita ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_estr_C1Z','pdf');
% 
% % médio comparação
% figure()
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), pulse.medio_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.medio3.Z.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['B&K LanXI — L_{Zeq} = ', num2str(round(pulse.Leq.medio_media)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.estreita.medio_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação ' char(8212) ' Condição 2'],['Avaliação em banda estreita ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_estr_C2Z','pdf');
% 
% % alto comparação
% figure()
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), pulse.alto_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto3.Z.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Sonômetro — L_{Zeq} = ', num2str(round(sonometro.Leq.alto_media)),'dB'],['B&K LanXI — L_{Zeq} = ', num2str(round(pulse.Leq.terco.alto_media)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.estreita.alto_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação' char(8212) ' Condição 3'],['Avaliação em banda estreita ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_estr_C3Z','pdf');
% 

% %% Plots comparação terço A
% 
% % residual comparação
% figure()
% semilogx(NI.alto1.frequencias.terco(1,3:end), sonometro.pondA.res_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.terco(1,3:end), pulse.pondA.res_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.res3.A.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Sonômetro — L_{Aeq} = ', num2str(round(sonometro.LAeq.res_media)),'dB'],['B&K LanXI — L_{Aeq} =', num2str(round(pulse.LAeq.terco.res_media)), 'dB'], ...
%     ['NI — L_{Aeq} = ', num2str(round(NI.Leq.terco.res_media_esp.A)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Com ponderação A' char(8212) ' Condição 1'],['Avaliação em terço de oitava ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_C1A','pdf');
% 
% % médio comparação
% figure()
% semilogx(NI.alto1.frequencias.terco(1,3:end), sonometro.pondA.medio_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.terco(1,3:end), pulse.pondA.medio_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.medio3.A.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Sonômetro — L_{Aeq} = ', num2str(round(sonometro.LAeq.medio_media)),'dB'],['B&K LanXI — L_{Aeq} = ', num2str(round(pulse.LAeq.terco.medio_media)), 'dB'], ...
%     ['NI — L_{Aeq} = ', num2str(round(NI.Leq.terco.medio_media_esp.A)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Com ponderação A' char(8212) ' Condição 2'],['Avaliação em terço de oitava ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_C2A','pdf');
% 
% % alto comparação
% figure()
% semilogx(NI.alto1.frequencias.terco(1,3:end), sonometro.pondA.alto_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.terco(1,3:end), pulse.pondA.alto_terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% semilogx(NI.alto1.frequencias.terco(1,3:end), NI.alto3.A.terco_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['Sonômetro — L_{Aeq} = ', num2str(round(sonometro.LAeq.alto_media)),'dB'],['B&K LanXI — L_{Aeq} = ', num2str(round(pulse.LAeq.terco.alto_media)), 'dB'], ...
%     ['NI — L_{Aeq} = ', num2str(round(NI.Leq.terco.alto_media_esp.A)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Com ponderação A' char(8212) ' Condição 3'],['Avaliação em terço de oitava ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_C3A','pdf');

% %% Comparação estreita Z
% 
% % residual comparação
% figure()
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), pulse.res_media_esp,'LineStyle','-','Linewidth',1.5); hold on
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.res3.Z.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['B&K LanXI — L_{Zeq} =', num2str(round(pulse.Leq.res_media)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.estreita.res_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação ' char(8212) ' Condição 1'],['Avaliação em banda estreita ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_estr_C1Z','pdf');
% 
% % médio comparação
% figure()
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), pulse.medio_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.medio3.Z.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['B&K LanXI — L_{Zeq} = ', num2str(round(pulse.Leq.medio_media)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.estreita.medio_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação ' char(8212) ' Condição 2'],['Avaliação em banda estreita ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_estr_C2Z','pdf');
% 
% % alto comparação
% figure()
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), pulse.alto_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto3.Z.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['B&K LanXI — L_{Zeq} = ', num2str(round(pulse.Leq.terco.alto_media)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.estreita.alto_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação' char(8212) ' Condição 3'],['Avaliação em banda estreita ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_estr_C3Z','pdf');
% 

% %% Comparação estreita A
% 
% % residual comparação
% figure()
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), pulse.pondA.res_media_esp,'LineStyle','-','Linewidth',1.5); hold on
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.res3.A.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['B&K LanXI — L_{Aeq} =', num2str(round(pulse.LAeq.res_media)), 'dB'], ...
%     ['NI — L_{Aeq} = ', num2str(round(NI.Leq.estreita.res_media_esp.A)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Com ponderação A ' char(8212) ' Condição 1'],['Avaliação em banda estreita ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_estr_C1A','pdf');
% 
% % médio comparação
% figure()
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), pulse.pondA.medio_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.medio3.A.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['B&K LanXI — L_{Aeq} = ', num2str(round(pulse.LAeq.medio_media)), 'dB'], ...
%     ['NI — L_{Aeq} = ', num2str(round(NI.Leq.estreita.medio_media_esp.A)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Com ponderação A ' char(8212) ' Condição 2'],['Avaliação em banda estreita ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_estr_C2A','pdf');
% 
% % alto comparação
% figure()
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), pulse.pondA.alto_media_esp,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(NI.alto1.frequencias.estreita(:,1:6401), NI.alto3.A.estreita_media_esp,'LineStyle','-','Linewidth',1.5); 
% legend(['B&K LanXI — L_{Zeq} = ', num2str(round(pulse.Leq.terco.alto_media)), 'dB'], ...
%     ['NI — L_{Aeq} = ', num2str(round(NI.Leq.estreita.alto_media_esp.A)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Com ponderação A' char(8212) ' Condição 3'],['Avaliação em banda estreita ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([20 20000]);
% % ylim([0 55])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'Comparacao_estr_C3A','pdf');
% 
% 
% 

%% Oitavas e Cuvas NC

% Sonômetro em oitava
sonometro.freq_oitava= create_freq('oitava');

string={'res' 'medio' 'alto'};
for j= 1:length(string)
        for i= 1:numPontos
                var= [char(string(j)),num2str(i)];
                sonometro.oitava.(var)= third2octave(sonometro.(var));
        end
end

sonometro.oitava.res_media= third2octave(sonometro.res_media_esp);
sonometro.oitava.medio_media= third2octave(sonometro.medio_media_esp);
sonometro.oitava.alto_media= third2octave(sonometro.alto_media_esp);


sonometro.Leq.oitava.res_media_esp.Z= 10*log10(sum(10.^((sonometro.oitava.res_media)./10)));
sonometro.Leq.oitava.medio_media_esp.Z= 10*log10(sum(10.^((sonometro.oitava.medio_media)./10)));
sonometro.Leq.oitava.alto_media_esp.Z= 10*log10(sum(10.^((sonometro.oitava.alto_media)./10)));

sonometro.Leq.oitava.res_media_esp.Z= 10*log10(sum(10.^((sonometro.Leq.oitava.res_media_esp.Z)./10)));
sonometro.Leq.oitava.medio_media_esp.Z= 10*log10(sum(10.^((sonometro.Leq.oitava.medio_media_esp.Z)./10)));
sonometro.Leq.oitava.alto_media_esp.Z= 10*log10(sum(10.^((sonometro.Leq.oitava.alto_media_esp.Z)./10)));


% Pulse em oitava

pulse.freq_oitava= create_freq('oitava');

string={'NPS_res' 'NPS_medio' 'NPS_alto'};
for j= 1:length(string)
        for i= 1:numPontos
                var= [char(string(j)),'_terco',num2str(i)];
                pulse.oitava.(var)= third2octave(pulse.(var));
        end
end

pulse.oitava.res_media= third2octave(pulse.res_terco_media_esp);
pulse.oitava.medio_media= third2octave(pulse.medio_terco_media_esp);
pulse.oitava.alto_media= third2octave(pulse.alto_terco_media_esp);

pulse.Leq.oitava.res_media_esp.Z= 10*log10(sum(10.^((pulse.oitava.res_media)./10)));
pulse.Leq.oitava.medio_media_esp.Z= 10*log10(sum(10.^((pulse.oitava.medio_media)./10)));
pulse.Leq.oitava.alto_media_esp.Z= 10*log10(sum(10.^((pulse.oitava.alto_media)./10)));

pulse.Leq.oitava.res_media_esp.Z= 10*log10(sum(10.^((pulse.Leq.oitava.res_media_esp.Z)./10)));
pulse.Leq.oitava.medio_media_esp.Z= 10*log10(sum(10.^((pulse.Leq.oitava.medio_media_esp.Z)./10)));
pulse.Leq.oitava.alto_media_esp.Z= 10*log10(sum(10.^((pulse.Leq.oitava.alto_media_esp.Z)./10)));


% NI em oitava

NI.freq_oitava= create_freq('oitava');

string={'res' 'medio' 'alto'};
for j= 1:length(string)
        for i= 1:numPontos
                var= [char(string(j)),num2str(i)];
                NI.(var).autoespectros.oitava.poderacao_Z= third2octave(NI.(var).autoespectros.terco.ponderacao_Z);
        end
end

NI.oitava.res_media= third2octave(NI.res3.Z.terco_media_esp);
NI.oitava.medio_media= third2octave(NI.medio3.Z.terco_media_esp);
NI.oitava.alto_media= third2octave(NI.alto3.Z.terco_media_esp);

NI.Leq.oitava.res_media_esp.Z= 10*log10(sum(10.^((NI.oitava.res_media)./10)));
NI.Leq.oitava.medio_media_esp.Z= 10*log10(sum(10.^((NI.oitava.medio_media)./10)));
NI.Leq.oitava.alto_media_esp.Z= 10*log10(sum(10.^((NI.oitava.alto_media)./10)));

NI.Leq.oitava.res_media_esp.Z= 10*log10(sum(10.^((NI.Leq.oitava.res_media_esp.Z)./10)));
NI.Leq.oitava.medio_media_esp.Z= 10*log10(sum(10.^((NI.Leq.oitava.medio_media_esp.Z)./10)));
NI.Leq.oitava.alto_media_esp.Z= 10*log10(sum(10.^((NI.Leq.oitava.alto_media_esp.Z)./10)));



%% Limpeza

clear i j string var

%% Curvas NC

NC_oitava=[70 90 90 84 79 75 72 71 70 68 68;
           65 90 88 80 75 71 68 65 64 63 62;
           60 90 85 77 71 66 63 60 59 58 57;
           55 89 82 74 67 62 58 56 54 53 52;
           50 87 79 71 64 58 54 51 49 48 47;
           45 85 76 67 60 54 49 46 44 43 42;
           40 84 74 64 56 50 44 41 39 38 37;
           35 82 71 60 52 45 40 36 34 33 32;
           30 81 68 57 48 41 35 32 29 28 27;
           25 80 65 54 44 37 31 27 24 22 22;
           20 79 63 50 40 33 26 22 20 17 16;
           15 78 61 47 36 28 22 18 14 12 11];

%% Expanda e descomente para plots das curvas NC e ruídos da sala
% %% Curvas NC e residual
% 
% figure() 
% semilogx(sonometro.freq_oitava, sonometro.oitava.res_media,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(pulse.freq_oitava, pulse.oitava.res_media,'LineStyle','-','Linewidth',1.5); 
% semilogx(NI.freq_oitava, NI.oitava.res_media,'LineStyle','-','Linewidth',1.5); 
% semilogx(sonometro.freq_oitava, NC_oitava(7:end,2:end),'LineStyle','--','Linewidth',0.8, 'Color', [0, 0, 0, 0.6]); hold on;
% 
% for i = 7:size(NC_oitava, 1) 
%     texto = ['NC' num2str(NC_oitava(i,1))];
%     posicao_x = 15000; % Posição x do texto
%     posicao_y = NC_oitava(i,end)+2; % Posição y do texto, assume-se que a primeira coluna contém os valores y
%     text(posicao_x, posicao_y, texto);
% end
% 
% legend(['Sonômetro — L_{Zeq} = ', num2str(round(sonometro.Leq.oitava.res_media_esp.Z)),'dB'],['B&K LanXI — L_{Zeq} = ', num2str(round(pulse.Leq.oitava.res_media_esp.Z)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.oitava.res_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação' char(8212) ' Condição 1'],['Avaliação em oitava ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([30 22000]);
% ylim([0 70])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NC_oitava','pdf');
% 
% % NC condição 2
% 
% figure() 
% semilogx(sonometro.freq_oitava, sonometro.oitava.medio_media,'LineStyle','-','Linewidth',1.5); hold on;
% semilogx(pulse.freq_oitava, pulse.oitava.medio_media,'LineStyle','-','Linewidth',1.5); 
% semilogx(NI.freq_oitava, NI.oitava.medio_media,'LineStyle','-','Linewidth',1.5); 
% semilogx(sonometro.freq_oitava, NC_oitava(6:end,2:end),'LineStyle','--','Linewidth',0.8, 'Color', [0, 0, 0, 0.6]); hold on;
% 
% for i = 6:size(NC_oitava, 1) 
%     texto = ['NC' num2str(NC_oitava(i,1))];
%     posicao_x = 15000; % Posição x do texto
%     posicao_y = NC_oitava(i,end)+2; % Posição y do texto, assume-se que a primeira coluna contém os valores y
%     text(posicao_x, posicao_y, texto);
% end
% 
% legend(['Sonômetro — L_{Zeq} = ', num2str(round(sonometro.Leq.oitava.medio_media_esp.Z)),'dB'],['B&K LanXI — L_{Zeq} = ', num2str(round(pulse.Leq.oitava.medio_media_esp.Z)), 'dB'], ...
%     ['NI — L_{Zeq} = ', num2str(round(NI.Leq.oitava.medio_media_esp.Z)),'dB'] ...
%     ,'location','southwest','Fontsize',22);
% title(['Comparação das cadeias de medição ' char(8212) ' Sem ponderação' char(8212) ' Condição 2'],['Avaliação em oitava ' char(8212) ' médias espaciais'],'FontSize',28);
% ylabel(['NPS [dB, ref 20 ' char(181) 'Pa]'], 'FontSize',28);
% xlabel('Frequência [Hz]', 'FontSize',28); 
% set(gca, 'FontSize', 15);
% grid on;
% xlim([30 22000]);
% ylim([0 70])
% % arruma_fig('spec2','no','virgula');
% set(gcf, 'PaperPosition', [0 0 14 9]); %position plot at left hand corner with width 12 and
% set(gcf, 'PaperSize', [14 9]); %Set the paper to have with 12 and height 9)
% saveas(gcf,'NC_oitava_C2','pdf');
