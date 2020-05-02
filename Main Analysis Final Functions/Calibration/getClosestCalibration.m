function [calibration, obj] = getClosestCalibration(calibrationFile, calibration)
calibrationTable = readtable(calibrationFile);
cals = calibrationTable.Calibration;
[~, ind] = min(abs(cals-calibration));
calibration = cals(ind);
obj = sprintf('%s_x%g',calibrationTable.lens{ind}, calibrationTable.optovar(ind));
end