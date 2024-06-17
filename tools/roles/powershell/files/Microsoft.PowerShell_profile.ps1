function prompt {
        $PROMPT_ALTERNATIVE='twoline'
        $NEWLINE_BEFORE_PROMPT='yes'
        $esc = [char]27
        $bell = [char]7
        $bold = "$esc[1m"
        $reset = "$esc[0m"
        If ($NEWLINE_BEFORE_PROMPT -eq 'yes') {
                Write-Host
        }
        If ($PROMPT_ALTERNATIVE -eq 'twoline') {
                Write-Host "┌──(" -NoNewLine -ForegroundColor Blue
                Write-Host "${bold}$([environment]::username)@$([system.environment]::MachineName)${reset}" -NoNewLine -ForegroundColor Magenta
                Write-Host ")-[" -NoNewLine -ForegroundColor Blue
                Write-Host "${bold}$(Get-Location)${reset}" -NoNewLine -ForegroundColor White
                Write-Host "]" -ForegroundColor Blue
                Write-Host "└─" -NoNewLine -ForegroundColor Blue
                Write-Host "${bold}PS>${reset}" -NoNewLine -ForegroundColor Blue
        } Else {
                Write-Host "${bold}PS " -NoNewLine -ForegroundColor Blue
                Write-Host "$([environment]::username)@$([system.environment]::MachineName) " -NoNewLine -ForegroundColor Magenta
                Write-Host "$(Get-Location)>${reset}" -NoNewLine -ForegroundColor Blue
        }
        # Terminal title
        Write-Host "${esc}]0;PS> $([environment]::username)@$([system.environment]::MachineName): $(Get-Location)${bell}" -NoNewLine
        return " "
}

## Set PSReadLine options and keybindings
$PSROptions = @{
    ContinuationPrompt = '  '
    Colors             = @{
        Operator         = $PSStyle.Foreground.Magenta
        Parameter        = $PSStyle.Foreground.Magenta
        Selection        = $PSStyle.Background.BrightBlack
        InLinePrediction = $PSStyle.Foreground.BrightYellow + $PSStyle.Background.BrightBlack
    }
}
Set-PSReadLineOption @PSROptions
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+a' -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord 'Ctrl+e' -Function EndOfLine
Set-PSReadLineKeyHandler -Chord 'Ctrl+Delete' -Function DeleteEndOfWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Tab -Function Complete
