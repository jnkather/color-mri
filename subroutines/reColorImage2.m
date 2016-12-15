% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function imageNEW  = reColorImage2(CH1,CH2,cnst,cmap)
 
    % analyze image
    imgSize = size(CH1);

    % make all 2D arrays 1D: H D R G B
    Ch1data = reshape(CH1,[],1);
    Ch2data = reshape(CH2,[],1);

    % calculate histograms from point coordinates and pixel colors
    % [~, colorsOriginal] = coords2hist(Ch1data,Ch2data,origImg,cnst.nBinsCoarse2D);
   
    % interpolate original 2D colormap and reconstruct pixel colors
    %colorsFine(:,:,1) = interp2(cmap.Xcoarse,cmap.Ycoarse,colorsOriginal(:,:,1),cmap.Xfine,cmap.Yfine,'spline');
    %colorsFine(:,:,2) = interp2(cmap.Xcoarse,cmap.Ycoarse,colorsOriginal(:,:,2),cmap.Xfine,cmap.Yfine,'spline');
    %colorsFine(:,:,3) = interp2(cmap.Xcoarse,cmap.Ycoarse,colorsOriginal(:,:,3),cmap.Xfine,cmap.Yfine,'spline');

    newImg = zeros(imgSize(1)*imgSize(2),3);

    tic
    for i=1:numel(cmap.Xfine)
        idX = (abs(Ch2data-cmap.Xfine(i)) < 1/cnst.nBinsFine2D);
        idY = (abs(Ch1data-cmap.Yfine(i)) < 1/cnst.nBinsFine2D);
        % plot(DABdata(idX & idY),Hdata(idX & idY),'.','Color',cmap(i,:))
        newImg(idX & idY,:) = repmat(cmap.colorList(i,:),sum(idX & idY),1);
        % disp(['Progress: ', num2str(i/numel(cmap.Xfine)*100), '%']);
    end
    % scatter(DABdata,Hdata,10,reshape(newImg,[],3),'filled');
    toc

    % create new image
    imageNEW = reshape(newImg,imgSize(1),imgSize(2),3);
end