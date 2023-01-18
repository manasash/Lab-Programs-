a=[-3 -1 1 3];
ind = randi(4,100,1)-1; ind = ind+1;
pam = a(ind); fs=24000; T=1/8000;
t=-5*T:1/fs:5*T; t=t+1e-10; alfa=0.5;
p=(sin(pi*t/T)./(pi*t/T).*cos(alfa*pi*t/T)./(1-(2*alfa*t/T).^2)); clf;
figure(1); plot(t,p); hold on; stem(t,p);
xlabel('T');
ylabel('A'); hold off;
N=length(pam); r=fs*T;
pams = zeros(size(1:r*N)); pams(1:r:r*N) = pam;
xn = filter(p,1,pams); figure(2); stem(xn(1:300));
clf;
hold on;
for i=16:6:300-6
plot(xn(i:i+6)); 
endfor
hold off; grid on;