local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
  return
end

null_ls.setup()

mason_null_ls.setup({
   ensure_installed = { "stylua", "jq" }, 
   automatic_setup = true,
})
