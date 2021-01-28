r=512;c=r;
a=zeros(r,c);
a(r/2-r/4:r/2+r/4,c/2-c/4:c/2+c/4)=1;
lamda=6328e-10;
k=2*pi/lamda;
L0=5e-3;
d=0.1;
x0=linspace(-L0/2,L0/2,c);
y0=linspace(-L0/2,L0/2,r);
[x0,y0]=meshgrid(x0,y0);
L=r*lamda*d/L0;     %式(3-10)
x=linspace(-L/2,L/2,c);
y=linspace(-L/2,L/2,r);
[x,y]=meshgrid(x,y);

F0=exp(1j*k*d)/(1j*lamda*d)*exp(1j*k/2/d*(x.^2+y.^2));  %式(3-4)
F=exp(1j*k/2/d*(x0.^2+y0.^2));
a=a.*F;        %相当于衍射孔内部U0(x0,y0)=1，其他地方都是0
Ff=fftshift(fft2(a));
Fuf=F0.*Ff;
I=Fuf.*conj(Fuf);
figure,
subplot(1,2,1),imshow(I,[0,max(max(I))]),colormap(gray)
subplot(1,2,2),imshow(max(max(I))-I,[]),colormap(gray)

