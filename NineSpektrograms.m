clc;
clear all;
window = 2048;
NFFT = 8192;
B = 1/500*ones(500,1);

% 9 spectrograms
figure;
subplot(3,3,1);
[y,Fs] = audioread('SPARROW House_02_Chubut_AR_MAR93_Felix Vidoz.mp3');
y = y(1:900000);
spectrogram(y, window,window/2, NFFT, Fs, 'yaxis');
title('Gråsparv')
subplot(3,3,4);
[y,Fs] = audioread('2001.mp3');
spectrogram(y, window,window/2, NFFT, Fs, 'yaxis');
subplot(3,3,7);
[y,Fs] = audioread('BLUEROBIN_HouseSparrow_Kaziranga_Assam_India_ArnoldMeijer_180209_LS100435.mp3');
spectrogram(y, window,window/2, NFFT, Fs, 'yaxis');

subplot(3,3,2);
[y,Fs] = audioread('LS110558_mesange_charbonniere_eigenhuis_noise_normal.mp3');
y = y(:,1);
y = y(1:900000);
spectrogram(y, window,window/2, NFFT, Fs, 'yaxis');
title('Talgoxe')
subplot(3,3,5);
[y,Fs] = audioread('XC120344-05277_pfranke_110408_kmei_bokharensis_S_A 4.mp3');
y = y(:,1);
y = y(1:900000);
spectrogram(y, window,window/2, NFFT, Fs, 'yaxis');
subplot(3,3,8);
[y,Fs] = audioread('Cinciallegra_28_5_2012_Riserva Naturale Torbiere del Sebino.mp3');
y = y(:,1);
y = y(1:900000);
spectrogram(y, window,window/2, NFFT, Fs, 'yaxis');

subplot(3,3,3);
[y,Fs] = audioread('FC0103.mp3');
y = y(:,1);
y = y(1:500000);
spectrogram(y, window,window/2, NFFT, Fs, 'yaxis');
title('Bofink')
subplot(3,3,6);
[y,Fs] = audioread('fricoe_m_s_Hirkan_20mar2012.mp3');
y = y(:,1);
y = y(1:900000);
spectrogram(y, window,window/2, NFFT, Fs, 'yaxis');
subplot(3,3,9);
[y,Fs] = audioread('BuchfinkOberaschau19-5-12_9-54.mp3');
y = y(:,1);
y = y(1:900000);
spectrogram(y, window,window/2, NFFT, Fs, 'yaxis');

%% Syllable cut for nine 
figure;
subplot(3,3,1);
[y,Fs] = audioread('SPARROW House_02_Chubut_AR_MAR93_Felix Vidoz.mp3');
y = y(1:900000);
plot(y);
hold on;
plot(getSyllableLocations(y, Fs, 0.5));
title('Gråsparv','FontSize',25)
subplot(3,3,4);
[y,Fs] = audioread('2001.mp3');
plot(y);
hold on;
plot(getSyllableLocations(y, Fs, 0.5));
subplot(3,3,7);
[y,Fs] = audioread('BLUEROBIN_HouseSparrow_Kaziranga_Assam_India_ArnoldMeijer_180209_LS100435.mp3');
plot(y);
hold on;
plot(getSyllableLocations(y, Fs, 0.5));

subplot(3,3,2);
[y,Fs] = audioread('LS110558_mesange_charbonniere_eigenhuis_noise_normal.mp3');
y = y(:,1);
y = y(1:900000);
plot(y);
hold on;
plot(getSyllableLocations(y, Fs, 0.5));
title('Talgoxe','FontSize',25)
subplot(3,3,5);
[y,Fs] = audioread('XC120344-05277_pfranke_110408_kmei_bokharensis_S_A 4.mp3');
y = y(:,1);
y = y(1:900000);
plot(y);
hold on;
plot(getSyllableLocations(y, Fs, 0.5));
subplot(3,3,8);
[y,Fs] = audioread('Cinciallegra_28_5_2012_Riserva Naturale Torbiere del Sebino.mp3');
y = y(:,1);
y = y(1:900000);
plot(y);
hold on;
plot(getSyllableLocations(y, Fs, 0.5));

