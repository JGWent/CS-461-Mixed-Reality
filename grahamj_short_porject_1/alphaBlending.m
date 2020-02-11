function OutputImage = alphaBlending(SourceImage, TargetImage, Mask, GaussianSize)

G = fspecial('gaussian',GaussianSize,(GaussianSize-1)/6);

GM = imfilter(Mask,G);

OutputImage = SourceImage .* GM + TargetImage .* (1-GM);

