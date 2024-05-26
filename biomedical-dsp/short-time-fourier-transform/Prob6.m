%% PROBLEM 6


L = 500;
R = 250;
N = 8192;

win = hamming(L)
Y1 = myspectrogram(SigOG,N,fs,win,R);
X1 = invmyspectrogram(Y1,R);
t = [0:1/fs:(length(SigOG)-1)/fs];
%%
figure
subplot(2,1,1)
plot(t,SigOG)
xlim([0 t(end)])
title('SigOG - Original Signal')
xlabel('Time (s)')
ylabel('Amplitude')
subplot(2,1,2)
plot(t,X1(1:200000))
xlim([0 t(end)])
title('SigOG - Original Signal, after Inverse Spectrogram')
xlabel('Time (s)')
ylabel('Amplitude')

%%

figure
subplot(2,1,1)
plot(t,SigOG)
title('SigOG - Zoomed in')
xlim([0 0.1])
xlabel('Time (s)')
ylabel('Amplitude')
subplot(2,1,2)
plot(t,X1(1:200000))
title('SigOG after Inverse - Zoomed in')
xlim([0 0.1])
xlabel('Time (s)')
ylabel('Amplitude')

%%

figure
subplot(2,1,1)
plot(t,SigOG)
title('SigOG - Zoomed in')
xlim([4 4.1])
xlabel('Time (s)')
ylabel('Amplitude')
subplot(2,1,2)
plot(t,X1(1:200000))
title('SigOG after Inverse - Zoomed in')
xlim([4 4.1])
xlabel('Time (s)')
ylabel('Amplitude')
%% 


L = 128;
R = 64;
N = 8192;

win = hamming(L);
Y1 = myspectrogram(SigOG,N,fs,win,R);
X1 = invmyspectrogram(Y1,R);
t = [0:1/fs:(length(SigOG)-1)/fs];
figure
subplot(2,1,1)
plot(t,X1(1:200000));
xlim([0 t(end)])
ylim([- 0.2 0.2])
title('SigOG Reconstructed - COLA Satisfied')
xlabel('Time (s)')
ylabel('Amplitude')



% COLA 

L = 128;
R = 80;
N = 8192;


win = hamming(L);
Y1_COLA = myspectrogram(SigOG,N,fs,win,R);
X1_COLA = invmyspectrogram(Y1_COLA,R);
t = [0:1/fs:(length(SigOG)-1)/fs];
subplot(2,1,2)
plot(t,X1_COLA(1:200000));
xlim([0 t(end)])
ylim([- 0.2 0.2])
title('SigOG Reconstructed - COLA Not Satisfied')
xlabel('Time (s)')
ylabel('Amplitude')

%%

% Finding other distortions

L = 128;
R = 70;
N = 8192;

figure
subplot(2,1,1)
plot(t,SigOG)
title('SigOG - Zoomed in')
xlim([4 4.1])
xlabel('Time (s)')
ylabel('Amplitude')
subplot(2,1,2)



win = rectwin(L);
Y2 = myspectrogram(SigOG,N,fs,win,R);
X2 = invmyspectrogram(Y2,R);
t = [0:1/fs:(length(SigOG)-1)/fs];
subplot(2,1,2)
plot(t,X2(1:200000));
xlim([4 4.1])
title('SigOG Reconstructed with Rectangular Window')
xlabel('Time (s)')
ylabel('Amplitude')



%}