%% QUESTION 1


Ts = 1/fs;
N = length(SigOG);
t_axis = [0:1/fs:(N-1)/fs];

figure
signoise_fft = abs(fft(SigNoise));
f_axis = [0:fs/(length(signoise_fft)):fs-(fs/length(signoise_fft))];
fft_shift_signoise = fftshift(signoise_fft);
fft_shift_OG = fftshift(abs(fft(SigOG)));
fs_axis = f_axis-fs/2;
subplot(2,1,1)
plot(fs_axis,fft_shift_OG)
ylabel('Magnitude')
xlabel('Frequency (Hz)')
title('FFT of Clean Data - SigOG')
xlim([-2000 2000])
subplot(2,1,2)
plot(fs_axis,fft_shift_signoise)
xlim([-2000 2000])
ylabel('Magnitude')
xlabel('Frequency (Hz)')
title('FFT of Noisy Data - SigNoise')

figure
subplot(2,1,1)
plot(t_axis,SigOG)
xlim([0 t_axis(end)])
xlabel('Time (s)')
ylabel('Amplitude')
title('Clean Signal - SigOG')
subplot(2,1,2)
plot(t_axis,SigNoise)
xlim([0 t_axis(end)])
xlabel('Time (s)')
ylabel('Amplitude')
title('Noisy Signal - Sig60Hz')



subplot(2,1,1)
plot(t_axis,denoised_speech)
xlim([0 t_axis(end)])
xlabel('Time (s)')
ylabel('Amplitude')
title('Filtered Signal')


subplot(2,1,2)
plot(fs_axis,fftshift(abs(fft(denoised_speech))))
ylabel('Magnitude')
xlabel('Frequency (Hz)')
title('FFT of Denoised Data')
xlim([-2000 2000])

 
denoised_speech = filter(Hd1_Speech,SigNoise)
audiowrite('Attempt14.wav',denoised_speech,48000,'BitsPerSample',16)




%% QUESTION 2



xn2 = SigNoise;
x = SigOG;

XnC = fft(xn2);
XnMag = abs(XnC);
XnPh = angle(XnC);
Thr1 = 20;
Thr2 = 9; 


ind1 = find(XnMag<0.3 & XnMag > 0.18);
ind2 = find(XnMag >=0.3 | XnMag <= 0.18);


XnMagFilt(ind1)= XnMag(ind1) - Thr1;
XnMagFilt(ind2)= XnMag(ind2) - Thr2;


zeroInd = find(XnMagFilt<0);
XnMagFilt(zeroInd) = 0;



XnCFilt = XnMagFilt.*exp(i*XnPh);
xn2Filt = ifft(XnCFilt);
t = [0:1/fs:(length(x)-1)/fs];

figure
subplot(2,1,1)
plot(t,xn2Filt)
set(gca,'YLim',[-2 3])
xlabel('Time (seconds)')
ylabel('Amplitude')
title('Spectral Subtraction Signal')
xlim([0 t_axis(end)])
ylim([-0.4 0.4])
subplot(2,1,2)
plot(t,x)
set(gca,'YLim',[-2 3])
xlabel('Time (seconds)')
title('Original Signal')
ylabel('Amplitude')
xlim([0 t_axis(end)])
ylim([-0.4 0.4])



figure
Xn = abs(fft(xn2));
w = [0:fs/(length(Xn)):fs-(fs/length(Xn))];
%subplot(4,1,1)
%plot(w,Xn)
%xlabel('Frequency (Hz)')
Xns = fftshift(abs(fft(xn2)));
ws = w-fs/2;
subplot(3,1,1)
plot(ws,Xns)
xlabel('Frequency (Hz)')
title('White Noise Added Data')
Xs = fftshift(abs(fft(x)));
subplot(3,1,2)
plot(ws,Xs)
xlabel('Frequency (Hz)')
title('Original Data')
subplot(3,1,3)
plot(ws,fftshift(abs(fft(xn2Filt))))
xlabel('Frequency (Hz)')
title('Filtrered Data')



y = filter(Hd2_Speech,xn2);
figure
%% 

subplot(2,1,1)
plot(t_axis,y)
xlim([0 t_axis(end)])
xlabel('Time (seconds)')
title('Spectral Filtered and Subtracted Signal')
xlabel('Time (s)')
ylabel('Amplitude')
subplot(2,1,2)
plot(t_axis,x)
title('Original Signal')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([0 t_axis(end)])
%% 

audiowrite('Q22a.wav',y,48000,'BitsPerSample',16)

