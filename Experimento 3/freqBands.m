function [vec, freqtick] = freqBands(type, varargin)
% Retorna um vetor de 1 a n, igualmente espaçado, para os ticks do eixo x e
% um vetor com strings para as labels do eixo x.
% Essa função torna-se útil para plots em bandas de 1/1 oitava e/ou 1/3
% oitava.
%
% 1 para 1/1 oitava, 3 para 1/3 oitava. Os casos 1.5 e 3.5 são para
% retornar um vetor com números das freqs. centrais.
%
% Exemplo: 
% [vec, freqtick] = freqBands(1, 'range', [100 10000])
% [vec, freqvec] = freqBands(3.5, 'range', [100 10000])
%
% Autor: Victor Kiyomi (EAC)
%%
p = inputParser;
default_range = [20 20000];
addRequired(p, 'type');
addParameter(p, 'range', default_range);
n = 1; m = 0;

parse(p, type, varargin{:});
range = p.Results.range;
    if ~isvector(range)
        error('Coloque um vetor com a frequência inicial e final.');
    end
    switch type
        case 1
            freqtick = [31.5 63 125 250 500 1000 2000 4000 8000 16000];
            if range(1) > freqtick(1) && range(2) < freqtick(end)
                while range(1) > freqtick(n)
                    n = n+1;
                end
                while range(2) < freqtick(length(freqtick)-m)
                    m = m+1;
                end
                freqtick = {'31,5', '63', '125', '250', '500', '1 k', '2 k', '4 k', '8 k', '16 k'};
                freqtick = freqtick(n:length(freqtick)-m);
                vec = 1:length(freqtick);
            elseif range(1) >= freqtick(n)
                n = 1;
                while range(1) > freqtick(n)
                    n = n+1;
                end
                freqtick = {'31,5', '63', '125', '250', '500', '1 k', '2 k', '4 k', '8 k', '16 k'};
                freqtick = freqtick(n:end);
                vec = 1:length(freqtick);
            elseif range(2) < freqtick(length(freqtick)-m)
                while range(2) < freqtick(length(freqtick)-m)
                    m = m+1;
                end
                freqtick = {'31,5', '63', '125', '250', '500', '1 k', '2 k', '4 k', '8 k', '16 k'};
                freqtick = freqtick(1:length(freqtick)-m);
                vec = 1:length(freqtick);
            else
                freqtick = {'31,5', '63', '125', '250', '500', '1 k', '2 k', '4 k', '8 k', '16 k'};
                vec = 1:length(freqtick);
            end
            case 1.5
            freqtick = [31.5 63 125 250 500 1000 2000 4000 8000 16000];
            if range(1) > freqtick(1) && range(2) < freqtick(end)
                while range(1) > freqtick(n)
                    n = n+1;
                end
                while range(2) < freqtick(length(freqtick)-m)
                    m = m+1;
                end
                freqtick = freqtick(n:length(freqtick)-m);
                vec = 1:length(freqtick);
            elseif range(1) >= freqtick(n)
                n = 1;
                while range(1) > freqtick(n)
                    n = n+1;
                end
                freqtick = freqtick(n:end);
                vec = 1:length(freqtick);
            elseif range(2) < freqtick(length(freqtick)-m)
                while range(2) < freqtick(length(freqtick)-m)
                    m = m+1;
                end
                freqtick = freqtick(1:length(freqtick)-m);
                vec = 1:length(freqtick);
            else
                vec = 1:length(freqtick);
            end
        case 3
            freqtick = [20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250, 1600 ...
                2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
            if range(1) > freqtick(1) && range(2) < freqtick(end)
                while range(1) > freqtick(n)
                    n = n+1;
                end
                while range(2) < freqtick(length(freqtick)-m)
                    m = m+1;
                end
                freqtick = {'20', '25', '31,5', '40', '50', '63', '80', '100', '125', '160', '200', '250', '315', '400', '500', '630', '800', '1k', '1,25k',...
                    '1,6k', '2k', '2,5k', '3,15k', '4k', '5k', '6,3k', '8k', '10k', '12,5k', '16k', '20k'};
                freqtick = freqtick(n:length(freqtick)-m);
                vec = 1:length(freqtick);
            elseif range(1) > freqtick(n)
                n = 1;
                while range(1) > freqtick(n)
                    n = n+1;
                end
                freqtick = {'20', '25', '31,5', '40', '50', '63', '80', '100', '125', '160', '200', '250', '315', '400', '500', '630', '800', '1k', '1,25k',...
                    '1,6k', '2k', '2,5k', '3,15k', '4k', '5k', '6,3k', '8k', '10k', '12,5k', '16k', '20k'};
                freqtick = freqtick(n:end);
                vec = 1:length(freqtick);
            elseif range(2) < freqtick(length(freqtick)-m)
                while range(2) < freqtick(length(freqtick)-m)
                    m = m+1;
                end
                freqtick = {'20', '25', '31,5', '40', '50', '63', '80', '100', '125', '160', '200', '250', '315', '400', '500', '630', '800', '1k', '1,25k',...
                    '1,6k', '2k', '2,5k', '3,15k', '4k', '5k', '6,3k', '8k', '10k', '12,5k', '16k', '20k'};
                freqtick = freqtick(1:length(freqtick)-m);
                vec = 1:length(freqtick);
            else
                freqtick = {'20', '25', '31,5', '40', '50', '63', '80', '100', '125', '160', '200', '250', '315', '400', '500', '630', '800', '1k', '1,25k',...
                    '1,6k', '2k', '2,5k', '3,15k', '4k', '5k', '6,3k', '8k', '10k', '12,5k', '16k', '20k'};
                vec = 1:length(freqtick);
            end
            case 3.5
            freqtick = [20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250, 1600 ...
                2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
            if range(1) > freqtick(1) && range(2) < freqtick(end)
                while range(1) > freqtick(n)
                    n = n+1;
                end
                while range(2) < freqtick(length(freqtick)-m)
                    m = m+1;
                end
                freqtick = freqtick(n:length(freqtick)-m);
                vec = 1:length(freqtick);
            elseif range(1) > freqtick(n)
                n = 1;
                while range(1) > freqtick(n)
                    n = n+1;
                end
                freqtick = freqtick(n:end);
                vec = 1:length(freqtick);
            elseif range(2) < freqtick(length(freqtick)-m)
                while range(2) < freqtick(length(freqtick)-m)
                    m = m+1;
                end
                freqtick = freqtick(1:length(freqtick)-m);
                vec = 1:length(freqtick);
            else
                vec = 1:length(freqtick);
            end
    end
end