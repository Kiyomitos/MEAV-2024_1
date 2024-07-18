function m = airAbs(f, T, RH, P)
% Função para calcular o coeficiente de absorção sonora do ar em 1/m de
% acordo com a ISO 9613-1.
% f  - frequência em Hz
% T  - temperatura em °C
% RH - umidade relativa em %
% P  - pressão atmosférica em Pa (Pascal)
%
% Autor: Victor Kiyomi (EAC)
%
% É possível conferir os valores com a calculadora do National Physical
% Laboratory (Reino Unido).
%
% PS: caso vá comparar com a tabela do Rossing (Handbook of Acoustics,
% Springer), os valores ficam distantes. Não sei por que.

    % Conversão da temperatura para Kelvin
    T_kelvin = T + 273.15;

    % Constantes
    P_ref = 101325;  % Pressão de referência em Pa
    T_ref = 293.15;  % Temperatura de referência em K (20°C)
    
    % Pressão de saturação do vapor de água (Tetens)
    Ps = 611.21 * exp((18.678 - T/234.5) * (T / (257.14 + T)));  % em Pa

    % Fração molar de vapor d'água
    H = RH * Ps / P;

    % Cálculo dos parâmetros de relaxação
    FrO = (P / P_ref) * (24 + 4.04e4 * H * (0.02 + H) / (0.391 + H));  % Frequência de relaxação do oxigênio
    FrN = (P / P_ref) * sqrt(T_kelvin / T_ref) * (9 + 280 * H * exp(-4.170 * (sqrt(T_kelvin / T_ref) - 1)));  % Frequência de relaxação do nitrogênio

    % Coeficiente de absorção sonora em 1/m
    alpha = (8.686 * f^2) * ((1.84e-11 * (P_ref / P) * sqrt(T_kelvin / T_ref)) + ...
        (T_kelvin / T_ref)^-2.5 * (0.01275 * exp(-2239.1 / T_kelvin) * (FrO + (f^2 / FrO))^-1 + ...
        0.1068 * exp(-3352 / T_kelvin) * (FrN + (f^2 / FrN))^-1));

    m = alpha/(10*log10(exp(1)));
end