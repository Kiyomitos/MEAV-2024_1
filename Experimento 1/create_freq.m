function [freq] = create_freq(banda) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Função simples para gerar um vetor de frequência
% Input em formato de string 'terco', 'estreita' ou 'oitava
% Por Yan Caproni Pereira
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 1== strcmp('estreita',banda)
        freq= 20:1:20000;
    elseif 1== strcmp('terco',banda)
        freq= [20 25 31.5 40 50 63	80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000  ...
        2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
    elseif 1== strcmp('oitava',banda)
        freq= [31.5 63 125 250 500 1000 2000 4000 8000 16000];
    end

end