return {
  {
    "puremourning/vimspector",
    keys = {
      { "<F9>", ":call vimspector#Launch()<cr>" },
      { "Db",   ":call vimspector#ToggleBreakpoint()<cr>" },
      { "Dw",   ":call vimspector#AddWatch()<cr>" },
      { "De",   ":call vimspector#Evaluate()<cr>" },
    },
  },
}
