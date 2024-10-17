files = dir('Fringilla coelebs-bofink')
avBofink = zeros(32,1);

for i = 4:length(files)-1
    i
    [y,Fs] = audioread(files(i).name);
    y = y(:,1);
    binaryVector = getSyllableLocations(y, Fs, 0.5);
    Xmat = syllableExtractor(binaryVector, y);    
    avSyllable = constructavsyllable(Xmat, Fs);  
    avBofink = avBofink + avSyllable;
    
end
avBofink = avBofink./(length(files)-4);
melFilterAvBofink = avBofink;

%%
files = dir('Parus major-talgoxe')
avTalgoxe = zeros(32,1);
for i = 4:length(files)-1
    i
    [y,Fs] = audioread(files(i).name);
    y = y(:,1);
    binaryVector = getSyllableLocations(y, Fs, 0.5);
    Xmat = syllableExtractor(binaryVector, y);    
    avSyllable = constructavsyllable(Xmat, Fs);  
    avTalgoxe = avTalgoxe + avSyllable;
end
avTalgoxe = avTalgoxe./(length(files)-4);
melFilterAvTalgoxe = avTalgoxe;

%%
files = dir('Passer domesticus-grasparv')
avGrasparv = zeros(32,1);
for i = 4:length(files)-1
    i
    [y,Fs] = audioread(files(i).name);
    y = y(:,1);
    binaryVector = getSyllableLocations(y, Fs, 0.5);
    Xmat = syllableExtractor(binaryVector, y);    
    avSyllable = constructavsyllable(Xmat, Fs);  
    avGrasparv = avGrasparv + avSyllable;
end
avGrasparv = avGrasparv./(length(files)-4);
melFilterAvGrasparv = avGrasparv;

%%
figure;
subplot(1,3,1)
plot(f, avGrasparv)
title('Gråsparv')
subplot(1,3,2)
plot(f, avTalgoxe)
title('Talgoxe')
subplot(1,3,3)
plot(f, avBofink)
title('Bofink')

%%
%load('customFilteravSyllables.mat',"freq");


subplot(1,3,1);
plot(cf, melFilterAvGrasparv);
xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')
subplot(1,3,2);
plot(cf, melFilterAvTalgoxe);
xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')
subplot(1,3,3);
plot(cf, melFilterAvBofink);
xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')

%% Spara

save('avSyllables.mat','avBofink','avGrasparv','avTalgoxe','f')
%%
save('customFilteravSyllables.mat', "customFilterAvTalgoxe","customFilterAvBofink","customFilterAvGrasparv","freq");
%%
save('melFilteravSyllables.mat', "melFilterAvTalgoxe","melFilterAvBofink","melFilterAvGrasparv","cf");


