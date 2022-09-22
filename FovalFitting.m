%% get data;
i = 2
x = FovalData{i,3}.x;
y = FovalData{i,3}.y;

%% get best n value;
FitDifference = [];
x3 = [x(1):0.1:x(end)];
for n =1:40
    figure;
    plot(x,y,'k');
    hold on;
    [p,S,mu] = polyfit(x,y,n);
    y2 = polyval(p,x,S,mu);
    FitDifference(n,1) = sum((y2-y).^2);
    
    y3 = polyval(p,x3,S,mu);
    plot(x3,y3,'r-');
end

%% replot;
close all;
Fig = figure('Position',[1 1 1000 1000]);
n=40;
plot(x,y,'k');
hold on;
[p,S,mu] = polyfit(x,y,n);
x4 = [x(1):0.01:x(end)];
y4 = polyval(p,x4,S,mu);
plot(x4,y4,'b-');

%% calculate;
HalfIndex = round(length(y4)/2);
[YMax,YMaxIndex] = max(y4);

[~,MinIndex] = min(y4);
if MinIndex > YMaxIndex
    [YCheck,YCheckIndex] = min(y4(1:HalfIndex));
    [~,Index] = min(abs(YCheck-y4(HalfIndex:end)));
    
    YChoose = y4(Index+HalfIndex-1);
    YChooseIndex = HalfIndex + Index-1;
    
    WaveWidth = abs(x4(YCheckIndex)-x4(YChooseIndex));
    WaveHeight = YMax - YCheck;
    HalfWave_Height = WaveHeight/2 + YCheck;
    
    [~,Index_Start] = min(abs(HalfWave_Height-y4(1:HalfIndex)));
    [~,Index_End] = min(abs(HalfWave_Height-y4(HalfIndex:end)));
    HalfWave = pdist([x4(Index_Start),y4(Index_Start);x4(HalfIndex + Index_End-1),y4(HalfIndex + Index_End-1)]);
    
    Dia = pdist([x4(Index_Start),y4(Index_Start);x4(end),y4(end)]);
    
else
    [YCheck,YCheckIndex] = min(y4(HalfIndex:end));
    YCheckIndex = YCheckIndex +HalfIndex-1;
    [~,Index] = min(abs(YCheck-y4(1:HalfIndex)));
    
    YChoose = y4(Index-1);
    YChooseIndex = Index-1;
    
    WaveWidth = abs(x4(YCheckIndex)-x4(YChooseIndex));
    WaveHeight = YMax - YCheck;
    HalfWave_Height = WaveHeight/2 + YCheck;
    
    [~,Index_Start] = min(abs(HalfWave_Height-y4(1:HalfIndex)));
    [~,Index_End] = min(abs(HalfWave_Height-y4(HalfIndex:end)));
    HalfWave = pdist([x4(Index_Start),y4(Index_Start);x4(HalfIndex + Index_End-1),y4(HalfIndex + Index_End-1)]);
    
    Dia = pdist([x4(Index_Start),y4(Index_Start);x4(end),y4(end)]);
end
%% add plot;
plot([x4(YCheckIndex),x4(YChooseIndex)],[y4(YCheckIndex),y4(YChooseIndex)],'b');
plot([x4(Index_Start),x4(HalfIndex + Index_End-1)],[y4(Index_Start),y4(HalfIndex + Index_End-1)],'b');
Fig.CurrentAxes.TickDir = 'out';
%% merge results;
FovalWidth(i,1) = WaveWidth;
FovalHeight(i,1) = WaveHeight;
FovalHalfWidth(i,1) = HalfWave;

