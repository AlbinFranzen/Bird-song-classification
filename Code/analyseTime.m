function [avGap, avSyllable] = analyseTime(syllableLocations,Fs)
% Inputs sequence of 1s and 0s and determines probability of being a
% certain bird

% Finds lengths of syllables
syllableLengths = nonzeros(accumarray(nonzeros(syllableLocations.*(cumsum(~syllableLocations)+1)),1))./Fs;

% Finds lengths of gaps
gapLengths = nonzeros(accumarray(nonzeros(~syllableLocations.*(cumsum(syllableLocations)+1)),1))./Fs;

% Remove first/last values
if syllableLocations(1) == 0
    gapLengths = gapLengths(2:end);
end
if syllableLocations(1) == 1
    syllableLengths = syllableLengths(2:end);
end
if syllableLocations(end) == 0
    gapLengths = gapLengths(1:end-1);
end
if syllableLocations(end) == 1
    syllableLengths = syllableLengths(1:end-1);
end

avGap = trimmean(gapLengths,50);
avSyllable = trimmean(syllableLengths,50);

end