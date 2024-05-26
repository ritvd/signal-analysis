
%
% Rithika Varma Dandu
% Biomedical DSP - HW8
% 

%% IMPLEMENTATION CODE. 
% Functions in Wiener_RVD1.m 
%% WAV Files
audiowrite('SigOG.wav',SigOG,48000,'BitsPerSample',16)
audiowrite('SigNoise.wav',SigNoise,48000,'BitsPerSample',16)
audiowrite('SigNoiseLess.wav',SigNoiseLess,48000,'BitsPerSample',16)

%% Signal and FFT Plots
Ts = 1/fs;
samples = length(SigOG);
t_axis = ((0:(samples-1))/fs)*1000;

figure
subplot(3,1,3)
plot(t_axis,SigNoise)
hold on
grid on
xlim([0, t_axis(end)]);cc
xlabel('Time (ms)')
ylabel('Ampltiude')  
hold off
title('Noisy Signal')

subplot(3,1,2)
plot(t_axis,SigNoiseLess)
hold on
grid on
xlim([0, t_axis(end)]);  
xlabel('Time (ms)')
ylabel('Ampltiude')  
hold off
title('Less Noisy Signal')


subplot(3,1,1)
plot(t_axis,SigOG)
hold on
grid on
xlim([0, t_axis(end)]);  
xlabel('Time (ms)')
ylabel('Ampltiude')  
hold off
title('Clean Signal')


figure
signoise_fft = fftshift(abs(fft(SigNoise)));
signoiseless_fft = fftshift(abs(fft(SigNoiseLess)));
sigOG_fft = fftshift(abs(fft(SigOG)));
f_axis = [0:fs/(length(signoise_fft)):fs-(fs/length(signoise_fft))];
fs_axis = f_axis-fs/2;
subplot(3,1,3)
plot(fs_axis,signoise_fft)
xlim([-2000 2000])


ylabel('Magnitude')
xlabel('Frequency (Hz)')
title('FFT of Noisy Signal')
subplot(3,1,2)
plot(fs_axis,signoiseless_fft)
ylabel('Magnitude')
xlim([-2000 2000])
xlabel('Frequency (Hz)')
title('FFT of Less Noisy Signal')


subplot(3,1,1)
plot(fs_axis,sigOG_fft)
ylabel('Magnitude')
xlabel('Frequency (Hz)')
xlim([-2000 2000])
title('FFT of Clean Signal')



%% PART I a. Decision Directed vs Spectral Subtraction 

output_DD_1 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.025, 0.5);
output_DD_2 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.5, 0.025, 0.5);
output_DD_3 = Wiener_RVD1(SigNoiseLess, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.25, 0.025, 0.5);

output_SS_1 = Wiener_RVD1(SigNoise, fs, 'Spectral', 0.15, 'Ham', 1, 0.25, 0.99, 0.025, 0.5);
output_SS_2 = Wiener_RVD1(SigNoise, fs, 'Spectral', 0.15, 'Ham', 1, 0.5, 0.99, 0.025, 0.5);
output_SS_3 = Wiener_RVD1(SigNoiseLess, fs, 'Spectral', 0.15, 'Ham', 1, 0.99, 0.50, 0.025, 0.5);


audiowrite('output_DD_1.wav', output_DD_1, 48000, 'BitsPerSample',16);
audiowrite('output_DD_2.wav', output_DD_2, 48000, 'BitsPerSample',16);
audiowrite('output_DD_3.wav', output_DD_3, 48000, 'BitsPerSample',16);

audiowrite('output_SS_1.wav', output_SS_1, 48000, 'BitsPerSample',16);
audiowrite('output_SS_2.wav', output_SS_2, 48000, 'BitsPerSample',16);
audiowrite('output_SS_3.wav', output_SS_3, 48000, 'BitsPerSample',16);


samples1 = length(output_DD_1);
t_axis1 = ((0:(samples1-1))/fs)*1000;

figure
subplot(2,1,1)
plot(t_axis1, output_DD_1)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal after Decision Directed')

subplot(2,1,2)
plot(t_axis1, output_SS_1)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal after Spectral Subtraction')


figure
subplot(2,1,1)
plot(t_axis1, output_DD_2)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal after Decision Directed')

subplot(2,1,2)
plot(t_axis1, output_SS_2)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal after Spectral Subtraction')

figure
subplot(2,1,1)
plot(t_axis1, output_DD_3)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Less Noisy Signal after Decision Directed')

subplot(2,1,2)
plot(t_axis1, output_SS_3)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Less Noisy Signal after Spectral Subtraction')


