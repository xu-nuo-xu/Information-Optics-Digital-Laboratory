lamda=6328e-10;
k=2*pi/lamda;
alpha=pi/2.005;
beta=pi/2.005;
L=0.004;
x=linspace(-L/2,L/2,512);y=x;
[x,y]=meshgrid(x,y);
U=exp(1j.*k.*(x.*cos(alpha)+y.*cos(beta)));
ph=k.*(x.*cos(alpha)+y.*cos(beta));
figure,surfl(ph),shading interp,colormap(gray)
phyp=angle(U);
figure,imshow(phyp,[])
figure,plot(ph(257,:),'--')
hold on,plot(phyp(257,:),'r')
diff=U+1;
I=diff.*conj(diff);
figure,imshow(I,[])
UFuv=fftshift(fft2(U));
figure,imshow(abs(UFuv),[0,max(max(abs(UFuv)))./50])
IFuv=fftshift(fft2(I));
figure,imshow(abs(IFuv),[0,max(max(abs(IFuv)))./50])
