
%
% Rithika Varma Dandu
% Biomedical DSP - HW4
% 

%% QUESTION - 1

figure
Ts = 1/fs; 
N = length(DataOG);
t_axis = [0:1/fs:(N-1)/fs];
subplot(2,1,1)
plot(t_axis,DataOG)
xlim([0 t_axis(end)])
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Clean Signal - DataOG')
subplot(2,1,2)
plot(t_axis,Data60Hz)
xlim([0 t_axis(end)])
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Noisy Signal - Data60Hz')

% The last value in the time axis is 200 miliseconds


%% QUESTION 2

figure
fft_OG = abs(fft(DataOG));
f_axis = 0:fs/(length(fft_OG)):fs-(fs/length(fft_OG)); % Hz
%subplot(2,1,1)
%plot(f_axis,fft_OG)
%xlabel('Frequency (Hz)')
fft_OG_shift = fftshift(fft_OG);
fs_axis  = f_axis-fs/2;
subplot(2,1,1)
plot(fs_axis,fft_OG_shift)
xlim([-300 300])
title('FFT of Clean Signal - DataOG')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(2,1,2)
fft_60Hz = abs(fft(Data60Hz));
fft_60_shift = fftshift(fft_60Hz);
plot(fs_axis,fft_60_shift)
xlim([-300 300])
title('FFT of Noisy Signal - Data60Hz')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

%Visualize 60Hz noise
figure
plot(fs_axis,fft_60_shift)
xlim([-100 100]) 


%Just a single major peak
%[max_value, max_index] = max(fft_60_shift);
%f = fs_axis(max_index(1))

spike_index = find(fft_60_shift==max(fft_60_shift));
spike_index = spike_index(2);
f = fs_axis(spike_index)

% The frequency is 60Hz frequency indeed, at f = 59.9854Hz

y1 = filter(HdNeural_2,Data60Hz); 
y2 = filter(HdNeural_2,DataOG)

figure
subplot(2,1,1)
plot(t_axis,y1)
xlim([0 t_axis(end)])
title('Filtered Signal - Data60Hz')
xlabel('Frequency (Hz)')
ylabel('Voltage (V)')
subplot(2,1,2)
plot(t_axis,DataOG)
xlim([0 t_axis(end)])
title('Filtered Signal - DataOG')
xlabel('Frequency (Hz)')
ylabel('Voltage (V)')

%% QUESTION 3 

y_neural3 = filter(Hd_Neural3,Data60Hz); 

figure
plot(t_axis,y_neural3)
xlim([0 t_axis(end)])
title('Filtered Signal - Data60Hz')
xlabel('Frequency (Hz)')
ylabel('Voltage (V)')



%% QUESTION 4

figure
subplot(2,1,1)
plot(t_axis, Data60Hz)
xlim([0 t_axis(end)])
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Noisy Signal - Data60Hz')
subplot(2,1,2)
fitted60 = fit60(fs,Data60Hz)
plot(t_axis,fitted60)
xlim([0 t_axis(end)])
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Clean, Fitted Signal')

figure
subplot(2,1,1)
plot(t_axis, Data60Hz)
xlim([0 t_axis(end)])
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Noisy Signal - Data60Hz')
subplot(2,1,2)
fitted60 = fit60(fs,Data60Hz)

y3 = filter(Hd2,fitted60)
plot(t_axis,y3)
xlim([0 t_axis(end)])
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Clean, Fitted and Filtered Signal')


plot(fs_axis, fftshift(abs(fft(fitted60))))
title('Real Sig')
xlim([-300 300])


%% QUESTION 5

y3 = filter(Hd_Neural5,Data60Hz)
y4 = filter(Hd_Neural5,DataOG)

figure
subplot(2,1,1)
plot(t_axis,y3)
xlim([0.04 0.055])
xticks(linspace(0.04, 0.055, 16)); % Set x-axis ticks to show 10 evenly spaced points
title('Noisy Signal - with 60 Hz Noise')
xlabel('Time (s)')
ylabel('Voltage (V)')
subplot(2,1,2)
plot(t_axis,y4)
xlim([0.04 0.055]) 
title('Clean Signal - without 60 Hz Noise')
xticks(linspace(0.04, 0.055, 16)); % Set x-axis ticks to show 10 evenly spaced points
xlabel('Time (s)')
ylabel('Voltage (V)')
