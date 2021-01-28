r=512;c=r;
a=zeros(r,c);
a(r/2-r/4:r/2+r/4,c/2-c/4:c/2+c/4)=1;
lamda=6328e-10;
k=2*pi/lamda;
L0=5e-3;
d=0.1;
x0=linspace(-L0/2,L0/2,c);
y0=linspace(-L0/2,L0/2,r);
kethi=linspace(-1/2/L0,1/2/L0,c)*c; %u_max
nenta=linspace(-1/2/L0,1/2/L0,r)*r; %v_max
[kethi,nenta]=meshgrid(kethi,nenta);
H=exp(1j*k*d.*(1-lamda.*lamda.*(kethi.*kethi+nenta.*nenta)./2));
fa=fftshift(fft2(a));
Fuf=fa.*H;
U=ifft2(Fuf);
I=U.*conj(U);
figure,imshow(I,[0,max(max(I))]),colormap(gray);