%% PART I. b. Initial Segment Noise vs Noise from All Segments


output_DD_4 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.025, 0.5);
output_DD_5 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 0, 1, 0.99, 0.025, 0.5);
output_DD_6 = Wiener_RVD1(SigNoiseLess, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.025, 0.5);
output_DD_7 = Wiener_RVD1(SigNoiseLess, fs, 'Decision', 0.15, 'Ham', 0, 1, 0.99, 0.025, 0.5);

figure
subplot(2,1,1)
plot(t_axis1, output_DD_4)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Initial Segment only')

subplot(2,1,2)
plot(t_axis1, output_DD_5)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using All Segments')

figure
subplot(2,1,1)
plot(t_axis1, output_DD_6)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Less Noisy Signal Filtering using Initial Segment only')

subplot(2,1,2)
plot(t_axis1, output_DD_7)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Less Noisy Signal Filtering using All Segments')


%%
audiowrite('output_DD_4.wav', output_DD_4, 48000, 'BitsPerSample',16);
audiowrite('output_DD_5.wav', output_DD_5, 48000, 'BitsPerSample',16);
audiowrite('output_DD_6.wav', output_DD_5, 48000, 'BitsPerSample',16);
audiowrite('output_DD_7.wav', output_DD_6, 48000, 'BitsPerSample',16);

%% PART II a. Using different windows

output_DD_8 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.025, 0.5);
output_DD_9 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Rec', 1, 1, 0.99, 0.025, 0.5);
output_DD_10 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Black', 1, 1, 0.99, 0.025, 0.5);

figure
subplot(3,1,1)
plot(t_axis1, output_DD_8)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Hamming Window')

subplot(3,1,2)
plot(t_axis1, output_DD_9)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Rectangular Window')

subplot(3,1,3)
plot(t_axis1, output_DD_10)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Blackman Window')



audiowrite('output_DD_8.wav', output_DD_8, 48000, 'BitsPerSample',16);
audiowrite('output_DD_9.wav', output_DD_9, 48000, 'BitsPerSample',16);
audiowrite('output_DD_10.wav', output_DD_10, 48000, 'BitsPerSample',16);


%% PART II b Changing window length ONLY

output_DD_11 = Wiener_RVD1(SigNoiseLess, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.0005, 0.5);
output_DD_12 = Wiener_RVD1(SigNoiseLess, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.15, 0.5);

output_DD_13 = Wiener_RVD1(SigNoiseLess, fs, 'Decision', 0.15, 'Rec', 1, 1, 0.99, 0.0005, 0.5);
output_DD_14 = Wiener_RVD1(SigNoiseLess, fs, 'Decision', 0.15, 'Rec', 1, 1, 0.99, 0.15, 0.5);


samples2 = length(output_DD_11);
samples3 = length(output_DD_12);
t_axis2 = ((0:(samples2-1))/fs)*1000;
t_axis3 = ((0:(samples3-1))/fs)*1000;

