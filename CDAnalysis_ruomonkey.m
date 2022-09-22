i = 1
% Load OCT image;
close all;
[FileName, FilePath] = uigetfile({'*.tif'},'Select data informations','E:\文章撰写\斜视猴子\弱视猴子\OCT\');
RawData = imread(fullfile(FilePath,FileName));
OCTData = squeeze(RawData(:,:,1));
OCTNum = str2num(FileName(end-5:end-4));
% plot piture;
figure;
set(gcf,'Position',[1 1 1080 1080]);
%imshow(RawData)
%imshow(adapthisteq(OCTData, 'NumTiles',[15 15]))
imshow(adapthisteq(OCTData, 'NumTiles',[20 20], 'ClipLimit',0.01,'NBins',100,'Distribution','exponential','Alpha',0.5))

AreaLine1 = drawpolyline('Color','green','LineWidth',1,'MarkerSize',2);
OutData{i,1} = AreaLine1.Position;
AreaLine2 = drawpolyline('Color','red','LineWidth',1,'MarkerSize',2);
InnerData{i,1} = AreaLine2.Position;

%BarData = diff(AreaLine.Position(:,2));
XBar_Raw = drawpolyline('Color','red','LineWidth',1,'MarkerSize',3);
XBar = 200/abs(diff(XBar_Raw.Position(:,1)))
YBar_Raw = drawpolyline('Color','green','LineWidth',1,'MarkerSize',3);
YBar = 200/abs(diff(YBar_Raw.Position(:,2)))
Bar = mean([XBar,YBar]);

% calculate;
Area1 =  polyarea(OutData{i,1}(:,1) ,OutData{i,1}(:,2));
Area2 =  polyarea(InnerData{i,1}(:,1) ,InnerData{i,1}(:,2));
CDArea(i,1) = (sqrt(Area1/pi)*Bar)^2*pi
CDArea(i,2) = (sqrt(Area2/pi)*Bar)^2*pi

sqrt(Area2/Area1)
%BarData = diff(AreaLine.Position(:,2));

% calculate;
Area =  polyarea(OutData{i,1}(:,1) ,OutData{i,1}(:,2));

%% save picture 1;
close all;
figure;
set(gcf,'Position',[1 1 1080 1080]);
imshow(adapthisteq(OCTData, 'NumTiles',[20 20], 'ClipLimit',0.01,'NBins',100,'Distribution','exponential','Alpha',0.5))
hold on;
plot(OutData{i,1}(:,1),OutData{i,1}(:,2),'g-o','MarkerSize',5,'MarkerFaceColor','none','MarkerEdgeColor','g');
plot(InnerData{i,1}(:,1),InnerData{i,1}(:,2),'b-o','MarkerSize',5,'MarkerFaceColor','none','MarkerEdgeColor','b');

SaveName = [FileName(1:end-4),'_Analysis2'];
SaveInfo = [FilePath,SaveName];
saveas(gcf,strcat(SaveInfo,'.jpg'));
saveas(gcf,strcat(SaveInfo, '.eps'), 'psc2');
close all;

%% save picture 2;
close all;
figure;
set(gcf,'Position',[1 1 1080 1080]);
imshow(adapthisteq(OCTData, 'NumTiles',[20 20]))
imshow(adapthisteq(OCTData, 'NumTiles',[15 15], 'ClipLimit',0.001,'NBins',1000,'Distribution','exponential','Alpha',0.4))
hold on;
plot(OutData{i,1}(:,1),OutData{i,1}(:,2),'g-o','MarkerSize',5,'MarkerFaceColor','none','MarkerEdgeColor','g');
plot(InnerData{i,1}(:,1),InnerData{i,1}(:,2),'b-o','MarkerSize',5,'MarkerFaceColor','none','MarkerEdgeColor','b');

SaveName = [FileName(1:end-4),'_Analysis_Black2'];
SaveInfo = [FilePath,SaveName];
saveas(gcf,strcat(SaveInfo,'.jpg'));
saveas(gcf,strcat(SaveInfo, '.eps'), 'psc2');
close all;

%% save results;
%SavePath = 'E:\文章撰写\斜视猴子\OCT\';
CDResults.CDArea = CDArea;
CDResults.OutData = OutData;
CDResults.InnerData = InnerData;
CDResults.Bar = Bar;