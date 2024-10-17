%% GapSyllable collector

files = dir('Passer domesticus-grasparv')
xplot = [];
yplot = [];
x1plot = [];
y1plot = [];
for i = 4:length(files)
    [y,Fs] = audioread(files(i).name);
    y = y(:,1);
    timeVec = getSyllableLocations(y, Fs, 0.5);
    [avGap500,avSyllable500] = analyseTime(timeVec, Fs);
    timeVec = getSyllableLocations(y, Fs, 0.02);
    [avGap20,avSyllable20] = analyseTime(timeVec, Fs);
   
    xplot(end+1) = avGap500;
    yplot(end+1) = avSyllable500;
    x1plot(end+1) = avGap20;
    y1plot(end+1) = avSyllable20;

end
data500 = [xplot.' yplot.' zeros(size(xplot,2),1)];
data20 = [x1plot.' y1plot.' zeros(size(x1plot,2),1)];

files = dir('Parus major-talgoxe');
xplot = [];
yplot = [];
x1plot = [];
y1plot = [];

for i = 4:length(files)-1
    [y,Fs] = audioread(files(i).name);
    y = y(:,1);
    timeVec = getSyllableLocations(y, Fs, 0.5);
    [avGap500,avSyllable500] = analyseTime(timeVec, Fs);   
    timeVec = getSyllableLocations(y, Fs, 0.02);
    [avGap20,avSyllable20] = analyseTime(timeVec, Fs);
   
    xplot(end+1) = avGap500;
    yplot(end+1) = avSyllable500;
    x1plot(end+1) = avGap20;
    y1plot(end+1) = avSyllable20;
 
end
vals = [xplot.' yplot.' ones(size(xplot,2),1)];
vals1 = [x1plot.' y1plot.' ones(size(x1plot,2),1)];
data500 = [data500; vals];
data20 = [data20; vals1];


files = dir('Fringilla coelebs-bofink')
xplot = [];
yplot = [];
x1plot = [];
y1plot = [];
for i = 4:length(files)-1
    [y,Fs] = audioread(files(i).name);
    y = y(:,1);
    timeVec = getSyllableLocations(y, Fs, 0.5);
    [avGap500,avSyllable500] = analyseTime(timeVec, Fs);   
    timeVec = getSyllableLocations(y, Fs, 0.02);
    [avGap20,avSyllable20] = analyseTime(timeVec, Fs);
   
    xplot(end+1) = avGap500;
    yplot(end+1) = avSyllable500;
    x1plot(end+1) = avGap20;
    y1plot(end+1) = avSyllable20;
 
end

vals = [xplot.' yplot.' ones(size(xplot,2),1)+1];
vals1 = [x1plot.' y1plot.' ones(size(x1plot,2),1)+1];
data500 = [data500; vals];
data20 = [data20; vals1];

save("data.mat","data500","data20")

