%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 18-491 Homework 2    %
% 2018/28/02           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

function X = idtft(x,n,w)
% Computes Discrete-time Fourier Transform
% [x] = dtft(x,n,w)
%
% X = DTFT values computed at frequencies w
% x is a finite-duration sequence over n
% n is the vector of "time" values over which the computation is
% performed
% w is a vector of frequencies used in the output

if max(size(x) ~= size(n)) > 0
    error('vectors x and n must have the same size')
end

if ~iscolumn(x) || ~iscolumn(n) || ~iscolumn(w)
    error('vectors x, n, and w must be vectors (1 column)')
end

% A matrix containing the e^-jwn term for all w, n
E = exp( 1i .* (w * (n')) );

if (size(E,1) ~= size(w,1)) || (size(E,2) ~= size(n,1))
    error('unknown internal error: |E| != (|w|,|n|)')
end

X = (1/(2*pi)) * (E * x);

end
