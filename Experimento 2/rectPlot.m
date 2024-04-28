function rectPlot(fig, varargin)
% Função para ajuste de plots no Matlab. Essa função deixa o plot
% retângular em proporção 16:9. Créditos à função my_plot de Felipe R.
% Mello.
% Autor: Victor Kiyomi, EAC UFSM
% Data: 12/04/2024
% Inputs: fig, font_size, ax_fontsize fig_size, xlabel_fontsize, ylabel_fontsize
p = inputParser;
validPosNum = @(x) isnumeric(x) && (x > 0);
default_font_size = 24;
default_fig_size = [800 600];
default_ax_size = 22;
default_xlabel_fontsize = 24;
addRequired(p, 'fig', @is_figure);
addParameter(p, 'font_size', default_font_size, validPosNum);
addParameter(p, 'fig_size', default_fig_size);
addParameter(p, 'ax_fontsize', default_ax_size);
addParameter(p, 'xlabel_fontsize', default_xlabel_fontsize);
addParameter(p, 'ylabel_fontsize', default_xlabel_fontsize);

parse(p, fig, varargin{:});
font_size = p.Results.font_size;
fig_size = p.Results.fig_size;
ax_fontsize = p.Results.ax_fontsize;


% Adjusting the figure
set(fig, 'outerposition', [100 100 fig_size]);
set(gca, 'FontSize', ax_fontsize);
set(gcf, 'PaperOrientation', 'landscape', 'PaperUnits', 'centimeters', 'PaperType','<custom>', 'PaperSize',[48 27], 'WindowState', 'normal', ...
    'PaperPosition', [0, 0, 1, 1]);
movegui(fig, 'center');
grid on;
end