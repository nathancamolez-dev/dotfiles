local M = {}
local uv = vim.loop

local theme_symlink_dir = os.getenv 'HOME' .. '/.config/omarchy/current'
local theme_file = theme_symlink_dir .. '/theme/neovim.lua'

local function load_theme_file()
  local ok, theme = pcall(dofile, theme_file)
  if not ok then
    vim.notify('Failed to load Omarchy theme file: ' .. tostring(theme), vim.log.levels.WARN)
    return nil
  end
  return theme
end

local function extract_colorscheme_from_string(str)
  -- Padrões para detectar colorscheme em diferentes formatos
  local patterns = {
    'vim%.cmd%.colorscheme%s*%(?["\']([^"\'%)]+)["\']%)?', -- vim.cmd.colorscheme("nome") ou vim.cmd.colorscheme "nome"
    'vim%.cmd%s*%(?["\']colorscheme%s+([^"\'%)]+)["\']%)?', -- vim.cmd("colorscheme nome") ou vim.cmd "colorscheme nome"
    'colorscheme%s+([%w_%-]+)', -- colorscheme nome (genérico)
    'colorscheme=("[%w_%-]+")', -- colorscheme=nome (genérico)
  }

  for _, pattern in ipairs(patterns) do
    local match = str:match(pattern)
    if match then
      return match:gsub('"', ''):gsub("'", ''):gsub('%s+$', ''):gsub('^%s+', '')
    end
  end

  return nil
end

local function extract_colorscheme_from_config(config_func)
  if type(config_func) ~= 'function' then
    return nil
  end

  -- Tenta obter informações sobre a função
  local info = debug.getinfo(config_func, 'S')
  if not info or not info.source then
    return nil
  end

  -- Se a função foi definida em um arquivo
  if info.source:match '^@' then
    local file_path = info.source:sub(2)
    local file = io.open(file_path, 'r')
    if file then
      local content = file:read '*all'
      file:close()

      -- Procura por colorscheme no conteúdo do arquivo
      local colorscheme = extract_colorscheme_from_string(content)
      if colorscheme then
        return colorscheme
      end
    end
  end

  -- Tenta converter a função em string e procurar nela
  local ok, func_str = pcall(string.dump, config_func)
  if ok then
    -- Isso não funcionará perfeitamente com bytecode, mas tentamos
    local colorscheme = extract_colorscheme_from_string(func_str)
    if colorscheme then
      return colorscheme
    end
  end

  return nil
end

function M.get_colorscheme()
  local theme = load_theme_file()
  if theme and type(theme) == 'table' then
    for _, entry in ipairs(theme) do
      if type(entry) == 'table' then
        -- Primeiro, verifica se há opts.colorscheme
        if entry.opts and entry.opts.colorscheme then
          return entry.opts.colorscheme
        end

        -- Se não, tenta extrair da função config
        if entry.config and type(entry.config) == 'function' then
          local colorscheme = extract_colorscheme_from_config(entry.config)
          if colorscheme then
            return colorscheme
          end
        end
      end
    end
  end
  return 'carbonfox'
end

function M.apply_colorscheme()
  local colorscheme = M.get_colorscheme()
  if colorscheme then
    local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
    if ok then
      vim.notify('Applied colorscheme: ' .. colorscheme)
    else
      vim.notify('Failed to apply colorscheme: ' .. colorscheme .. '. Applying fallback carbonfox', vim.log.levels.WARN)
      pcall(vim.cmd, 'colorscheme carbonfox')
    end
  end
end

local function watch_symlink()
  local watcher = uv.new_fs_event()
  watcher:start(
    theme_symlink_dir,
    {},
    vim.schedule_wrap(function(err)
      if not err then
        M.apply_colorscheme()
      end
    end)
  )
end

-- Inicializa
M.apply_colorscheme()
watch_symlink()

return M
