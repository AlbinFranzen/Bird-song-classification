function [probaGrasparv, probaTalgoxe, probaBofink] = yToTimeProbability(y, Fs);
% Returns the probability of a soundfile being of a certain bird from an
% audio vector

% Get average gaps and syllable lengths for 500ms and 20ms syllable merge
% distances
timeVec500 = getSyllableLocations(y, Fs, 0.5); 
[avGap500,avSyllable500] = analyseTime(timeVec500, Fs);
timeVec20 = getSyllableLocations(y, Fs, 0.02); 
[avGap20,avSyllable20] = analyseTime(timeVec20, Fs);

% PCA from avGap500 and avSyllable500
xmean = 0.3687;
ymean = 0.7714;
principalComponent = 0.9887; 

xProjection = (avSyllable500-ymean+principalComponent*xmean+avGap500./principalComponent)/(principalComponent+1/principalComponent);
yProjection = principalComponent*(xProjection-xmean)+ymean;
PCA500 = sqrt((xProjection).^2+(yProjection-ymean+xmean./principalComponent).^2); % Convert projection to a line

% Predict using naive bayes on PCA500 and AvGap20 with pretrained model
load("nb_model.mat",'Mdl');
[prediction,Posterior,~] = predict(Mdl, [avGap20 PCA500]); % Predict with PCA and avGap20
prediction

probaGrasparv = Posterior(1); 
probaTalgoxe = Posterior(2);
probaBofink = Posterior(3);

end