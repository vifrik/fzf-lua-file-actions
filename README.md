# fzf-lua-file-actions

See [fzf-lua](https://github.com/ibhagwan/fzf-lua)

# Contents
- [Description](#description)
- [Installation](#istallation)
- [Actions](#actions)

## Description
fzf-lua-file-actions is a simple plugin to extend the actions of fzf-lua on files

## Installation

### lazy.nvim
```lua
local M = {
    'ibhagwan/fzf-lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        {
            'vifrik/fzf-lua-file-actions',
            dependencies = { 'nvim-lua/plenary.nvim' },
        },
    },
}

function M.config()
    local fzf = require('fzf-lua')
    local actions = require('fzf-lua.actions')
    local file_actions = require('fzf-lua-file-actions')

    fzf.setup({
        files = {
            actions = {
                -- Default action to open file
                ["default"] = actions.file_edit,
                ["ctrl-e"] = file_actions.edit,
                -- set reload = true to keep fzf-lua open
                ["ctrl-y"] = { fn = file_actions.yank, reload = true },
                ["ctrl-t"] = { fn = file_actions.touch, reload = true },
                ["ctrl-r"] = { fn = file_actions.rename, reload = true },
                ["ctrl-d"] = { fn = file_actions.delete, reload = true },
            },
        },
    })
end

return M
```

## Actions
| Action            | Description                                |
| ----------------- | ------------------------------------------ |
| `edit`            | open buffer without writing to file        |
| `yank`            | copy file                                  |
| `touch`           | create file                                |
| `rename`          | rename file                                |
| `delete`          | delete file                                |

