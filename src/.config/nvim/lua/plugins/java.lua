--local setup_debug = function()
--  local java_debug = vim.fn.stdpath('data') .. '/jdtls/java-debug'
--  local java_test = vim.fn.stdpath('data') .. '/jdtls/vscode-java-test'
--
--  local debug_build_script = vim.fn.isdirectory(java_debug) == 0
--      and 'git clone https://github.com/microsoft/java-debug ' .. java_debug
--      or 'git -C ' .. java_debug .. ' pull'
--  debug_build_script = debug_build_script .. ' && cd ' .. java_debug .. ' && ./mvnw clean package'
--
--  local test_build_script = vim.fn.isdirectory(java_test) == 0
--      and 'git clone https://github.com/microsoft/vscode-java-test ' .. java_test
--      or 'git -C ' .. java_test .. ' pull'
--  test_build_script = test_build_script .. ' && cd ' .. java_test .. ' && npm install && npm run build-plugin'
--
--  return {
--    debug_build_script,
--    test_build_script,
--  }
--end

return {
  "mfussenegger/nvim-jdtls",
  --dependencies = {
  --    "mfussenegger/nvim-dap"
  --},
  --build = setup_debug(),
}
