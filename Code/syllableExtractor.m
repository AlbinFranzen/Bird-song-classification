function [Xmat] = syllableExtractor(binaryVector, y)
%Returns a cell array of the different syllables
Xmat = {};

foundSyllable = false;

    for i = 1:length(binaryVector)
        %Finding the starting index of the syllable:
        if(binaryVector(i) == 1 && foundSyllable == false)
            indexStart = i;
            foundSyllable = true;
        end
        
            %Finding the last index of the syllable:
           if(binaryVector(i) == 0 && foundSyllable == true)
                   
               indexStop = i-1;
               foundSyllable = false;
               
               %Adding syllable to Xmat:
               Xmat = [Xmat {transpose(y(indexStart:indexStop))}];

           
        end
        
       
        
    end

end

