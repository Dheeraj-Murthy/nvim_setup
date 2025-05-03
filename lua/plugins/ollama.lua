return {
    "nvim-lua/plenary.nvim",
    name = "ollamarun",
    config = function()
        local chat_bufnr = nil
        local response_buffer = ""
        local response_line = nil

        local function clean_output(str)
            return str
                :gsub('\27%[[0-9;]*[a-zA-Z]', '')
                :gsub('\r', '')
                :gsub('\x1b%]133;.-', '')
        end

        local function get_chat_buf()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):match("OllamaChat%.md$") then
                    return buf
                end
            end
            return nil
        end

        vim.api.nvim_create_user_command("OllamarunChat", function()
            -- Check for existing buffer by name
            chat_bufnr = get_chat_buf()

            if not chat_bufnr then
                chat_bufnr = vim.api.nvim_create_buf(true, false)
                vim.api.nvim_buf_set_name(chat_bufnr, "OllamaChat.md")
                vim.api.nvim_buf_set_option(chat_bufnr, 'filetype', 'markdown')
                vim.api.nvim_buf_set_option(chat_bufnr, 'wrap', true)
                vim.api.nvim_buf_set_option(chat_bufnr, 'linebreak', true)
            end

            vim.api.nvim_set_current_buf(chat_bufnr)

            -- Set keymap only once per buffer
            if not vim.b[chat_bufnr].ollamarun_mapped then
                vim.keymap.set("n", "<CR>", function()
                    local lines = vim.api.nvim_buf_get_lines(chat_bufnr, 0, -1, false)
                    local last_line = lines[#lines]

                    if not last_line or last_line == "" then
                        print("No input")
                        return
                    end

                    vim.api.nvim_buf_set_lines(chat_bufnr, -1, -1, false, { "🤖 Thinking..." })
                    response_buffer = ""
                    response_line = vim.api.nvim_buf_line_count(chat_bufnr) - 1

                    local cmd = { "ollama", "run", "deepseek-coder-v2" }
                    local job_id = vim.fn.jobstart(cmd, {
                        stdout_buffered = false,
                        stderr_buffered = false,
                        stdin = "pipe",
                        stderr = "stdout",
                        on_stdout = function(_, data)
                            if not data then return end

                            response_buffer = response_buffer .. table.concat(data, '\n')

                            vim.schedule(function()
                                if not response_line or not vim.api.nvim_buf_is_valid(chat_bufnr) then
                                    return
                                end

                                local cleaned = clean_output(response_buffer)
                                local lines = vim.split(cleaned, '\n', { trimempty = false })

                                local new_text = clean_output(table.concat(data, '\n'))
                                local new_lines = vim.split(new_text, '\n', { trimempty = false })
                                local line_count = vim.api.nvim_buf_line_count(chat_bufnr)

                                vim.api.nvim_buf_set_lines(
                                    chat_bufnr,
                                    response_line,
                                    line_count,
                                    false,
                                    lines
                                )

                                -- if #new_lines > 1 then
                                --     vim.api.nvim_buf_set_lines(chat_bufnr, response_line + 1, response_line + 1, false,
                                --         { unpack(new_lines, 2) })
                                -- end
                            end)
                        end,
                        -- on_exit = function()
                        --     vim.schedule(function()
                        --         if not response_line then return end
                        --
                        --         local cleaned = clean_output(response_buffer)
                        --         local lines = vim.split(cleaned, '\n', { trimempty = false })
                        --
                        --         -- vim.api.nvim_buf_set_lines(
                        --         --     chat_bufnr,
                        --         --     response_line,
                        --         --     response_line + 1,
                        --         --     false,
                        --         --     lines
                        --         -- )
                        --         response_line = nil
                        --     end)
                        -- end
                    })

                    vim.fn.chansend(job_id, last_line .. "\n")
                    vim.fn.chanclose(job_id, "stdin")
                end, { buffer = chat_bufnr, noremap = true, silent = true })

                vim.b[chat_bufnr].ollamarun_mapped = true -- Mark buffer as mapped
            end
        end, {})
    end,
}
