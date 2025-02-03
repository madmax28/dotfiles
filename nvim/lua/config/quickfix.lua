-- Quickfix nav
vim.keymap.set('n', '<leader><tab>', ':cn<cr>')
vim.keymap.set('n', '<leader><s-tab>', ':cp<cr>')

-- Togle quickfix/loclist
vim.cmd([[
    function! s:GetBufferList()
      redir =>buflist
      silent! ls
      redir END
      return buflist
    endfunction

    function! ToggleList(bufname, pfx)
      let buflist = s:GetBufferList()
      for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
          exec(a:pfx.'close')
          return
        endif
      endfor
      if a:pfx == 'l' && len(getloclist(0)) == 0
          echohl ErrorMsg
          echo "Location List is Empty."
          return
      endif
      let winnr = winnr()
      exec(a:pfx.'open')
      if winnr() != winnr
        wincmd p
      endif
    endfunction
]])
vim.keymap.set('n', '<leader>l', ':call ToggleList("Location List", "l")<cr>', { silent = true })
vim.keymap.set('n', '<leader>q', ':call ToggleList("Quickfix List", "c")<cr>:pclose<cr>', { silent = true })

-- Maximize quickfix windows' width
vim.cmd([[
    function! MaxQuickfixWin()
        if &buftype ==# "quickfix"
            execute "normal! \<c-w>J"
        endif
    endfunction
    augroup MaxQuickfixWinGrp
        autocmd!
        autocmd BufWinEnter * call MaxQuickfixWin()
    augroup END
]])
