% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function [zcounts, colorsOriginal] = coords2hist(x,y,origImg,nBins)

  % bindim is a smoothing factor for the data

  % bins has to be augmented by one, because bins actually denominates
  % the sampling points on the grid. 
  nBins = nBins + 1;

  % prepare bins for 2D histograms, caution: range always 0...1
  xgrid = linspace(0,1,nBins);
  ygrid = linspace(0,1,nBins);
  
  % use interpolation to create a native 2D histogram
  xcounts = interp1(xgrid,1:numel(xgrid),x,'nearest')';
  ycounts = interp1(ygrid,1:numel(ygrid),y,'nearest')';
  zcounts = accumarray([xcounts' ycounts'], 1, [nBins nBins]);

  % calculate RGB channel means for each bin
  colorsOriginal(:,:,1) = accumarray([xcounts' ycounts'],origImg(:,1)',[],@mean);
  colorsOriginal(:,:,2) = accumarray([xcounts' ycounts'],origImg(:,2)',[],@mean);
  colorsOriginal(:,:,3) = accumarray([xcounts' ycounts'],origImg(:,3)',[],@mean);

end