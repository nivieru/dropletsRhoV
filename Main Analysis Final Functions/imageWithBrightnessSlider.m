function fig = imageWithBrightnessSlider(Image)
fig = figure;
ax = axes(fig);
hImage = imshow(Image, [], 'Parent', ax);
CL = ax.CLim;
c = uicontrol(fig, 'Style','slider','Min',CL(1)+1, 'Max', CL(2),'Value', CL(2), 'Callback', @imageCLim);
c.Position(3) = 120;

    function imageCLim(source,event)
        val = source.Value;
        CL = ax.CLim;
        ax.CLim = [ax.CLim(1),val];
    end

end
