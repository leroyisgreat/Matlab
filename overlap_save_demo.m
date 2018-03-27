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

function overlap_save_demo(x,h,L)
% Simple demo function that takes in two time functions and an overlap
% amount and shows the result of using the Overlap-Add algorithm on those
% inputs.
% overlap_dft_demo(x,h,N,L)
%
% x: vector representing first function
% h: vector representing second function
% L: length of new samples to be used for each segment

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

%% Chop the input to length L+M-1 segments with M-1 overlap

M = length(h);

% the number of segments
n = ceil(length(x)/L);
% matrix containing the segments themselves
xx = zeros(n,L+M-1);
for i = 0:1:n-1
    if (i > 0)
        % The first segment will have some leading zeros. The rest will
        % have a portion of overlap - the first M-1 points are equal to the
        % last M-1 points of the previous segment.
        xx(i+1,1:M-1) = xx(i,L+1:end);
    end
    xx(i+1,M:end) = padtrunc(x(L*i +1:end), L);
end

figure;
for i = 1:1:min(6,n)
    subplot(3,2,i); stem(xx(i,:));
    xlabel(strcat('x_', num2str(i), '[n]'));
end
suptitle('First 6 segments of input -- Press Spacebar to continue');

pause; close all;

%% Perform the convolution in Frequency Domain using DFTs

% matrix containing the convolution of the segments of x
yy = zeros(n,L+M-1);
H = dft(h,L+M-1);
for i = 0:1:n-1
    Xi = dft(xx(i+1,:), L+M-1);
    yy(i+1,:) = idft(Xi.*H, L+M-1);
end

figure;
for i = 1:1:min(6,n)
    subplot(3,2,i); stem(yy(i,:));
    xlabel(strcat('y_', num2str(i), '[n]'));
end
suptitle('First 6 convolutions of x_i[n] using DFTs -- Press Spacebar to continue');

pause; close all;

%% Combine convolved segments using the Overlap-Save algorithm

y_overlap_save = zeros(1,n*L);
for i = 0:1:n-1
    y_overlap_save(L*i +1:L*i +L) = yy(i+1,M:end);
end

figure;
subplot(2,1,1); stem(y_conv);
subplot(2,1,2); stem(padtrunc(y_overlap_save,length(y_conv)));
suptitle('Regular convolution vs. Overlap-Add with overlapping segments (End)');

end
