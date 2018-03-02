%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 2018/29/02           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

function [h,m] = interpolate1(x,n,L)
% Downsamples the given input function
% [h,n] = decimate(x,lo,hi,M)
%
% h = the downsampled sequence output
% m = the index variable over which h is based, integers
% x = finite-duration sequence
% n = the index variable over which x is based, integers
% L = the interpolation factor

if max(size(x) ~= size(n)) > 0
    error('vectors x and n must have the same size')
end

if ~isrow(x) || ~isrow(n)
    error('vectors x, n, and w must be rows (1 row)')
end

lo = n(1);   % index start
hi = n(end); % index end

m = (lo*L):1:(hi*L)+(L-1);
% x with L-1 zeroes between samples
h = (1/(2*pi)) * kron(x, [1 zeros(1,L-1)]);

if max(size(h) ~= size(m)) > 0
    error('internel error: outputs are not same size')
end
end
