% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function distance = getColorDistanceHex( foregroundColor, backgroundColor )
% this functions calculates the perceived distance between two colors.
% Expects input to be two hex colors (#XXXXXX). Output is a scalar.

    % convert input from rgb to lab
    foregroundColorLAB = rgb2lab(hex2rgb(foregroundColor));
    backgroundColorLAB = rgb2lab(hex2rgb(backgroundColor));
   
    % calculate euclidean distance in lab space
    distance = norm(foregroundColorLAB-backgroundColorLAB);

end