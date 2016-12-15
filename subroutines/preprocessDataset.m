% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function Dataset = preprocessDataset(Dataset,cnst)

% create directory names for saving output

switch cnst.mode
    case 'trivariate'
        Dataset.pngSavedir = strcat(cnst.saveDir, Dataset.Name, '/', Dataset.Dir, ...
            'Reconstruction_', num2str(cnst.nBins,'%02d'),'_Bins_',cnst.colorScheme,...
            '_Mode_', cnst.mode ,'/', 'PNG/');
        Dataset.dcmSavedir = strcat(cnst.saveDir, Dataset.Name, '/', Dataset.Dir, ...
            'Reconstruction_', num2str(cnst.nBins,'%02d'),'_Bins_',cnst.colorScheme,...
            '_Mode_', cnst.mode ,'/', 'DICOM/');
        Dataset.AnnotationsSavedir = strcat(cnst.saveDir, Dataset.Name, '/', Dataset.Dir, ...
            'Reconstruction_', num2str(cnst.nBins,'%02d'),'_Bins_',cnst.colorScheme,...
            '_Mode_', cnst.mode , '/', 'Annotations/');
    case 'bivariate'
        Dataset.pngSavedir = strcat(cnst.saveDir, Dataset.Name, '/', Dataset.Dir, ...
            'Reconstruction_', num2str(cnst.nBinsFine2D,'%02d'),'_Bins_',cnst.cmap2D_FG,'_',cnst.cmap2D_BG,...
            '_Mode_', cnst.mode ,'/', 'PNG/');
        Dataset.dcmSavedir = strcat(cnst.saveDir, Dataset.Name, '/', Dataset.Dir, ...
            'Reconstruction_', num2str(cnst.nBinsFine2D,'%02d'),'_Bins_',cnst.cmap2D_FG,'_',cnst.cmap2D_BG,...
            '_Mode_', cnst.mode ,'/', 'DICOM/');
        Dataset.AnnotationsSavedir = strcat(cnst.saveDir, Dataset.Name, '/', Dataset.Dir, ...
            'Reconstruction_', num2str(cnst.nBinsFine2D,'%02d'),'_Bins_',cnst.cmap2D_FG,'_',cnst.cmap2D_BG,...
            '_Mode_', cnst.mode , '/', 'Annotations/');   
    otherwise
        error('illegal cnst.mode');
end

    Dataset.origSavedir1 = strcat(cnst.saveDir, Dataset.Name, '/', Dataset.Dir, ...
        'Original_Ch1_', Dataset.Channel1.ShortName,'/');
    Dataset.origSavedir2 = strcat(cnst.saveDir, Dataset.Name, '/', Dataset.Dir, ...
        'Original_Ch2_', Dataset.Channel2.ShortName,'/');
    Dataset.origSavedir3 = strcat(cnst.saveDir, Dataset.Name, '/', Dataset.Dir, ...
        'Original_Ch3_', Dataset.Channel3.ShortName,'/');

        
    % create folder for saving if neccessary
    if(cnst.savePNG && ~exist(Dataset.pngSavedir, 'dir'))
      mkdir(Dataset.pngSavedir); % create folder to save PNG results
    end
    
    if(cnst.saveDICOM && ~exist(Dataset.dcmSavedir, 'dir'))
      mkdir(Dataset.dcmSavedir); % create folder to save DICOM results
    end

    if(cnst.saveOriginal &&  ~exist(Dataset.origSavedir1, 'dir'))
      mkdir(Dataset.origSavedir1); % create folder for original channel 1
    end

    if(cnst.saveOriginal &&  ~exist(Dataset.origSavedir2, 'dir'))
      mkdir(Dataset.origSavedir2); % create folder for original channel 2
    end

    if(cnst.saveOriginal &&  ~exist(Dataset.origSavedir3, 'dir'))
      mkdir(Dataset.origSavedir3); % create folder for original channel 3
    end

    if(cnst.saveAnnotations &&  ~exist(Dataset.AnnotationsSavedir, 'dir'))
      mkdir(Dataset.AnnotationsSavedir); % create folder for annotations
    end

%% check for common problems
if((numel(Dataset.Channel1.Files) ~= numel(Dataset.Channel2.Files)) | ...
        (numel(Dataset.Channel1.Files) ~= numel(Dataset.Channel3.Files)))
    error(['Number of files in each channel is not equal: ',...
            num2str(numel(Dataset.Channel1.Files)),' ',...
            num2str(numel(Dataset.Channel2.Files)),' ',...
            num2str(numel(Dataset.Channel3.Files))]);
end

if(~numel(Dataset.Channel1.Files) | ...
        ~numel(Dataset.Channel2.Files) | ...
            ~numel(Dataset.Channel3.Files))
    error(['There is a channel with zero images: ',...
            num2str(numel(Dataset.Channel1.Files)),' ',...
            num2str(numel(Dataset.Channel2.Files)),' ',...
            num2str(numel(Dataset.Channel3.Files))]);
end

end

