close all;
clc;
A1= 1;
f1 = 2;
 
A2 = 1;
f2= 20;

fs = 500;
ts= 1/fs:1/fs:1;
x= A1*sin(2*pi*f1*ts);
y = A2*sin(2*pi*f2*ts);
z = x + y; 


subplot(2,2,1);
plot(ts,z,'g');
xlabel("Time");
ylabel("Amplitude ");
title("Adril Thapa (Addition of two sin Waves)");


subplot(2,2,2);
FT1=abs(fft(z));
% FT= FT(0:length(FT));
% f=(0:length(FT))*fs/2/length(FT);
% FT1(10:490)=0;
% FT1(490:end)=0;
plot(FT1,'r');
xlabel("Frequency(HZ)");
ylabel("Amplitude");
title("Adril Thapa (Fourier Transform)");

 subplot(2,2,3);
 signal= ifft(FT1);
 plot(ts,signal,'y');
 xlabel("Amplitude");
 ylabel("Time");
title("Adril Thapa (Inverse Fourier Trasform");