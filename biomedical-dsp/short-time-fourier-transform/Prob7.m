%% PROBLEM 7


t = [0:1/fs:(length(NoisySig)-1)/fs];

figure(1)
subplot(2,1,1);
plot(t,CleanSig);
title('Clean Signal');
xlabel('Time (s)')
ylabel('Amplitude')

subplot(2,1,2);
plot(t,NoisySig);
title('Noisy Signal');
xlabel('Time (s)')
ylabel('Amplitude')

% Spectrograms

R = 250;
N = 8192;
L = 500;

figure
subplot(2,1,1);
myspectrogram(CleanSig,N,fs,rectwin(L),R);
ax = gca;
% ax.YLim = [0 fs/(1e3*2)];
title('Clean Signal spectrogram')

subplot(2,1,2);
myspectrogram(NoisySig,N,fs,rectwin(L),R);
ax = gca;
% ax.YLim = [0 fs/(1e3*2)];
title('Noisy Signal Spectrogram')

% Fitting a signal

%{
filtered_signal = zeros(size(NoisySig));

freq_increase_rate = .01024;
for n = 1:length(t)
    freq = freq_increase_rate * n; 
    sinusoidal_sample = 0.025*sin(2 * pi * freq * t(n)); 
    filtered_signal(n) = NoisySig(n) - sinusoidal_sample;
end

figure
subplot(2,1,1);
plot(t, NoisySig);
title('Noisy Signal');
xlabel('Time (s)')
ylabel('Amplitude')

subplot(2,1,2);
plot(t, filtered_signal);
title('Filtered Signal (Noisy Signal - Fitted Sinusoid)');
xlabel('Time (s)')
ylabel('Amplitude')
audiowrite('E:\Semester II\DSP\HW5\HW5 Files and Extra Docs\HW5 Files and Extra Docs\Cleaned_20.wav', y2, 48000, 'BitsPerSample', 16);
%}




R = 250;
N = 8192;
L = 500;
t = [0:1/fs:(length(NoisySig)-1)/fs];

figure
subplot(2,1,1)
s = myspectrogram(NoisySig,N,fs,hamming(L),R,1);
ax = gca;
ax.YLim = [0 fs/(1e3*2)];
title('Spectrogram, Hamming window, L = 500, R = 250')
subplot(2,1,2)
x = inv7(s,R,fs);
plot(t,x(1:200000));
title('Reconstructed Signal')
xlabel('Time (s)')
ylabel('Amplitude')

audiowrite('E:\Semester II\DSP\HW5\HW5 Files and Extra Docs\HW5 Files and Extra Docs\Cleaned_20.wav', y2, 48000, 'BitsPerSample', 16);
%%

figure
subplot(2,1,1);
plot(t, NoisySig);
title('Noisy Signal');
xlabel('Time (s)')
ylabel('Amplitude')

subplot(2,1,2);
plot(t, x(1:200000));
title('Reconstructed signal from STFT');
xlabel('Time (s)')
ylabel('Amplitude')


%%
y = filter(Num3,1,x);
y2 = filter(Num3_4,1,y);

%audiowrite('E:\Semester II\DSP\HW5\HW5 Files and Extra Docs\HW5 Files and Extra Docs\Cleaned_17.wav', y2, 48000, 'BitsPerSample', 16);

figure
subplot(2,1,1);
plot(t,x(1:200000));
title('Noisy Signal')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(2,1,2);
plot(t,y2(1:200000));
title('Filtered Signal from LPF')
xlabel('Time (s)')
ylabel('Amplitude')
%%

figure
subplot(2,1,1);
plot(t,CleanSig);
title('Clean Signal')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(2,1,2);
plot(t,y2(1:200000));
title('Filtered Signal from LPF')
xlabel('Time (s)')
ylabel('Amplitude')
