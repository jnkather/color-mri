% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function [imageNEW,scatterOut] = reColorImage3(image1,image2,image3,nBins,Xgrid,Ygrid,Zgrid,cmapData)

    newImg = zeros(size(image1,1),size(image1,2),3);
    newImgData = reshape(newImg,[],3);
        
    image1Data = image1(:);
    image2Data = image2(:);
    image3Data = image3(:);
    
    % figure()
    % axis([0;1;0;1;0;1]);axis equal;
    for i=1:numel(Xgrid)
        idX = (abs(image1(:)-Xgrid(i)) < 1/nBins);
        idY = (abs(image2(:)-Ygrid(i)) < 1/nBins);
        idZ = (abs(image3(:)-Zgrid(i)) < 1/nBins);

        %scatter3(image1Data(idX & idY & idZ),image2Data(idX & idY & idZ),image3Data(idX & idY & idZ),40,cmapData(i,:),'filled')         
    
          %hold on           
	    newImgData(idX & idY & idZ,:)= repmat(cmapData(i,:),sum(idX & idY & idZ),1);

        %disp(['Progress: ', num2str(i/numel(Xgrid)*100), '%']);
    end

    scatterOut.image1Data = image1Data;
    scatterOut.image2Data = image2Data;
    scatterOut.image3Data = image3Data;
    scatterOut.newImgData = newImgData;
    scatterOut.cmapData = cmapData;
    scatterOut.Xgrid = Xgrid;
    scatterOut.Ygrid = Ygrid;
    scatterOut.Zgrid = Zgrid;
   
    % create new image
    imageNEW = reshape(newImgData,size(image1,1),size(image1,2),3);
end

