%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 2018/26/03           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

% Since I don't really know what happens when the inputs overlap, I thought
% to experiment and try it out.
%
% When N < length(h)-1, there isn't enough discarded points to acount for
% aliasing, and we end up with a corrupted signal.

function overlap_save_demo(x,h,L,N)
% Simple demo function that takes in two time functions and an overlap
% amount and shows the result of using the Overlap-Add algorithm on those
% inputs.
% overlap_dft_demo(x,h,N,L)
%
% x: vector representing first function
% h: vector representing second function
% L: number of new samples to be used for each segment
% N: number of old samples to be used for each segment (overlap)
%    default overlap for overlap-save algorithm is N = length(h)-1

%% Display the expected results

y_conv = conv(x,h);

figure;
subplot(3,1,1); stem(x);
xlabel('x[n]');
subplot(3,1,2); stem(h);
xlabel('h[n]');
subplot(3,1,3); stem(y_conv);
xlabel('x[n]*h[n]');
suptitle('Press Spacebar to continue');
pause; close all;

%% Chop the input to length L+N segments with N overlap

% the number of segments
n = ceil(length(x)/L);
% matrix containing the segments themselves
xx = zeros(n,L+N);
for i = 0:1:n-1
    if (i > 0)
        % The first segment will have some leading zeros. The rest will
        % have a portion of overlap - the first M-1 points are equal to the
        % last M-1 points of the previous segment.
        xx(i+1,1:N) = xx(i,L+1:end);
    end
    xx(i+1,N+1:end) = padtrunc(x(L*i +1:end), L);
end

figure;
for i = 1:1:min(6,n)
    subplot(ceil(min(6,n)/2),2,i); stem(xx(i,:));
    xlabel(strcat('x_', num2str(i), '[n]'));
end
suptitle('Up to first 6 segments of input -- Spacebar to continue');
pause; close all;

%% Perform the convolution in Frequency Domain using DFTs

% matrix containing the convolution of the segments of x
yy = zeros(n,L+N);
H = dft(h,L+N);
for i = 0:1:n-1
    Xi = dft(xx(i+1,:), L+N);
    yy(i+1,:) = idft(Xi.*H, L+N);
end

figure;
for i = 1:1:min(6,n)
    subplot(ceil(min(6,n)/2),2,i); stem(yy(i,:));
    xlabel(strcat('y_', num2str(i), '[n]'));
end
suptitle('Up to first 6 y_i[n] using DFTs -- Spacebar to continue');
pause; close all;

%% Combine convolved segments using the Overlap-Save algorithm

yy_trim = yy(:,N+1:end);
% collect rows of matrix into a single row-vector
y_overlap_save = reshape(yy_trim.',[],1);

figure;
subplot(2,1,1); stem(y_conv);
subplot(2,1,2); stem(y_overlap_save);
suptitle('Convolution vs. Overlap-Save (End)');

end
