% 1. Open the script file
vbsFile = 'UpdateCapsDirect.vbs';
fid = fopen(vbsFile, 'w');

% 2. FORCE HFSS to look ONLY at what is actively clicked on your monitor
fprintf(fid, 'Set oAnsoftApp = CreateObject("Ansoft.ElectronicsDesktop")\n');
fprintf(fid, 'Set oDesktop = oAnsoftApp.GetAppDesktop()\n');
fprintf(fid, 'Set oProject = oDesktop.GetActiveProject()\n'); % Grabs your open project
fprintf(fid, 'Set oDesign = oProject.GetActiveDesign()\n');   % Grabs your active window

% 3. Loop through and assign variables directly to that active window
for i = 1:length(Cm_mat)
    varName = sprintf('C%d', i);
    varValue = sprintf('%gpf', Cm_mat(i)); 
    
    % This command targets the selected local design properties explicitly
    fprintf(fid, 'oDesign.SetVariableValue "%s", "%s"\n', varName, varValue);
end

fclose(fid);
disp('VBScript generated successfully!');