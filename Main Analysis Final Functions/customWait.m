function customWait(hROI)

% Listen for mouse clicks on the ROI
l = addlistener(hROI,'ROIClicked',@clickCallback);

% Block program execution
uiwait;

% Remove listener
delete(l);
hROI.InteractionsAllowed = 'none';
end

function clickCallback(~,evt)

if strcmp(evt.SelectionType,'double')
    uiresume;
end

end
