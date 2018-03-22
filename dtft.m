%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 18-491 Homework 2    %
% 2018/29/01           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

function X = dtft(x,n,w)
% Computes Discrete-time Fourier Transform
% [x] = dtft(x,n,w)
%
% X: DTFT values computed at frequencies w
% x: a finite-duration sequence over n
% n: the "time" vector over which the computation is performed
% w: a vector of frequencies used in the output

if max(size(x) ~= size(n)) > 0
    error('vectors x and n must have the same size')
end

if ~isrow(x) || ~isrow(n) || ~isrow(w)
    error('vectors x, n, and w must be row-vectors')
end

% A matrix containing the e^-jwn term for all w, n
E = exp( -1i .* ((n') * w) );

if (size(E,2) ~= length(w)) || (size(E,1) ~= length(n))
    error('unknown internal error: |E| != (|n|,|w|)')
end

X = x * E;

end
