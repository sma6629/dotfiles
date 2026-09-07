return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    local opencode_cmd = "opencode --port"
    ---@type snacks.terminal.Opts
    local term_opts = {
      win = {
        position = "right",
        enter = false,
      },
    }

    local function toggle_opencode()
      require("snacks").terminal.toggle(opencode_cmd, term_opts)
    end

    local function map_opencode_terminal(buf)
      local opts = { buffer = buf, silent = true }

      vim.keymap.set({ "t", "n" }, "<C-w>q", toggle_opencode, vim.tbl_extend("force", opts, { desc = "Close opencode window" }))
      vim.keymap.set("t", "<C-w>h", [[<C-\><C-n><C-w>h]], vim.tbl_extend("force", opts, { desc = "Move to left window" }))
      vim.keymap.set("t", "<C-w>j", [[<C-\><C-n><C-w>j]], vim.tbl_extend("force", opts, { desc = "Move to lower window" }))
      vim.keymap.set("t", "<C-w>k", [[<C-\><C-n><C-w>k]], vim.tbl_extend("force", opts, { desc = "Move to upper window" }))
      vim.keymap.set("t", "<C-w>l", [[<C-\><C-n><C-w>l]], vim.tbl_extend("force", opts, { desc = "Move to right window" }))
    end

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type or field for details
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Use terminal-safe mappings so they survive tmux and terminal key handling.
    vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<leader>ox", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
    vim.keymap.set("n", "<leader>oo", toggle_opencode,                                                        { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<leader>ou", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<leader>od", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

    vim.api.nvim_create_autocmd("TermOpen", {
      callback = function(event)
        local buf = event.buf
        local name = vim.api.nvim_buf_get_name(buf)
        local term = vim.b[buf].snacks_terminal
        if name:match("opencode %-%-port") or (term and term.cmd == opencode_cmd) then
          map_opencode_terminal(buf)
        end
      end,
    })
  end,
}