subplot(3,3,3);
[y,Fs] = audioread('FC0103.mp3');
y = y(:,1);
y = y(1:500000);
plot(y);
hold on;
plot(getSyllableLocations(y, Fs, 0.5));
title('Bofink','FontSize',25)
subplot(3,3,6);
[y,Fs] = audioread('fricoe_m_s_Hirkan_20mar2012.mp3');
y = y(:,1);
y = y(1:900000);
plot(y);
hold on;
plot(getSyllableLocations(y, Fs, 0.5));
subplot(3,3,9);
[y,Fs] = audioread('BuchfinkOberaschau19-5-12_9-54.mp3');
y = y(:,1);
y = y(1:900000);
plot(y);
hold on;
plot(getSyllableLocations(y, Fs, 0.5));

%% 
window = 2048;
NFFT = 8048;


subplot(1,3,1);
[y,Fs] = audioread('fricoe_m_s_Hirkan_20mar2012.mp3');
y = y(:,1);
y = y(1:900000);
a = pwelch(y, window,window/2, NFFT, Fs);
pwelch(y, window,window/2, NFFT, Fs);
subplot(1,3,2);
[y,Fs] = audioread('BuchfinkOberaschau19-5-12_9-54.mp3');
y = y(:,1);
y = y(1:900000);
[b, f] = pwelch(y, window,window/2, NFFT, Fs);
pwelch(y, window,window/2, NFFT, Fs);
subplot(1,3,3);
plot(f,10*log10(a+b))

%%
% 9 spectrograms
fontSize = 25;
 window = 1024;
 NFFT = 8192;
figure;
subplot(3,3,1);
[y,Fs] = audioread('SPARROW House_02_Chubut_AR_MAR93_Felix Vidoz.mp3');
y = y(1:900000);
pwelch(y,hanning(window),window/2,NFFT,Fs); 
xlabel('Frekvens(Hz)');
ylabel('Effekt per frekvens')
title('Gråsparv', 'FontSize', fontSize)
subplot(3,3,4);
[y,Fs] = audioread('2001.mp3');
pwelch(y,hanning(window),window/2,NFFT,Fs); 
xlabel('Frekvens(Hz)');
ylabel('Effekt per frekvens')
subplot(3,3,7);
[y,Fs] = audioread('BLUEROBIN_HouseSparrow_Kaziranga_Assam_India_ArnoldMeijer_180209_LS100435.mp3');
pwelch(y,hanning(window),window/2,NFFT,Fs); 
xlabel('Frekvens(Hz)');
ylabel('Effekt per frekvens')

subplot(3,3,2);
[y,Fs] = audioread('LS110558_mesange_charbonniere_eigenhuis_noise_normal.mp3');
y = y(:,1);
y = y(1:900000);
pwelch(y,hanning(window),window/2,NFFT,Fs); 
xlabel('Frekvens(Hz)');
ylabel('Effekt per frekvens')
title('Talgoxe', 'FontSize', fontSize);
subplot(3,3,5);
[y,Fs] = audioread('XC120344-05277_pfranke_110408_kmei_bokharensis_S_A 4.mp3');
y = y(:,1);
y = y(1:900000);
pwelch(y,hanning(window),window/2,NFFT,Fs); 
xlabel('Frekvens(Hz)');
ylabel('Effekt per frekvens')
subplot(3,3,8);
[y,Fs] = audioread('Cinciallegra_28_5_2012_Riserva Naturale Torbiere del Sebino.mp3');
y = y(:,1);
y = y(1:900000);
pwelch(y,hanning(window),window/2,NFFT,Fs); 
xlabel('Frekvens(Hz)');
ylabel('Effekt per frekvens')

subplot(3,3,3);
[y,Fs] = audioread('FC0103.mp3');
y = y(:,1);
y = y(1:500000);
pwelch(y,hanning(window),window/2,NFFT,Fs); 
xlabel('Frekvens(Hz)');
ylabel('Effekt per frekvens') 
title('Bofink', 'FontSize', fontSize);
subplot(3,3,6);
[y,Fs] = audioread('fricoe_m_s_Hirkan_20mar2012.mp3');
y = y(:,1);
y = y(1:900000);
pwelch(y,hanning(window),window/2,NFFT,Fs); 
xlabel('Frekvens(Hz)');
ylabel('Effekt per frekvens')
subplot(3,3,9);
[y,Fs] = audioread('BuchfinkOberaschau19-5-12_9-54.mp3');
y = y(:,1);
y = y(1:900000);
pwelch(y,hanning(window),window/2,NFFT,Fs); 
xlabel('Frekvens(Hz)');
ylabel('Effekt per frekvens')






