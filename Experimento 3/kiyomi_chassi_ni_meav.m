%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Código para medição de resposta impulsiva com chassi NI                 %
%   Autor: Victor Kiyomi                                                    %
%   Agradecimentos especiais: Felipe Mello (código o qual foi adaptado),    %
%   Bianca Kemerich e Yan Caproni.                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cleaning Service
clear all; clc; close all; clear memory;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configurações do DAQ e da medição

numOfMeans = 1; % Número de medições

canais = 2; % Número de canais de mic + o sinal de excitação
numofMics = 1; % Número de microfones
msNI = cell(numOfMeans, canais);

% Lista os dispositivos NI conectados
config.d = daqlist("ni");

% Inicia a conexão com o dispositivo
msDevices.daqObj = daq("ni");

% Configura as propriedades do DAQ
msDevices.daqObj.Rate = 51200; % Taxa de amostragem da NI
msConfig.daqRate = 51200;

%% Configuração dos canais da NI (CONFIRA NO DRIVER DA NI)

% Canais do primeiro módulo
msDevices.inChannel0 = addinput(msDevices.daqObj, 'cDAQ3Mod2', 'ai0' , 'Voltage');      % Este canal é destinado à loopback
msDevices.inChannel1 = addinput(msDevices.daqObj, 'cDAQ3Mod2', 'ai1' , 'Microphone');   % Microfone 1
%% Sensibilidade dos mics (ver encarte de cada mic)
% Módulo 1
msDevices.inChannel0.Coupling = 'AC'; % Loopback
msDevices.inChannel1.Sensitivity = 49.4*1E-3; % Mic 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ajuste de sensibilidade dos microfones à 1 kHz

clc;
tcalib = 10; % Tempo de ajuste

prompt = 'Você deseja realizar o ajuste de microfones? [y/n]\n';
validate = input(prompt, 's');

if validate == 'n'
    for canal = 1:numofMics
        msNI{numOfMeans, canal}.REF_FC =  1;
    end
else
    prompt = 'Insira o mic BK no calibrador sonoro e aperte enter para começar\n';
    input(prompt);
    
    validate = 'n';
    for canal=1:1:numofMics
       if canal > 1
        input('Posicione o calibrador no próximo microfone.');
       end
        fprintf('Ajuste do  microfone %d (canal %d)\n', canal, canal);
        numOfMeasurement = 1;
      while numOfMeasurement <= numOfMeans
        fprintf('Medição número %d\n', numOfMeasurement);    
        
        while strcmp(validate, 'n')
            daqData = read(msDevices.daqObj, seconds(tcalib)); % Grava o sinal
            switch canal % Guarda os dados em tabelas "daqData.cDAQ3Modx_ain"
                case 1
                    data = daqData.cDAQ3Mod2_ai1;
            end
            msNI{numOfMeasurement, canal}.sensitivity = itaAudio(data, msConfig.daqRate, 'time');
            msNI{numOfMeasurement, canal}.sensitivity.plot_time;
            msNI{numOfMeasurement, canal}.sensitivity.plot_freq;
            
            prompt = 'Validar a medição? [y/n]\n';
                validate = input(prompt, 's');
        end
        
        clear daqData
    
        msNI{numOfMeasurement, canal}.REF_FC =  1/max(abs(msNI{numOfMeasurement, canal}.sensitivity.freqData));
        
        if numOfMeasurement < numOfMeans
            input('Reinsira o microfone no acoplador e aperte enter para começar:\n');
        end
        
        validate = 'n';
        numOfMeasurement = numOfMeasurement + 1;
        
      end
       canal = canal+1;
    end
end
%% Medição de som residual
clc;

prompt = 'Medição de som residual está iniciando... Aperte enter para começar\n';
input(prompt);

med_residual = 65;
numOfMeans = 1;
msNumber = 1;
validate = 'n';

