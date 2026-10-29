# Local static server for environments without Node.js (same behavior as server.cjs)
param([int]$Port = $(if ($env:PORT) { [int]$env:PORT } else { 4173 }))
$root = Join-Path $PSScriptRoot 'public'
$types = @{ '.html'='text/html; charset=utf-8'; '.css'='text/css; charset=utf-8'; '.js'='text/javascript; charset=utf-8' }
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "SUI: http://localhost:$Port/board.html"
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $res = $ctx.Response
  try {
    $p = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath)
    if ($p -eq '/') { $p = '/index.html' }
    $file = [IO.Path]::GetFullPath((Join-Path $root $p.TrimStart('/')))
    if (-not [IO.Path]::GetExtension($file)) { $file += '.html' }
    if (-not $file.StartsWith($root + [IO.Path]::DirectorySeparatorChar)) { $res.StatusCode = 403 }
    elseif (-not (Test-Path $file -PathType Leaf)) { $res.StatusCode = 404 }
    else {
      $bytes = [IO.File]::ReadAllBytes($file)
      $ext = [IO.Path]::GetExtension($file)
      $res.ContentType = if ($types[$ext]) { $types[$ext] } else { 'application/octet-stream' }
      $res.OutputStream.Write($bytes, 0, $bytes.Length)
    }
  } catch { $res.StatusCode = 500 }
  $res.Close()
}
