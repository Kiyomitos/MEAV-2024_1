function OK = is_figure(h)
% IS_FIGURE checks if h is a matlab figure
%
% Based on: https://www.mathworks.com/matlabcentral/answers/300880-what-is-best-practice-to-determine-if-input-is-a-figure-or-axes-handle

%% Function

if strcmp(get(h,'type'),'figure')
  OK = 1;
else
  OK = 0;
end

end