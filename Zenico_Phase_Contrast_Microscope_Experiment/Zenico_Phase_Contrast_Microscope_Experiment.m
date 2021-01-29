Uo=imread('./pics/xuehua.jpg');
Uo=double(Uo(:,:,1));
figure,imshow(Uo,[]);
Uo=exp(1j.*Uo/255);     %纯相位物光场
[c,r]=size(Uo);
lamda=6328e-10;
k=2*pi/lamda;
f=0.004;
Lo=0.001;
D=0.00005;
%===============物光到透镜前 S-FFT =================
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
figure,imshow(I2,[0,max(I2(:))/10000]),colormap(gray),title('后焦面光强分布');
%==================================================
%=====================生成滤波器====================
DD=round(D*r/Lyp);
H=zeros(c,r);
for n=1:c
    for m=1:r
        if (n-c/2-1)^2+(m-r/2-1)^2<=(DD/2)^2
            H(n,m)=1;
        end
    end
end
figure,imshow(H,[]);title('理想的低通滤波器');
H_p=exp(1j*pi/2).*H;        %正相衬滤波器
H_n=exp(1j*3*pi/2).*H;      %负相衬滤波器
%==================================================
%计算经过正负相衬后焦面光场 这里结合《傅里叶光学》中P328解释
Uf_p=H_p.*Uf+(1-H).*Uf;     %低频(零频)部分用H_p作用后相位增加pi/2，高频部分不变，让其自然通过即可
Uf_n=H_n.*Uf+(1-H).*Uf;     %低频(零频)部分用H_n作用后相位增加3*pi/2，高频部分不变，让其自然通过即可
%===================================================
%=======下面计算焦面后光场到达观察面过程 S-FFT========
dfi=do*f/(do-f)-f;
Li=r*lamda*dfi/Lyp;
xi=linspace(-Li/2,Li/2,r);
yi=linspace(-Li/2,Li/2,c);
[xi,yi]=meshgrid(xi,yi);
F0=exp(1j*k*dfi)/(1j*lamda*dfi)*exp(1j*k/2/dfi*(xi.^2+yi.^2));
F=exp(1j*k/2/dfi*(xf.^2+yf.^2));
%======计算再现像===================
Ui=(Lyp*Lyp/r/r).*fft2(Uf.*F);
Ui=Ui.*F0;
Ii=Ui.*conj(Ui);
figure,imshow(Ii,[]),title('无相衬再现像');

Ui_p=(Lyp*Lyp/r/r).*fft2(Uf_p.*F);
Ui_p=Ui_p.*F0;
Ii_p=Ui_p.*conj(Ui_p);
figure,imshow(Ii_p,[]),title('正相衬再现像');

Ui_n=(Lyp*Lyp/r/r).*fft2(Uf_n.*F);
Ui_n=Ui_n.*F0;
Ii_n=Ui_n.*conj(Ui_n);
figure,imshow(Ii_n,[]),title('负相衬再现像');

% Ii_p_yp=flipud(fliplr(Ii_p));
% Ii_n_yp=flipud(fliplr(Ii_n));
% figure,subplot(2,1,1),plot(1-2*angle(Uo(round(r/2),:)),'--k'),axis([1 r-1 1 pi])
% hold on,plot(1+2*angle(Uo(round(r/2)-2,:)),'-+r'),title('理论结果')
% subplot(2,1,2),plot(Ii_n_yp(round(r/2)-2,91:477),'--k'),axis([1 386 0 2.5e-3])
% hold on,plot(Ii_p_yp(round(r/2)-2,91:477),'-+r'),title('实验结果')
