function OutputImage = pyramidBlending(SourceImage, TargetImage, Mask, GaussianSizes)

for i = 1:length(GaussianSizes)
    
    G{i} = fspecial('gaussian',GaussianSizes(i),(GaussianSizes(i)-1)/6);
    GM{i} = imfilter(Mask,G{i});
    GT{i} = imfilter(TargetImage,G{i});
    GS{i} = imfilter(SourceImage,G{i});
    
end

for i = 1:length(GaussianSizes)-1
    LS{i} = GS{i}-GS{i+1};
    LT{i} = GT{i}-GT{i+1};
end
LS{length(GaussianSizes)} = GS{length(GaussianSizes)};
LT{length(GaussianSizes)} = GT{length(GaussianSizes)};

for i = 1:length(GaussianSizes)
    LO{i} = LS{i} .* GM{i} + LT{i} .* (1-GM{i});
end

for i = 1:length(GaussianSizes)
    if ~exist('OutputImage','var')
       OutputImage = LO{i};
    else
        OutputImage = OutputImage + LO{i};
    end
end

