%%%% This function plot rho vs V
%%%% take average 

AverageValuesBuffer=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Main Data figures\Buffer\All V\AverageValues.mat');
AverageValuesAlfaActinin=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Main Data figures\Alfa actinin\All V\AverageValues.mat');
AverageValues_mDia=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Main Data figures\mDia\All V\AverageValues.mat');
AverageValues_ActA=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Main Data figures\ActA\All V\AverageValues.mat');

figure
for t=1:4
  if (t==1)  AverageValues=AverageValuesBuffer;
      factor=2.5;
      j=1;
      col=[128/255 128/255 128/255];
  else if (t==2)  AverageValues=AverageValuesAlfaActinin;
          factor=1;
          j=2;
          col=[0 1 1];
          else if (t==3)  AverageValues=AverageValues_mDia;
                  factor=2;
                  j=2;
                  col=[1 0 1];
              else if (t==4)  AverageValues=AverageValues_ActA;
                      factor=1.5;
                      j=2;
                      col=[1 0 0];
                  end
              end
      end
  end
  
%%% V(r) 

x=[-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3]+AverageValues(j).Xteanslation;
x=x';
y=AverageValues(j).LinearFit;

% plot(x,y,'--','Color','k','LineWidth',1)

place=min(find(x>0));
x(1:place)=[];
y(1:place)=[];

% hold on
% plot(x,y,'--','Color','r','LineWidth',1)
% 
%%% Rho(r) 

AvgRho=(AverageValuesRho(t).meanRho)/factor;
AvgRrho=AverageValuesRho(t).meanRrho;

RhoV=interp1(AvgRrho,AvgRho,x);


% plot(RhoV,y,'Color',col)
plot(abs(y),RhoV,'Color',col)
hold on
ylabel('\rho [a.u]','FontSize',24)
xlabel('V [\mum]','FontSize',24)

end


