Set oAnsoftApp = CreateObject("Ansoft.ElectronicsDesktop")
Set oDesktop = oAnsoftApp.GetAppDesktop()
Set oProject = oDesktop.GetActiveProject()
Set oDesign = oProject.GetActiveDesign()
oDesign.SetVariableValue "C1", "0.140013pf"
oDesign.SetVariableValue "C2", "0.492158pf"
oDesign.SetVariableValue "C3", "0.925645pf"
oDesign.SetVariableValue "C4", "0.148377pf"
oDesign.SetVariableValue "C5", "0.4171pf"
oDesign.SetVariableValue "C6", "0.629649pf"
oDesign.SetVariableValue "C7", "0.225557pf"
oDesign.SetVariableValue "C8", "0.36956pf"
oDesign.SetVariableValue "C9", "0.641627pf"
oDesign.SetVariableValue "C10", "0.513543pf"
oDesign.SetVariableValue "C11", "0.513543pf"
oDesign.SetVariableValue "C12", "0.641627pf"
oDesign.SetVariableValue "C13", "0.36956pf"
oDesign.SetVariableValue "C14", "0.225557pf"
oDesign.SetVariableValue "C15", "0.629649pf"
oDesign.SetVariableValue "C16", "0.4171pf"
oDesign.SetVariableValue "C17", "0.148377pf"
oDesign.SetVariableValue "C18", "0.925645pf"
oDesign.SetVariableValue "C19", "0.492158pf"
oDesign.SetVariableValue "C20", "0.140013pf"
