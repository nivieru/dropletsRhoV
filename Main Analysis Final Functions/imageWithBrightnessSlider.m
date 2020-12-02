function fig = imageWithBrightnessSlider(Image)
fig = figure;
ax = axes(fig);
hImage = imshow(Image, [], 'Parent', ax);
CL = ax.CLim;
brightnessSlider = uicontrol(fig, 'Style','slider','Min',CL(1)+1, 'Max', CL(2),'Value', CL(2), 'Callback', @imageCLim);
sliderLabel = uicontrol(fig, 'Style','text','String', 'brightness');
brightnessSlider.Position(3) = 120;
brightnessSlider.Position(1) = sliderLabel.Position(1) + sliderLabel.Position(3) +10;

cancelButton = uicontrol(fig, 'Style','pushbutton','String', 'Ignore Droplet', 'Callback', {@cancelImage, fig});
%.Position(1) = brightnessSlider.Position(1) + brightnessSlider.Position(3) + 10;
cancelButton.Position(3) = 80;
cancelButton.Position(1) = fig.Position(3) - 90;

    function imageCLim(source,event)
        val = source.Value;
        CL = ax.CLim;
        ax.CLim = [ax.CLim(1),val];
    end

    function cancelImage(source,event, f)
        close(f);
    end
end
