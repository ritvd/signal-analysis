%{
Q3. Load the Fluorescence image into Matlab and develop a script that can change the SNR by adding various 
    level of image noise. Develop functionality to simulate Gaussian noise, Poisson Noise and Impulse Noise. 
    First, estimate the SNR of the image and then reduce the SNR by 50% and 90%.
%}


clc;
clear all;

img = imread('Fluorescence_image_HW1','png');
img = rgb2gray(img);
figure;
subplot(1,2,1); imshow(img); title('Fluorescence image');
subplot(1,2,2); imhist(img); title('Image Histogram');

noise = img <=25; % to differentiate between signal and noise 
signal = img >25;

img_noise = double(img(noise)); % for SNR calculation, later on
img_signal = double(img(signal));


% verifying the regions of image and noise 
%{
figure;
subplot(2,2,1); imshow(noise)
subplot(2,2,2); imshow(signal)
%}


img_SNR = mean(img_signal(:))/std(img_noise(:)) % SNR = 23.7222

% to degrade SNR by 50%, it has to come to approx. 11.861, and for 90% degradation it has to come to approx. 2.372



%%%    1. Gaussian ; 

% We can define coefficients to alter the variance of the Gaussian noise in the imnoise function

gauss_coeff_1 = 0.0008; 
gauss_coeff_2 = 0.0399; 

img_gauss_1 = imnoise(uint8(img),'gaussian',0,gauss_coeff_1);
img_gauss_2 = imnoise(uint8(img),'gaussian',0,gauss_coeff_2);


figure;
subplot(1,2,1); imshow((img_gauss_1)); title('Gaussian: 50%')
subplot(1,2,2); imshow((img_gauss_2)); title('Gaussian: 90%')


img_gauss_1 = double(img_gauss_1);
img_gauss_2 = double(img_gauss_2);

gauss_SNR_1 = mean(img_gauss_1(signal)) / std(img_gauss_1(noise)) 
gauss_SNR_2 = mean(img_gauss_2(signal)) / std(img_gauss_2(noise))



%%%     2. Poisson Noise ; 

% Since imnoise has no parameters that can directly tweak Poisson noise values, we can use the function 
% poissrnd (Statistics & Machine Learning toolbox) to generate Poisson noise instead


img_pois_1 = img + uint8(poissrnd(20,size(img)));
%figure; imhist(img_pois_1);title('Poisson Threshold = 40')
pois_thres_1 = 40;
pois_signal_1 = img >= pois_thres_1;
pois_noise_1 = img < pois_thres_1;


img_pois_2 = img + uint8(poissrnd(150,size(img)));
%figure; imhist(img_pois_2);title('Poisson Threshold = 150')
pois_thres_2 = 210;
pois_signal_2 = img >= pois_thres_2;
pois_noise_2 = img < pois_thres_2;


figure;
subplot(1,2,1); imshow((img_pois_1)); title('Poisson: 50%')
subplot(1,2,2); imshow((img_pois_2)); title('Poisson: 90%')


poiss_signal_mean1 = mean(img_pois_1(pois_signal_1));
poiss_noise_std1 = std(double(img_pois_1(pois_noise_1)));
poiss_SNR_1 = poiss_signal_mean1/poiss_noise_std1

poiss_signal_mean2 = mean(img_pois_2(pois_signal_2));
poiss_noise_std2 = std(double(img_pois_2(pois_noise_2)));
poiss_SNR_2 = poiss_signal_mean2/poiss_noise_std2



%%%     3. Impulse Noise,
% modulating the noise density using coefficients
 
impls_coeff_1 = 0.000825; 
impls_coeff_2 = 0.033;

img_impls_1 = imnoise(uint8(img),'salt & pepper',impls_coeff_1); % reduction of SNR from initial calculation
img_impls_2 = imnoise(uint8(img),'salt & pepper',impls_coeff_2); % reduction of SNR from initial calculation

figure;
subplot(1,2,1); imshow((img_impls_1)); title('Impulse: 50%')
subplot(1,2,2); imshow((img_impls_2)); title('Impulse: 90%')

img_impls_1 = double(img_impls_1);
img_impls_2 = double(img_impls_2);


impls_SNR_1 = mean(img_impls_1(signal)) / std(img_impls_1(noise))
impls_SNR_2 = mean(img_impls_2(signal)) / std(img_impls_2(noise))

