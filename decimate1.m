%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 2018/29/02           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

function [h,m] = decimate1(x,n,M,opt)
% Downsamples the given input function
% [h,n] = decimate(x,lo,hi,M)
%
% h = the downsampled sequence output
% m = the index variable over which h is based, integers
% x = finite-duration sequence
% n = the index variable over which x is based, integers
% M = the decimation factor
% opt = an option string:
%       if opt == 'space', then h will be the same length as x
%       if opt == 'nospace', then h will be the length of x / M

lo = n(1);   % index start
hi = n(end); % index end

if strcmp(opt, 'space')
    m = n;
    h = x .* (mod(n,M) == 0);
elseif strcmp(opt, 'nospace')
    m = (lo/M):1:(hi/M);
    h = x(1:M:end);
else
    error('opt value ' + opt + ' not known')
end

end

