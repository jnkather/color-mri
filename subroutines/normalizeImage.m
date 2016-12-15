% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function imageOut = normalizeImage(imageIn, opt)

    % convert image to double
	imageOut = double(imageIn);

    % process each channel
	for i=1:size(imageIn,3)

        % extract one channel at a time
		Ch = imageOut(:,:,i);

        % normalize output range to 0...1
		imageOut(:,:,i) = (imageOut(:,:,i)-min(Ch(:)))/(max(Ch(:)-min(Ch(:))));

        % optional: stretch histogram
        if strcmp(opt,'stretch')
        	imageOut(:,:,i) = imadjust(imageOut(:,:,i), ...
						stretchlim(imageOut(:,:,i)),[]);
						 % default option for stretchlim is [0.01,0.99]
        end
	end

end
