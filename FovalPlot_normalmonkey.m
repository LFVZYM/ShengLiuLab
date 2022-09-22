%% load results;
load('E:\文章撰写\斜视猴子\normal monkey\OCT\OCTResults3.mat');

%% plot foval curve;
Fig = figure('Position',[1 1 1000 1000]);
hold on;
Color = {'r','g','b','y','m','c',[0.8500 0.3250 0.0980],[0 0.74902 1],[1 0.64706 0]};
LeftIndex = 13;
FovalData = {};
for i = 1:1
    OuterData = [];
        OuterData = OCTPlotData{9,1};
        IndexStart = 5;
        IndexEnd = 23;
    
x = [];
y = [];
z = [];
z = OuterData(:,3);
MatchIndex = find(z == LeftIndex);
x = OuterData(MatchIndex,1);
y = OuterData(MatchIndex,2);
plot(x,y,'-*','Color',Color{i+2},'MarkerSize',10);
plot(x(IndexStart:IndexEnd),y(IndexStart:IndexEnd),'-o','Color',Color{i},'MarkerSize',10);
%plot(x,y,'o','MarkerSize',10,'MarkerFaceColor',Color{i});
%scatter3(x,y,z,'o','MarkerFaceColor',Color{i});
FovalData{i,1} = [x(IndexStart:IndexEnd)*XBar,y(IndexStart:IndexEnd)*YBar];
end
Fig.CurrentAxes.YLim = [50 200];
Fig.CurrentAxes.TickDir = 'out';

%% correct x;
FovalData_Correct = {};
Fig = figure('Position',[1 1 1000 1000]);
NewColor = {'g','b'};
hold on;
FovalArea = [];
FovalDiameter = [];
for i = 1:1
    XMin = min(FovalData{i,1}(:,1));
    XMax = max(FovalData{i,1}(:,1));
    if i == 1
        FovalData_Correct{i,1}(:,1) = abs(FovalData{i,1}(:,1) - XMax);
    elseif i== 2
        FovalData_Correct{i,1}(:,1) = FovalData{i,1}(:,1) - XMin;
    end
    FovalData_Correct{i,1}(:,2) = FovalData{i,1}(:,2);
    plot(FovalData_Correct{i,1}(:,1) ,FovalData_Correct{i,1}(:,2),'-o','Color',NewColor{i},'MarkerSize',10);
    % calculate;
    FovalArea(i,1) =  polyarea(FovalData_Correct{i,1}(:,1) ,FovalData_Correct{i,1}(:,2));
    FovalDiameter(i,1) = pdist([FovalData_Correct{i,1}(1,:);FovalData_Correct{i,1}(end,:)]);
end
Fig.CurrentAxes.TickDir = 'out';

%% calculate;
InterArea =  FovalArea(1,1) - FovalArea(2,1);

FovalResults = [];
FovalResults.FovalData = FovalData;
FovalResults.FovalArea = FovalArea;
FovalResults.FovalDiameter = FovalDiameter;
FovalResults.FovalWidth = FovalWidth;
FovalResults.FovalHeight = FovalHeight;
FovalResults.FovalHalfWidth = FovalHalfWidth;

