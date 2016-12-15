% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

clear all, clc, close all

colors = colorSet('L50opt-60deg');

% color interpolation method in LAB space
cnst.method='linear';
cnst.loadDir = '../mri-input/'; % default 'input/'
cnst.imgResolution = '-r450';
cnst.saveDir = '../mri-output/'; % default 'output/'
cnst.savePNG = true;

load([cnst.loadDir,char('Prostate-Color-186')]);
Dataset.AnnotationsSavedir = strcat(cnst.saveDir, Dataset.Name,'/', Dataset.Dir, ...
        'Annotations/');

% number of different color levels in each dimension
cnst.nBins = 25; % default: 30; no perceivable difference above 30

% create color map and save to 'cmap' structure
[cmap.colorsNew, cmap.Xq, cmap.Yq, cmap.Zq] = ...
    trivariateColormapAB3MRI(colors.A, colors.B, colors.C, ...
    colors.AB, colors.BC, colors.AC, cnst.nBins, cnst.method);

% gamut as reference
numGa = 600;
[ gamutX,gamutY,gamutZ,gamutRGB ] = gamut( numGa, 0 );
        
% convert to CIELAB
cmap.LAB = rgb2lab(cmap.colorsNew);


% figure()
% scatter3(gamutX,gamutY,gamutZ,15,gamutRGB,'filled'); %
% hold on
% scatter3(cmap.LAB(:,1),cmap.LAB(:,2),cmap.LAB(:,3),250,cmap.colorsNew,'filled');
% lo.x = 0; lo.y = -60; hi.x = 100; hi.y = 100;
% plotPlane(colA,colB,colC,lo,hi);
% 
%     figure()
%     xes = colorsNew_LAB(:,1);
%     ys = colorsNew_LAB(:,2);
%     labs = colorsNew_LAB(:,3);
%     cs = cmap.colorsNew;
%     mask = ~~labs;
%     scatter(xes(mask),ys(mask),150,cs(mask),'filled');
%     axis equal tight
%     
%     
%     

%% circular color map
% create circular color map
xc = linspace(0,1,7);
nPointsCirc = 300; % default 300
nPointsRad = nPointsCirc; % default
ballSize = 30; % default 30
neutralL = 100;

cc = zeros(7,nPointsRad,3);
    
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

neutralElement = [neutralL,0,0];

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
xq = linspace(0,1,nPointsCirc);
cq = zeros(nPointsCirc,3);

% plot circle
figure()
phi = linspace(0,2*pi,nPointsCirc);

hold on
r = linspace(0,1,nPointsCirc);

for j = 1:nPointsCirc

    % perform interpolation
    cq(:,1) = interp1(xc,cc(:,nPointsRad+1-j,1),xq);
    cq(:,2) = interp1(xc,cc(:,nPointsRad+1-j,2),xq);
    cq(:,3) = interp1(xc,cc(:,nPointsRad+1-j,3),xq);
    % go back to RGB
    cq=lab2rgb(cq);

    xp=r(j)*cos(phi);
    yp=r(j)*sin(phi);
    scatter(xp,yp,ballSize,cq,'filled');
    %scatter(repmat(r(j),[numel(phi),1]),phi,100,cq,'filled');
    hold on

end
axis square tight off
set(gcf,'Color','w');

% plot the three main corners, nPoints = 4 because of circular folding
nPoints = 4;
xq = linspace(0,1,nPoints);
phi = linspace(0,2*pi,nPoints);
xp=1.25*cos(phi);
yp=1.25*sin(phi);

    % text on top
text(xp,yp,{regexprep(Dataset.Channel1.ShortName,' ','\n'),...
    regexprep(Dataset.Channel2.ShortName,' ','\n'),...
    regexprep(Dataset.Channel3.ShortName,' ','\n'),''},...
'FontSize',14,'HorizontalAlignment','center',...
'VerticalAlignment','middle','FontWeight','bold');

xp=1.05*cos(phi);
yp=1.05*sin(phi); 
scatter(xp,yp,50,[0 0 0 ],'filled');

if cnst.savePNG
print(gcf,[Dataset.AnnotationsSavedir, '/Circular_Legend_Full','.png'],...
    '-dpng',cnst.imgResolution);
end

%     
%     % interpolate colors on a circle
%     nPoints = 4;
%     xq = linspace(0,1,nPoints);
%     cq = zeros(nPoints,3);
%     % perform interpolation
%     cq(:,1) = interp1(xc,cc(:,1),xq);
%     cq(:,2) = interp1(xc,cc(:,2),xq);
%     cq(:,3) = interp1(xc,cc(:,3),xq);
%     % go back to RGB
%     cq=lab2rgb(cq);
% 
%     % plot circle
%     hold on
%     r  = 1;
%     phi = linspace(0,2*pi,nPoints);
%     xp=r*cos(phi);
%     yp=r*sin(phi);
%     scatter(r,phi,100,cq,'filled');
%     %scatter(xp,yp,1000,cq,'filled');
%     axis equal
%     axis off
%     set(gcf,'Color','w');
% 

figure()
vertices = [colW ; colA ; colB ; colC ; colAB ; colBC ; colAC ; colK];
DT = delaunayTriangulation(vertices(:,1),vertices(:,2),vertices(:,3));
Hull = convexHull(DT);
faceColor  = [0.6875 0.8750 0.8984];
trisurf(Hull,DT.Points(:,1),DT.Points(:,2),DT.Points(:,3),...
    'FaceColor',[0 0 0],'FaceAlpha',0.3);%faceColor,'FaceAlpha',0.3);
hold on
scatter3(vertices(:,1),vertices(:,2),vertices(:,3),500,lab2rgb(vertices),...
    'filled','MarkerEdgeColor',[0 0 0],'LineWidth',5);
%scatter3(gamutX,gamutY,gamutZ,15,gamutRGB,'filled');
xlabel('L'),ylabel('a'),zlabel('b');
axis equal
grid on
axis off
set(gcf,'Color','w');

view(0,30)
if cnst.savePNG
print(gcf,[Dataset.AnnotationsSavedir, 'Hexagon_3D_-10,30','.png'],...
    '-dpng',cnst.imgResolution);
end

view(60,30)
if cnst.savePNG
print(gcf,[Dataset.AnnotationsSavedir, 'Hexagon_3D_-70,30','.png'],...
    '-dpng',cnst.imgResolution);
end


view(-60,30)
if cnst.savePNG
print(gcf,[Dataset.AnnotationsSavedir, 'Hexagon_3D_50,30','.png'],...
    '-dpng',cnst.imgResolution);
end


    % suptitle('color legend for trivariate reconstruction');
