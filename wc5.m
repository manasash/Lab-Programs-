%PN sequence generation
clc;
clear all;
close all;
M=4; %number of flipflops in LFSR
N=2^M-1; %length of PN sequence
%initial states of LFSR
x1=1;
x2=0;
x3=0;
x4=1;
states=[];
for i=1:N
 states=[states;x1(i) x2(i) x3(i) x4(i)];
 x1(i+1)=xor(x3(i),x4(i));
 x2(i+1)=x1(i);
 x3(i+1)=x2(i);
 x4(i+1)=x3(i);
end
pn=x4(1:N);
%balanace properties verification
no_ones=sum(pn==1);
no_zeros=sum(pn==0);
if no_ones==1+no_zeros
 disp('Balanace property of PN sequence is satisfied');
end
%Autocorrelation Properties verification
for i=1:N
 if pn(i)==1
 pn(i)=-1;
 else
 pn(i)=1;
 end
end
ac=[];
for d=-1:2*N+1
 p=circshift(pn,d);
 acf=sum(pn.*p)/N;
 ac=[ac acf];
end
figure;
d=-1:2*N+1;
plot(d,ac,'r-');
title('Autocorrreation function');
xlabel('lag------->');
ylabel('Amplitude-------------->');