Set oAnsoftApp = CreateObject("Ansoft.ElectronicsDesktop")
Set oDesktop = oAnsoftApp.GetAppDesktop()
Set oProject = oDesktop.GetActiveProject()
Set oDesign = oProject.GetActiveDesign()
oDesign.SetVariableValue "C1", "0.143992pf"
oDesign.SetVariableValue "C2", "0.480929pf"
oDesign.SetVariableValue "C3", "0.914671pf"
oDesign.SetVariableValue "C4", "0.142207pf"
oDesign.SetVariableValue "C5", "0.427425pf"
oDesign.SetVariableValue "C6", "0.648132pf"
oDesign.SetVariableValue "C7", "0.273867pf"
oDesign.SetVariableValue "C8", "0.352234pf"
oDesign.SetVariableValue "C9", "0.664771pf"
oDesign.SetVariableValue "C10", "0.518252pf"
oDesign.SetVariableValue "C11", "0.518252pf"
oDesign.SetVariableValue "C12", "0.664771pf"
oDesign.SetVariableValue "C13", "0.352234pf"
oDesign.SetVariableValue "C14", "0.273867pf"
oDesign.SetVariableValue "C15", "0.648132pf"
oDesign.SetVariableValue "C16", "0.427425pf"
oDesign.SetVariableValue "C17", "0.142207pf"
oDesign.SetVariableValue "C18", "0.914671pf"
oDesign.SetVariableValue "C19", "0.480929pf"
oDesign.SetVariableValue "C20", "0.143992pf"
