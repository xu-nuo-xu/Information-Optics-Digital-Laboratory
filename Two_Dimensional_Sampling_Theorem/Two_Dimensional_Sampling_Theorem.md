# 二维抽样定理
## peaks 函数
> [[官方文档介绍]](https://www.mathworks.com/help/matlab/ref/peaks.html)<br>
>matlab 中的 peaks 函数是一个典型的多元函数。它本质上通过平移和缩放高斯分布得到，一般作为一个示例函数，函数表达式与图像如下：
$$f(x,y)=3(1-x)^2e^{-x^2-(y+1)^2}-10(\frac{1}{5}x-x^3-y^5)e^{-x^2-y^2}-\frac{1}{3}e^{-(x+1)^2-y^2}$$
<br> 
<div align=center><img src="pics/peaks.jpg"  width="60%" height="60%"><br>
<div align=left>
<br>

## imshow(f)和imshow(f,[])的区别
>**imshow(f)**<br>
在matlab中，为了保证精度，经过了运算的图像矩阵 f 其数据类型会从 uint8 型变成double 型。imshow()显示图像时对 double 型是认为在0~1范围内，**即大于1时都是显示为白色**，imshow显示uint8型时是0~255范围。<br>
>**imshow(f,[])**<br>
是**将 f 的最大值（max(f)）和最小值（min(f)）分别作为纯白(255)和纯黑(0)**。中间的 K 值相应地映射为 0到255 之间的标准灰度值，这样就可以正常显示了，相当于将 double 型的矩阵 S 拉伸成为了 0-255 的 uint8 型的矩阵，因此就可以正常显示。<br> 

<center>imshow(f)</center>
<div align=center><img src="pics/imshow(fxy).jpg"  width="60%" height="60%"><br>
<div align=left>
<center>imshow(f,[])</center><div align=center><img src="pics/imshow(fxy,[]).jpg"  width="60%" height="60%"><br>
<div align=left><br>

>上图可见，imshow(f,[])可显示的色阶更多，imshow(f)因为很多数据大于 1 于是都被显示为了白色。

## 二维傅里叶变换是怎么进行的？
[[知乎问题]](https://www.zhihu.com/question/22611929)<br>
参考答主：阿姆斯特朗。最后提到了fftshift的作用

## shading interp
>对曲面或图形对象的颜色着色进行色彩的插值处理，使色彩平滑过渡

## 设置图像横纵坐标范围 axis
>plot(x,y)<br>
axis([0 10 0 20]);<br>
就是控制x坐标显示0-10，y坐标显示0-20<br>

## surfl
>具有基于颜色图的光照的曲面图<br>
surfl(X,Y,Z) 创建一个带光源高光的三维曲面图。该函数将矩阵 Z 中的值绘制为由 X 和 Y 定义的 x-y 平面中的网格上方的高度。该函数使用光源的默认方向和着色模型的默认光照系数。这会将曲面的颜色数据设置为曲面的反射颜色。<br>
由于曲面法向量的计算方式的原因，surfl 需要大小至少为 3×3 的矩阵。<br>
[[官方文档]](https://ww2.mathworks.cn/help/matlab/ref/surfl.html?searchHighlight=surfl&s_tid=srchtitle)
