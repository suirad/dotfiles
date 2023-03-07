source ~/.vimrc
lua require('leap').add_default_mappings()
lua require('hex').setup({ dump_cmd = 'xxd -g 1 -u', assemble_cmd = 'xxd -r', is_buf_binary_pre_read = function() end, is_buf_binary_post_read = function() end })
