return {
    "Dheeraj-Murthy/Ollama_chat.nvim",
    -- dir = "~/Dev/nvim_plugin/ollama_chat.nvim",
    enabled = true,
    config = function()
        require("ollama_chat").setup({
            model = "codellama:13b-instruct-q4_k_m", -- or any other Ollama model
        })
    end
}
