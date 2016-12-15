% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

% project points on a plane in 3D
% N=normal, point=Point on Plane
function pointsOut = projectOnPlane(pointsIn, normal, point) 
    pointsIn=double(pointsIn);
    [m,n]=size(pointsIn);
    normal = normal/norm(normal);  % normalize the normal vector
    N2 = normal.'*normal;
    pointsOut = pointsIn*(eye(3)-N2)+repmat(point*N2,m,1);
end