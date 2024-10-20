%% Load data
load("data.mat","data20","data500");

x500 = data500(:,[1,2]);
y = data500(:,3);

x1_500 = x500(1:15,:);
x2_500 = x500(16:33,:);
x3_500 = x500(34:44,:);
y1 = y(1:15,:);
y2 = y(16:33,:)
y3 = y(34:44,:);

x20 = data20(:,[1,2]);
x1_20 = x20(1:15,:);
x2_20 = x20(16:33,:);
x3_20 = x20(34:44,:);


subplot(1,2,1)
scatter(x1_20(:,1), x1_20(:,2),'filled','blue'); 
hold on;
scatter(x2_20(:,1), x2_20(:,2),'filled','red'); 
hold on;
scatter(x3_20(:,1), x3_20(:,2),'filled','green');
% hold on;
% plot(xline, yline);
% hold on;
% scatter(xpoints1, ypoints1, 'blue');
% hold on;
% scatter(xpoints2, ypoints2, 'red');
% hold on;
% scatter(xpoints3, ypoints3, 'green');

legend('Gråsprav','Talgoxe','Bofink');
ylabel('Genomsnittlig stavelselängd med 20ms sammanfogningsavstånd (s)');
xlabel('Genomsnittlig mellanrum med 20ms sammanfogningsavstånd (s)');
axis('square')

subplot(1,2,2)
scatter(x1_500(:,1), x1_500(:,2),'filled','blue'); 
hold on;
scatter(x2_500(:,1), x2_500(:,2),'filled','red'); 
hold on;
scatter(x3_500(:,1), x3_500(:,2),'filled','green');

legend('Gråsprav','Talgoxe','Bofink');
ylabel('Genomsnittlig stavelselängd med 500ms sammanfogningsavstånd (s)');
xlabel('Genomsnittlig mellanrum med 500ms sammanfogningsavstånd (s)');
axis('square')

%% PCA on data

%PCA
xmean = mean(x1_500(:,1));
ymean = mean(x1_500(:,2));
coef = pca([(x1_500(:,1)-xmean) (x1_500(:,2)-ymean)])
primaryPC = coef(1);
xline = linspace(0, 12,1000);
yline = primaryPC*(xline-xmean) + ymean;

xpoints1 = (x1_500(:,2)-ymean+primaryPC*xmean+x1_500(:,1)./primaryPC)/(primaryPC+1/primaryPC);
ypoints1 = primaryPC*(xpoints1-xmean)+ymean;
ypca1 = sqrt((xpoints1).^2+(ypoints1-ymean+xmean./primaryPC).^2);
scatter(x1_20(:,1),ypca1,'filled','blue');

xpoints2 = (x2_500(:,2)-ymean+primaryPC*xmean+x2_500(:,1)./primaryPC)/(primaryPC+1/primaryPC);
ypoints2 = primaryPC*(xpoints2-xmean)+ymean;
ypca2 = sqrt((xpoints2).^2+(ypoints2-ymean+xmean./primaryPC).^2);
hold on;
scatter(x2_20(:,1),ypca2,'filled','red');

xpoints3 = (x3_500(:,2)-ymean+primaryPC*xmean+x3_500(:,1)./primaryPC)/(primaryPC+1/primaryPC);
ypoints3 = primaryPC*(xpoints3-xmean)+ymean;
ypca3 = sqrt((xpoints3).^2+(ypoints3-ymean+xmean./primaryPC).^2);
hold on;
scatter(x3_20(:,1),ypca3,'filled','green');

legend('Gråsprav','Talgoxe','Bofink');
xlabel('Genomsnittlig mellanrum med 20ms sammanfogningsavstånd (s)');
ylabel('Principalkomponent med 500ms sammanfogningsavstånd (s)');

%%

X2 = [ypca1;ypca2;ypca3];
X = [x20(:,1) X2];

prior = [0.33 0.33 0.33];
Mdl = fitcnb(X,y,'Prior',prior);
save('nb_model.mat','Mdl')

x1range = min(X(:,1)):.001:max(X(:,1));
x2range = min(X(:,2)):.001:max(X(:,2));
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];

[predictedspecies,Posterior,~] = predict(Mdl,XGrid);
certainty = max(Posterior,[],2);
certainty(certainty < 1) = 0;

for i=1:size(certainty,1)
    if (xx2(i)>5.3*xx1(i)) && certainty(i) == 1
        certainty(i) = 2;
    end
end

lightblue = [173, 216, 230]./255;
lightred = [255 127 127]./255;
lightgreen = [144 238 144]./255;
lightyellow = [255 255 204]./255;
colororder([lightyellow; lightblue; lightred]);

gscatter(xx1(:), xx2(:), certainty);

hold on;
scatter(x1_20(:,1),ypca1,'filled','blue',"MarkerEdgeColor","black");
hold on;
scatter(x2_20(:,1),ypca2,'filled','red',"MarkerEdgeColor","black");
hold on;
scatter(x3_20(:,1),ypca3,'filled',"MarkerFaceColor", "green","MarkerEdgeColor","black");
hold on

legend('','','','Gråsparv','Talgoxe','Bofink')
% sz = size(xx1);
% figure
% hold on
% surf(xx1,xx2,reshape(Posterior(:,1),sz),'EdgeColor','none')
% surf(xx1,xx2,reshape(Posterior(:,2),sz),'EdgeColor','none')
% surf(xx1,xx2,reshape(Posterior(:,3),sz),'EdgeColor','none')
% xlabel('Genomsnittlig mellanrum med 20ms sammanfogningsavstånd (s)');
% ylabel('Principalkomponent med 500ms sammanfogningsavstånd (s)');
% cb = colorbar(); 
% ylabel(cb,'Posteriori-sannolikhet','FontSize',16,'Rotation',270)
% view(2) 
% hold off

