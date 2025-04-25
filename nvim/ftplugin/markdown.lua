function MarkdownFoldExpr()
    local line = vim.v.lnum - 1
    local node = vim.treesitter.get_node({
        pos = { line, 0 }
    })

    -- Find the section we are in
    while node ~= nil and node:type() ~= 'section' do
        node = node:parent()
    end

    -- Not inside a section
    if node == nil then return '0' end

    local fold = ''
    local start_row, _, end_row, _ = node:range(false)
    if start_row == end_row - 1 then
        -- Single line sections do not create folds
        node = node:parent()
    elseif line == start_row then
        -- Fold starts here
        fold = '>'
    elseif line == end_row - 1 then
        -- Fold ends here
        fold = '<'
    end

    local level = 0
    while node ~= nil do
        if node:type() == 'section' then
            level = level + 1
        end
        node = node:parent()
    end

    return fold .. level
end

vim.wo.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.MarkdownFoldExpr()'
