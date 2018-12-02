%%%%% This function determine the grid 

function DetermineGridForSTICS(Capture_folder)

X0=importdata([Capture_folder,'Analysis parameters\X0.m']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.m']);
step=importdata([Capture_folder,'Analysis parameters\step.m']);
roi=importdata([Capture_folder,'Analysis parameters\roi.m']);

if (roi(3)>roi(4))
roiWidth=roi(3);
else roiWidth=roi(4);
end

GridPointsXend=ceil(X0+roiWidth/2);
GridPointsXstart=ceil(X0-roiWidth/2);

GridPointsYend=ceil(Y0+roiWidth/2);
GridPointsYstart=ceil(Y0-roiWidth/2);


GridPointsXright=[X0:step:GridPointsXend];
GridPointsXleft=fliplr([X0-step:-step:GridPointsXstart]);
GridPointsX=[GridPointsXleft,GridPointsXright];
% GridPointsX(GridPointsX<10)=[];
% GridPointsX(GridPointsX>502)=[];

GridPointsYright=[Y0:step:GridPointsYend];
GridPointsYleft=fliplr([Y0-step:-step:GridPointsYstart]);
GridPointsY=[GridPointsYleft,GridPointsYright]';
% GridPointsY(GridPointsY<10)=[];
% GridPointsY(GridPointsY>502)=[];

save([Capture_folder,'Analysis parameters\GridPointsX.mat'],'GridPointsX');
save([Capture_folder,'Analysis parameters\GridPointsY.mat'],'GridPointsY');

end