figure;

colororder([lightblue ;lightred; lightgreen]);
gscatter(xx1(:), xx2(:), predictedspecies);

legend off, axis tight
hold on;
scatter(x1_20(:,1),ypca1,'filled','blue',"MarkerEdgeColor","black");
hold on;
scatter(x2_20(:,1),ypca2,'filled','red',"MarkerEdgeColor","black");
hold on;
scatter(x3_20(:,1),ypca3,'filled',"MarkerFaceColor", "green","MarkerEdgeColor","black");
hold on

legend('Gråsprav','Talgoxe','Bofink');
xlabel('Genomsnittlig mellanrum med 20ms sammanfogningsavstånd (s)');
ylabel('Principalkomponent med 500ms sammanfogningsavstånd (s)');

%%
figure(1);
axis([0 1.2 0 9])
xlabel('Genomsnittlig mellanrum med 20ms sammanfogningsavstånd (s)');
ylabel('Principalkomponent med 500ms sammanfogningsavstånd (s)');

%%

figure
h = gca;
cxlim = h.XLim;
cylim = h.YLim;
hold on
Params = cell2mat(Mdl.DistributionParameters); 
Mu = Params(2*(1:3)-1,1:2); % Extract the means
Sigma = zeros(2,2,3);
for j = 1:3
    Sigma(:,:,j) = diag(Params(2*j,:)).^2; % Create diagonal covariance matrix
    xlim = Mu(j,1) + 4*[-1 1]*sqrt(Sigma(1,1,j));
    ylim = Mu(j,2) + 4*[-1 1]*sqrt(Sigma(2,2,j));
    f = @(x,y) arrayfun(@(x0,y0) mvnpdf([x0 y0],Mu(j,:),Sigma(:,:,j)),x,y);
    fcontour(f,[xlim ylim],'b') % Draw contours for the multivariate normal distributions 
end
h.XLim = cxlim;
h.YLim = cylim;

hold on
scatter(x1_20(:,1),ypca1,'filled','blue',"MarkerEdgeColor","black");
hold on;
scatter(x2_20(:,1),ypca2,'filled','red',"MarkerEdgeColor","black");
hold on;
scatter(x3_20(:,1),ypca3,'filled',"MarkerFaceColor", "green","MarkerEdgeColor","black");
xlabel('Genomsnittlig mellanrum med 20ms sammanfogningsavstånd (s)');
ylabel('Principalkomponent med 500ms sammanfogningsavstånd (s)');

legend('','','','Gråsparv','Bofink','Talgoxe')
axis([0 1.2 0 10]);
hold off

%%

% x = linspace(0,24000,2000);
% sig = ones(2000, 1);
% [freq, newSig] = customFilter(x, sig);
% figure;
% size(freq)
% scatter(freq, newSig,'.');

%%
x = linspace(0,24000,513);
[fb,cf] = designAuditoryFilterBank(48000,"NumBands",32,"FrequencyRange",[0 24000]);
for i = 1:size(fb,1)
    hold on;
    plot(x, fb(i,:))
end

xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')
%%
x = linspace(0,24000,2000);
sig = ones(2000, 1);

processedSig = interp1(x, sig, linspace(0,24000,513));
plot(processedSig)
newSig = fb*transpose(processedSig);
figure;
scatter(cf, newSig,'.');
%%

load("customFilteravSyllables.mat");

subplot(1,3,1);
plot(freq, customFilterAvGrasparv);
xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')
subplot(1,3,2);
plot(freq, customFilterAvTalgoxe);
xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')
subplot(1,3,3);
plot(freq, customFilterAvBofink);
xlabel('Frekvens (Hz)')
ylabel('Effekt per frekvens')

%%

[y, Fs] = audioread('2001.mp3'); 
y = y(:,1);
x1 = linspace(0,907776,907776)/Fs.';
x2 = linspace(0,907777,907777)/Fs.';
t = getSyllableLocations(y,Fs,0.5);
subplot(7,1,7);
plot(x1,y)
xlim([0 20]);
hold on;
plot(x2,0.3*t)
xlim([0 20]);
ylim([-0.5 0.5])
title('Utsignal','FontSize',25)

%%

[y, Fs] = audioread('talgoxe1.mp3'); 
y = y(:,1);
[g,t,b] = yToTimeProbability(y, Fs);
[y, Fs] = audioread('talgoxe1.mp3');
y = y(:,1);
[g,t,b] = yToTimeProbability(y, Fs);
[y, Fs] = audioread('talgoxe1.mp3');
y = y(:,1);
[g,t,b] = yToTimeProbability(y, Fs);

[y, Fs] = audioread('Grasparv1.mp3'); 
y = y(:,1);
[g,t,b] = yToTimeProbability(y, Fs);
[y, Fs] = audioread('Grasparv1.mp3');
y = y(:,1);
[g,t,b] = yToTimeProbability(y, Fs);
[y, Fs] = audioread('Grasparv1.mp3');
y = y(:,1);
[g,t,b] = yToTimeProbability(y, Fs);

[y, Fs] = audioread('bofink1.mp3'); 
y = y(:,1);
[g,t,b] = yToTimeProbability(y, Fs);
[y, Fs] = audioread('bofink1.mp3');
y = y(:,1);
[g,t,b] = yToTimeProbability(y, Fs);
[y, Fs] = audioread('bofink1.mp3');
y = y(:,1);
[g,t,b] = yToTimeProbability(y, Fs);












