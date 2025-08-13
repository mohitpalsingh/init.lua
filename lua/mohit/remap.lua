
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set(
    "n",
    "<leader>ea",
    "oassert.NoError(err, \"\")<Esc>F\";a"
)

vim.keymap.set(
    "n",
    "<leader>el",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
)


vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- =============================================================================
-- Competitive Programming C++ Workflow
-- =============================================================================
-- C++ compiler and flags
local cpp_compiler = "g++-15"
local cpp_compile_flags = "-std=c++17 -Wshadow -Wall -O2"

-- A helper function that handles the entire compile and run process silently.
local function compile_and_run(is_interactive)
    vim.cmd("write")
    vim.cmd("clear")

    -- Build the compile command
    local file = vim.fn.expand("%:p")
    local executable = vim.fn.expand("%:p:h") .. "/" .. vim.fn.expand("%:t:r")
    local compile_command = cpp_compiler .. " " .. cpp_compile_flags .. " " .. file .. " -o " .. executable

    -- 1. Run compilation and capture any output.
    local compile_output = vim.fn.system(compile_command)

    -- 2. Check if compilation failed.
    if vim.v.shell_error ~= 0 then
        print("Error.")
        -- Display the captured compiler error.
        vim.api.nvim_echo({ {compile_output, "ErrorMsg"} }, true, {})
        return
    end

    -- 3. Build the execution command (no 'time' command needed).
    local run_command
    if is_interactive then
        run_command = executable
    else
        run_command = executable .. " < input.txt > output.txt"
    end

    -- 4. Run the program and capture any output (for runtime errors).
    local run_output = vim.fn.system(run_command)

    -- 5. Check for runtime errors.
    if vim.v.shell_error ~= 0 then
        print("Error.")
        vim.api.nvim_echo({ {run_output, "ErrorMsg"} }, true, {})
        return
    end

    -- 6. If all commands succeeded, print "Done."
    print("Done.")
end

-- F6: Compile & Run with file I/O
vim.keymap.set("n", "<F6>", function() compile_and_run(false) end, { desc = "Compile & Run with file I/O" })

-- F7: Compile & Run interactively
vim.keymap.set("n", "<F7>", function() compile_and_run(true) end, { desc = "Compile & Run interactively" })

-- F8: Quickly open the output file in a vertical split
vim.keymap.set("n", "<F8>", "<cmd>vsplit output.txt<CR>", { desc = "View output.txt" })

-- Disable Copilot for all files in a specific directory
vim.api.nvim_create_autocmd('BufEnter', {
  -- Use the absolute path to your directory. The * at the end is a wildcard for any file inside.
  pattern = '/Users/mohits/Documents/personal/cp/*',
  callback = function()
    vim.b.copilot_enabled = false
  end,
  desc = 'Disable Copilot for a specific project directory',
})
