%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 2018/26/03           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

% Since I don't really know what happens when the inputs overlap, I thought
% to experiment and try it out. I expected that there would be different
% gains for different segments, unless the overlapp ratio was 1/2, 2/3,
% 3/4, etc. each having a constant gain of the denominator value.

function overlap_dft_demo(x,h,N,L)
% Simple demo function that takes in two time functions and an overlap
% amount and shows the result of using the Overlap-Add algorithm on those
% inputs.
% overlap_dft_demo(x,h,N,L)
%
% x: vector representing first function
% h: vector representing second function
% N: length of segments into which x will be broken
% L: number of samples for each segment of x to overlap

% Represents the offset of the start of each segment compared to the start 
% of the last segment. 
% For instance, if N = 32 and L = 8 (8 overlapping samples) then M is 24,
% where to start segment 2 if you want an overlap of 8.
M = N - L; 

%% Display the expected results

y_conv = conv(x,h);

figure;
subplot(3,1,1); stem(x);
xlabel('x[n]');
subplot(3,1,2); stem(h);
xlabel('h[n]');
subplot(3,1,3); stem(y_conv);
xlabel('x[n]*h[n]');
title('Press Spacebar to continue');

pause; close all;

%% Chop the input to length N segments with L-pt. overlap

% the number of segments
n = ceil(length(x)/M);
% matrix containing the segments themselves
xx = zeros(n,N);
for i = 0:1:n-1
    start_i = i*M +1; % +1 because of 1-indexing 
    end_i = min(start_i+N-1,length(x)); % total of at least N points
    xx(i+1,:) = padtrunc(x(start_i:end_i), N); 
end

figure;
for i = 1:1:min(8,n)
    subplot(4,2,i); stem(xx(i,:));
    xlabel(strcat('x', num2str(i), '[n]'));
end
title('Segments of input\nPress Spacebar to continue');

pause; close all;

%% Perform the convolution in Frequency Domain using DFTs

% the final length of convolving the segments of input x with h
conv_size = N + length(h) - 1;
% the next highest power of 2 to do the DFT
dft_size = 2^(ceil(log2(conv_size)));
% matrix containing the convolution of the segments of x
yy = zeros(n,conv_size);
for i = 0:1:n-1
    Xi = dft(xx(i+1,:), dft_size);
    H = dft(h,dft_size);
    yy(i+1,:) = padtrunc(idft(Xi.*H, dft_size), conv_size);
end

figure;
for i = 1:1:min(8,n)
    subplot(4,2,i); stem(yy(i,:));
    xlabel(strcat('y', num2str(i), '[n]'));
end
title('Convolution of xi[n] using DFTs\nPress Spacebar to continue');

pause; close all;

%% Combine convolved segments using the Overlap-Add algorithm

y_overlap_add = zeros(1,(n-1)*M + conv_size);
for i = 0:1:n-1
    start_i = M*i +1; % +1 because of 1-indexing in matlab
    end_i = start_i + conv_size - 1;
    y_overlap_add(start_i:end_i) = y_overlap_add(start_i:end_i) + yy(i+1,:);
end

figure;
subplot(2,1,1); stem(y_conv);
subplot(2,1,2); stem(y_overlap_add(1:length(y_conv)));
title('Regular convolution vs. Overlap-Add with overlapping segments (End)');

end
