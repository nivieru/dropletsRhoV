function [h, mask, radius, X, Y] = measureCircle(calibration)
h = drawcircle('DrawingArea', 'unlimited','FaceAlpha',0);
customWait(h);
radius = h.Radius * calibration;
center = h.Center;
X = center(1);
Y = center(2);
mask = createMask(h);
