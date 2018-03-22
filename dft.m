%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 2018/21/03           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

function [X,w] = dft(x,N)
% Computes the N-sampled Discrete Fourier Transform
% [X,w] = dft(x,N)
%
% w: convenience vector containing 2*pi*k/N for 0 <= k < N
% X: DTFT sampled at w
% x: time function to be transformed
% N: number of samples at which to take the DFT

if ~isrow(x)
    error('x must be a row-vector')
end

if N < 1
    error('N must be positive, non-zero')
end

% a vector containing the 'time' samples
n = (0:1:N-1);

% truncate or pad x with the necessary number of zeros
xn = [x(1:min(N,length(x))) zeros(1,N-length(x))];

% a vector representing the frequencies at which to compute te DFT
w = 2*pi * n / N;

% A matrix containing the e^-jwn term for all w, n
WN = exp( -1i .* ((n') * w) );

if (size(WN,2) ~= length(w)) || (size(WN,1) ~= length(n))
    error('unknown internal error: |WN| != (|n|,|w|)')
end

X = xn * WN;

end
