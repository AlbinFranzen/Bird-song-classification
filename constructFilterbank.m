%%
load('avSyllables.mat','avBofink','avGrasparv','avTalgoxe','f')
figure;

importantF = abs(avTalgoxe-avGrasparv)+abs(avTalgoxe-avBofink)+abs(avBofink-avGrasparv);

B = 1/100*ones(100,1);
filterImportantF = filter(B,1,importantF);
filterImportantF(1:380) = 0;
filterImportantF(1450:end) = 0;

filterImportantF = filterImportantF/trapz(filterImportantF);

subplot(1,2,1);
plot(f, importantF);
xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')
subplot(1,2,2);
plot(f, filterImportantF);
xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')

%%
numBins = 50;
edges = zeros(1,numBins+2);
k = 350;

frequencies = linspace(0,24000,24000);
energy = interp1(f,filterImportantF,frequencies);
%plot(frequencies,energy)

edges(1) = 3300;
currentF = 380;
for i = 2:numBins+1;
    
    nextEdgeEnergy = energy(edges(i-1)+1+round(6300./(10*numBins)));
    currentEdgeEnergy = energy(min(edges(i-1)+1,8500));
    avBinEnergy = (nextEdgeEnergy+currentEdgeEnergy)/2;
    scalingFactor = k*avBinEnergy;

    edges(i) = round(edges(i-1) + 6300/numBins/scalingFactor);
    if edges(i) > 8500
        edges(i) = 8500;
        
        break
    end

    currentF = currentF + round(edges(i));

end
edges = [2207, edges(1:16), 8500];

plot(f, filterImportantF);
hold on;
scatter(edges, zeros(1,size(edges,2))+0.0005,'x')

%% Plot Filters


centers = ones(1,size(edges,2)-1);
for i = 1:size(edges,2)-1
    centers(i) = round((edges(i)+edges(i+1))/2);
    hold on;

    midpoint = round((edges(i)+edges(i+1))/2);
    x1e = linspace(edges(i),midpoint,10);
    y1 = energy(midpoint)./(midpoint-edges(i))*(x1e-edges(i));

    x2e = linspace(midpoint,edges(i+1),10);
    y2 = -energy(midpoint)/(midpoint-edges(i))*(x2e-edges(i+1));

    plot([x1e x2e],[y1 y2]);
end

for i = 1:size(centers,2)-1
    hold on;

    midpoint = round((centers(i)+centers(i+1))/2);
    x1c = linspace(centers(i),midpoint,10);
    y1 = energy(midpoint)./(midpoint-centers(i))*(x1c-centers(i));

    x2c = linspace(midpoint,centers(i+1),10);
    y2 = -energy(midpoint)/(midpoint-centers(i))*(x2c-centers(i+1));

    plot([x1c x2c],[y1 y2]);
end

xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')
%%

save('filterBankCoefs.mat','edges','centers','energy');

%%

vals = 0;

if max(avt, avb, avg) == avb;
    vals = vals +1 ;
end
vals/size(vals);
