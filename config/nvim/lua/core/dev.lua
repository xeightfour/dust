function ReloadConfig()
    for name, i in pairs(package.loaded) do
        if name:match('core/*') or name:match('plug/*') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    vim.notify('Reloaded!', vim.log.levels.INFO)
end

function nmap(shortcut, command)
    vim.keymap.set('n', shortcut, command, {})
end
function imap(shortcut, command)
    vim.keymap.set('i', shortcut, command, {})
end
function vmap(shortcut, command)
    vim.keymap.set('v', shortcut, command, {})
end
function tmap(shortcut, command)
    vim.keymap.set('t', shortcut, command, {})
end
