clc;
clear all;
window = 2048;
NFFT = 8192;

figure;
subplot(3,3,1);
[y,Fs] = audioread('SPARROW House_02_Chubut_AR_MAR93_Felix Vidoz.mp3');
y = y(1:900000);
melSpectrogram(y, Fs);
title('Gråsparv')
subplot(3,3,4);
[y,Fs] = audioread('2001.mp3');
melSpectrogram(y, Fs);
subplot(3,3,7);
[y,Fs] = audioread('BLUEROBIN_HouseSparrow_Kaziranga_Assam_India_ArnoldMeijer_180209_LS100435.mp3');
melSpectrogram(y, Fs);

subplot(3,3,2);
[y,Fs] = audioread('LS110558_mesange_charbonniere_eigenhuis_noise_normal.mp3');
y = y(:,1);
y = y(1:900000);
melSpectrogram(y, Fs);
title('Talgoxe')
subplot(3,3,5);
[y,Fs] = audioread('XC120344-05277_pfranke_110408_kmei_bokharensis_S_A 4.mp3');
y = y(:,1);
y = y(1:900000);
melSpectrogram(y, Fs);
subplot(3,3,8);
[y,Fs] = audioread('Cinciallegra_28_5_2012_Riserva Naturale Torbiere del Sebino.mp3');
y = y(:,1);
y = y(1:900000);
melSpectrogram(y, Fs);

subplot(3,3,3);
[y,Fs] = audioread('FC0103.mp3');
y = y(:,1);
y = y(1:500000);
melSpectrogram(y, Fs);
title('Bofink')
subplot(3,3,6);
[y,Fs] = audioread('fricoe_m_s_Hirkan_20mar2012.mp3');
y = y(:,1);
y = y(1:900000);
melSpectrogram(y, Fs);
subplot(3,3,9);
[y,Fs] = audioread('BuchfinkOberaschau19-5-12_9-54.mp3');
y = y(:,1);
y = y(1:900000);
melSpectrogram(y, Fs);