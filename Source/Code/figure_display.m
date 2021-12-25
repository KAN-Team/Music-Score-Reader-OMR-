function figure_display(name, image, title_)
        figure('name', name), imshow(image, 'InitialMagnification', 'fit');
        title(title_);
end