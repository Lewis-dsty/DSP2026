

N = 251;                                       %Choose odd number
Fs = 40000;                                    %Select sample rate
fc = 1000; 
n = floor(N/2); disp(n)

%------------------------------------------------------------------------

f0 = 2*pi*fc/(Fs/2);

Ir = f0+sinc(f0*(-n:n));
plot(Ir) 

%------------------------------------------------------------------------

Window = hamming(length(Ir));

Ir = Ir(:);
Window = Window(:);

WindowSinc = Ir.*Window;

stem(Window)

freqz(WindowSinc, 1)
hold on
freqz(Ir,1)

%------------------------------------------------------------------------

HP= -WindowSinc;
HP(n+1) = 1;
fvtool(HP, 1)

%conv(HP, WindowSinc)