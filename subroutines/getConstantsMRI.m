% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function [cnst, cmap, colors] = getConstantsMRI(varargin)
% if this function is called with an argument, the resulting variables are
% saved for reproducibility. The saving filename is the name of the
% argument to this function

    % set constants, save to structures 'colors', 'cnst', 'cmap'
    
    % --- BASIC PARAMETERS
    % parameters for overlay on background
    cnst.lowerBackgroundThresh = 0; % lower intensity quantile threshold for removing weak background pxs
    cnst.removeDarkNoiseResu = 0; % lower lightness quantile threshold for removing dark noise

    % interpolation
    cnst.method='linear'; % color interpolation method in LAB space
    
    % filter settings
    cnst.medfilt2orig = false; % median filter original images?
    cnst.medfilt2resu = false; % median filter result images?
  
    % set percentiles for outliers.
    cnst.outliers = [1,99]; % default [1,99] for Prostate. For the Rat MRI 
    % data, the outlier removal should include at least 2,98 or 3,97. 

    % parameters for saving the output
    cnst.imgResolution  = '-r450';
    cnst.showOutput      = false;       % show output on screen
    cnst.savePNG         = true;        % save output as PNG
    cnst.saveDICOM       = true;        % save output as DICOM
    cnst.saveOriginal    = false;       % save original image as PNG
    cnst.saveAnnotations = true;        % create and save color legend
    cnst.saveDir = '../mri-output/';    % default 'output/'
    cnst.loadDir = '../mri-input/';     % default 'input/'
    cnst.cnstDir = './cnstDir/';        % folder to save constants
    cnst.inputFormat = '*.dcm';         % default '*.dcm'
    cnst.DoAnalysis = true; % perform the actual analysis? default true

    % plot parameters
    cnst.scatterSize = 40; % default 40
    
    % error workarounds
    cnst.overrideADCdimMismatch = false; % be cautious! default false
    cnst.avoidMacbookOverheat = false;  % pause program after each iteration

    % --- PARSE INPUT and determine type and complexity of color map
    % choose bivariate or trivariate
    if nargin>0, cnst.mode = varargin{1}; else cnst.mode = 'trivariate'; end
    
    switch cnst.mode
        
        case 'trivariate' % select color map for trivariate mode
            % options: L50opt | L75 | defaultOnPlane | defaultOrig | L50opt-60deg
            if nargin>1, cnst.colorScheme = varargin{2};
            else cnst.colorScheme = 'defaultOrig'; end 
                % number of different color levels in each dimension for TRIVARIATE
            if nargin>2, cnst.nBins = varargin{3};
            else cnst.nBins = 20; end % default: 20
            
        case 'bivariate' % select color map for bivariate mode
            % color map for bivariate
            cnst.colorScheme2DName = 'BluOrng'; % used in our histology paper
            cnst.cmap2D_FG = '006EFF'; cnst.cmap2D_BG = 'FFAD00';
            % number of different color levels in each dimension for BIVARIATE
            if nargin>2, cnst.nBinsCoarse2D = varargin{3};
            else cnst.nBinsCoarse2D = 75; end
            cnst.nBinsFine2D = cnst.nBinsCoarse2D;
    end
    % ------------

    % request colors for selected color set
    colors = colorSet(cnst.colorScheme);
    
    % --- PARSE MODE and create color map
    switch cnst.mode
        case 'trivariate'
        % create trivariate color map and save to 'cmap' structure
        [cmap.colorsNew, cmap.Xq, cmap.Yq, cmap.Zq] = ...
            trivariateColormapAB3MRI(colors.A, colors.B, colors.C, ...
            colors.AB, colors.BC, colors.AC, cnst.nBins, cnst.method);

        case 'bivariate'
        % create bivariate color map and save to 'cmap' structure    
            % prepare for plot and plot results
            [cmap.Xcoarse,cmap.Ycoarse] = meshgrid(linspace(0,1,cnst.nBinsCoarse2D+1));
            [cmap.Xfine,cmap.Yfine] = meshgrid(linspace(0,1,cnst.nBinsFine2D));

            %% create alternative colormap
            cmap.colorsNew = bivariateColormapAB3MRI(cnst.cmap2D_FG,cnst.cmap2D_BG,cnst.nBinsCoarse2D+1,cnst.method);

            % interpolate new 2D colormap and reconstruct pixel colors
            cmap.colorsFineNew(:,:,1) = interp2(cmap.Xcoarse,cmap.Ycoarse,cmap.colorsNew(:,:,1),cmap.Xfine,cmap.Yfine,'spline');
            cmap.colorsFineNew(:,:,2) = interp2(cmap.Xcoarse,cmap.Ycoarse,cmap.colorsNew(:,:,2),cmap.Xfine,cmap.Yfine,'spline');
            cmap.colorsFineNew(:,:,3) = interp2(cmap.Xcoarse,cmap.Ycoarse,cmap.colorsNew(:,:,3),cmap.Xfine,cmap.Yfine,'spline');

            cmap.colorList = reshape(cmap.colorsFineNew,[],3);
        otherwise    
        error('illegal option');    
    end
    


    if nargin>3
        disp('saving constants to file');
        save([cnst.cnstDir,char(varargin{4})],'cnst','cmap','colors');
    end
end

