#!/usr/bin/env pwsh

# ANSI color definitions for foreground and background
$colors = @{
    f0 = "`e[30m"; f1 = "`e[31m"; f2 = "`e[32m"; f3 = "`e[33m"
    f4 = "`e[34m"; f5 = "`e[35m"; f6 = "`e[36m"; f7 = "`e[37m"
    b0 = "`e[40m"; b1 = "`e[41m"; b2 = "`e[42m"; b3 = "`e[43m"
    b4 = "`e[44m"; b5 = "`e[45m"; b6 = "`e[46m"; b7 = "`e[47m"
}
$bld = "`e[1m"
$rst = "`e[0m"

# Render the Space Invaders
Write-Host @"
 $($colors.f1)  ▀▄   ▄▀     $($colors.f2) ▄▄▄████▄▄▄    $($colors.f3)  ▄██▄     $($colors.f4)  ▀▄   ▄▀     $($colors.f5) ▄▄▄████▄▄▄    $($colors.f6)  ▄██▄  $rst
 $($colors.f1) ▄█▀███▀█▄    $($colors.f2)███▀▀██▀▀███   $($colors.f3)▄█▀██▀█▄   $($colors.f4) ▄█▀███▀█▄    $($colors.f5)███▀▀██▀▀███   $($colors.f6)▄█▀██▀█▄$rst
 $($colors.f1)█▀███████▀█   $($colors.f2)▀▀███▀▀███▀▀   $($colors.f3)▀█▀██▀█▀   $($colors.f4)█▀███████▀█   $($colors.f5)▀▀███▀▀███▀▀   $($colors.f6)▀█▀██▀█▀$rst
 $($colors.f1)▀ ▀▄▄ ▄▄▀ ▀   $($colors.f2) ▀█▄ ▀▀ ▄█▀    $($colors.f3)▀▄    ▄▀   $($colors.f4)▀ ▀▄▄ ▄▄▀ ▀   $($colors.f5) ▀█▄ ▀▀ ▄█▀    $($colors.f6)▀▄    ▄▀$rst

 $($bld)$($colors.f1)▄ ▀▄   ▄▀ ▄   $($colors.f2) ▄▄▄████▄▄▄    $($colors.f3)  ▄██▄     $($colors.f4)▄ ▀▄   ▄▀ ▄   $($colors.f5) ▄▄▄████▄▄▄    $($colors.f6)  ▄██▄  $rst
 $($bld)$($colors.f1)█▄█▀███▀█▄█   $($colors.f2)███▀▀██▀▀███   $($colors.f3)▄█▀██▀█▄   $($colors.f4)█▄█▀███▀█▄█   $($colors.f5)███▀▀██▀▀███   $($colors.f6)▄█▀██▀█▄$rst
 $($bld)$($colors.f1)▀█████████▀   $($colors.f2)▀▀▀██▀▀██▀▀▀   $($colors.f3)▀▀█▀▀█▀▀   $($colors.f4)▀█████████▀   $($colors.f5)▀▀▀██▀▀██▀▀▀   $($colors.f6)▀▀█▀▀█▀▀$rst
 $($bld)$($colors.f1) ▄▀     ▀▄    $($colors.f2)▄▄▀▀ ▀▀ ▀▀▄▄   $($colors.f3)▄▀▄▀▀▄▀▄   $($colors.f4) ▄▀     ▀▄    $($colors.f5)▄▄▀▀ ▀▀ ▀▀▄▄   $($colors.f6)▄▀▄▀▀▄▀▄$rst


                                     $($colors.f7)▌$rst

                                   $($colors.f7)▌$rst

                              $($colors.f7)    ▄█▄    $rst
                              $($colors.f7)▄█████████▄$rst
                              $($colors.f7)▀▀▀▀▀▀▀▀▀▀▀$rst
"@ -NoNewline
