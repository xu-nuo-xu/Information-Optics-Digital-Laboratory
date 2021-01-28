n = 0:39;
y = cos(2*pi*(2*n)/40);
stem(n,y);
%stem(n, abs(fft(fft(y))));
