vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

local jenv = vim.fn.expand('$HOME/.jenv/versions/')
local sdkman = vim.fn.expand('$HOME/.sdkman/candidates/java/')

local resolve_java_bin = function()
  -- todo support graal
  -- try to resolve stable releases only, precedence going to highest version
  for _, version in ipairs({ 21, 17 }) do
    -- try to resolve a jenv version
    local jenv_bin = jenv .. version .. '/bin/java'
    if not jenv_bin:match("graal") and vim.fn.filereadable(jenv_bin) ~= 0 then
      -- check if jenv_bin contains the word graal
      return jenv_bin
    end

    -- try to resolve a sdkman version
    for _, sdkman_bin in ipairs(vim.fn.expand(sdkman .. version .. '/bin/java')) do
      if not sdkman_bin:match("graal") and vim.fn.filereadable(sdkman_bin) ~= 0 then
        return sdkman_bin
      end
    end
  end

  -- fallback to path resolution
  return 'java'
end

local mason = vim.fn.stdpath('data') .. '/mason'
--local jdtls_bin = mason .. '/bin/jdtls'
local jdtls_lombok = mason .. '/share/jdtls/lombok.jar'
local jdtls_plugins = mason .. '/share/jdtls/plugins/'
local jdtls_config_dir = mason .. '/packages/jdtls/'
local java_bin = resolve_java_bin();
local project_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1])
local project_name = vim.fn.fnamemodify(project_dir, ':p:h:t')
local workspace = vim.fn.stdpath('data') .. '/workspace-jdtls/' .. project_name
local jdtls_config = ''
if vim.fn.has('mac') then
  jdtls_config = jdtls_config_dir .. '/config_mac'
elseif vim.fn.has('linux') then
  jdtls_config = jdtls_config_dir .. '/config_linux'
elseif vim.fn.has('win32') then
  jdtls_config = jdtls_config_dir .. '/config_win'
else
  print('Unsupported platform for jdtls')
  return
end
--print('JDTLS using ' .. jdtls_config .. ' platform configuration')

-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
-- And search for `interface RuntimeOption`
-- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
local possible_runtimes = {
  {
    name = "JavaSE-1.8",
    path = jenv .. '1.8',
  },
  {
    name = "JavaSE-11",
    path = jenv .. '11',
  },
  {
    name = "JavaSE-17",
    path = jenv .. '17',
  },
  {
    name = "JavaSE-21",
    path = jenv .. '21',
  },
}

local runtimes = {}
for _, runtime in ipairs(possible_runtimes) do
  if vim.fn.isdirectory(runtime.path) ~= 0 then
    table.insert(runtimes, runtime)
  end
end

local jdtls_cmd = {
  java_bin,
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Djava.import.generatesMetadataFilesAtProjectRoot=false',
  '-Xmx1g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-javaagent:' .. jdtls_lombok,
  '-jar', jdtls_plugins .. 'org.eclipse.equinox.launcher.jar',
  '-configuration', jdtls_config,
  '-data', workspace,
}

vim.g.jdtls_cmd = jdtls_cmd

local bundles = {}
local java_debug = vim.fn.stdpath('data') .. '/jdtls/java-debug'
table.insert(bundles, vim.fn.glob(java_debug .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1))
local java_test = vim.fn.stdpath('data') .. '/jdtls/vscode-java-test'
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test .. "/server/*.jar", 1), "\n"))
local init_options = {
  bundles = bundles
}

local config = {
  cmd = jdtls_cmd,
  --  cmd = {
  --    jdtls_bin,
  --    --"-javaagent:" .. jdtls_lombok,
  --    "--jvm-arg=" .. "-javaagent:" .. jdtls_lombok,
  --  },
  root_dir = project_dir,
  settings = {
    java = {
      home = jenv .. '17',
      import = {
        maven = {
          enabled = true,
        },
        gradle = {
          annotationProcessing = {
            enabled = true
          },
          enabled = true,
          wrapper = {
            enabled = true,
          }
        },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "/build/**"
        },
      },
      jdt = {
        ls = {
          lombokSupport = {
            enabled = true
          }
        }
      },
      referenceCodeLens = {
        enabled = true,
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        }
      },
      configuration = {
        runtimes = runtimes
      }
      --      codeGeneration = {
      --        hashCodeEquals = {
      --          useInstanceof = true,
      --          useJava7Objects = true
      --        },
      --        toString = {
      --          codeStyle = "STRING_BUILDER_CHAINED"
      --        },
      --        useBlocks = true,
      --      },
    }
  },
  init_options = init_options,
}
require('jdtls').start_or_attach(config)
