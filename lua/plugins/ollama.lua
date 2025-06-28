return {
    "Dheeraj-Murthy/Ollama_chat.nvim",
    enabled = true,
    config = function()
        require("ollamarun").setup({
            model = "deepseek-coder-v2", -- or any other Ollama model
        })
    end
}
