function syl = constructavsyllable(Xmat,Fs)
 window = 1024;
 NFFT = 8192;
 [nrrows, nbrcolumnsX]=size(Xmat);
 [row,~]=size(pwelch(Xmat(1:end,1),hanning(window),window/2,NFFT,Fs));
 newmat=zeros(32,1);
for i = 1:nbrcolumnsX
     [pxx, f] = pwelch(Xmat(1:end,i),hanning(window),window/2,NFFT,Fs); 
    % [freq, filteredPxx] = customFilter(f, pxx); 
    % newmat=newmat + filteredPxx; 

    [fb,cf] = designAuditoryFilterBank(48000,"NumBands",32,"FrequencyRange",[0 24000]);      
    processedSig = interp1(f, pxx, linspace(0,24000,513));
    processedSig(isnan(processedSig))=0;
    filteredSig = fb*transpose(processedSig);
    newmat=newmat + filteredSig; 
    
    
end

syl=newmat./nbrcolumnsX;


end

