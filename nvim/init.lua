if vim.env.EDITOR == "vim" then
    local nvimrc = vim.fn.stdpath("config") .. "/nvimrc.vim"
    vim.cmd.source(nvimrc)
end
