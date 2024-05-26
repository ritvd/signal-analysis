function new_data = fit60(fs,data)


% Define time vector
t = 0:(1/fs):(length(data)-1)/fs;
t = t';

% Generate model to fit 60 Hz noise component of signal
f = fittype('a*sin(2*pi*59.9854*x+b)', 'independent', 'x');

% Define fitting & solver options
fit_options = fitoptions('Method','NonLinearLeastSquares');
fit_options.Robust = 'On'; % Less sensitive to non-normal error distribution
fit_options.StartPoint = [0.002 0]; % Set initial values for iterative solver 
% for the 'a' and 'b' coefficients in fitting equation above. Play around
% with this depending on visual inspection of the 60 Hz signal.

% Ignore data points inside the specified time range by ExcludeTRange
outliers = ~excludedata(t,data,'domain', [0.2,0.7]);  % ~ means do opposite so INCLUDE in this case
fit_options.Exclude = outliers;

% Fit data to the model 'f', using options defined above in fit_options
my_fit = fit(t,data,f,fit_options);

% Generate modeled 60 Hz Noise
NoiseSignal = (my_fit.a)*sin(2*pi*59.9854.*t+(my_fit.b));

% Signal = (Signal+Noise) - Noise
new_data = data-NoiseSignal;



end
