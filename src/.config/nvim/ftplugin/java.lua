local mason = vim.fn.stdpath('data') .. '/mason'
local jdtls_bin = mason .. '/bin/jdtls'
local jdtls_lombok = mason .. '/share/jdtls/lombok.jar'
local jdtls_plugins = mason .. '/share/jdtls/plugins/'
local jdtls_config = mason .. '/packages/jdtls/config_mac'
-- todo configure somewhere better
local jenv = vim.fn.expand('$HOME/.jenv/versions/')
local java_bin = jenv .. '17/bin/java'
local project_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])
local project_name = vim.fn.fnamemodify(project_dir, ':p:h:t')
local workspace = vim.fn.stdpath('data') .. '/workspace-jdtls/' .. project_name

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
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
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
        },
        imports = {
          maven = {
            enabled = true,
          },
          gradle = {
            enabled = true,
            wrapper = {
              enabled = true,
            }
          },
          signatureHelp = {
            enabled = true,
          }
        },
        jdt = {
          ls = {
            lombokSupport = {
              enabled = true
            }
          }
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          }
        }
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
  }
}
require('jdtls').start_or_attach(config)
