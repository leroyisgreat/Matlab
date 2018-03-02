%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
% LeRoy Gary           %
% lgary@andrew.cmu.edu %
%                      %
% 2018/28/02           %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%

% Note: ztrans doesn't work with the heaviside() function, because
% heaviside(0) = 0.5, and that fundamentally ruins the z transform.
kronDel = @(j, k) j==k ;
u = @(x) (heaviside(x)+0.5*kronDel(x,0));

wlo = -pi;  % frequency start
whi = pi;   % frequency end
lo = -10;   % index start
hi = 10;    % index end
M = 2;      % downsample amount
L = 2;      % upsample amount

n = lo:1:hi;
x = cos(pi/2 *n);
w = linspace(wlo,whi,length(n));
X = dtft(x',n',w');

% upsampling
[xu, ni] = interpolate1(x,n,L);
wi = linspace(wlo,whi,length(ni));
% interpolation
xi = conv(xu,L*sinc(ni/L));
xi = xi((length(xu)/2):(end-length(xu)/2));
XI = dtft(xi',ni',wi');

% downsampling
% antialiasing
xd = conv(xi,M*sinc(ni/M));
xd = xd((length(xu)/2):(end-length(xu)/2));
%...
[xd, nd] = decimate1(xi,ni,M,'nospace');
wd = linspace(wlo,whi,length(nd));
XD = dtft(xd',nd',wd');


figure;
subplot(6,1,1); stem(n, x);
subplot(6,1,2); plot(w/pi, X);
xlabel('original function x[n]');
subplot(6,1,3); stem(ni, xi);
subplot(6,1,4); plot(wi/pi, XI);
xlabel(strcat('upsampled function x_i[n] with L = ', int2str(L)));
subplot(6,1,5); stem(nd, xd);
subplot(6,1,6); plot(wd/pi, XD);
xlabel(strcat('downsampled function x_d[n] with M = ', int2str(M)));
