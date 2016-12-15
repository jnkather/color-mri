% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function [ img_lab ] = gray2lab( img_gray )

img_lab = zeros(size(img_gray,1),size(img_gray,2),3);
img_lab(:,:,1) = img_gray;

end

