clear; clc; close all;

%% -----------------------------
% USER SETTINGS (adjust here)
%% -----------------------------
wet_hall   = 1;   % 0 to 1 (Hall wet level)
wet_church = 1;   % 0 to 1 (Church wet level)

%% -----------------------------
% Load Original Signal
%% -----------------------------
[x, fs] = audioread('pluck.wav');

% Convert to mono if stereo
if size(x,2) == 2
    x = mean(x,2);
end

%% -----------------------------
% Load Impulse Responses
%% -----------------------------
[h_hall, fs_h1] = audioread('LargeHall.wav');
[h_church, fs_h2] = audioread('Church.wav');

% Convert IRs to mono
if size(h_hall,2) == 2
    h_hall = mean(h_hall,2);
end

if size(h_church,2) == 2
    h_church = mean(h_church,2);
end

% Match sampling rates
if fs ~= fs_h1
    h_hall = resample(h_hall, fs, fs_h1);
end

if fs ~= fs_h2
    h_church = resample(h_church, fs, fs_h2);
end

%% -----------------------------
% Convolution (Reverb)
%% -----------------------------
r_hall   = conv(x, h_hall);
r_church = conv(x, h_church);

% Pad original to match length
x_hall_pad   = [x; zeros(length(r_hall)-length(x),1)];
x_church_pad = [x; zeros(length(r_church)-length(x),1)];

%% -----------------------------
% Wet/Dry Mixing Algorithm
%% -----------------------------
y_hall = (1 - wet_hall)*x_hall_pad + wet_hall*r_hall;
y_church = (1 - wet_church)*x_church_pad + wet_church*r_church;

% Normalize to prevent clipping
y_hall   = y_hall / max(abs(y_hall));
y_church = y_church / max(abs(y_church));

%% -----------------------------
% Playback (Sequential)
%% -----------------------------
disp('Playing Original (Dry)...')
sound(x, fs)
pause(length(x)/fs + 1)

disp('Playing Large Hall Mix...')
sound(y_hall, fs)
pause(length(y_hall)/fs + 1)

disp('Playing Church Mix...')
sound(y_church, fs)

%% -----------------------------
% Plot Results
%% -----------------------------
figure;

subplot(3,1,1)
plot(x)
title('Original Dry Signal')
xlabel('Samples')
ylabel('Amplitude')

subplot(3,1,2)
plot(y_hall)
title(['Large Hall Reverb  (Wet = ', num2str(wet_hall*100), '%)'])
xlabel('Samples')
ylabel('Amplitude')

subplot(3,1,3)
plot(y_church)
title(['Church Reverb  (Wet = ', num2str(wet_church*100), '%)'])
xlabel('Samples')
ylabel('Amplitude')
