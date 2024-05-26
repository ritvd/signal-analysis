function a = invmyspectrogram(b,hop)
%INVMYSPECTROGRAM Resynthesize a signal from its spectrogram.
%   A = INVMYSPECTROGRAM(B,NHOP)
%   B = complex array of STFT values as generated by MYSPECTROGRAM.
%   The number of rows of B is taken to be the FFT size, NFFT.
%   INVMYSPECTROGRAM resynthesizes A by inverting each frame of the 
%   FFT in B, and overlap-adding them to the output array A.  
%   NHOP is the overlap-add offset between successive IFFT frames.
%
%   See also: MYSPECTROGRAM

[nfft,nframes] = size(b);

No2 = nfft/2; % nfft assumed even
a = zeros(1, nfft+(nframes-1)*hop);
xoff = 0 - No2; % output time offset = half of FFT size
for col = 1:nframes
  fftframe = b(:,col);
  xzp = ifft(fftframe);
  % xzp = real(xzp); % if signal known to be real
  x = [xzp(nfft-No2+1:nfft); xzp(1:No2)];
  if xoff<0 % FFT's "negative-time indices" are out of range
    ix = 1:xoff+nfft;
    a(ix) = a(ix) + x(1-xoff:nfft)'; % partial frames out
  else
    ix = xoff+1:xoff+nfft;
    a(ix) = a(ix) + x';  % overlap-add reconstruction
  end
  xoff = xoff + hop;
end










