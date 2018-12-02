%%%% Maya Malik Garbi - 22/9/17
%%%% OperateActinIntensityCheck.m

slide_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Actin & LA labeling\2017_02_15\80% extract 1.5uM ActA Rh actin & LA GFP\mix2 sample2 time15_00\';
ActinNoLabelBack=1369; 
LANoLabelBack=1275;
calibration=0.2054; %%% microscope calibration [um/pixel]

MainActinIntensityCheck(slide_folder,calibration,ActinNoLabelBack,LANoLabelBack)