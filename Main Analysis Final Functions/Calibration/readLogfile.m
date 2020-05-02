function [micronsPerPixel, timeSep] = readLogfile(logfile)
LF = fopen(logfile);
TS = textscan(LF, '%s %f',3,'Delimiter',':','HeaderLines',5);    
fclose(LF);
micronsPerPixel = TS{2}(1);
timeSep  = TS{2}(3)/1000;