fxy = cos(peaks(256).*2+pi)+1;
[rr,cc]=size(fxy);
figure,imshow(fxy,[])
F=fftshift(fft2(fxy));
figure,plot(abs(F(round(rr/2)+1,:))),
figure,plot(abs(F(:,round(cc/2)+1))),
figure,surfl(abs(F)),shading interp,colormap(gray);
combxy=zeros(rr,cc);
X=4;Y=4;
for n=1:Y:rr
    for m=1:X:cc
        combxy(n,m)=1;
    end
end
figure,imshow(combxy,[]);
C=fftshift(fft2(combxy));
figure,surfl(abs(C)),shading interp,colormap(gray);
gxy=zeros(rr,cc);
gxy=fxy.*combxy;
figure,imshow(gxy,[]);
Gs=fftshift(fft2(gxy));
figure,surfl(abs(Gs)),shading interp,colormap(gray);
figure,plot(abs(Gs(:,cc/2+1))),
By=round(rr/2/Y);Bx=round(cc/2/X);
H=zeros(rr,cc);
H(round(rr/2)+1-By:round(rr/2)+1+By-1,round(cc/2)+1-Bx:round(cc/2)+1+Bx-1)=1;
figure,imshow(H,[])
Gsyp=H.*Gs;
figure,surfl(abs(Gsyp)),shading interp,colormap(gray);
gxyyp=X*Y.*abs(ifft2(Gsyp));
figure,imshow(gxyyp,[])