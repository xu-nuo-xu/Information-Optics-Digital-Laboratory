Uo=imread('./pics/分辨率板_2.bmp');
Uo=double(Uo(:,:,1));  %相当于Uo=double(Uo)
lamda=6328e-10;k=2*pi/lamda;
D=0.01;f=0.4;
figure,imshow(Uo,[]);
[c,r]=size(Uo);
L0=0.005;
x0=linspace(-L0/2,L0/2,r);
y0=linspace(-L0/2,L0/2,c);
[x0,y0]=meshgrid(x0,y0);
d1=1.2;
L=r*lamda*d1/L0;    %式(3-10)
p=linspace(-L/2,L/2,r);
q=linspace(-L/2,L/2,c);
[p,q]=meshgrid(p,q);
F00=exp(1j*k*d1)/(1j*lamda*d1)*exp(1j*k/2/d1*(p.^2+q.^2));      %S-FFT算法
Fpq=exp(1j*k/2/d1*(x0.^2+y0.^2));
a=Uo.*Fpq;
FUpq=fft2(a);
Ffpq=fftshift(FUpq);
Fufpq=F00.*Ffpq;
I=Fufpq.*conj(Fufpq);
figure,imshow(I,[]),colormap(pink),title('透镜上的光场分布');

DD=round(D*r/L);    %0.01/0.0778*512,孔径采样数(因为衍射成的边为0.0778的像必须有512个采样点，同采样密度计算孔径上采样个数)
pxy=zeros(c,r);
for n=1:c
    for m=1:r
        if (n-c/2)^2+(m-r/2)^2<=(DD/2)^2
            pxy(n,m)=1;
        end
    end
end
figure,imshow(pxy,[]),title('孔径函数')
Fufpqyp=Fufpq.*pxy.*exp(-1j*k.*(p.^2+q.^2)/2/f);    %式（6-8）

d2=d1*f/(d1-f);
Lyp=r*lamda*d2/L;
x=linspace(-Lyp/2,Lyp/2,r);
y=linspace(-Lyp/2,Lyp/2,c);
[x,y]=meshgrid(x,y);
F0=exp(1j*k*d2)/(1j*lamda*d2)*exp(1j*k/2/d2*(x.^2+y.^2));
F=exp(1j*k/2/d2*(p.^2+q.^2));

re_image=fft2(Fufpqyp.*F);
re_image=re_image.*F0;
if Lyp<0
    re_image=flipud(re_image);
    re_image=fliplr(re_image);
end
figure,imshow(re_image.*conj(re_image),[]),title('再现像');
