function figure_display(name, image, title_)
    %{
      FIGURE_DISPLAY Creates a new figure and display an image.
        The displayed image is fitted to screen. 

        @Author Kareem Sherif
        @Copyright 12-2021 The KAN, Org.
    %}

    %%
    figure('name', name), imshow(image, 'InitialMagnification', 'fit');
    title(title_);
end