% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function [ gamutX,gamutY,gamutZ,gamutRGB ] = gamut( numGa, parallel )
% parallel: e.g. 0 or [-80:4:80]

% initialize the full gamut

    gamutRGB = [0, 0, 0];
    for i=parallel
        gamutRGB = [gamutRGB; lab2rgb( rgb2lab(hsv(numGa))+repmat([i,0,0],numGa,1))];
    end
    
    % cut the first
    gamutRGB = gamutRGB(2:end,:);
    
    % convert to lab
    gamutLAB = rgb2lab(gamutRGB);

    % return coordinates for plotting
    gamutX = gamutLAB(:,1);
    gamutY = gamutLAB(:,2);
    gamutZ = gamutLAB(:,3);
    
end

