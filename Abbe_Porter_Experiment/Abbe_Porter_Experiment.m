r=512;c=r;
Uo=zeros(c,r);
d=30;
a=10;
for n=1:d:c
    Uo(n:n+a,:)=1;
end
for m=1:d:r
    Uo(:,m:m+a)=1;
end
Uo=Uo(1:c,1:r);         %边界设定
figure,imshow(Uo,[]);title('物光分布');
lamda=6328e-10;
k=2*pi/lamda;
f=0.004;
Lo=0.001;
D1=0.00005;
D2=0.00005;
%=====================物光到透镜前 S-FFT=========================
xo=linspace(-Lo/2,Lo/2,r);
yo=linspace(-Lo/2,Lo/2,c);
[xo,yo]=meshgrid(xo,yo);
do=0.0041;
L=r*lamda*do/Lo;
x1=linspace(-L/2,L/2,r);
y1=linspace(-L/2,L/2,c);
[x1,y1]=meshgrid(x1,y1);
F0=exp(1j*k*do)/(1j*lamda*do)*exp(1j*k/2/do*(x1.^2+y1.^2));
F=exp(1j*k/2/do*(xo.^2+yo.^2));
FU=(Lo*Lo/r/r).*fftshift(fft2(Uo.*F));  
%FU=fftshift(fft2(Uo.*F));      %FU为什么不用这种形式？二者结果目测下来效果一样
U1=F0.*FU;
I1=U1.*conj(U1);
figure,imshow(I1,[]),colormap(gray),title('透镜上的光强分布');
%==================================================
%透镜后光场
U1yp=U1.*exp(-1j*k.*(x1.^2+y1.^2)/2/f);     %式6-8，忽略透镜孔径大小影响
%==================================================
%===========计算透镜后光场到达后交面过程 S-FFT=======
dlf=f;
Lyp=r*lamda*dlf/L;
xf=linspace(-Lyp/2,Lyp/2,r);
yf=linspace(-Lyp/2,Lyp/2,c);
[xf,yf]=meshgrid(xf,yf);
F0=exp(1j*k*dlf)/(1j*lamda*dlf)*exp(1j*k/2/dlf*(xf.^2+yf.^2));
F=exp(1j*k/2/dlf*(x1.^2+y1.^2));
Uf=(L*L/r/r).*fft2(U1yp.*F);
Uf=Uf.*F0;
I2=Uf.*conj(Uf);
figure,imshow(I2,[0,max(I2(:))/100]),colormap(gray),title('后焦面光强分布');
%===================多边形滤波==============================
[cc,rr]=getline(gcf,'closed');
H=zeros(c,r);
H=roipoly(H,cc,rr);
figure,imshow(H,[]);title('多边形滤波器');
Ufyp=H.*Uf;
%==========三种滤波器===================
DD=round(D1*r/Lyp);
SD=round(D2*r/Lyp/2);
H1=zeros(c,r);
for n=1:c
    for m=1:r
        if (n-c/2-1)^2+(m-r/2-1)^2<=(DD/2)^2
            H1(n,m)=1;
        end
    end
end
figure,subplot(1,3,1),imshow(H1,[]),title('滤波器H1')
H2=zeros(c,r);
H2(round(c/2)-SD:round(r/2)+SD,:)=1;
subplot(1,3,2),imshow(H2,[]),title('滤波器H2')
H3=zeros(c,r);
H3(:,round(r/2)-SD:round(r/2)+SD)=1;
subplot(1,3,3),imshow(H3,[]),title('滤波器H3')
%==========================================================
Uf1=H1.*Uf;
Uf2=H2.*Uf;
Uf3=H3.*Uf;
%===========================================================
%========下面计算后焦面光场到达像面成像过程 S-FFT=============
dfi=do*f/(do-f)-f;
Li=r*lamda*dfi/Lyp;
xi=linspace(-Li/2,Li/2,r);
yi=linspace(-Li/2,Li/2,c);
[xi,yi]=meshgrid(xi,yi);
F0=exp(1j*k*dfi)/(1j*lamda*dfi)*exp(1j*k/2/dfi*(xi.^2+yi.^2));
F=exp(1j*k/2/dfi*(xf.^2+yf.^2));
%=========无滤波时===================
Ui=(Lyp*Lyp/r/r).*fft2(Uf.*F);
Ui=Ui.*F0;
Ii=Ui.*conj(Ui);
figure,imshow(Ii,[]),title('无滤波再现像');
%========三种滤波情况===================
Ui1=(Lyp*Lyp/r/r).*fft2(Uf1.*F);
Ui1=Ui1.*F0;
Ii1=Ui1.*conj(Ui1);
figure,imshow(Ii1,[]),title('滤波H1再现像');

Ui2=(Lyp*Lyp/r/r).*fft2(Uf2.*F);
Ui2=Ui2.*F0;
Ii2=Ui2.*conj(Ui2);
figure,imshow(Ii2,[]),title('滤波H2再现像');

Ui3=(Lyp*Lyp/r/r).*fft2(Uf3.*F);
Ui3=Ui3.*F0;
Ii3=Ui3.*conj(Ui3);
figure,imshow(Ii3,[]),title('滤波H3再现像');

figure,subplot(2,1,1),plot(Ii1(round(c/2),:));
subplot(2,1,2),plot(Ii2(round(c/2),:))

%================多边形滤波===========================
Ui4=fft2(Ufyp.*F);
Ui4=Ui4.*F0;
Ii4=Ui4.*conj(Ui4);
figure,imshow(Ii4,[]),title('多边形滤波再现像');
figure,plot(Ii4(round(c/2),:))