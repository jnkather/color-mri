% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

function pauseMyProgram(elapsedTime,maxTime)
      if elapsedTime>maxTime, elapsedTime = maxTime; end % max. pause = maxTime sec
      warning(['Pausing for ', num2str(elapsedTime), ' seconds...']);
      pause(elapsedTime); disp('continuing...'); 
end