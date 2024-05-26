%% PROBLEM 5

% SigOG with Hamming

N = 8192;

a = 50;
b = 100;
c = 500;

R1 = 25;
R2 = 50;
R3 = 250;

% Sig OG

figure;
subplot(3,1,1)
L = a; win = hamming(L);
% SigOG_p = padarray(SigOG,200000);
YR1 = myspectrogram(SigOG,N,fs,win,R1,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigOG - Hamming Window, L = 50, R = 25')


subplot(3,1,2)
L = b; win = hamming(L);
YR2 = myspectrogram(SigOG,N,fs,win,R2,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigOG - Hamming Window, L = 100, R = 50')


subplot(3,1,3)
L = c; win = hamming(L);
YR3 = myspectrogram(SigOG,N,fs,win,R3,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigOG - Hamming Window, L = 500, R = 250')


%%
% Sig Noise with Hamming

figure;
subplot(3,1,1)
L = a; win = hamming(L);
% SigOG_p = padarray(SigOG,200000);

YR1 = myspectrogram(SigNoise,N,fs,win,R1,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('Hamming')
title('SigNoise - Hamming Window, L = 50, R = 25')


subplot(3,1,2)
L = b; win = hamming(L);
YR2 = myspectrogram(SigNoise,N,fs,win,R2,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigNoise - Hamming Window, L = 100, R = 50')


subplot(3,1,3)
L = c; win = hamming(L);
YR3 = myspectrogram(SigNoise,N,fs,win,R3,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigNoise - Hamming Window, L = 500, R = 250')

%%

% Sig OG with Rectangular

figure;
subplot(3,1,1)
L = a; win = rectwin(L);
% SigOG_p = padarray(SigOG,200000);

YR1 = myspectrogram(SigOG,N,fs,win,R1,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigOG - Rectangular Window, L = 50, R = 25')

subplot(3,1,2)
L = b; win = rectwin(L);
YR2 = myspectrogram(SigOG,N,fs,win,R2,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigOG - Rectangular Window, L = 100, R = 50')


subplot(3,1,3)
L = c; win = rectwin(L);
YR3 = myspectrogram(SigOG,N,fs,win,R3,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigOG - Rectangular Window, L = 500, R = 250')


%%

% SigNoise with Rectangular




figure;
subplot(3,1,1)
L = a; win = rectwin(L);
% SigOG_p = padarray(SigOG,200000);

YR1 = myspectrogram(SigNoise,N,fs,win,R1,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigNoise - Rectangular Window, L = 50, R = 25')

subplot(3,1,2)
L = b; win = rectwin(L);
YR2 = myspectrogram(SigNoise,N,fs,win,R2,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigNoise - Rectangular Window, L = 100, R = 50')


subplot(3,1,3)
L = c; win = rectwin(L);
YR3 = myspectrogram(SigNoise,N,fs,win,R3,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('SigNoise - Rectangular Window, L = 500, R = 250')



%%


% Zero padding

SigN_p = padarray(SigNoise,200000);
L = b;
subplot(2,1,1)
YR2 = myspectrogram(SigNoise,N,fs,rectwin(L),R2,1,100);
ax = gca;
ax.YLim = [0 fs/(1e3*2)]
title('SigOG, Rectangular Window - L = 100, R = 50')
subplot(2,1,2)
YR2_z = myspectrogram(SigN_p,N,fs,rectwin(L),R2,1,100);
ax = gca;
ax.YLim = [0 fs/(1e3*2)]
ax.XLim = [4 8.2]
title('Padded SigOG, Rectangular Window - L = 100, R = 50')
%%