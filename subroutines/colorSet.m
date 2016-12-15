% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function colors = colorSet(colorScheme)

if strcmp(colorScheme,'L50')
%Luminance 50 
colors.AC = '1173FE'; 
colors.BC = 'EA0A02'; 
colors.AB = '138A0C'; 

colors.C = 'CF33A3'; 
colors.A = '0C839D';
colors.B = 'A06B10';

elseif strcmp(colorScheme,'L50opt')
%Luminance 50

colors.AC = '1173FE'; % Blue
colors.BC = 'F40000'; % Red
colors.AB = '009100'; % Green

colors.C = 'EB009C'; % magenta       rgb2hex(lab2rgb([50 89.23 -24.62]))
colors.A = '008B8E'; % cyan          rgb2hex(lab2rgb([50 -31.86 -29.83]))
colors.B = 'A27200'; % orange        rgb2hex(lab2rgb([50 15.57 81.43]))

%50 14.24 81.83

elseif strcmp(colorScheme,'L50opt-60deg')
    
colors.AC = 'EB009C'; % was Blue
colors.BC = 'A27200'; % was Red
colors.AB = '008B8E'; % was Green

colors.C = 'F40000'; % was magenta       rgb2hex(lab2rgb([50 89.23 -24.62]))
colors.A = '1173FE'; % was cyan          rgb2hex(lab2rgb([50 -31.86 -29.83]))
colors.B = '009100'; % was orange        rgb2hex(lab2rgb([50 15.57 81.43]))


elseif strcmp(colorScheme,'L75')
% Luminance 75 

colors.A = '3CCFAF'; % cyan
colors.B = 'FEA30B'; % orange
colors.C = 'E99FED'; % violet

colors.AB = '82CA72';
colors.BC = 'FC9F92';
colors.AC = 'A9B6FE';    
    

elseif strcmp(colorScheme,'defaultOnPlane')
% main colors
colors.A = '008CFF';
colors.B = 'FFFF00';
colors.C = 'FF0000';

% intermediate colors
colors.AB = 'C1C2A5'; 
colors.BC = 'FFA100';
colors.AC = 'CD6386';    

elseif strcmp(colorScheme,'defaultOrig')
% main colors
colors.A = '0073CC';
colors.B = 'FFFF00';
colors.C = 'FF0000';

% intermediate colors
colors.AB = '8EE8A3';
colors.BC = 'FFA700';
colors.AC = 'CB2EB8';    
else
    error('unknown argument');
end

end
