function [syllableLocations] = getSyllableLocations(y, Fs, mergeTime);
% Audiofile is assumed to be 1D
% Returns 1 where there is a syllable and 0 where there isn't
% mergeTime is in seconds

x1 = linspace(0,907776,907776)/Fs.';
x2 = linspace(0,907777,907777)/Fs.';
figure;
subplot(7,1,1);
plot(x1,y);
xlim([0 20]);
title('Insignal','FontSize',25);
upperQuant = prctile(y,99.99); % Scale by quantile
lowerQuant = prctile(y,0.01);
quantY = y;
quantY(quantY > upperQuant) = upperQuant;
quantY(quantY < lowerQuant) = lowerQuant;
subplot(7,1,2);
plot(x1,y);
xlim([0 20]);
title('99.99% Kvantil','FontSize',25);
scaledY = quantY./max(abs(upperQuant), abs(lowerQuant));
subplot(7,1,3);
plot(x1,y);
xlim([0 20]);
title('Normering','FontSize',25);

highY = highpass(scaledY, 1500, Fs); % Highpass filter over 1500Hz
subplot(7,1,4);
plot(x1,y);
xlim([0 20]);
title('Högpassfilter','FontSize',25);
highY(abs(highY)<0.27) = 0; % Remove low amplitudes with threshhold 0.1
subplot(7,1,5);
plot(x1,y);
xlim([0 20]);
title('Tröskel','FontSize',25);
filterLen = round(Fs*mergeTime); % 500ms syllable distance
B = 1/filterLen * ones(1, filterLen); % Moving average filter of half a second to detect zeros
syllableLocations = filter(B,1,highY);
subplot(7,1,6);
plot(x1,y);
xlim([0 20]);
title('MA-filter','FontSize',25);
syllableLocations(abs(syllableLocations)>0) = 1; % Replace nonzero values with 1
syllableLocations = syllableLocations(round(filterLen/2):end); % Remove first Fs/4 values
if syllableLocations(end) == 1       % Add last Fs/4 values
    syllableLocations(end+1:end+round(filterLen/2))=1;
end
if syllableLocations(end) == 0
    syllableLocations(end+1:end+round(filterLen/2))=0;
end



end