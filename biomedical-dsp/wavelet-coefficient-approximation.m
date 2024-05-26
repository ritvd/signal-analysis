
%
% Rithika Varma Dandu
% Biomedical DSP - HW8
% 

%{
Write a simple Matlab program that will implement a two-stage analysis filterbank tree using the Haar
filter. In other words, in class we saw that obtaining the Haar coefficients simply requires us to take our
samples, f[n], and feed it through two different filters to obtain our cj[k] and dj[k] coefficients. To do
this, we are first approximating our highest resolution coefficients cj+1[k] with our samples f[n] (wavelets
results in an approximation of our original signal that becomes more accurate with higher sampling
frequency). “Two-stage” means you do this 2 times so in the end, you should have 4 sets of coefficient
values (cj[k], dj[k], cj-1[k], dj-1[k]). You only need dj[k], dj-1[k], cj-1[k] to represent your signal f[n].
Apply this to a simple sinusoidal signal f[n] = sin(π*[1:128]/8). Plot each of the outputs and also sketch
the filterbank representation for both stages. Please indicate which part of the filterbank schematic
corresponds to which set of coefficients. Keep in mind that this filterbank method enables you to use the
“conv” function in Matlab to efficiently obtain your coefficients. You will need to identify the filters h[n]
and h1[n]. h[n] is provided on page 13 of Chapter 2. You can calculate h1[n] from equation 2.25.
One confusing aspect of these equations is that you end up getting more coefficients after each filtering
stage (artificially using “conv” in Matlab rather than the original equations (3) and (4) provided in class
that results in a length = N + P – 1). For Haar Wavelets it is not as bad since P is only 2, but for other
Wavelets, P can be much longer. You just need to keep track of the number of coefficients you should
have (usually half of the # from the previous stage unless you start with an odd # of coefficients in which
you will have 1 extra coefficient at the end that extends past the length of the original signal and
corresponds to a smeared edge value; more information on this below). After the “conv” in Matlab, you
have to downsample by 2 to get the true number of coefficients for each scale (i.e., stage). Please look at
the original equations 3.9 and 3.10 to see which coefficients to keep and which ones to discard when
downsampling. This is tricky because Matlab doesn’t start the “conv” from when both sequences are
initially aligned at index 0 but places the h[-n] or h1[-n] filters so that they are starting before with only 1
overlapping sample (think about what “conv” in Matlab does versus equations (3) and (4)). Also Matlab
doesn’t keep track of the indices, so you need to keep track of this. As a result, you need to discard the
first few samples depending on the length of your h[-n] or h1[-n] filters. For the Haar Wavelets, since the
filters are only a length of 2, it really only means you eliminate the first sample after each filtering. If I
just confused you, come to office hours or email me.
Another thing to note is that although your signal may be from 0 to N seconds (or samples), your
coefficients may span a larger time period than your original signal depending on your scaling/wavelet
functions. In other words, you may have a signal that starts at time 0 seconds with a sudden transient
edge (similarly at the end with a sudden transient edge) but to represent that with a certain set of
scaling/wavelet functions, you actually need, for example, a few functions at -2 and -1 seconds to sum up
together with the functions at 0, 1, 2 seconds to get that transient component occurring at 0 seconds (hope
I didn’t just confuse you). If your scaling/wavelet functions span a longer time period (unlike the Haar
functions which are quite localized in time with only 2 filter coefficients), then there will be even more
coefficients for the times before and after your original signal period. Indirectly you can see this by
equations 3.9 and 3.10 that lead to more coefficients at each stage (for negative k values and k values
exceeding your signal duration of N samples), especially for longer h[n] and h1[n] filters. In class we left
the index “m” without any actual limits to keep this flexible. I made notes in class that “m” generally
corresponds to 0 to the length of your cj-1[k] sequence. Also that “k” goes up to half the length of your
cj-1[k] sequence. However, this all depends on if you just want to display the coefficients aligned with
your original signal or some of the “before” and “after” transient coefficients to fully represent your
original sequence including the edges. Please keep track of which coefficients correspond to which time
point in your original signal. This is probably the most confusing part of calculating the coefficients.
Although the Matlab wavelets toolbox computes the coefficients for you, it still results in more
coefficients than your original signal that you have to keep track of in terms of which coefficients
correspond to which time point.

%}



xn = sin(pi*[1:128]/8);


h0 = [1/sqrt(2) 1/sqrt(2)]
h1 = [1/sqrt(2) -1/sqrt(2)]

h0 = flip(h0)
h1 = flip(h1)

c1 = conv(xn,h0);
c1 = c1(2:2:end);

d1 = conv(xn,h1);
d1 = d1(2:2:end);


figure
subplot(3,1,1)
stem(1:length(xn),xn,'MarkerFaceColor', 'magenta', 'MarkerEdgeColor', 'black', 'Color', 'magenta')
xlim([1 length(xn)]);
xlabel('n')
ylabel('Amplitude, x(n)')
title('Input Signal')

subplot(3,1,2)
stem(1:length(c1),c1,'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'black', 'Color', 'blue');
xlim([1 length(c1)]);

hold on
stem(1:length(d1),d1,'MarkerFaceColor', 'red', 'MarkerEdgeColor', 'black', 'Color', 'red');
xlim([1 length(d1)]);
title('First Stage Filterbank')
xlabel('n')
ylabel('Coefficient Values')
legend('Approximation Coefficients Cj','Detail Coefficients Dj')
hold off


c0 = conv(c1,h0);
c0 = c0(2:2:end);

d0 = conv(c1,h1);
d0 = d0(2:2:end);

subplot(3,1,3)
stem(1:length(c0),c0,'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'black', 'Color', 'blue');
xlim([1 length(c0)]);
hold on
stem(1:length(d0),d0,'MarkerFaceColor', 'red', 'MarkerEdgeColor', 'black', 'Color', 'red');
xlim([1 length(d0)]);
title('Second Stage Filterbank')
xlabel('n')
ylabel('Coefficient Values')
legend('Approximation Coefficients Cj-1','Detail Coefficients Dj-1')
hold off
