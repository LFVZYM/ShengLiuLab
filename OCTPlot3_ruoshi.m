%% load results;
load('E:\文章撰写\斜视猴子\弱视猴子\OCT\OCTResults_Final.mat');

%% analyze Left data;
OSData = [];
k = 0;
for i = 1:size(OCTResults.LeftData,1)
    OS_Temp = OCTResults.LeftData{i, 1}.OS;
    for j = 1:size(OS_Temp,1)
        k = k +1;
        OSData(k,:) = [OS_Temp(j,:),i];
    end
end

ISData = [];
k = 0;
for i = 1:size(OCTResults.LeftData,1)
    IS_Temp = OCTResults.LeftData{i, 1}.IS;
    for j = 1:size(IS_Temp,1)
        k = k +1;
        ISData(k,:) = [IS_Temp(j,:),i];
    end
end

ONLData = [];
k = 0;
for i = 1:size(OCTResults.LeftData,1)
    ONL_Temp = OCTResults.LeftData{i, 1}.ONL;
    for j = 1:size(ONL_Temp,1)
        k = k +1;
        ONLData(k,:) = [ONL_Temp(j,:),i];
    end
end

OPLData = [];
k = 0;
for i = 1:size(OCTResults.LeftData,1)
    OPL_Temp = OCTResults.LeftData{i, 1}.OPL;
    for j = 1:size(OPL_Temp,1)
        k = k +1;
        OPLData(k,:) = [OPL_Temp(j,:),i];
    end
end

INLData = [];
k = 0;
for i = 1:size(OCTResults.LeftData,1)
    INL_Temp = OCTResults.LeftData{i, 1}.INL;
    for j = 1:size(INL_Temp,1)
        k = k +1;
        INLData(k,:) = [INL_Temp(j,:),i];
    end
end

IPLData = [];
k = 0;
for i = 1:size(OCTResults.LeftData,1)
    IPL_Temp = OCTResults.LeftData{i, 1}.IPL;
    for j = 1:size(IPL_Temp,1)
        k = k +1;
        IPLData(k,:) = [IPL_Temp(j,:),i];
    end
end

GCLData = [];
k = 0;
for i = 1:size(OCTResults.LeftData,1)
    GCL_Temp = OCTResults.LeftData{i, 1}.GCL;
    for j = 1:size(GCL_Temp,1)
        k = k +1;
        GCLData(k,:) = [GCL_Temp(j,:),i];
    end
end

NFLData = [];
k = 0;
for i = 1:size(OCTResults.LeftData,1)
    NFL_Temp = OCTResults.LeftData{i, 1}.NFL;
    for j = 1:size(NFL_Temp,1)
        k = k +1;
        NFLData(k,:) = [NFL_Temp(j,:),i];
    end
end

OuterData = [];
k = 0;
for i = 1:size(OCTResults.LeftData,1)
    Outer_Temp = OCTResults.LeftData{i, 1}.Outer;
    for j = 1:size(Outer_Temp,1)
        k = k +1;
        OuterData(k,:) = [Outer_Temp(j,:),i];
    end
end

%% merge;
OCTPlotData = {};
OCTPlotData{1,1} = OSData;
OCTPlotData{1,2} = 'OS';
OCTPlotData{2,1} = ISData;
OCTPlotData{2,2} = 'IS';
OCTPlotData{3,1} = ONLData;
OCTPlotData{3,2} = 'ONL';
OCTPlotData{4,1} = OPLData;
OCTPlotData{4,2} = 'OPL';
OCTPlotData{5,1} = INLData;
OCTPlotData{5,2} = 'INL';
OCTPlotData{6,1} = IPLData;
OCTPlotData{6,2} = 'IPL';
OCTPlotData{7,1} = GCLData;
OCTPlotData{7,2} = 'GCL';
OCTPlotData{8,1} = NFLData;
OCTPlotData{8,2} = 'NFL';
OCTPlotData{9,1} = OuterData;
OCTPlotData{9,2} = 'Outer';

