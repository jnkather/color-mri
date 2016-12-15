% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function setSubplotLabel( FigHandle, Titles)

% this function adds letters (A, B, C, ...) as large titles to all subplots
% in the figure FigHandle

% convert input argument
Titles = fliplr(Titles);

% get all subplots in figure
allAxes = findall(FigHandle,'type','axes'); %,'tag',''

try
    % more than 1 axes
    axPos = cell2mat(get(allAxes,'Position'));
catch
    % just 1 axes
    axPos = get(allAxes,'Position');
end

% sort subplots by position
[~, idx] = sortrows(axPos,1);

    % iterate through all subplots
    for i=idx' %numel(allAxes)
        % make axis current
        set(FigHandle, 'currentaxes', allAxes(i)); 
        % get old title
        oldTitle=get(get(allAxes(i),'Title'),'String');
        % prepare new title
        titleStr = strcat('\fontsize{12} ', char(Titles(i)), 10, '\fontsize{8} ', char(oldTitle));
        % set new title
        title(titleStr,'interpreter','tex'); 
    end
   
end

