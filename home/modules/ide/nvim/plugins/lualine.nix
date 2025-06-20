{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "tokyonight";
        always_divide_middle = true;
        ignore_focus = [ "neo-tree" ];
        globalstatus = true; # single statusline at the bottom of Neovim
        disabled_filetypes.statusline = [
          "dashboard"
          "alpha"
        ];
        section_separators = {
          left = "";
          right = "";
        };
      };

      extensions = [ "fzf" ];

      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];

        lualine_y = [
          {
            __unkeyed = "progress";
            separator = "";
          }
          {
            __unkeyed = "location";
            separator = "";
            padding = {
              left = 0;
              right = 1;
            };
          }
        ];

        lualine_z = [
          ''" " .. os.date("%R")''
        ];
      };
    };
  };

  extraConfigLua = ''
        -- helper for linking highlight‑group foregrounds
        local ui = {}
    		
     		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
      	vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

        function ui.fg(name)
          local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
                    or vim.api.nvim_get_hl_by_name(name, true)
          local fg = hl and (hl.fg or hl.foreground)
          return fg and { fg = string.format("#%06x", fg) } or nil
        end

        ---@param opts? {relative: "cwd"|"root", modified_hl: string?}
        function ui.pretty_path(opts)
          opts = vim.tbl_extend("force", {
            relative     = "cwd",
            modified_hl  = "Constant",
          }, opts or {})

          return function()
            local path = vim.fn.expand("%:p")
            if path == "" then return "" end

            local bufname = vim.fn.bufname(vim.fn.bufnr())
            local sep     = package.config:sub(1, 1)
            local root    = (opts.relative == "root") and vim.fn.getcwd()
                           or vim.fn.fnamemodify(bufname, ":h")
            local cwd     = vim.fn.getcwd()

            path = (opts.relative == "cwd" and path:find(cwd, 1, true) == 1)
                 and path:sub(#cwd + 2) or path:sub(#root + 2)

            local parts = vim.split(path, "[\\/]")
            if #parts > 3 then
              parts = { parts[1], "…", parts[#parts-1], parts[#parts] }
            end

            if opts.modified_hl and vim.bo.modified then
              local hl_fg = ui.fg(opts.modified_hl)
              if hl_fg then
                parts[#parts] = string.format("%%#%s#%s%%*", opts.modified_hl, parts[#parts])
              end
            end

            return table.concat(parts, sep)
          end
        end

        require("lualine").setup({
          sections = {
            lualine_c = {
              {
                "diagnostics",
                symbols = {
                  error = " ", 
                  warn  = " ", 
                  hint  = " ", 
                  info  = " ", 
                },
                separator = ")",
              },
              { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
              { ui.pretty_path() },
            },

            lualine_x = {
              {
                function() return require("noice").api.status.command.get() end,
                cond   = function() return package.loaded["noice"]
                                     and require("noice").api.status.command.has() end,
                color  = ui.fg("Statement"),
                separator = "(",
              },
              {
                function() return require("noice").api.status.mode.get() end,
                cond   = function() return package.loaded["noice"]
                                     and require("noice").api.status.mode.has() end,
                color  = ui.fg("Constant"),
                separator = "(",
              },
              {
                function() return " " .. require("dap").status() end,  
                cond   = function() return package.loaded["dap"]
                                     and require("dap").status() ~= "" end,
                color  = ui.fg("Debug"),
                separator = "(",
              },
              {
                function()
                  local buf_ft  = vim.api.nvim_buf_get_option(0, "filetype")
                  for _, client in ipairs(vim.lsp.get_clients()) do
                    if client.config.filetypes
                       and vim.fn.index(client.config.filetypes, buf_ft) ~= -1 then
                      return client.name
                    end
                  end
                  return ""
                end,
                color     = ui.fg("StatusLine"),
                separator = "(",
              },
              {
                "diff",
                symbols = {
                  added    = " ",
                  modified = " ", 
                  removed  = " ",  
                },
              },
            },
          },
        })
  '';
}