%% get bar size;
%% get x;
% Load OCT image;
[FileName, FilePath] = uigetfile({'*.tif'},'Select data informations','E:\文章撰写\斜视猴子\弱视猴子\OCT\Left\');
RawData = imread(fullfile(FilePath,FileName));
OCTData = squeeze(RawData(:,:,1));
% plot piture;
figure;
imshow(adapthisteq(OCTData(:,497:1264), 'NumTiles',[20 20]))
set(gcf,'Position',[1 1 1920 1080]);
XBar_Raw = drawpolyline('Color','red','LineWidth',1,'MarkerSize',3);
XBar = 200/abs(diff(XBar_Raw.Position(:,1)))
YBar_Raw = drawpolyline('Color','green','LineWidth',1,'MarkerSize',3);
YBar = 200/abs(diff(YBar_Raw.Position(:,2)))
close all;
figure;
imshow(OCTData(:,1:496))
set(gcf,'Position',[1 1 1920 1080]);
ZBar_Raw = drawpolyline('Color','blue','LineWidth',1,'MarkerSize',3);
ZBar = 200/abs(diff(ZBar_Raw.Position(:,2)))
close all;

%% plot;
Fig = figure('Position',[1 1 1000 1000]);
FigAxes = axes('Parent',Fig)
hold on;
Color = {'r','g','b','y','m','c',[0.8500 0.3250 0.0980],[0 0.74902 1],[1 0.64706 0]};
for i = 1:9
x = [];
y = [];
z = [];
x = OCTPlotData{i,1}(:,1)*XBar;
y = OCTPlotData{i,1}(:,2)*YBar;
z = OCTPlotData{i,1}(:,3)*ZBar;
plot3(x,y,z,'o','MarkerSize',10,'MarkerFaceColor',Color{i});
%scatter3(x,y,z,'o','MarkerFaceColor',Color{i});
end
view(FigAxes,[45.376 25.3541104294478])

%% plot foval curve;
Fig = figure('Position',[1 1 1000 1000]);
hold on;
Color = {'r','g','b','y','m','c',[0.8500 0.3250 0.0980],[0 0.74902 1],[1 0.64706 0]};
LeftIndex = 15;
FoveaData = {};
for i = 1:9
x = [];
y = [];
z = [];
z = OCTPlotData{i,1}(:,3);
MatchIndex = find(z == LeftIndex);
x = OCTPlotData{i,1}(MatchIndex,1)*XBar;
y = OCTPlotData{i,1}(MatchIndex,2)*YBar;
plot(x,y,'-o','Color',Color{i},'MarkerSize',10);
%plot(x,y,'o','MarkerSize',10,'MarkerFaceColor',Color{i});
%scatter3(x,y,z,'o','MarkerFaceColor',Color{i});
FoveaData{i,1} = [OCTPlotData{i,1}(MatchIndex,1),OCTPlotData{i,1}(MatchIndex,2)];
end
Fig.CurrentAxes.TickDir = 'out';

%% get mean line;
for i = 1:9
    OCTPlotData{i,3} = [];
    TempData = [];
    TempData = OCTPlotData{i,1};
    [n,XBin] = histcounts(TempData(:,1),50);
    MatchData = [];
    MatchNum = 0;
    for j = 2:length(XBin)
        BinStart = XBin(1,j-1);
        BinEnd = XBin(1,j);
        MatchNum = MatchNum + 1;
        MatchData(MatchNum,:) = mean(TempData(find(TempData(:,1)>= BinStart & TempData(:,1) < BinEnd),1:2),1);
    end
    OCTPlotData{i,3} = MatchData;
end

%% plot mean;
Fig = figure('Position',[1 1 1000 1000]);
hold on;
Color = {'r','g','b','y','m','c',[0.8500 0.3250 0.0980],[0 0.74902 1],[1 0.64706 0]};
for i = 1:9
x = [];
y = [];
x = OCTPlotData{i,3}(:,1)*XBar;
y = OCTPlotData{i,3}(:,2)*YBar;
%scatter(x,y,40,Color{i},'filled');
plot(x,y,'-o','Color',Color{i},'MarkerSize',10);
end
Fig.CurrentAxes.TickDir = 'out';

%% calculate mean area;
%% remove OP;
% Load OCT image;
[FileName, FilePath] = uigetfile({'*.tif'},'Select data informations','E:\文章撰写\斜视猴子\弱视猴子\OCT\Left\');
RawData = imread(fullfile(FilePath,FileName));
OCTData = squeeze(RawData(:,:,1));
OCTNum = str2num(FileName(end-5:end-4));
% plot piture;
figure;
imshow(adapthisteq(OCTData(:,497:1264), 'NumTiles',[20 20]))
set(gcf,'Position',[1 1 1920 1080]);
% LLine_Raw = drawpolyline('Color','red','LineWidth',1,'MarkerSize',3);
% LLine = mean(LLine_Raw.Position(:,1));
RLine_Raw = drawpolyline('Color','red','LineWidth',1,'MarkerSize',3);
RLine = mean(RLine_Raw.Position(:,1));
close all;

% calculate;
figure;
hold on;
for i = 1:8
    UpData = [];
    DownData = [];
    UpData_Check = [];
    DownData_Check = [];
    UpData_Correct = [];
    DownData_Correct = [];
    UpData = OCTPlotData{i,3};
    DownData = OCTPlotData{i+1,3};
    % correct OP;
    UpData_Correct = UpData(find(UpData(:,1)>= RLine),:);
    DownData_Correct = DownData(find(DownData(:,1)>= RLine),:);
    
    UpData_Check = UpData_Correct;
    DownData_Check = DownData_Correct;
    if min(UpData_Correct(:,1)) <= min(DownData_Correct(:,1))
        XMinData = min(UpData_Correct(:,1));
        DownData_XMinData = [XMinData,interp1(DownData_Correct(:,1),DownData_Correct(:,2),XMinData,'makima')];
        DownData_Check = [DownData_XMinData;DownData_Correct];
    else
        XMinData = min(DownData_Correct(:,1));
        UpData_XMinData = [XMinData,interp1(UpData_Correct(:,1),UpData_Correct(:,2),XMinData,'makima')];
        UpData_Check = [UpData_XMinData;UpData_Correct];
    end
    if max(UpData_Correct(:,1)) >= max(DownData_Correct(:,1))
        XMaxData = max(UpData_Correct(:,1));
        DownData_XMaxData = [XMaxData,interp1(DownData_Correct(:,1),DownData_Correct(:,2),XMaxData,'makima')];
        DownData_Check = [DownData_Check;DownData_XMaxData];
    else
        XMaxData = max(DownData_Correct(:,1));
        UpData_XMaxData = [XMaxData,interp1(UpData_Correct(:,1),UpData_Correct(:,2),XMaxData,'makima')];
        UpData_Check = [UpData_Check;UpData_XMaxData];
    end
   
    UpData_Check2 = [[UpData_Check(1,1),0];UpData_Check;[UpData_Check(end,1),0]];
    DownData_Check2 = [[DownData_Check(1,1),0];DownData_Check;[DownData_Check(end,1),0]];
    InterArea = polyarea(UpData_Check2(:,1),UpData_Check2(:,2)) - polyarea(DownData_Check2(:,1),DownData_Check2(:,2));
      MeanLength = (UpData_Check(end,1) - UpData_Check(1,1) + DownData_Check(end,1) - DownData_Check(1,1))/2
    MeanHeight = InterArea/MeanLength;
    OCTPlotData{i,4} = MeanHeight*YBar;
    
    % plot;
    plot(UpData_Check(:,1),UpData_Check(:,2));
    plot(DownData_Check(:,1),DownData_Check(:,2));
end

%% get fovea area;
OCTPlotData(:,5) = FoveaData(:,1);
figure;
hold on;
for i = 1:8
    UpData = [];
    DownData = [];
    UpData_Check = [];
    DownData_Check = [];
    UpData_Correct = [];
    DownData_Correct = [];
    UpData = OCTPlotData{i,5};
    DownData = OCTPlotData{i+1,5};
    % correct OP;
    UpData_Correct = UpData(find(UpData(:,1)>= RLine),:);
    DownData_Correct = DownData(find(DownData(:,1)>= RLine),:);
    
    if UpData_Correct(1,1) > UpData_Correct(end,1)
        UpData_Correct = flipud(UpData_Correct);
        DownData_Correct = flipud(DownData_Correct);
    end
    
    UpData_Check = UpData_Correct;
    DownData_Check = DownData_Correct;
    if min(UpData_Correct(:,1)) <= min(DownData_Correct(:,1))
        XMinData = min(UpData_Correct(:,1));
        DownData_XMinData = [XMinData,interp1(DownData_Correct(:,1),DownData_Correct(:,2),XMinData,'makima')];
        DownData_Check = [DownData_XMinData;DownData_Correct];
    else
        XMinData = min(DownData_Correct(:,1));
        UpData_XMinData = [XMinData,interp1(UpData_Correct(:,1),UpData_Correct(:,2),XMinData,'makima')];
        UpData_Check = [UpData_XMinData;UpData_Correct];
    end
    if max(UpData_Correct(:,1)) >= max(DownData_Correct(:,1))
        XMaxData = max(UpData_Correct(:,1));
        DownData_XMaxData = [XMaxData,interp1(DownData_Correct(:,1),DownData_Correct(:,2),XMaxData,'makima')];
        DownData_Check = [DownData_Check;DownData_XMaxData];
    else
        XMaxData = max(DownData_Correct(:,1));
        UpData_XMaxData = [XMaxData,interp1(UpData_Correct(:,1),UpData_Correct(:,2),XMaxData,'makima')];
        UpData_Check = [UpData_Check;UpData_XMaxData];
    end
   
    UpData_Check2 = [[UpData_Check(1,1),0];UpData_Check;[UpData_Check(end,1),0]];
    DownData_Check2 = [[DownData_Check(1,1),0];DownData_Check;[DownData_Check(end,1),0]];
    InterArea = polyarea(UpData_Check2(:,1),UpData_Check2(:,2)) - polyarea(DownData_Check2(:,1),DownData_Check2(:,2));
      MeanLength = (UpData_Check(end,1) - UpData_Check(1,1) + DownData_Check(end,1) - DownData_Check(1,1))/2;
    MeanHeight = InterArea/MeanLength;
    OCTPlotData{i,6} = MeanHeight*YBar;
    
    % plot;
    plot(UpData_Check(:,1),UpData_Check(:,2));
    plot(DownData_Check(:,1),DownData_Check(:,2));
end

%% save data;
OCTResults.LeftResults = OCTPlotData;
OCTResults.LeftBar.XBar = XBar;
OCTResults.LeftBar.YBar = YBar;
OCTResults.LeftBar.ZBar = ZBar;

SaveName = 'OCTPlotResults_Final';
FilePath = 'E:\文章撰写\斜视猴子\弱视猴子\OCT\';
SaveInfo = [FilePath,SaveName];
save(strcat(SaveInfo,'.mat'),'OCTResults');
close all;