while msNumber <= numOfMeans
    
    fprintf('Medição número %d\n', msNumber);
    
    while strcmp(validate, 'n')
        
        %%%%%%%%%% Gravação BK %%%%%%%%%%
        
        % Inicia a NI
        flush(msDevices.daqObj);
        start(msDevices.daqObj, "continuous");

        pause(med_residual);
        stop(msDevices.daqObj);
        daqData = read(msDevices.daqObj, "all");
        
        %%%%%%%%%% Ajuste dos dados NI %%%%%%%%%%
      
         for canal=1:1:numofMics
             switch canal
                 case 1
                    data = daqData.cDAQ3Mod2_ai1; % Microfone 1
             end

            msNI{msNumber, canal}.somResidual = itaAudio(data, msConfig.daqRate, 'time');
            msNI{msNumber, canal}.somResidualInPascal = (msNI{msNumber, canal}.somResidual)*(msNI{1, canal}.REF_FC);
                       
         end


        %%%%%%%%%% Plot, no tempo, para validação %%%%%%%%%%
        
        for canal=1:numofMics
            fig = figure();
            fredPlot(fig, 16);
            plot(msNI{msNumber, canal}.somResidual.timeVector, msNI{msNumber, canal}.somResidual.timeData);
            title(['Som residual no microfone ' num2str(canal)]);
            xlabel('Tempo [s]');
            ylabel('Amplitude [Pa]');
            grid on;
        end
        
        prompt = 'Validar a medição? [y/n]\n';
        validate = input(prompt, 's');
        
    end
    

    msNumber = msNumber + 1;    
    validate = 'n';
end

clc;
disp('Medições finalizadas!')
%% Configurações da NI para o sinal de entrada (sweep)

msDevices.outChannelao0 = addoutput(msDevices.daqObj, 'cDAQ3Mod4', 'ao0', 'Voltage');
msDevices.outChannelao1 = addoutput(msDevices.daqObj, 'cDAQ3Mod4', 'ao2', 'Voltage');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sinal de excitação

% Sweep exponencial
msExcitation.fftDeg = 19;
amplitude= 0.9; % CUIDADO! Avalie se há distorção do sinal de saída no dodecaedro. Cuidado ao ajustar o ganho no amplificador.

msExcitation.sweep = ita_generate_sweep('samplingRate', 51200, 'fftDegree', msExcitation.fftDeg,...
    'freqRange', [80 15000]);

outData = [msExcitation.sweep.timeData*amplitude, msExcitation.sweep.timeData*amplitude];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Gravação simultânea do sinal de excitação

clc;
time_save= 2;

prompt = 'Medição de resposta impulsiva... Aperte enter para começar\n';
input(prompt);

numOfMeans = 10;
msNumber = 1; 
H = cell(msNumber, numofMics);
validate = 'n';

while msNumber <= numOfMeans
    
    fprintf('Medição número %d\n', msNumber);
    
    while strcmp(validate, 'n')
        
        %%%%%%%%%% Gravação BK e NI %%%%%%%%%%
        
%         % Inicia a NI
        flush(msDevices.daqObj);
%         start(msDevices.daqObj, "continuous");
%         
        
        % Inicia gravação simultânea do sweep e dos microfones
        recordedAudio = readwrite(msDevices.daqObj, outData, "OutputFormat", "Matrix");

        % Salva os dados que estão no buffer da NI
        pause(time_save);
        stop(msDevices.daqObj);

