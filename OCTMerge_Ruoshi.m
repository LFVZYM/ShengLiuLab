%% open analysis data;
OCTNum = 31;
LeftPath = 'E:\文章撰写\斜视猴子\弱视猴子\OCT\Left';
RightPath = 'E:\文章撰写\斜视猴子\弱视猴子\OCT\Right';
LeftFirstData = 'FengL_00200';
RightFirstData = 'FengL_01500';

%% load Left data;
LeftData = {};
for i = 1:OCTNum
    if i<= 10
        DataName = [LeftFirstData(1:11),num2str(i-1),'_Analysis.mat'];
    else
        DataName = [LeftFirstData(1:10),num2str(i-1),'_Analysis.mat'];
    end
    Data = [];
    Data = load(fullfile(LeftPath,DataName));

    % merge;
    LeftData{i,1} = Data.Results;
end

%% load Right data;
RightData = {};
for i = 1:OCTNum
    if i<= 10
        DataName = [RightFirstData(1:11),num2str(i-1),'_Analysis.mat'];
    else
        DataName = [RightFirstData(1:10),num2str(i-1),'_Analysis.mat'];
    end
    Data = [];
    Data = load(fullfile(RightPath,DataName));

    % merge;
    RightData{i,1} = Data.Results;
end

%% save data;
OCTResults.LeftData = LeftData;
OCTResults.RightData = RightData;

SaveName = 'OCTResults_Final';
FilePath = 'E:\文章撰写\斜视猴子\弱视猴子\OCT\';
SaveInfo = [FilePath,SaveName];
save(strcat(SaveInfo,'.mat'),'OCTResults');
close all;

