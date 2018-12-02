save_to_file='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Paper figures 21_3\S1 long TL\S1 f\';
close all
h=figure (1)

x=[DROPSforRho.DropSize];
y=[DROPSforRho.CHUNK_radius];
plot(x,y,'.','Color',[128/255 128/255 128/255])

NEWx=[0:0.5:70];
p1=0.1726
LinearFit=p1*NEWx;

hold on
plot(NEWx,LinearFit,'k')
xlim([25 70])
ylim([0 17])
ax=gca;
ax.YAxis.TickValues=[ 0 5 10 15 ];
xlabel('Droplet Radius [\mum]','FontSize',10)
ylabel('r_0 [\mum]','FontSize',10)

box off
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])

savefig(fullfile(save_to_file,'Rblob VS Rdrop .fig'));
saveas(figure (1),fullfile(save_to_file,'Rblob VS Rdrop.tif'));
saveas(figure (1),fullfile(save_to_file,'Rblob VS Rdrop'),'epsc');



