function octaveData= third2octave(thirdData)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is a simple function created to do a simple task.
% The input must be a vector containing the frequency data (third-octave)
% in dB (with a non quadratical relation)
%
% Function created by Yan Caproni Pereira - UFSM EAC (BR)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1==isvector(thirdData)
    num_tercos = floor(length(thirdData) / 3);
    octaveData = zeros(1, num_tercos);
    
    % Getting the numbers to create an octave data
    pace = 3; % Pulando 2 casas entre os valores
    u=1;
    for i = 3:pace:length(thirdData)
        octaveData(1,u) = 10*log10(10^(thirdData(i)/10)+10^(thirdData(i-1)/10)...
            +10^(thirdData(i+1)/10));
        u=u+1;
    end

else
    fprintf('The input data is not a vector!!!\n');

end