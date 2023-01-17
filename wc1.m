clear all;

close all;

%PCM of 24 signals

No_samples=input('Enter no of samples to be considered signal for display:');
Total_BitsperSignal=No_samples*8;
%each sample represented in 8 bits

PCM_signals=randi([0,1],24,Total_BitsperSignal);
figure(1);
for i=1:24 
    subplot(24,1,i);

stem(PCM_signals(i,:)); 
title(sprintf("PCM Signal-%di,i"));

end

xlabel('bits');

ylabel('amp');

%Multiplxing of 24 PCM signals

Tiframe=[];

for i=1:8:Total_BitsperSignal 
    multiplexed_signal=[];
    for j=1:24

multiplexed_signal=[multiplexed_signal PCM_signals(j,i:i+7)];
    end
Tiframe=[Tiframe 0 multiplexed_signal];
end



figure(2);

stem(Tiframe);

title('T1Bit stream'); 
xlabel('bits');

ylabel('amp');