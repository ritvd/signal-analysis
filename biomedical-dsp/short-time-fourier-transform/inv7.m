function a = inv7(b,hop,fs)

[nfft,nframes] = size(b);

No2 = nfft/2; % nfft assumed even
a = zeros(1, nfft+(nframes-1)*hop);
xoff = 0 - No2; % output time offset = half of FFT size
for col = 1:nframes
  fftframe = b(:,col);
  xzp = ifft(fftframe);
  frlen = length(fftframe); % frame length
  f = (0:nfft-1)*fs/nfft;
  fmin = 800;
  fmax = fs/2;
  noise_ind = find(abs(fftframe)>3);
  fval = zeros(1,length(noise_ind));
  for i = 1:length(noise_ind)
      fval(1,i) = f(1,noise_ind(i,1));
  end

   valid_freq = fval(fval>fmin & fval<fmax);
   l_th = min(valid_freq);
   h_th = max(valid_freq);


  % xzp = real(xzp); % if signal known to be real
  x = [xzp(nfft-No2+1:nfft); xzp(1:No2)];

   if l_th ~=0 & h_th ~=0 & l_th < h_th
       x = bandstop(x,[l_th h_th],fs);
       [d,c] = butter(12,1000/(fs/2),"low");
       x = filter(d,c,x);
   end
   if col > 600
       [d,c] = butter(12,0.05,'low');
       x = filter(d,c,x);
   end

  if xoff<0 % FFT's "negative-time indices" are out of range
    ix = 1:xoff+nfft;
    a(ix) = a(ix) + x(1-xoff:nfft)'; % partial frames out
  else
    ix = xoff+1:xoff+nfft;
    a(ix) = a(ix) + x';  % overlap-add reconstruction
  end
  xoff = xoff + hop;
end











