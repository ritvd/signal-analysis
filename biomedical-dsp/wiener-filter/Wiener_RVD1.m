function output = Wiener_RVD1(signal, fs, method, init, win_type, start_only, rho, alpha, win_len, shift_p)


% signal: input signal i.e. SigNoisy or SigLessNoisy
% fs: 48828.125 Hz
% noise_method: the method desired for noise removal, input:
  %  Decision  for Decision Directed, 
  %  Spectral  for Spectral Subtraction 
% init: the length of the initial segment in seconds 
% win_type: Type of window used, input
  %  Ham  for Hamming,
  %  Rec, for Rectangular,
  %  Black  for Blackman,
  %  Kai  for Kaiser,
  %  Tri, for Triangular,
  %  Hann  for Hann
% start_only: method to compute noise PSD, input
  % 1 for using the initial segment only
  % 0 for using the entire signal 
% rho: weight of non-ideal estimate of current SNR. 
% alpha: weight of ideal estimate of old SNR. 
% win_len: Length of the window 
% shift_p: Percentage shift of the window 

% WINDOW PROPERTIES DEFINED HERE

W=fix(win_len*fs);
% window selection 
if (win_type == 'Ham')
    wnd=hamming(W);
elseif (win_type == 'Rec')
    wnd = rectwin(W);
elseif (win_type == 'Black')
    wnd = blackman(W);
elseif (win_type=='Kai')
    wnd = kaiser(W);
elseif (win_type == 'Tri')
    wnd = triang(W);
elseif (win_type == 'Hann')
    wnd = hann(W);
else
    disp('Invalid input for ''win_type''');
end


pre_emph=0;
signal=filter([1 -pre_emph],1,signal); % pre_emph=0 just causes this to be an all pass unity filter for this example

n_init=fix((init*fs-W)/(shift_p*W) +1); % number of initial silence segments

% STAGE I: SEGMENT AND WINDOW

y=segment(signal,W,shift_p,wnd);  % returns segments of the signal based on the window type, length, shift

FFTLen = 8*W; % zero padding, N >>> L > R
Y=fft(y,FFTLen);
YPhase=angle(Y(1:fix(end/2)+1,:)); % phase of the Noisy Speech signal segment, used for reconstruction later
Y=abs(Y(1:fix(end/2)+1,:)); % spectrogram
numberOfFrames=size(Y,2); 
FreqResol=size(Y,1);

N=mean(Y(:,1:n_init)')'; % mean of the initial segments 

LambdaD=mean((Y(:,1:n_init)').^2)';% estimating the variance for the initial segments

NoiseCounter=0;
NoiseLength=9;
G=ones(size(N)); 
Gamma=G;
PyyOld = LambdaD; % initial segments are noise, so old Pyy can be set to the PSD of the noise and later be updated

X=zeros(size(Y)); 

h=waitbar(0,'Wait...');


% STAGE III: SPEECH/NOISE DETECTION. VAD = Voice Activity Detection


for i=1:numberOfFrames
    if i<=n_init % silent segment
        SpeechFlag=0;
        NoiseCounter=100; 
    else % VAD
        if( start_only==1 )
            SpeechFlag=1;  
        else
            [NoiseFlag, SpeechFlag, NoiseCounter, Dist]=vad(Y(:,i),N,NoiseCounter); 
        end
    end

    if SpeechFlag==0 % if not speech (OR) start_only disabled, noise parameters need to be updated during the signal
        N=(NoiseLength*N+Y(:,i))/(NoiseLength+1); % updating noise mean
        LambdaD=(NoiseLength*LambdaD+(Y(:,i).^2))./(1+NoiseLength); % updatng noise variance
    end 
    
    if( method== 'Decision' ) % do decision directed
        gammaNew=(Y(:,i).^2)./LambdaD; % A posteriori SNR 
        xi=alpha*(G.^2).*Gamma+(1-alpha).*max(gammaNew-1,0); 
        Gamma=gammaNew;

    else  
        PyyNew = rho*Y(:,i).^2 + (1-rho)*PyyOld;
        PyyOld = PyyNew;
        xi = (PyyNew - LambdaD)./LambdaD;
    end

    G=(xi./(xi+1));
    X(:,i)=G.*Y(:,i); 
    waitbar(i/numberOfFrames,h,num2str(fix(100*i/numberOfFrames)));
end

close(h);

% reconstuction 

output=OverlapAdd2(X,YPhase,FFTLen,shift_p*W); 
output=filter(1,[1 -pre_emph],output); 



function ReconstructedSignal=OverlapAdd2(XNEW,yphase,FFTLen,ShiftLen);

if ShiftLen~=fix(ShiftLen);
    disp('The shift length has to be an integer as it is the number of samples.')
    disp(['shift length is fixed to ' num2str(ShiftLen)])
end

[FreqRes FrameNum]=size(XNEW);

Spec=XNEW.*exp(j*yphase);


if mod(FFTLen,2) 
    Spec=[Spec;flipud(conj(Spec(2:end,:)))];
else
    Spec=[Spec;flipud(conj(Spec(2:end-1,:)))];
end


sig=zeros((FrameNum-1)*ShiftLen+FFTLen,1);
weight=sig;

for i=1:FrameNum
    start=(i-1)*ShiftLen+1;    
    spec=Spec(:,i);
    sig(start:start+FFTLen-1)=sig(start:start+FFTLen-1)+real(ifft(spec,FFTLen));  
end
ReconstructedSignal=sig;





function Seg=segment(signal,W,shift_p,Window)
if nargin<3
    shift_p=.4;
end
if nargin<2
    W=256;
end
if nargin<4
    Window=hamming(W);
end
Window=Window(:);

L=length(signal);
shift_p=fix(W.*shift_p);
N=fix((L-W)/shift_p +1); 

Index=(repmat(1:W,N,1)+repmat((0:(N-1))'*shift_p,1,W))';
hw=repmat(Window,1,N);
Seg=signal(Index).*hw;



%**************************************************************************
%**************************************************************************



function [NoiseFlag, SpeechFlag, NoiseCounter, Dist]=vad(signal,noise,NoiseCounter,NoiseMargin,Hangover)

if nargin<4
    NoiseMargin=3;
end
if nargin<5
    Hangover=8;
end
if nargin<3
    NoiseCounter=0;
end
    
FreqResol=length(signal);

SpectralDist= 20*(log10(signal)-log10(noise));
SpectralDist(find(SpectralDist<0))=0;

Dist=mean(SpectralDist); 
if (Dist < NoiseMargin) 
    NoiseFlag=1; 
    NoiseCounter=NoiseCounter+1;
else
    NoiseFlag=0;
    NoiseCounter=0;
end

% Detect noise only periods and attenuate the signal     
if (NoiseCounter > Hangover) 
    SpeechFlag=0;    
else 
    SpeechFlag=1; 
end 
