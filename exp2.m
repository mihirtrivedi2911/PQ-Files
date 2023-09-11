% Mihir Trivedi (20BEE064)
% PQ Lab - 09/08/2023
% EXP2: To write a MATLAB code to generate standard waveform for voltage interruption, voltage flicker and voltage unbalance
% The code must be customizable with following parameters :
% Supply voltage (rms), No. of Phases, Supply frequency, Total no. of
% cycles on the scope, interruption occurring time and duration,
% flicker, occurring time and duration of voltage unbalance, occurring time and duration 
clc;
clear all;
close all;

% input parameters
Vrms = input('Enter the rms value of supply voltage: ');
f = input('Enter the frequency of supply voltage: ');
T = input('Enter the total number of cycles on the scope: ');
t1 = input('Enter the time at which interruption occurs: ');
t2 = input('Enter the duration of interruption: ');
flicker_per = input('Enter value of flicker (%): ');
t3 = input('Enter the time at which flicker occurs: ');
t4 = input('Enter the duration of flicker: ');
t5 = input('Enter the time at which unbalance occurs: ');
t6 = input('Enter the duration of unbalance: ');

% Vrms = 230;
% f = 50;
% T = 25;
% t1 = 5;
% t2 = 3;
% flicker_per = 5;
% t3 = 10;
% t4 = 3;
% t5 = 15;
% t6 = 3;
thetaR = 0;
thetaY = (2*pi)/3;
thetaB = (2*pi)/3;

% generate time vector
t = linspace(0,T/f,T*100);

% generate 3-phase sine wave
V_R = Vrms*sqrt(2)*sin(2*pi*f*t+thetaR);
V_Y = Vrms*sqrt(2)*sin(2*pi*f*t-thetaY);
V_B = Vrms*sqrt(2)*sin(2*pi*f*t+thetaB);

% generate voltage interruption
Vint_R = Vrms*sqrt(2)*sin(2*pi*f*t+thetaR);
Vint_Y = Vrms*sqrt(2)*sin(2*pi*f*t-thetaY);
Vint_B = Vrms*sqrt(2)*sin(2*pi*f*t+thetaB);
Vint_R(t1*100:t1*100+t2*100) = 0;
Vint_Y(t1*100:t1*100+t2*100) = 0;
Vint_B(t1*100:t1*100+t2*100) = 0;

% generate voltage flicker
Vflicker_R = Vrms*sqrt(2)*sin(2*pi*f*t+thetaR);
Vflicker_Y = Vrms*sqrt(2)*sin(2*pi*f*t-thetaY);
Vflicker_B = Vrms*sqrt(2)*sin(2*pi*f*t+thetaB);
Vflicker_R(t3*100:t3*100+t4*100) = Vflicker_R(t3*100:t3*100+t4*100)/flicker_per;
Vflicker_Y(t3*100:t3*100+t4*100) = Vflicker_Y(t3*100:t3*100+t4*100)/flicker_per;
Vflicker_B(t3*100:t3*100+t4*100) = Vflicker_B(t3*100:t3*100+t4*100)/flicker_per;

% generate voltage unbalance
Vunbalance_R = Vrms*sqrt(2)*sin(2*pi*f*t+thetaR);
Vunbalance_Y = Vrms*sqrt(2)*sin(2*pi*f*t-thetaY);
Vunbalance_B = Vrms*sqrt(2)*sin(2*pi*f*t+thetaB);
Vunbalance_R(t5*100:t5*100+t6*100) = Vunbalance_R(t5*100:t5*100+t6*100)*0.9;
Vunbalance_Y(t5*100:t5*100+t6*100) = Vunbalance_Y(t5*100:t5*100+t6*100)*0.5;
Vunbalance_B(t5*100:t5*100+t6*100) = Vunbalance_B(t5*100:t5*100+t6*100)*0.75;
Vunbalance_R(t5*100+t6*100/2:t5*100+t6*100/2+t6*100) = Vunbalance_R(t5*100+t6*100/2:t5*100+t6*100/2+t6*100)*1.1;
Vunbalance_Y(t5*100+t6*100/2:t5*100+t6*100/2+t6*100) = Vunbalance_Y(t5*100+t6*100/2:t5*100+t6*100/2+t6*100)*1.2;
Vunbalance_B(t5*100+t6*100/2:t5*100+t6*100/2+t6*100) = Vunbalance_B(t5*100+t6*100/2:t5*100+t6*100/2+t6*100)*1.05;

% plot the waveforms
figure;
subplot(4,1,1);
plot(t,V_R);
hold on;
plot(t,V_Y);
plot(t,V_B);
hold off;
xlabel('Time (s)');
ylabel('Voltage (V)');
title('3-Phase Waveform');
grid on;

subplot(4,1,2);
plot(t,Vint_R);
hold on;
plot(t,Vint_Y);
plot(t,Vint_B);
hold off;
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage Interruption');
grid on;

subplot(4,1,3);
plot(t,Vflicker_R);
hold on;
plot(t,Vflicker_Y);
plot(t,Vflicker_B);
hold off;
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage Flicker');
grid on;

subplot(4,1,4);
plot(t,Vunbalance_R);
hold on;
plot(t,Vunbalance_Y);
plot(t,Vunbalance_B);
hold off;
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage Unbalance');
grid on;