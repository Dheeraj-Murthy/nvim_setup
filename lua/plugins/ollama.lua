return {
    "Dheeraj-Murthy/Ollama_chat.nvim",
    enabled = true,
    config = function()
        require("ollamarun").setup({
            model = "codellama:7b-instruct-q4_0", -- or any other Ollama model
        })
    end
}
