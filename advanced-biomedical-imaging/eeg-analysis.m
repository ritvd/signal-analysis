%% 1. Read the description.
%% 2. Upload the data into matlab. The structure includes the data matrix X (time-samples x channels) and y (events in sample space).

a03 = importdata('A03.mat');
a04 = importdata('A04.mat');
a06 = importdata('A06.mat');

patient = a06; % change this to change which patient's data is being viewed

X = patient.X; % selected patient's channels and time samples
Y = patient.y; % selected patient's events 

%% 3. Find the onset of events '1' and '2'.

[pks,locs,w,p] = findpeaks(Y); % locs is the location of each peak, and pks is the corresponding peak (1 or 2)
nt = 1; % indexing for non target
t = 1; % indexing for target 
for i = 1:length(pks)
    if pks(i)==1
        nt_locs(nt) = locs(i); % storing the locations of non target stimuli
        nt = nt + 1;
    else if pks(i)==2
        t_locs(t) = locs(i); % storing the locations of target stimuli
        t = t+1;
    else continue
    end
    end
end


%% 4. Cut the EEG in epochs ranging from 0.5 seconds before each event to 1 second after. Note that the sampling frequency is 256 Hz.

% for non target stimuli i.e. event 1 stimuli
for i = 1:length(nt_locs)
    ep_start = nt_locs(i) - 128; % start of the epoch
    ep_end = nt_locs(i) + 256; % end of the epoch
    % non target epochs, for each channel
    nt_c1(:,i) = X(ep_start:ep_end,1)'; 
    nt_c2(:,i) = X(ep_start:ep_end,2)';
    nt_c3(:,i) = X(ep_start:ep_end,3)';
    nt_c4(:,i) = X(ep_start:ep_end,4)';
    nt_c5(:,i) = X(ep_start:ep_end,5)';
    nt_c6(:,i) = X(ep_start:ep_end,6)';
    nt_c7(:,i) = X(ep_start:ep_end,7)';
    nt_c8(:,i) = X(ep_start:ep_end,8)';
end

for i = 1:length(t_locs)
    ep_start = t_locs(i) - 128;
    ep_end = t_locs(i) + 256;
    % target epochs, for each channel
    t_c1(:,i) = X(ep_start:ep_end,1)';
    t_c2(:,i) = X(ep_start:ep_end,2)';
    t_c3(:,i) = X(ep_start:ep_end,3)';
    t_c4(:,i) = X(ep_start:ep_end,4)';
    t_c5(:,i) = X(ep_start:ep_end,5)';
    t_c6(:,i) = X(ep_start:ep_end,6)';
    t_c7(:,i) = X(ep_start:ep_end,7)';
    t_c8(:,i) = X(ep_start:ep_end,8)';
end 

% averaging non target per channel

nt_c1_mean = mean(nt_c1,2)';
nt_c2_mean = mean(nt_c2,2)';
nt_c3_mean = mean(nt_c3,2)';
nt_c4_mean = mean(nt_c4,2)';
nt_c5_mean = mean(nt_c5,2)';
nt_c6_mean = mean(nt_c6,2)';
nt_c7_mean = mean(nt_c7,2)';
nt_c8_mean = mean(nt_c8,2)';

% averaging target per channel

t_c1_mean = mean(t_c1,2)';
t_c2_mean = mean(t_c2,2)';
t_c3_mean = mean(t_c3,2)';
t_c4_mean = mean(t_c4,2)';
t_c5_mean = mean(t_c5,2)';
t_c6_mean = mean(t_c6,2)';
t_c7_mean = mean(t_c7,2)';
t_c8_mean = mean(t_c8,2)';

%% 5. Average the epochs for both target and non-target stimuli. Plot the difference.


nt_mean(:,1) = mean(nt_c1');
nt_mean(:,2) = mean(nt_c2');
nt_mean(:,3) = mean(nt_c3');
nt_mean(:,4) = mean(nt_c4');
nt_mean(:,5) = mean(nt_c5');
nt_mean(:,6) = mean(nt_c6');
nt_mean(:,7) = mean(nt_c7');
nt_mean(:,8) = mean(nt_c8');

t_mean(:,1) = mean(t_c1');
t_mean(:,2) = mean(t_c2');
t_mean(:,3) = mean(t_c3');
t_mean(:,4) = mean(t_c4');
t_mean(:,5) = mean(t_c5');
t_mean(:,6) = mean(t_c6');
t_mean(:,7) = mean(t_c7');
t_mean(:,8) = mean(t_c8');

% the difference between the two types of stimuli:

c1 = t_c1_mean - nt_c1_mean;
c2 = t_c2_mean - nt_c2_mean;
c3 = t_c3_mean - nt_c3_mean;
c4 = t_c4_mean - nt_c4_mean;
c5 = t_c5_mean - nt_c5_mean;
c6 = t_c6_mean - nt_c6_mean;
c7 = t_c7_mean - nt_c7_mean;
c8 = t_c8_mean - nt_c8_mean;

% plotting all of the above

plot(c1)
hold on
plot(c2)
plot(c3)
plot(c4)
plot(c5)
plot(c6)
plot(c7)
plot(c8)
legend(patient.channels)
hold off