figure
subplot(3,1,1)
plot(t_axis2, output_DD_11)
xlim([0, t_axis2(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Hamming Window, Short Window Length')

subplot(3,1,2)
plot(t_axis1, output_DD_8)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Hamming Window, Ideal Window Length')

subplot(3,1,3)
plot(t_axis3, output_DD_12)
xlim([0, t_axis3(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Hamming Window, Long Window Length')


figure
subplot(3,1,1)
plot(t_axis2, output_DD_13)
xlim([0, t_axis2(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Rectangular Window, Short Window Length')

subplot(3,1,2)
plot(t_axis1, output_DD_9)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Rectangular Window, Ideal Window Length')

subplot(3,1,3)
plot(t_axis3, output_DD_14)
xlim([0, t_axis3(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Rectangular Window, Long Window Length')


audiowrite('output_DD_11.wav', output_DD_11, 48000, 'BitsPerSample',16);
audiowrite('output_DD_12.wav', output_DD_12, 48000, 'BitsPerSample',16);

% Demonstration of time-frequency tradeoff

fft_shortwindow = fftshift(abs(fft(output_DD_13)));
fft_idealwindow = fftshift(abs(fft(output_DD_8)));

f_axis1 = [0:fs/(length(fft_shortwindow)):fs-(fs/length(fft_shortwindow))];
fs_axis1 = f_axis1-fs/2;

f_axis2 = [0:fs/(length(fft_idealwindow)):fs-(fs/length(fft_idealwindow))];
fs_axis2 = f_axis2-fs/2;

figure
subplot(3,1,3)
plot(fs_axis1,fft_shortwindow)
ylabel('Magnitude')
xlim([-2000 2000])
xlabel('Frequency (Hz)')
title('FFT of Shorter Windowed Signal')

subplot(3,1,2)
plot(fs_axis2,fft_idealwindow)
ylabel('Magnitude')
xlabel('Frequency (Hz)')
xlim([-2000 2000])
title('FFT of Ideally Windowed Signal')

subplot(3,1,1)
plot(fs_axis,sigOG_fft)
ylabel('Magnitude')
xlabel('Frequency (Hz)')
xlim([-2000 2000])
title('FFT of Clean Signal')




%% PART II c Changing Overlap 

% Overlap only

output_DD_14 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.025, 0.20);
output_DD_15 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.025, 0.80);


samples4 = length(output_DD_14);
samples5 = length(output_DD_15);
t_axis4 = ((0:(samples4-1))/fs)*1000;
t_axis5 = ((0:(samples5-1))/fs)*1000;


figure
subplot(3,1,1)
plot(t_axis4, output_DD_14)
xlim([0, t_axis4(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering with Higher Window Overlap')

subplot(3,1,2)
plot(t_axis1, output_DD_8)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering with Moderate Window Overlap')

subplot(3,1,3)
plot(t_axis5, output_DD_15)
xlim([0, t_axis5(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering with Lower Window Overlap')


audiowrite('output_DD_14.wav', output_DD_14, 48000, 'BitsPerSample',16);
audiowrite('output_DD_15.wav', output_DD_15, 48000, 'BitsPerSample',16);

fft_shortshift = fftshift(abs(fft(output_DD_14)));
fft_midshift = fftshift(abs(fft(output_DD_8)));
fft_longshift = fftshift(abs(fft(output_DD_15)));

f_axis3 = [0:fs/(length(fft_shortshift)):fs-(fs/length(fft_shortshift))];
fs_axis3 = f_axis3-fs/2;

f_axis4 = [0:fs/(length(fft_midshift)):fs-(fs/length(fft_midshift))];
fs_axis4 = f_axis4-fs/2;

f_axis5 = [0:fs/(length(fft_longshift)):fs-(fs/length(fft_longshift))];
fs_axis5 = f_axis5-fs/2;

figure
subplot(3,1,1)
plot(fs_axis1,fft_shortwindow)
ylabel('Magnitude')
xlim([-2000 2000])
xlabel('Frequency (Hz)')
title('FFT of Higher Overlap Signal')

subplot(3,1,2)
plot(fs_axis2,fft_idealwindow)
ylabel('Magnitude')
xlabel('Frequency (Hz)')
xlim([-2000 2000])
title('FFT of Moderate Overlap Signal')

subplot(3,1,3)
plot(fs_axis5,fft_longshift)
ylabel('Magnitude')
xlabel('Frequency (Hz)')
xlim([-2000 2000])
title('FFT of Lower Overlap Signal')

% Attempt to change both parameters, induced distortion

%{

output_DD_16 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.0125, 0.8);
output_DD_17 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.75, 0.05, 0.25);

samples6 = length(output_DD_16);
samples7 = length(output_DD_17);
t_axis6 = ((0:(samples6-1))/fs)*1000;
t_axis7 = ((0:(samples7-1))/fs)*1000

subplot(2,1,1)
plot(t_axis6, output_DD_16)
ylabel('Magnitude')
xlim([-2000 2000])
xlabel('Frequency (Hz)')
title('Window Length 0.0125, Shift Percentage 0.8')

subplot(2,1,2)
plot(t_axis7, output_DD_17)
ylabel('Magnitude')
xlabel('Frequency (Hz)')
xlim([-2000 2000])
title('Window Length 0.05, Shift Percentage 0.25')
%}

%% PART III a. Changing Alpha

output_DD_18 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.025, 0.5);
output_DD_19 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.75, 0.025, 0.5);
output_DD_20 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.25, 0.025, 0.5);
%output_DD_21 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 0.25, 0.25, 0.025, 0.5);

figure
subplot(3,1,1)
plot(t_axis1, output_DD_18)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using High Alpha value')

subplot(3,1,2)
plot(t_axis1, output_DD_19) 
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Moderate Alpha value')

subplot(3,1,3)
plot(t_axis1, output_DD_20)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Low Alpha value')

%{
figure
subplot(2,1,1)
plot(t_axis1, output_DD_20)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal filtering with lowest Alpha')

subplot(2,1,2)
plot(t_axis1, output_DD_21)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal filtering with lowest Alpha and Changed Rho')

%}

audiowrite('output_DD_18.wav', output_DD_18, 48000, 'BitsPerSample',16);
audiowrite('output_DD_19.wav', output_DD_19, 48000, 'BitsPerSample',16);
audiowrite('output_DD_20.wav', output_DD_20, 48000, 'BitsPerSample',16);
% audiowrite('output_DD_21.wav', output_DD_21, 48000, 'BitsPerSample',16);


%% PART III b. Changing Rho

output_SS_5 = Wiener_RVD1(SigNoise, fs, 'Spectral', 0.15, 'Ham', 1, 0.99, 0.99, 0.025, 0.5);
output_SS_6 = Wiener_RVD1(SigNoise, fs, 'Spectral', 0.15, 'Ham', 1, 0.75, 0.99, 0.025, 0.5);
output_SS_7 = Wiener_RVD1(SigNoise, fs, 'Spectral', 0.15, 'Ham', 1, 0.25, 0.99, 0.025, 0.5);
%%
figure
subplot(3,1,1)
plot(t_axis1, output_SS_5)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using High Rho value')

subplot(3,1,2)
plot(t_axis1, output_SS_6)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Moderate Rho value')

subplot(3,1,3)
plot(t_axis1, output_SS_7)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal Filtering using Low Rho value')


audiowrite('output_SS_5.wav', output_SS_5, 48000, 'BitsPerSample',16);
audiowrite('output_SS_6.wav', output_SS_6, 48000, 'BitsPerSample',16);
audiowrite('output_SS_7.wav', output_SS_7, 48000, 'BitsPerSample',16);



%% PART IV a. SNR vs performance


output_DD_21 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.025, 0.5);
output_DD_22 = Wiener_RVD1(SigNoiseLess, fs, 'Decision', 0.15, 'Ham', 1, 1, 0.99, 0.025, 0.5);

figure

subplot(2,1,1)
plot(t_axis, SigNoise)
xlim([0, t_axis(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Noisy Signal')


subplot(2,1,2)
plot(t_axis1, output_DD_21)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Decision Directed Performance with Lower SNR')

figure
subplot(2,1,1)
plot(t_axis, SigNoiseLess)
xlim([0, t_axis(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Less Noisy Signal')

subplot(2,1,2)
plot(t_axis1, output_DD_22)
xlim([0, t_axis1(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Decision Directed Performance on Higher SNR')


audiowrite('output_DD_21.wav', output_DD_21, 48000, 'BitsPerSample',16);
audiowrite('output_DD_22.wav', output_DD_22, 48000, 'BitsPerSample',16);



%% PART IV b. Wiener Filtering on Clean Signal


output_DD_23 = Wiener_RVD1(SigOG, fs, 'Decision', 0.15, 'Ham', 1, 0.5, 0.5, 0.15, 0.5);
samples4 = length(output_DD_23);
t_axis4 = ((0:(samples4-1))/fs)*1000;

figure
subplot(2,1,1)
plot(t_axis, SigOG)
xlim([0, t_axis(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Clean Signal')

subplot(2,1,2)
plot(t_axis4, output_DD_23)
xlim([0, t_axis4(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Filtered Clean Signal')


%% BEST DENOISED ATTEMPT


output_DD_24 = Wiener_RVD1(SigNoise, fs, 'Decision', 0.15, 'Ham', 1, 0.99, 0.99, 0.020, 0.5);
output_DD_25 = Wiener_RVD1(SigNoiseLess, fs, 'Decision', 0.15, 'Ham', 1, 0.99, 0.99, 0.020, 0.5);

samples8 = length(output_DD_24);
samples9 = length(output_DD_25);
t_axis8 = ((0:(samples8-1))/fs)*1000;
t_axis9 = ((0:(samples9-1))/fs)*1000;

figure
subplot(3,1,1)
plot(t_axis, SigOG)
xlim([0, t_axis(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Clean Signal')

subplot(3,1,2)
plot(t_axis8, output_DD_24)
xlim([0, t_axis8(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Filtered Best Denoised Less Noisy Signal')


subplot(3,1,3)
plot(t_axis9, output_DD_25)
xlim([0, t_axis9(end)])
ylabel('Amplitude')
xlabel('Time (ms)')
title('Filtered Best Denoised Noisy Signal')

audiowrite('output_DD_24.wav', output_DD_24, 48000, 'BitsPerSample',16);
audiowrite('output_DD_25.wav', output_DD_25, 48000, 'BitsPerSample',16);


% 0.2, 0.99 - some time distortion