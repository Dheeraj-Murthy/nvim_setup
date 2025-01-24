return {
  "xeluxee/competitest.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  ft = "cpp",
  config = function()
    require("competitest").setup({
      -- Custom configuration if needed
      save_current_file = true,                                   -- Save the current file before running
      testcases_directory = "./testcases",                        -- Custom directory for testcases
      maximum_time = 3000,                                        -- Max execution time in milliseconds
      runner_ui = {
        interface = "popup",                                      -- popup, split                              -- Use popup UI
      },
      companion_port = 27121,                                     -- Ensure this matches the extension's port
      received_problems_path = "$(CWD)/$(PROBLEM).$(FEXT)",       -- Customize as needed
      open_received_problems = true,                              -- Open problem files automatically
    })
  end,
}
