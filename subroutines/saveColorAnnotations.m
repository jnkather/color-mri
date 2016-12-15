% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function saveColorAnnotations(colors,cmap,cnst,Dataset,bgColor)

%% circular color map
    % create circular color map
    xc = linspace(0,1,7);
    nPoints = 250;
    nPointsRad = nPoints; % default
    cc = zeros(7,nPointsRad,3);
    neutralL = 100;
    neutralElement = [neutralL,0,0];
    ballSize = 450;
    
    % read hex colors from variables
    colW = rgb2lab(hex2rgb('000000')); 
    colA = rgb2lab(hex2rgb(char(colors.A)));
    colB = rgb2lab(hex2rgb(char(colors.B)));    
    colC = rgb2lab(hex2rgb(char(colors.C)));
    colAB = rgb2lab(hex2rgb(char(colors.AB)));
    colBC = rgb2lab(hex2rgb(char(colors.BC)));    
    colAC = rgb2lab(hex2rgb(char(colors.AC)));
    colK = rgb2lab(hex2rgb('FFFFFF'));

    % store colors in one matrix in the right order
    cc(1,1,:) = colA;
    cc(2,1,:) = colAB;
    cc(3,1,:) = colB;
    cc(4,1,:) = colBC;
    cc(5,1,:) = colC;
    cc(6,1,:) = colAC;
    cc(7,1,:) = colA;
    
    cc(1,nPointsRad,:) = neutralElement;
    cc(2,nPointsRad,:) = neutralElement;
    cc(3,nPointsRad,:) = neutralElement;
    cc(4,nPointsRad,:) = neutralElement;
    cc(5,nPointsRad,:) = neutralElement;
    cc(6,nPointsRad,:) = neutralElement;
    cc(7,nPointsRad,:) = neutralElement;

    % fill lines
    for k = 1:size(cc,1)
       cc(k,:,1) = interp1([1,nPointsRad],[cc(k,1,1),cc(k,nPointsRad,1)],1:nPointsRad);
       cc(k,:,2) = interp1([1,nPointsRad],[cc(k,1,2),cc(k,nPointsRad,2)],1:nPointsRad);
       cc(k,:,3) = interp1([1,nPointsRad],[cc(k,1,3),cc(k,nPointsRad,3)],1:nPointsRad);
    end

    % interpolate colors on a circle
    xq = linspace(0,1,nPoints);
    cq = zeros(nPoints,3);

    %---- 1st part: full circle
    figure()
    phi = linspace(0,2*pi,nPoints);
    r = linspace(0,1,nPoints);

    for j = 1:nPoints
        % perform interpolation
        cq(:,1) = interp1(xc,cc(:,nPointsRad+1-j,1),xq);
        cq(:,2) = interp1(xc,cc(:,nPointsRad+1-j,2),xq);
        cq(:,3) = interp1(xc,cc(:,nPointsRad+1-j,3),xq);
        % go back to RGB
        cq=lab2rgb(cq);
        xp=r(j)*cos(phi);
        yp=r(j)*sin(phi);
        scatter(xp,yp,ballSize,cq,'filled');
        hold on
    end
    
    %---- 2nd part: legends
    % interpolate colors on a circle
    nPoints = 4;
    xq = linspace(0,1,nPoints);
    cq = zeros(nPoints,3);
    % perform interpolation
    cq(:,1) = interp1(xc,cc(:,1,1),xq);
    cq(:,2) = interp1(xc,cc(:,1,2),xq);
    cq(:,3) = interp1(xc,cc(:,1,3),xq);
    % go back to RGB
    cq=lab2rgb(cq);

    % plot legends
    hold on
    r  = 1;
    phi = linspace(0,2*pi,nPoints);
    xp=r*cos(phi);
    yp=r*sin(phi);
    
    % plot large circles for legends
    scatter(xp,yp,5000,cq,'filled');
    axis equal off
    set(gcf,'Color',bgColor);

    % text on top
    text(xp,yp,{regexprep(Dataset.Channel1.ShortName,' ','\n'),...
        regexprep(Dataset.Channel2.ShortName,' ','\n'),...
        regexprep(Dataset.Channel3.ShortName,' ','\n'),''},...
    'FontSize',14,'HorizontalAlignment','center',...
    'VerticalAlignment','middle','FontWeight','bold');

    % suptitle('color legend for trivariate reconstruction');
    fh = gcf;
    fh.InvertHardcopy = 'off'; % use specified figure background color for printing
    
    print(gcf,[Dataset.AnnotationsSavedir, 'Circular_Legend','.png'],...
        '-dpng',cnst.imgResolution);

    close(gcf);
    
    %% CIELAB Plot
    
    % show new Colors in LAB space
    figure()
    hold on
%     numGa = 600;
%     [ gamutX,gamutY,gamutZ,gamutRGB ] = gamut( numGa, 0 );
%         scatter3(gamutX,gamutY,gamutZ,15,gamutRGB,'filled'); %

    colorsNew_LAB = rgb2lab(cmap.colorsNew);
    scatter3(colorsNew_LAB(:,1),colorsNew_LAB(:,2),colorsNew_LAB(:,3),...
        30,cmap.colorsNew,'filled');
    xlabel('L');ylabel('a');zlabel('b');
    axis equal tight
    set(gcf,'Color','w')

    v =    [162,-24];
             view(v)
             grid off
             title('image colors in CIELAB space')

    drawnow
    print(gcf,[Dataset.AnnotationsSavedir, 'CIELAB_view','.png'],...
        '-dpng',cnst.imgResolution);
    
    %close(gcf);
    
end