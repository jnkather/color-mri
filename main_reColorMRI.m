% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

close all; format compact; clc

% instructions:
% - all directory names that are save to variables must end with '/'
% - before running this script, a dataset meta-file has to be created for
% each dataset by using createDatasetFiles.m

% ---------------------------------
%% BEGIN HEADER

main_createDatasetFiles
addpath([pwd,'/subroutines'],'-end');     % add subroutine folder to path
[cnst, cmap, colors] = getConstantsMRI('trivariate','L50opt',30); % request constants, def. 30
cnst.useBackgrounds = [0 0.5]; % weight for first and second background channel
                             % default [0 0.5]

% load dataset created with 'main_createDatasetFiles()'
datasets = { 'Prostate_146_ADC_PBF_B800_Backgrounds'}; %  list all files that should be analyzed

% iterate through datasets and create auxiliary folders
    
for currentSet = 1:numel(datasets)
    
    disp(['#####',10,'Starting: ', char(datasets(currentSet)),10,'#####']); % status info
    load([cnst.loadDir,char(datasets(currentSet))]); % load dataset file

    % create folders if neccessary
    Dataset = preprocessDataset(Dataset,cnst); % function uses input from 'main_createDatasetFiles'
                                               
% ---------------------------------
%% BEGIN MAIN PART
% main part: perform the analysis of the current dataset

% iterate through all images in the current set
if cnst.DoAnalysis

SeriesInstanceUID = dicomuid; % create dicom UID for current reconstruction

for imgnum = 1:numel(Dataset.Channel1.Files) %imgnum = 37; % 13:68 % #12
    
    % display progress
    disp(['***',10,'Processing image ', num2str(imgnum), ' of ', ...
        num2str(numel(Dataset.Channel1.Files)),' from ', ...
            char(datasets(currentSet)),10,'***']);
    
    tImage = tic; % start timer
    % prepare image locations
    img1path = strcat(Dataset.Channel1.FullPath, ...
        Dataset.Channel1.Files(imgnum).name);
    img2path = strcat(Dataset.Channel2.FullPath, ...
        Dataset.Channel2.Files(imgnum).name);
    img3path = strcat(Dataset.Channel3.FullPath, ...
        Dataset.Channel3.Files(imgnum).name);
    
    % load DICOM images and metadata for each of the 3 images
    img1 = dicomread(img1path);   img1info = dicominfo(img1path);
    img2 = dicomread(img2path);   img2info = dicominfo(img2path);
    img3 = dicomread(img3path);   img3info = dicominfo(img3path);

    % omit current image if Channel 1 or 2 are black
    if max(img1(:))==0 || max(img2(:))==0
        continue;
    end
        
    % remove outlier pixels from image data
    img1_n = removeOutliers(img1,cnst.outliers);
    img2_n = removeOutliers(img2,cnst.outliers);
    img3_n = removeOutliers(img3,cnst.outliers);
    
    % normalize images by histogram equalization
    img1_n = normalizeImage(img1_n,'stretch');  % default stretch.
    img2_n = normalizeImage(img2_n,'stretch');  % default stretch. 
    img3_n = normalizeImage(img3_n,'stretch');  % default stretch. 
 
    if cnst.medfilt2orig
        img1_n = medfilt2(img1_n,[3 3]);
        img2_n = medfilt2(img2_n,[3 3]); 
        img3_n = medfilt2(img3_n,[3 3]);
    end
    
    % check matrix dimensions of 1st and 2nd channel
    if not(min(size(img1_n) == size(img2_n))) && cnst.overrideADCdimMismatch
        img1_n = imresize(img1_n,size(img2_n)/size(img1_n));
        warning('scaled 1st channel, be cautious');
    end
    
    
    % -------- experimental part -----
    if isfield(Dataset,'Backgrounds1')
        imgBackgrounds1Path = strcat(Dataset.Backgrounds1.FullPath, ...
            Dataset.Backgrounds1.Files(imgnum).name);
        imgC1 = dicomread(imgBackgrounds1Path);
        imgC1_n = normalizeImage(imgC1,'stretch');
        imgC1_n = removeOutliers(imgC1_n,cnst.outliers);
        %imgC1_n = imgradient(imgC1_n,'prewitt');
        %imgC1_n(imgC1_n<quantile(imgC1_n(:),cnst.lowerBackgroundThresh)) = 0;
        
        imgBackgrounds2Path = strcat(Dataset.Backgrounds2.FullPath, ...
            Dataset.Backgrounds2.Files(imgnum).name);
        imgC2 = dicomread(imgBackgrounds2Path);
        imgC2_n = normalizeImage(imgC2,'stretch');
        imgC2_n = removeOutliers(imgC2_n,cnst.outliers);
        %imgC2_n = imgradient(imgC2_n,'prewitt');
        %imgC2_n(imgC2_n<quantile(imgC2_n(:),cnst.lowerBackgroundThresh)) = 0;
    end
    % ---------
    
    % this is the actual image processing part
    switch cnst.mode
        case 'trivariate' 
            % re-color the image, trivariate (channel 1, 2 and 3)
            [imrgb, scatterOut] = ...
                reColorImage3(img1_n, img2_n, img3_n, ...
                cnst.nBins, cmap.Xq, cmap.Yq, cmap.Zq, cmap.colorsNew);
            disp('finished TRI-variate reconstruction');
            SeriesDescription = ['Trivariate-', num2str(cnst.nBins,'%02d'),'Bins',...
                               '-', cnst.colorScheme,...
                               '-', strrep(num2str(cnst.outliers),' ','_'),...
                               '-', strrep(Dataset.Channel1.ShortName,' ',''), ...
                               '-', strrep(Dataset.Channel2.ShortName,' ',''), ... 
                               '-', strrep(Dataset.Channel3.ShortName,' ',''),...
                               '-', Dataset.extraMode];
        case 'bivariate' 
            % re-color the image, bivariate (channel 1 and 2 only)
            imrgb = reColorImage2(img3_n,img2_n,cnst,cmap);
            disp('finished BI-variate reconstruction');      
            SeriesDescription = ['Bivariate-', num2str(cnst.nBinsFine2D,'%02d'),'Bins',...
                               '-', cnst.colorScheme2DName,...
                               '-', strrep(num2str(cnst.outliers),' ','_'),...
                               '-', strrep(Dataset.Channel3.ShortName,' ',''), ...
                               '-', strrep(Dataset.Channel2.ShortName,' ',''),...
                               '-', Dataset.extraMode];
        otherwise
            error('mode is not specified. check cnst.mode');
    end
    
    % -------- experimental part -----
    if isfield(Dataset,'Backgrounds1')
        
        max(imrgb(:))
        
        imrgb = rgb2lab(imrgb);
        imrgb_L = imrgb(:,:,1);
        
        % now mix imrgb_L with imgC_n
        newL = zeros(size(imgC1_n,1),size(imgC1_n,2),2);
        newL(:,:,1) = imrgb_L;          
        newL(:,:,2) = cnst.useBackgrounds(1) * normalizeImage(imgC1_n,'no-stretch') * max(imrgb_L(:));
        newL(:,:,3) = cnst.useBackgrounds(2) * normalizeImage(imgC2_n,'no-stretch') * max(imrgb_L(:));
        
        max_L = max(newL,[],3);
        
