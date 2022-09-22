Fig = figure('Position',[1 1 1000 1000]);
FigAxes = axes('Parent',Fig)
hold on;
%plot(s1.FovalData{1, 3}.x,s1.FovalData{1, 3}.y,'k-')  
plot(s1.FovalData{2, 3}.x,s1.FovalData{2, 3}.y,'k')  

%plot(s2.FovalData{1, 3}.x,s2.FovalData{1, 3}.y,'r-')  
plot(s2.FovalData{2, 3}.x,s2.FovalData{2, 3}.y,'r')  

%plot(s3.FovalData{1, 3}.x,s3.FovalData{1, 3}.y,'b-')  
plot(s3.FovalData{2, 3}.x,s3.FovalData{2, 3}.y,'b')  

Fig.CurrentAxes.TickDir = 'out';