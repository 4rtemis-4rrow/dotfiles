require'telescope-lsp-handlers'.setup({
  declaration = {
    disabled = false,
    picker = { prompt_title = 'LSP Declarations' },
    no_results_message = 'Declaration not found',
  },
  definition = {
    disabled = false,
    picker = { prompt_title = 'LSP Definitions' },
    no_results_message = 'Definition not found',
  },
  implementation = {
    disabled = false,
    picker = { prompt_title = 'LSP Implementations' },
    no_results_message = 'Implementation not found',
  },
  type_definition = {
    disabled = false,
    picker = { prompt_title = 'LSP Type Definitions' },
    no_results_message = 'Type definition not found',
  },
  reference = {
    disabled = false,
    picker = { prompt_title = 'LSP References' },
    no_results_message = 'No references found'
  },
  document_symbol = {
    disabled = false,
    picker = { prompt_title = 'LSP Document Symbols' },
    no_results_message = 'No symbols found',
  },
  workspace_symbol = {
    disabled = false,
    picker = { prompt_title = 'LSP Workspace Symbols' },
    no_results_message = 'No symbols found',
  },
  incoming_calls = {
    disabled = false,
    picker = { prompt_title = 'LSP Incoming Calls' },
    no_results_message = 'No calls found',
  },
  outgoing_calls = {
    disabled = false,
    picker = { prompt_title = 'LSP Outgoing Calls' },
    no_results_message = 'No calls found',
  },
})
