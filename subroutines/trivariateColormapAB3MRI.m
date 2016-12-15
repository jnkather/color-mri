% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function [colorsNew,Xq,Yq,Zq] = trivariateColormapAB3MRI(colorA,colorB,colorC,colorAB,colorBC,colorAC,nBins,method)

	% expects the following inputs:
    % colorA = Hex code for foreground color, i.e. corner 1
    % colorB = Hex code for background color, i.e. corner 3
    % corner 2 and 4 are black and white
    % nBins = x and y dimension of the resulting color map
    % varargin = if colors should be mixed in LAB rather than RGB space, an
    % argument 'lab' can be provided optionally
    
    % set up colors for corners of color map
    % convert input colors from Hex to RGB to CIELAB
    
    colW = rgb2lab(hex2rgb('000000')); 
    colA = rgb2lab(hex2rgb(char(colorA)));
    colB = rgb2lab(hex2rgb(char(colorB)));    
    colC = rgb2lab(hex2rgb(char(colorC)));
    colAB = rgb2lab(hex2rgb(char(colorAB)));
    colBC = rgb2lab(hex2rgb(char(colorBC)));    
    colAC = rgb2lab(hex2rgb(char(colorAC)));
    colK = rgb2lab(hex2rgb('FFFFFF'));
    
    % prepare defined colors
    [X,Y,Z] = meshgrid(0:1);  % coordinates are: for I = 1:numel(X); co =[X(I),Y(I),Z(I)], end
    
    % prepare color array
    originalColors = zeros(8,3);
    
    % fill color vector manually
    originalColors(1,:) = (colW);
    originalColors(2,:) = (colB);
    originalColors(3,:) = (colA);
    originalColors(4,:) = (colAB);
    originalColors(5,:) = colC; 
    originalColors(6,:) = colBC;
    originalColors(7,:) = colAC;
    originalColors(8,:) = (colK);


    % prepare color V vectors
    VL = zeros(size(X));
    Va = zeros(size(X));
    Vb = zeros(size(X));
    
    for i=1:numel(X)
        VL(i) = originalColors(i,1);
        Va(i) = originalColors(i,2);
        Vb(i) = originalColors(i,3);
    end
     
    % prepare grid
    [Xq,Yq,Zq] = meshgrid(linspace(0,1,nBins));
  
    % preallocate color map
    colorsNew = zeros(nBins,nBins,nBins,3);
           
    % iterate through the three channels
    colorsNew(:,:,:,1) = interp3(X,Y,Z,VL,Xq,Yq,Zq,method);
    colorsNew(:,:,:,2) = interp3(X,Y,Z,Va,Xq,Yq,Zq,method);
    colorsNew(:,:,:,3) = interp3(X,Y,Z,Vb,Xq,Yq,Zq,method);
    
    % return color map as a color vector
    colorsNew = reshape(colorsNew,nBins,[],3);
    colorsNew = normalizeImage(lab2rgb(colorsNew),'no-stretch');    
    colorsNew = reshape(colorsNew,[],3);
end