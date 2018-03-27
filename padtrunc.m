%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 2018/26/03           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

function X = padtrunc(x,N)
% Pads or truncates x with the necessary number of zeros to make it n
% samples in length.
% X = padtrunc(x,n)
%
% X: padded or truncated version of x
% x: array to be padded or truncated
% N: length of the output

validateattributes(x,{'numeric'},{'row'});
validateattributes(N,{'numeric'},{'scalar'});

X = [x(1:min(N,length(x))) zeros(1,N-length(x))];

end
