%% Parameters
fs = 100;                       % [Hz]; sampling rate
t_length = 30;                  % [sec]; total time length (Length of signal)
time = 0:1/fs:t_length-1/fs;    % time vector
N = numel(time);                % number of data points
%% Generate 10 Hz sine waves
s1 = sin(2*pi*10*time);

figure();
plot(time, s1)
xlabel('Time [sec]')
ylabel('[Arbitrary unit]')
hold on
%% Obtain power spectral densities using fft
s1_fft = fft(s1);                   % Fast Fourier transform

P2 = abs(s1_fft/N);                 % symmetry spectrum cal
P1 = P2(1:(N/2+1));                 % spectrum cal
P1(2:end-1) = 2*P1(2:end-1);        

f1 = fs*(0:(N/2))/N;
figure()
plot(f1, P1)
xlabel('f (Hz)')                   
ylabel('|P1(f)|') 

%% and 25 Hz 
s2 = sin(2*pi*25*time);
plot(time, s2)
xlabel('Time [sec]')
ylabel('[Arbitrary unit]')
hold on

s2_ftt = fft(s2);

P_2 = abs(s1_fft/N);                 % 양방향 스펙트럼 계산
P_1 = P_2(1:(N/2+1));                % 신호길이를 기반으로 단방향 스펙트럼 계산
P_1(2:end-1) = 2*P_1(2:end-1);        

f_1 = fs*(0:(N/2))/N;
figure()
plot(f_1, P_1)

f_2 = fs*((-N/2+1):(N/2))/N;
figure()
plot(f_2, P_2)
xlabel('f (Hz)')                    % x
ylabel('|P1(f)|')                   % y

%% Raw Data - time domain
len = 0:length(data)-1;
t = len/fs;
s = data*10^6;

figure()
plot(t, s)                  
xlabel('Time [sec]')                
ylabel('[Micro Volts]')

%% Raw Data - fft-power domain
N = length(data);
xdft = fft(data*10^6);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N))*abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
f = 0:fs/N:fs/2;

figure()
plot(f, log10(psdx))
xlabel('Frequency [Hz]')                
ylabel('Power [log(V^2)]')

figure()
plot(f, 10*log10(psdx))
xlim([1 100])
%% Raw Data - pwelch-power domain
[pxx, f] = pwelch(mat_Data.streams.raw, 15000, 800, 15000, mat_Data.fs_raw);

figure()
plot(f, log10(pxx))
xlabel('Frequency [Hz]')                
ylabel('Power [log(V^2)]')
xlim([1 100])

save('C:\Users\OWNER\Desktop\DGIST\Matlab\PSD.mat', 'pxx', 'f', 'fs', '-v7.3')


figure()
plot(f, (pxx))
xlabel('Frequency [Hz]')                
ylabel('Power [(V^2)]')
xlim([1 100])







