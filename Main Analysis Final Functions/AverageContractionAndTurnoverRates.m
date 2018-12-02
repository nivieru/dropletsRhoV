

Directory='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Average Contraction and Turnover Rates\';

DifferentAverageRates=struct;

ratesRambam41=importdata([Directory,'Buffer Rambam 4_1\AllDataRates.mat']);
DifferentAverageRates(1).Name='control rambam 4-1';
DifferentAverageRates(1).Data=ratesRambam41;

ratesAllBuffers=importdata([Directory,'All Buffers\AllDataRates.mat']);
DifferentAverageRates(2).Name='control rambam 5 all buffers';
DifferentAverageRates(2).Data=ratesAllBuffers;

ratesXBbuffer=importdata([Directory,'XB buffer\AllDataRates.mat']);
DifferentAverageRates(3).Name='control rambam 5 only XB buffer';
DifferentAverageRates(3).Data=ratesXBbuffer;

Rambam5andRambam41=[ratesRambam41,ratesAllBuffers];
DifferentAverageRates(4).Name='All data';
DifferentAverageRates(4).Data=Rambam5andRambam41;


for i=1:4
  
RelevantData=DifferentAverageRates(i).Data;
    
DifferentAverageRates(i).AverageContractionRate=real(mean([RelevantData.ContractionRate]));
DifferentAverageRates(i).stdContractionRate=real(std([RelevantData.ContractionRate]));
DifferentAverageRates(i).NornStdContractionRate=DifferentAverageRates(i).stdContractionRate/DifferentAverageRates(i).AverageContractionRate;

DifferentAverageRates(i).AverageTurnoverRate=real(mean([RelevantData.TurnoverRate]));
DifferentAverageRates(i).stdTurnoverRate=real(std([RelevantData.TurnoverRate]));
DifferentAverageRates(i).NormStdTurnoverRate=DifferentAverageRates(i).stdTurnoverRate/DifferentAverageRates(i).AverageTurnoverRate;

DifferentAverageRates(i).BetaOverK=DifferentAverageRates(i).AverageTurnoverRate/DifferentAverageRates(i).AverageContractionRate;

end

