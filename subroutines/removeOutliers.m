% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function imgOut = removeOutliers( imgIn, percentiles )

    % check for validity of parameters
    if numel(percentiles) ~= 2
        error('invalid argument');
    end
    
    % convert input image to double
    imgOut = double(imgIn);
    
    % show status
    disp('removing outliers...');
    disp(['PRE: ',num2str(mean(imgOut(:))),' +/- ', ...
        num2str(std(imgOut(:))), ' max ', num2str(max(imgOut(:)))]);
    
    % calculate intensity cutoff values based on percentiles
    cutoffs = prctile(imgOut(:),[percentiles(1),percentiles(2)]);
    
    % remove everything below / above the n-th/m-th percentile
    imgOut(imgOut(:)<cutoffs(1)) = cutoffs(1); 
    imgOut(imgOut(:)>cutoffs(2)) = cutoffs(2); 
    
    % show status
    disp(['POST: ',num2str(mean(imgOut(:))),' +/- ', ...
        num2str(std(imgOut(:))), ' max ', num2str(max(imgOut(:)))]);

end