%     
        %%%%%%%%%% Ajuste dos dados NI %%%%%%%%%%
      
         for canal=1:1:(canais)
             switch canal
                 case 1
                     data = recordedAudio(:, 2); % Microfone 1
                 case 2
                     data = recordedAudio(:, 1); % Canal de loopback
             end
            
           if data == recordedAudio(:, 1) % Caso seja o canal de loopback, não haverá correção de sensibilidade.

               msNI{msNumber, canal}.sweepRecord = itaAudio(data, msConfig.daqRate, 'time'); 
           else
               msNI{msNumber, canal}.sweepRecord = itaAudio(data, msConfig.daqRate, 'time');
               msNI{msNumber, canal}.sweepInPascal = msNI{msNumber, canal}.sweepRecord*(msNI{1, canal}.REF_FC);
            end
                       
         end
        
        for canal=1:1:numofMics % FRFs
            H{msNumber, canal} = ita_divide_spk(msNI{msNumber, canal}.sweepRecord, msNI{msNumber, 2}.sweepRecord,...
             'regularization',[80 15000], 'mode', 'linear'); 
        end
        
       
        %%%%%%%%%% Plot para validação tempo %%%%%%%%%%

        for canal = 1:canais
            fig = figure();
            fredPlot(fig, 16);
            plot(msNI{msNumber, canal}.sweepRecord.timeVector, msNI{msNumber, canal}.sweepRecord.timeData);
            
            if canal == canais
                title('Sweep gravado pela NI');
            else
                title(['Sweep gravado pelo microfone' num2str(canal)]);
            end
            
            xlabel('Tempo [s]');
            ylabel('Amplitude [Pa]');
            grid on;
        end

        for canal = 1:numofMics
            fig = figure();
            fredPlot(fig, 16);
            plot(H{msNumber, canal}.timeVector, H{msNumber, canal}.timeData);
            title(['Resposta ao impulso na posição do microfone' num2str(canal)]);
            xlabel('Tempo [s]');
            ylabel('Amplitude [Pa]');
            grid on;
        end

        prompt = 'Validar a medição? [y/n]\n';
        validate = input(prompt, 's');
        
    end
    

    msNumber = msNumber + 1;    
    validate = 'n';
end

clc;
disp('Medições finalizadas!')
%% Curvas de decaimento
H_cort= H{10,1}.timeData(1:(length(H{1,1}.timeData))/2);
y= itaAudio(H_cort,51200,'time');
TR_exp3 = ita_roomacoustics(y,'freqRange',[100 10000],'bandsPerOctave', 3, 'T20');
%% Salvando 

fileName = sprintf('pot_aspirador_pos1.mat'); % Nome do arquivo a ser salvo

save(fileName, 'msNI', 'H'); % Nome do arquivo a ser salvo e conteúdo

disp('Tudo salvo!')
%% Medição de nível de pressão sonora
clc;

prompt = 'Medição de nível de pressão sonora está iniciando... Aperte enter para começar\n';
input(prompt);

med_nps = 128;
numOfMeans = 6;
msNumber = 1; 
freqRange       = [20 20000];       % Range de frequências
bandsPerOctave  = 3;                % Bandas por oitava
validate = 'n';

while msNumber <= numOfMeans
    
    fprintf('Medição número %d\n', msNumber);
    
    while strcmp(validate, 'n')
        
        %%%%%%%%%% Gravação BK %%%%%%%%%%
        
        % Inicia a NI
        flush(msDevices.daqObj);
        start(msDevices.daqObj, "continuous");

        pause(med_nps);
        stop(msDevices.daqObj);
        daqData = read(msDevices.daqObj, "all");
        
        %%%%%%%%%% Ajuste dos dados NI %%%%%%%%%%
      
         for canal=1:1:numofMics
             switch canal
                 case 1
                    data = daqData.cDAQ3Mod2_ai1; % Microfone 1
             end

            msNI{msNumber, canal}.NPS = itaAudio(data, msConfig.daqRate, 'time');
            msNI{msNumber, canal}.NPSInPascal = (msNI{msNumber, canal}.NPS)*(msNI{1, canal}.REF_FC);
                       
         end


        %%%%%%%%%% Plot, no tempo, para validação %%%%%%%%%%
        
        for canal=1:numofMics
            fig = figure();
            fredPlot(fig, 16);
            plot(msNI{msNumber, canal}.NPS.timeVector, 20*log10(abs(msNI{msNumber, canal}.NPS.timeData)/20e-6));
            title(['Nível de pressão sonora no microfone' num2str(canal)]);
            xlabel('Tempo [s]');
            ylabel(['NPS [dB ref 20 ' char(181) ' Pa]']);
            grid on;
        end
        

        prompt = 'Validar a medição? [y/n]\n';
        validate = input(prompt, 's');
        
    end
    

    msNumber = msNumber + 1;    
    validate = 'n';
end

clc;
disp('Medições finalizadas!')
%% Salvando 

fileName = sprintf('pot_refSource_pos2.mat'); % Nome do arquivo a ser salvo

save(fileName, 'msNI'); % Nome do arquivo a ser salvo e conteúdo

disp('Tudo salvo!')