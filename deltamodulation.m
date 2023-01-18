clc; clear all; close all; a=2;
t=0:2*pi/50:2*pi; x=a*sin(t); l=length(x);
%figure(1);
plot(x,'r'); delta=0.2; hold on xn=0;
for i=1:l;
if x(i)>xn(i)
d(i)=1;
xn(i+1)=xn(i)+delta; else
d(i)=0;
xn(i+1)=xn(i)-delta; end
end
stairs(xn) %modulation hold on
for i=1:d
if d(i)>xn(i)
d(i)=0;
xn(i+1)=xn(i)-delta; else
d(i)=1;
xn(i+1)=xn(i)+delta; %demodulation end
end
%figure(2);
plot(xn,'c'); %plot graph xlabel('-----------t/n >')
ylabel('-----------x(t)/y[n] >')
legend('Original Signal','Modulated Signal')
legend('Original Signal','Modulated Signal')