return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    local jdtls = require("jdtls")

    -- Expand home path
    local jdtls_path = vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")
    -- If Mason jdtls fails, fallback to system jdtls
    if vim.fn.executable(jdtls_path) == 0 then
      jdtls_path = "/usr/bin/jdtls"
    end

    -- Detect root dir
    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
    local root_dir = require("jdtls.setup").find_root(root_markers)
    if root_dir == nil then
      vim.notify("JDTLS: No project root found", vim.log.levels.ERROR)
      return
    end

    -- Workspace folder
    local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    local config = {
      cmd = { jdtls_path, "-data", workspace_dir },
      root_dir = root_dir,
      settings = { java = {} },
    }

    jdtls.start_or_attach(config)
  end,
}
