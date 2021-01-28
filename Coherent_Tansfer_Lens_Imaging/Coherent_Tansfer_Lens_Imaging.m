Uo=imread('./pics/分辨率板_2.bmp');
Uo=double(Uo(:,:,1));
[c,r]=size(Uo);
lamda=6328e-10;k=2*pi/lamda;
D=0.01;
f=0.4;
figure,imshow(Uo,[]);
L0=0.005;
d0=1.2;
di=d0*f/(d0-f);
cutoff_frequency=D/2/lamda/di;  %式(3-9)，和光瞳有关
Li=L0*di/d0;
kethi=linspace(-1/2/Li,1/2/Li,r).*r;
nenta=linspace(-1/2/Li,1/2/Li,c).*c;    %式(3-7)
[kethi,nenta]=meshgrid(kethi,nenta);    %按照物的最高空间频率，构建像的频谱网格
H=zeros(c,r);
for n=1:c
    for m=1:r
        if kethi(n,m)^2+nenta(n,m)^2<=cutoff_frequency^2
            H(n,m)=1;
        end
    end
end
figure,imshow(H,[]);title('传递函数')
Gg=fftshift(fft2(Uo));

Gi=Gg.*H;
Ui=ifft2(Gi);
Ii=Ui.*conj(Ui);
figure,imshow(Ii,[]),title('像的光强分布')