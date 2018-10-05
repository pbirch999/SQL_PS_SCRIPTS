$Shell = New-Ojbect -ComObject Shell.Application
$RecBin = $Shell.Namespace(0xA)
$RecBin.Items() | %{Remove-Item $_.Path -Recurse -Confirm:$TRUE}