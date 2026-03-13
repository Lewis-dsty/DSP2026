%--------------------------------------------------------------------------
%Task 1:
%--------------------------------------------------------------------------

[x, fs] = audioread('pluck.wav'); %Reads the audiofile

x = x(:,1);
N = length(x);

t = (0);


%--------------------------------------------------------------------------

delay_ms = 500;        %Delay in milliseconds
alpha = 0.5;           %Attenuation factor (0-1)


%Convert delay from milliseconds to Samples
delay_samples = round(delay_ms/100);


%--------------------------------------------------------------------------

h = zero(delay_samples = 1, 1);       %Initialise input response
h(1) = 1;                             %Direct signal
h(delay_samples + 1) = alpha;         %Echo Component

y = conv (x, h);

%Creating time axis for output
t_y = (0:length(y)-1)/Fs;



%--------------------------------------------------------------------------

%Plotting Original and output signal

figure;

subplot(2,1,1)
plot(t,x)
xlabel("Time (seconds)")
ylabel("Amplitude")
title("Original Sample")
grid on

subplot(2,1,2)
plot(t,y)
xlable("Time (seconds)")
ylabel("Amplitude")
title("Echoed signal")
grid on






