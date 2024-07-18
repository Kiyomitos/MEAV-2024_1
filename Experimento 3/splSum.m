function levelSum = splSum(data)
% Simple function to calc. the log sum of SPL values
% Input: data (double 1xn)
%
% Author: Victor Kiyomi (EAC)
%
% Example: 
% data = [35 38 48 27 50 49 77 20]
% sum = splSum(data) -> result: 77 dB

% Check if data is a vector
if ~isnumeric(data)
    error('Data must be a double 1 x n.');
end

levelsum = 0;

for n=1:length(data)
    levelsum = levelsum+10^(data(n)/10);
end

levelSum = 10*log10(levelsum);

end