%         mixF = 0.3;
%         maxL = max(imrgb_L(:));
%         imrgb_L = (normalizeImage(imrgb_L,'no-stretch') * (1-mixF) + ...
%                   normalizeImage(imgC_n,'no-stretch') * (mixF)) * maxL;
%               
%         imrgb_L(imrgb_L>maxL) = maxL;      
%         
         imrgb(:,:,1) = max_L;
         imrgb = lab2rgb(imrgb);
         imrgb = imrgb-min(imrgb(:));
         imrgb = imrgb/max(imrgb(:)); % correct for non-existing RGB colors
        
        disp('final min max');
        min(imrgb(:))
        max(imrgb(:))
    end    
    % ---
        
    if cnst.medfilt2resu % optional: median filter the resulting image
        imrgb_t = rgb2lab(imrgb);
        for ch = 1:3
            imrgb_t(:,:,ch) = medfilt2(imrgb_t(:,:,ch),[3 3]);
        end
        imrgb = lab2rgb(imrgb_t);
    end
    
    if cnst.removeDarkNoiseResu > 0 % optional: remove low-intensity pixels
        imlab = rgb2lab(imrgb);
        imlab_L = imlab(:,:,1);
        imlab_L(imlab_L<quantile(imlab_L(:),cnst.removeDarkNoiseResu)) = 0;
        imlab(:,:,1) = imlab_L;
        imrgb = lab2rgb(imlab);
    end
    
    % save result as PNG
    if cnst.savePNG
       imwrite(imrgb,[Dataset.pngSavedir, num2str(imgnum,'%06d'), '_', cnst.mode,'.png']);
       disp('saved PNG');
    end
    
    % save result as DICOM
    if cnst.saveDICOM
       metadata = img3info;
       metadata.SeriesDescription = SeriesDescription;
       metadata.SeriesInstanceUID = SeriesInstanceUID;
       metadata.BitDepth = 16;
       
       max(imrgb(:))
        
       imdcm = uint16(round(imrgb*255));
       
       min(imdcm(:))
       max(imdcm(:))
       mean(imdcm(:))
      
       dicomwrite(imdcm,[Dataset.dcmSavedir, num2str(imgnum,'%06d'), '_', cnst.mode,'.dcm'],metadata);
       disp('saved DICOM');
    end
    
   % save originals as PNG
    if cnst.saveOriginal
       imwrite(img1_n,[Dataset.origSavedir1, num2str(imgnum,'%06d'),'.png']);
       imwrite(img2_n,[Dataset.origSavedir2, num2str(imgnum,'%06d'),'.png']);
       imwrite(img3_n,[Dataset.origSavedir3, num2str(imgnum,'%06d'),'.png']);
    end
    
    elapsedTime = toc(tImage);
    if cnst.avoidMacbookOverheat
        pauseMyProgram(elapsedTime,45)
    end

end
end

%% save annotations
if cnst.saveAnnotations
    saveColorAnnotations(colors,cmap,cnst,Dataset,'k');
end % end save annotations

disp([char(10), char(10)]);

end % end current set (iteration through sets)
