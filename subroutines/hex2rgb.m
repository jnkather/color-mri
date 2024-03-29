% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function rgb = hex2rgb(hexString)

% expects a string that contains a hex code of a color. The string can have
% 6 characters (like 'FFFFFF') or 7 characters (like '#FFFFFF'). If the
% string contains 7 characters, the first is stripped. RGB is a
% three-element vector of the red, green, blue value in range 0...1

	if size(hexString,2) ~= 6
        if size(hexString,2) == 7
            % strip first character
            hexString = hexString(2:end);
        else
            error('invalid input: not 6 or 7 characters');
        end
    end    
	
    % hexString has 6 characters
	r = double(hex2dec(hexString(1:2)))/255;
	g = double(hex2dec(hexString(3:4)))/255;
	b = double(hex2dec(hexString(5:6)))/255;
	rgb = [r, g, b];
end