% Mihir Trivedi (20BEE064)
% PQ Lab - 16/08/2023
% EXP3: To write a MATLAB code to generate standard waveform for
% voltage notching, power system transients (both types) & harmonics. 
% The code must be customizable with following parameters :
% Supply voltage (rms), No. of Phases, Supply frequency,
% Total no. of cycles on the scope,
% Notch occurring instance (at x millisecond),
% Impulse occurring instance (at y  millisecond), 
% Addition of harmonics (order of harmonics and % amplitude) 
clc;
clear all;
close all;

Vrms = input('Enter the rms value of voltage: ');
f = input('Enter the frequency: ');
cycle = input('Enter the Number of cycle: ');

% Vrms = 230; 
% f = 50;
% cycle = 25;

t_plot = (1/f) * cycle;
sampling_rate = 10000; % Sampling rate in Hz
t = linspace(0, t_plot, t_plot * sampling_rate);

sinusoid = Vrms * sqrt(2) * sin(2 * pi * f * t);
notch_signal = sinusoid;
impulse_signal = sinusoid;

%% Voltage Notching

notch_start = input('Enter the starting time of notching (in seconds): ');
notch_duration = input('Enter the time for which notching will stay (in seconds): ');
notch_percentage = input('Enter the (%) notch: ');

% notch_start = 0.05;
% notch_duration = 0.001;
% notch_percentage = 10;

notch_start_sample = (notch_start * sampling_rate) + 1;
notch_end_sample = ((notch_start + notch_duration) * sampling_rate);

notch_amplitude = 600 * sqrt(2); % Adjusted amplitude for the notch component
notch_signal(notch_start_sample:notch_end_sample) = -notch_amplitude + (notch_amplitude * (notch_percentage / 100));

%% Voltage Impulse Transient

impulse_start = input('Enter the starting time of impulse (in seconds): ');
impulse_percentage = input('Enter the (%) impulse: ');

% impulse_start = 0.25;
impulse_duration = 0.001;
% impulse_percentage = 125;

impulse_start_sample = round(impulse_start * sampling_rate) + 1;
impulse_end_sample = round((impulse_start + impulse_duration) * sampling_rate);

impulse_amplitude = 600 * sqrt(2); % Adjusted amplitude for the impulse component
impulse_signal(impulse_start_sample:impulse_end_sample) = impulse_amplitude + (impulse_amplitude * (impulse_percentage / 100));

%% Voltage Harmonics

numHarmonics = input('Enter the number of harmonics: ');

frequencies = zeros(1, numHarmonics);
amplitudes = zeros(1, numHarmonics);

for i = 1:numHarmonics
    frequencies(i) = input(['Enter the nth number of harmonic ', num2str(i), ': ']) * 50;
    amplitudes(i) = input(['Enter the (%) amplitude of harmonic ', num2str(i), ': ']);
end

waveform = zeros(size(t));
for i = 1:numHarmonics
    waveform = waveform + (amplitudes(i) / 100) * 600 * sqrt(2) * sin(2 * pi * frequencies(i) * t);
end

%% Plot

figure;
plot(t, notch_signal + impulse_signal + waveform);
title('Combined Signal (Notch, Impulse, and Harmonics)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
