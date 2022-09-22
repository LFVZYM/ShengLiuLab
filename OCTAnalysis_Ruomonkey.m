clear;
close;
close all;
clc;
pause(0.01);
%% Load OCT image;
[FileName, FilePath] = uigetfile({'*.tif'},'Select data informations','E:\文章撰写\斜视猴子\弱视猴子\OCT\Left\');
RawData = imread(fullfile(FilePath,FileName));
OCTData = squeeze(RawData(:,:,1)); 
OCTNum = str2num(FileName(end-5:end-4)); 

%% plot piture;
figure;
% imshow(OCTData(:,504:1264))
imshow(adapthisteq(OCTData(:,497:1264), 'NumTiles',[20 20], 'ClipLimit',0.01,'NBins',100,'Distribution','exponential','Alpha',0.5))
% imshow(adapthisteq(OCTData))
% image(OCTData)
set(gcf,'Position',[1 1 1920 1080]);

%% get curve point data;
Data_OS  = drawpolyline('Color',[0.9290 0.6940 0.1250],'LineWidth',1,'MarkerSize',3);
Data_IS = drawpolyline('Color',[0.52941 0.80784 0.92157],'LineWidth',1,'MarkerSize',3);
Data_ONL = drawpolyline('Color','yellow','LineWidth',1,'MarkerSize',3);
Data_OPL = drawpolyline('Color','magenta','LineWidth',1,'MarkerSize',3);
Data_INL = drawpolyline('Color','cyan','LineWidth',1,'MarkerSize',3);
Data_IPL = drawpolyline('Color','green','LineWidth',1,'MarkerSize',3);
Data_GCL = drawpolyline('Color','red','LineWidth',1,'MarkerSize',3);
Data_NFL = drawpolyline('Color','blue','LineWidth',1,'MarkerSize',3);
Data_Outer = drawpolyline('Color',[0.8500 0.3250 0.0980],'LineWidth',1,'MarkerSize',3);

%% combine results;
Results = [];
Results.OCTNum = OCTNum;
Results.Outer = Data_Outer.Position;
Results.NFL = Data_NFL.Position;
Results.GCL = Data_GCL.Position;
Results.IPL = Data_IPL.Position;
Results.INL = Data_INL.Position;
Results.OPL = Data_OPL.Position;
Results.ONL = Data_ONL.Position;
Results.IS = Data_IS.Position;
Results.OS = Data_OS.Position;

%% save results;
%SavePath = 'E:\文章撰写\斜视猴子\OCT\';
SaveName = [FileName(1:end-4),'_Analysis'];
SaveInfo = [FilePath,SaveName];
save(strcat(SaveInfo,'.mat'),'Results');
saveas(gcf,strcat(SaveInfo,'.jpg'));
saveas(gcf,strcat(SaveInfo, '.eps'), 'psc2');
close all;
