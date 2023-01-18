clc;
close all;
am=1;
fm=1;
fs=20*fm;
t=0:1/fs:1;
x=am*cos(2*pi*fm*t);
plot(x,'m.-'); hold on;
d=(2*pi*am*fm)/fs;
for n=1:length(x)
    if n==1
e(n)=x(n);
eq(n)=d*sign(e(n));
xq(n)=eq(n);
    else
        e(n)=x(n)-xq(n-1);
        eq(n)=d*sign(e(n));
        xq(n)=eq(n)+xq(n-1);
    end
end
stairs(xq,'black');
for n=1:length(x)
    if e(n)>0
        dm(n)=1;
    else
        dm(n)=0;
    end
end
