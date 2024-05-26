%{
IMAGING HW#3 – PROBLEM 3 – DUE OCT 21, 2022 via UPLOAD IN CANVAS.
For this problem:
1-	Load the DICOM data using MATLAB’s “dicomread”. Then read the info contained in the dicom file using MATLAB’s “dicominfo”. What is the repetition time and echo time of the sequence used? What was the resolution? At what magnetic field (B0) was this image acquired?
2-	Load the raw k-space data from the “series36Raw.mat” file. Select the fourth slice. Compute the inverse Fourier transform to reconstruct the image. Plot figures showing the k-space and the image.
3-	Subsampling the k-space causes aliasing in the image domain. Subsample the k-space (e.g. with a factor of two: select every other line) in the phase encoding direction. Reconstruct the image to demonstrate the effect of subsampling.
4-	Spikes in k-space cause banding in the image space. To create a spike in k-space, increase the amplitude of a point in k-space. 
Create a ?spike near center of the k-space and then reconstruct the image.
Create a spike near the edge of the k-space and then reconstruct the image.
Plot figures for the two images. Which spike (central or edge) corresponds to high frequency bands and which to low frequency bands?
%}

%%%% 1. 
dcmfile = fullfile(pwd, 'MR-ST001-SE036-0004.dcm');

img = dicomread(dcmfile);

info = dicominfo(dcmfile)

% TR, TE, Resoln, Mag Field
% TR = 10 s
% TE = 3 s
% field = 3T
% Res = 256, 256, 12

%%%% 2. 
load('series36Raw.mat'); 

ksp_4 = ksp(:,:,4);  % loading 4th slice
slice_4 = fftshift(ifft2(ifftshift(ksp_4)));

figure; imagesc(abs(ksp_4)), colormap(gray) ,title('2. 4th slice k-space')
figure; imagesc(abs(slice_4)), colormap(gray), title('2. 4th slice image')


%%%% 3. 
ksp_subs = ksp(2:2:end,:); % subsampling
ksp_subs_img = fftshift(ifft2(ifftshift(ksp_subs))); % reconstructing the image
figure; imagesc(abs(ksp_subs)), colormap(gray) ,title('3. subsampled k-space')
figure; imagesc(abs(ksp_subs_img)), colormap(gray) ,title('3. subsampled image')


%%% 4. 
ksp_4(124:126,124:126) = 256; % adding centre spike
ksp_cntr = fftshift(ifft2(ifftshift(ksp_4))); % reconstructing the image
figure; imagesc(abs(ksp_4)), colormap(gray) ,title('4. centre spike k-space')
figure; imagesc(abs(ksp_cntr)), colormap(gray) ,title('4. centre spike image')

ksp_4(241:243,241:243) = 256; % adding edge spike
ksp_edge = fftshift(ifft2(ifftshift(ksp_4))); % reconstructing the image
figure; imagesc(abs(ksp_4)), colormap(gray) ,title('4. edge spike k-space')
figure; imagesc(abs(ksp_edge)), colormap(gray) ,title('4. edge spike image')
