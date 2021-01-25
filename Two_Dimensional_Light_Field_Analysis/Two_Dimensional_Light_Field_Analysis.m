lamda = 6328e-10;
k = 2*pi/lamda;
x0=0.001;
y0=0.001;
z=0.3;
L=0.005;
x=linspace(-L/2,L/2,512);
y=x;
[x,y]=meshgrid(x,y);
U1=exp(1j*k*z).*exp(1j*k.*((x-x0).^2+(y-y0).^2)/2/z);   %ʽ(2-13)
ph1=k.*((x-x0).^2+(y-y0).^2)/2/z;
%figure,surfl(ph1),shading interp,colormap(gray)
phyp1=angle(U1);
%figure,imshow(phyp1,[])
U2=exp(-1j*k*z).*exp(-1j*k.*((x-x0).^2+(y-y0).^2)/2/z); %ʽ(2-14)
ph2=-k.*((x-x0).^2+(y-y0).^2)/2/z;
%figure,surfl(ph2),shading interp,colormap(gray)
phyp2=angle(U2);
%figure,imshow(phyp2,[])
%figure,plot(ph2(257,:),'--')
%hold on
%plot(phyp2(257,:),'r')
diff1=U1+1;
I1=diff1.*conj(diff1);
%figure,imshow(I1,[0,max(max(I1))])
diff2=U2+1;
I2=diff2.*conj(diff2);
%figure,imshow(I2,[0,max(max(I2))])
