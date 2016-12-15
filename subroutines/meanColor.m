% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function meanhex = meanColor( col1hex, col2hex )

meanhex = rgb2hex(lab2rgb(mean([rgb2lab(hex2rgb(col1hex)); ...
                                rgb2lab(hex2rgb(col2hex))])));

end

