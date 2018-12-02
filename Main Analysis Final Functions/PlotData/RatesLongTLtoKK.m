clear all
close all

file='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Paper figures 21_3\S1 long TL\Matlab functions and structures';
save_to_file='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Paper figures 21_3\S1 long TL\figures\';
x=5*[1:11];

AllDataRates1=importdata(fullfile(file,'\longTL drop5\rates\AllDataRates.mat'));
AllDataRates2=importdata(fullfile(file,'\longTL drop6\rates\AllDataRates.mat'));
AllDataRates3=importdata(fullfile(file,'\longTL drop7\rates\AllDataRates.mat'));
AllDataRates4=importdata(fullfile(file,'\longTL drop8\rates\AllDataRates.mat'));
AllDataRates5=importdata(fullfile(file,'\longTL drop9\rates\AllDataRates.mat'));
AllDataRates6=importdata(fullfile(file,'\rates Long TL\AllDataRates.mat'));



%%%%%%%%%%%%%%%%%%%%%%%%%% Not notmalized

for i=2:length(AllDataRates1)
beta(i)=mean([AllDataRates1(i).TurnoverRate,AllDataRates2(i).TurnoverRate,AllDataRates3(i).TurnoverRate...
,AllDataRates4(i).TurnoverRate,AllDataRates5(i).TurnoverRate,AllDataRates6(i).TurnoverRate]);

STDbeta(i)=std([AllDataRates1(i).TurnoverRate,AllDataRates2(i).TurnoverRate,AllDataRates3(i).TurnoverRate...
,AllDataRates4(i).TurnoverRate,AllDataRates5(i).TurnoverRate,AllDataRates6(i).TurnoverRate]);

k(i)=mean([AllDataRates1(i).ContractionRate,AllDataRates2(i).ContractionRate,AllDataRates3(i).ContractionRate...
,AllDataRates4(i).ContractionRate,AllDataRates5(i).ContractionRate,AllDataRates6(i).ContractionRate]);

STDk(i)=std([AllDataRates1(i).ContractionRate,AllDataRates2(i).ContractionRate,AllDataRates3(i).ContractionRate...
,AllDataRates4(i).ContractionRate,AllDataRates5(i).ContractionRate,AllDataRates6(i).ContractionRate]);

end

figure (1)
for i=2:6
plot(x(i),k(i),'.','Color','k')
hold on
errorbarxy(x(i),k(i),0,STDk(i), 0, STDk(i),'k' ,'k')
hold on
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
% xlim([-0.1 1.7])
xlim([5 35])
ylim([0 1])
% ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
% ax.YAxis.TickValues=[ 0 0.2 0.4 0.6 ];

ax.XAxis.TickValues=[0:10:30];

xlabel('Time [min]','FontSize',10)
ylabel('Contraction rate [1/min]','FontSize',10)

savefig(fullfile(save_to_file,'\AVGcontraction rate vs time non norm.fig'));
saveas(figure (1),fullfile(save_to_file,'\AVGcontraction rate vs time non norm.tif'));
saveas(figure (1),[save_to_file,'\AVGcontraction rate vs time non norm'],'epsc');



figure (2)
for i=2:6
plot(x(i),beta(i),'.','Color','k')
hold on
errorbarxy(x(i),beta(i),0,STDbeta(i), 0, STDbeta(i),'k' ,'k')
hold on
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])
set(gcf,'position',[7 7 5 4])
% xlim([-0.1 5])
xlim([5 35])
ylim([0 2])

% ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
  ax.XAxis.TickValues=[0:10:30];
%  ax.XAxis.TickValues=[0:10:30];

% ax.YAxis.TickValues=[ 0 1 2 ];

xlabel('Time [min]','FontSize',10)
ylabel('Net turnover rate [1/min]','FontSize',10)

savefig(fullfile(save_to_file,'\AVGturnover rate vs time non norm.fig'));
saveas(figure (2),fullfile(save_to_file,'\AVGturnover rate vs time non norm.tif'));
saveas(figure (2),[save_to_file,'\AVturnover  rate vs time non norm'],'epsc');
