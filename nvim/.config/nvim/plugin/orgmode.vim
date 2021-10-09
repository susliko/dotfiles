lua << EOF
require('orgmode').setup({
  org_agenda_files = {'~/diary/*'},
  org_default_notes_file = '~/diary/default.org',
})
EOF
