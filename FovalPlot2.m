%% get results;
FovalData = {};
FovalData{1,1}.x = OCTResults.LeftResults{9, 5}(:,1)*OCTResults.LeftBar.XBar;  
FovalData{1,1}.y = OCTResults.LeftResults{9, 5}(:,2)*OCTResults.LeftBar.YBar;  
FovalData{2,1}.x = OCTResults.RightResults{9, 5}(:,1)*OCTResults.RightBar.XBar;  
FovalData{2,1}.y = OCTResults.RightResults{9, 5}(:,2)*OCTResults.RightBar.YBar;  

% correct;
FovalData{1,1}.x = max(FovalData{1,1}.x) - fliplr(FovalData{1,1}.x);
FovalData{1,1}.y = fliplr(FovalData{1,1}.y);
FovalData{2,1}.x = FovalData{2,1}.x - min(FovalData{2,1}.x);

figure;
hold on;
plot(FovalData{1,1}.x,FovalData{1,1}.y);
plot(FovalData{2,1}.x,FovalData{2,1}.y);

%% fit;
XNew = 0:10:7000;
FovalData{1,2}.y = interp1(FovalData{1,1}.x,FovalData{1,1}.y,XNew,'makima');
FovalData{2,2}.y = interp1(FovalData{2,1}.x,FovalData{2,1}.y,XNew,'makima');
FovalData{1,2}.x = XNew;
FovalData{2,2}.x = XNew;

% left;
figure;
plot(FovalData{1,2}.x,FovalData{1,2}.y);
hold on;
Slop1 = [];
for k = 1:length(XNew)-1
    Slop1(1,k) = (FovalData{1,2}.y(k+1)-FovalData{1,2}.y(k))/(XNew(k+1)-XNew(k));
end
[~,MinIndex] = min(Slop1(1,1:350));
[~,StartIndex] = min(abs(Slop1(1,MinIndex:350)))
TargetIndex_Start = StartIndex + MinIndex;
scatter(FovalData{1,2}.x(TargetIndex_Start),FovalData{1,2}.y(TargetIndex_Start),'r');

[~,MaxIndex] = max(Slop1(1,500:end-1));
[~,EndIndex] = min(abs(Slop1(1,500:500+MaxIndex)));
TargetIndex_End = 500 + EndIndex;
scatter(FovalData{1,2}.x(TargetIndex_End),FovalData{1,2}.y(TargetIndex_End),'b');

FovalData{1,3}.x = FovalData{1,2}.x(TargetIndex_Start:TargetIndex_End);
FovalData{1,3}.y = FovalData{1,2}.y(TargetIndex_Start:TargetIndex_End);

% right
figure;
plot(FovalData{2,2}.x,FovalData{2,2}.y);
hold on;
Slop2 = [];
for k = 1:length(XNew)-1
    Slop2(1,k) = (FovalData{2,2}.y(k+1)-FovalData{2,2}.y(k))/(XNew(k+1)-XNew(k));
end
[~,MinIndex] = min(Slop2(1,1:250));
[~,StartIndex] = min(abs(Slop2(1,MinIndex:250)))
TargetIndex_Start = StartIndex + MinIndex;
scatter(FovalData{2,2}.x(TargetIndex_Start),FovalData{2,2}.y(TargetIndex_Start),'r');

[~,MaxIndex] = max(Slop2(1,350:end));
[~,EndIndex] = min(abs(Slop2(1,350:350+MaxIndex)));
TargetIndex_End = 350 + EndIndex;
scatter(FovalData{2,2}.x(TargetIndex_End),FovalData{2,2}.y(TargetIndex_End),'b');

FovalData{2,3}.x = FovalData{2,2}.x(TargetIndex_Start:TargetIndex_End);
FovalData{2,3}.y = FovalData{2,2}.y(TargetIndex_Start:TargetIndex_End);

FovalData{1,3}.x = FovalData{1,3}.x - min(FovalData{1,3}.x);
FovalData{2,3}.x = FovalData{2,3}.x - min(FovalData{2,3}.x);
FovalData{1,3}.y = FovalData{1,3}.y - min(FovalData{1,3}.y);
FovalData{2,3}.y = FovalData{2,3}.y - min(FovalData{2,3}.y);
%% calculate;
for i = 1:2
    FovalArea(i,1) =  polyarea(FovalData{i,3}.x ,FovalData{i,3}.y);
    FovalDiameter(i,1) = pdist([FovalData{i,3}.x(1),FovalData{i,3}.y(1);FovalData{i,3}.x(end),FovalData{i,3}.y(end)]);
end

figure;
hold on;
plot(FovalData{1,3}.x,FovalData{1,3}.y);
plot(FovalData{2,3}.x,FovalData{2,3}.y);

%% calculate;
FovalResults = [];
FovalResults.FovalData = FovalData;
FovalResults.FovalArea = FovalArea;
FovalResults.FovalDiameter = FovalDiameter;
FovalResults.FovalWidth = FovalWidth;
FovalResults.FovalHeight = FovalHeight;
FovalResults.FovalHalfWidth = FovalHalfWidth;

