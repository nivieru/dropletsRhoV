function color = getColorForExpType(expType)
    switch expType
        case 29 % Rambam 5 80%
            color = [128 128 128]/255; %%% Gray
        case 37 % Rambam 5 80%
            color = [3 78 162]/255; %%% Blueish
        case 100 % Rambam 5 80%
            color = [201 100 101]/255; %%% Pinkish
        case 2012 % Rambam 12 80%
            color = [200 100 100]/255;
        case 104 % Rambam 6 80%
            color = [100 100 200]/255;
        case 10 % Rambam 10 80%
            color = [128 128 128]/255; %%% Gray
%         case 100 % Rambam 10 80%
%             color = [200 100 100]/255; %%% Gray
        case 101 % Rambam 10 80%
            color = [100 100 200]/255; %%% Gray
        otherwise
            color = getcolorfromindex(gca,expType);
    end
end