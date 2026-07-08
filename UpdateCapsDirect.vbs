Set oAnsoftApp = CreateObject("Ansoft.ElectronicsDesktop")
Set oDesktop = oAnsoftApp.GetAppDesktop()
Set oProject = oDesktop.GetActiveProject()
Set oDesign = oProject.GetActiveDesign()
oDesign.SetVariableValue "C1", "0.146081pf"
oDesign.SetVariableValue "C2", "0.482681pf"
oDesign.SetVariableValue "C3", "0.914344pf"
oDesign.SetVariableValue "C4", "0.145pf"
oDesign.SetVariableValue "C5", "0.427115pf"
oDesign.SetVariableValue "C6", "0.648362pf"
oDesign.SetVariableValue "C7", "0.273966pf"
oDesign.SetVariableValue "C8", "0.352033pf"
oDesign.SetVariableValue "C9", "0.66476pf"
oDesign.SetVariableValue "C10", "0.518259pf"
oDesign.SetVariableValue "C11", "0.518259pf"
oDesign.SetVariableValue "C12", "0.66476pf"
oDesign.SetVariableValue "C13", "0.352033pf"
oDesign.SetVariableValue "C14", "0.273966pf"
oDesign.SetVariableValue "C15", "0.648362pf"
oDesign.SetVariableValue "C16", "0.427115pf"
oDesign.SetVariableValue "C17", "0.145pf"
oDesign.SetVariableValue "C18", "0.914344pf"
oDesign.SetVariableValue "C19", "0.482681pf"
oDesign.SetVariableValue "C20", "0.146081pf"
