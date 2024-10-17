function [freq, filteredSignal] = customFilter(f, y)
% input as a signal in frequency domain and outputs filtered signal on a
% requires y as 24k spektrum with 24k values
processedSig = interp1(f, y, linspace(0,24000,24000));

load('filterBankCoefs.mat','centers','edges','energy');
load('avSyllables.mat','avBofink','avGrasparv','avTalgoxe','f');
importantF = abs(avTalgoxe-avGrasparv)+abs(avTalgoxe-avBofink)+abs(avBofink-avGrasparv); % Get most important frequencies

B = 1/100*ones(100,1);
filterImportantF = filter(B,1,importantF); % Moving average filter on important frequencies
filterImportantF(1:380) = 0; % Bandpass filter on non-important frequencies
filterImportantF(1450:end) = 0;

filterImportantF = filterImportantF/trapz(f,filterImportantF); % Normalisation

filteredSignal = zeros(size(edges,2)-1+size(centers,2)-1,1); % Create new signal
freq = zeros(size(filteredSignal,2),1);


for i = 1:size(edges,2)-1 % Add the edges    
    mid = round((edges(i)+edges(i+1))/2);
    freq(2*i-1) = mid;
    for j = edges(i):edges(i+1)        
        if j < mid;
              filteredSignal(2*i-1) = filteredSignal(2*i-1) + processedSig(j)*energy(mid)/(abs(edges(i)-mid))*(j-edges(i));
        else; 
             filteredSignal(2*i-1) = filteredSignal(2*i-1) - processedSig(j)*energy(mid)/abs((edges(i+1)-mid))*(j-edges(i+1));          
        end
        
    end
    filteredSignal(2*i-1) = 2*filteredSignal(2*i-1)/(edges(i+1)-edges(i));
    
end

for i = 1:size(centers,2)-1 % Add the centers  
    mid = round((centers(i)+centers(i+1))/2);
    freq(2*i) = mid;
    for j = centers(i):centers(i+1)        
        if j < mid;
              filteredSignal(2*i) = filteredSignal(2*i) + processedSig(j)*energy(mid)/(abs(centers(i)-mid))*(j-centers(i));
        else; 
             filteredSignal(2*i) = filteredSignal(2*i) - processedSig(j)*energy(mid)/abs((centers(i+1)-mid))*(j-centers(i+1));          
        end
        
    end
    filteredSignal(2*i) = 2*filteredSignal(2*i)/(centers(i+1)-centers(i));
    
end


end