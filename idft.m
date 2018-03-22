%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 2018/21/03           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

function [x,n] = idft(X,N)
% Computes the N-sampled inverse Discrete Fourier Transform
% [x,n] = idft(X,N)
%
% n: convenience vector containing 0 .. N-1
% x: time function from the DFT X
% X: frequency function to be transformed
% N: number of samples at which to take the DFT

if ~isrow(X)
    error('X must be a row-vector')
end

if N < 1
    error('N must be positive, non-zero')
end

% a vector containing the 'time' samples
n = (0:1:N-1);

% truncate or pad X with the necessary number of zeros
XN = [X(1:min(N,length(X))) zeros(1,N-length(X))];

% a vector representing the frequencies at which to compute te DFT
w = 2*pi * n / N;

% A matrix containing the e^-jwn term for all w, n
WN = exp( -1i .* ((n') * w) );

if (size(WN,2) ~= length(w)) || (size(WN,1) ~= length(n))
    error('unknown internal error: |WN| != (|n|,|w|)')
end

x = (1/N) * XN * WN;

end
