local orgmode_ok, _ = pcall(require, "orgmode")
if not orgmode_ok then 
  return
end

require('orgmode').setup({
  org_agenda_files = {'~/diary/*'},
  org_default_notes_file = '~/diary/default.org',
})
