Delta=0.1; A=3;
t=0:2*pi/100:2*pi; sig_in=A*sin(t); td=2*pi/100; ts=1.5*td;
if (round(ts/td) >= 2)
Nfac = round(ts/td); %Nearest integer xsig = downsample(sig_in,Nfac);
Lxsig = length(xsig); Lsig_in = length(sig_in);

ADMout = zeros(Lsig_in); %Initialising output

cnt1 = 0; %Counters for no. of previous consecutively increasing cnt2 = 0; %steps
sum = 0;
for i=1:Lxsig

if (xsig(i) == sum) elseif (xsig(i) > sum)
if (cnt1 < 2)
sum = sum + Delta; %Step up by Delta, same as in DM elseif (cnt1 == 2)
sum = sum + 2*Delta; %Double the step size after
%first two increase elseif (cnt1 == 3)
sum = sum + 4*Delta; %Double step size else
sum = sum + 8*Delta; %Still double and then stop
%doubling thereon
End
if (sum < xsig(i)) cnt1 = cnt1 + 1;
else
cnt1 = 0; end
else
if (cnt2 < 2)
sum = sum - Delta; elseif (cnt2 == 2)
sum = sum - 2*Delta;
elseif (cnt2 == 3)
sum = sum - 4*Delta; else
sum = sum - 8*Delta; end

if (sum > xsig(i)) cnt2 = cnt2 + 1;
else
cnt2 = 0; end
end
ADMout(((i-1)*Nfac + 1):(i*Nfac)) = sum; end
end hold on
plot(sig_in); stairs(ADMout); hold off