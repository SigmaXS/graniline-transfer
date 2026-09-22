Add-Type -AssemblyName System.Drawing

$srcDir = "C:\Users\sorin\AppData\Roaming\Claude\scratch-workspaces\f8eafd03-bc21-40fc-a8a6-6ec43fba92c5\6ce10541-4432-4911-afc2-c4546df62f04\scratch-2026-09-19-c985a4\cars"
$dstDir = "C:\Users\sorin\AppData\Roaming\Claude\scratch-workspaces\f8eafd03-bc21-40fc-a8a6-6ec43fba92c5\6ce10541-4432-4911-afc2-c4546df62f04\scratch-2026-09-19-c985a4\cars-cut"
New-Item -ItemType Directory -Force -Path $dstDir | Out-Null

$targetWidth = 760
$threshLow = 222
$threshHigh = 250

function Process-Image($srcPath, $dstPath) {
    $orig = [System.Drawing.Image]::FromFile($srcPath)
    $ratio = $targetWidth / $orig.Width
    $w = $targetWidth
    $h = [int][Math]::Round($orig.Height * $ratio)

    $resized = New-Object System.Drawing.Bitmap $w, $h, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($resized)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($orig, 0, 0, $w, $h)
    $g.Dispose()
    $orig.Dispose()

    $rect = New-Object System.Drawing.Rectangle 0, 0, $w, $h
    $bmpData = $resized.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadWrite, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $stride = $bmpData.Stride
    $bytesLen = $stride * $h
    $bytes = New-Object byte[] $bytesLen
    [System.Runtime.InteropServices.Marshal]::Copy($bmpData.Scan0, $bytes, 0, $bytesLen)

    for ($y = 0; $y -lt $h; $y++) {
        $rowStart = $y * $stride
        for ($x = 0; $x -lt $w; $x++) {
            $i = $rowStart + $x * 4
            $b = $bytes[$i]
            $gr = $bytes[$i + 1]
            $r = $bytes[$i + 2]

            $maxc = [Math]::Max($r, [Math]::Max($gr, $b))
            $minc = [Math]::Min($r, [Math]::Min($gr, $b))
            $sat = $maxc - $minc

            if ($sat -le 16) {
                if ($minc -ge $threshHigh) {
                    $bytes[$i + 3] = 0
                } elseif ($minc -ge $threshLow) {
                    $frac = ($minc - $threshLow) / ($threshHigh - $threshLow)
                    $bytes[$i + 3] = [byte](255 * (1 - $frac))
                }
            }
        }
    }

    [System.Runtime.InteropServices.Marshal]::Copy($bytes, 0, $bmpData.Scan0, $bytesLen)
    $resized.UnlockBits($bmpData)
    $resized.Save($dstPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $resized.Dispose()
}

Get-ChildItem $srcDir -Filter business-audi.jpg | ForEach-Object {
    $dst = Join-Path $dstDir ($_.BaseName + ".png")
    Process-Image $_.FullName $dst
    Write-Output "done: $($_.Name) -> $dst"
}
