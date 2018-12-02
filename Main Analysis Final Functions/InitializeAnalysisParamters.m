function InitializeAnalysisParamters(Capture_folder,AnalysisParemeters)

%%AnalysisParemeters=[calibration,Time_intervale,interrogationarea,step,subpixfinder,pix_size_for_CLAHEprefilter,pix_size_for_HPprefilter];

calibration=AnalysisParemeters(1);
save([Capture_folder,'Analysis parameters\calibration.m'],'calibration')

Time_intervale=AnalysisParemeters(2);
save([Capture_folder,'Analysis parameters\Time_intervale.m'],'Time_intervale')

interrogationarea=AnalysisParemeters(3);
save([Capture_folder,'Analysis parameters\interrogationarea.m'],'interrogationarea')

SecondCorrWindowSize=AnalysisParemeters(4);
save([Capture_folder,'Analysis parameters\SecondCorrWindowSize.m'],'SecondCorrWindowSize')

step=AnalysisParemeters(5);
save([Capture_folder,'Analysis parameters\step.m'],'step')

subpixfinder=AnalysisParemeters(6);
save([Capture_folder,'Analysis parameters\subpixfinder.m'],'subpixfinder')

pix_size_for_CLAHEprefilter=AnalysisParemeters(7);
save([Capture_folder,'Analysis parameters\pix_size_for_CLAHEprefilter.m'],'pix_size_for_CLAHEprefilter')

pix_size_for_HPprefilter=AnalysisParemeters(8);
save([Capture_folder,'Analysis parameters\pix_size_for_HPprefilter.m'],'pix_size_for_HPprefilter')

backgroundNoFlu=AnalysisParemeters(9);
save([Capture_folder,'Analysis parameters\backgroundNoFlu.m'],'backgroundNoFlu')


end