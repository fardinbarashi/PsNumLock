#----------------------------------- Settings ------------------------------------------
# TranScript
$ScriptName = $MyInvocation.MyCommand.Name
$LogFileDate = (Get-Date -Format yyyy/MM/dd/HH.mm.ss)
$TranScriptLogFile = "$PSScriptRoot\Logs\$ScriptName - $LogFileDate.Txt" 
$StartTranscript = Start-Transcript -Path $TranScriptLogFile -Force
Get-Date -Format "yyyy/MM/dd HH:mm:ss"
Write-Host ".. Starting TranScript"

# FilePath 
$RegistryFilePath = "Registry::HKU\.DEFAULT\Control Panel\Keyboard"

# FunctionList

#----------------------------------- Start Script ------------------------------------------
# Section 1 : Connect To RegEdit to $RegistryFilePath
Try
{ # Start Try
Get-Date -Format "yyyy/MM/dd HH:mm:ss"
$Section = "Section 1 : Connect To RegEdit to $RegistryFilePath"
Write-Host $Section "0%" -ForegroundColor Yellow

# Run Query
   $RegEditNumlockQuestion = Read-Host "Do You want change so that Numlock is always Enabled in $RegistryFilePath. (Y/N)"
    if ($RegEditNumlockQuestion -Eq "Y")  
     { # Start If ($RegEditNumlockQuestion -Eq "Y")   
        # User Wants to Enable it
         Write-Host " 1.1 - Enable Numlock-function in RegEdit "
         
         # Run Query Enable Numlock-function in RegEdit 
         Set-ItemProperty -Path $RegistryFilePath -Name "InitialKeyboardIndicators" -Value "2"
         
         # Recheck if the Value is changed
         Write-Host " 1.2 - Checking if Numlock is Enabled in RegEdit "
         $CheckRegEditNumlockQuestion = Get-ItemProperty -Path $RegistryFilePath -Name "InitialKeyboardIndicators"
          if ( $CheckRegEditNumlockQuestion.InitialKeyboardIndicators -Eq "2" )
           { # Start if ( $CheckRegEditNumlockQuestion.InitialKeyboardIndicators -Eq "2" )
            Write-host " 1.2.1 - Numlock is Enabled in RegEdit"
            Write-Host $Section "100%" -ForegroundColor Green
           } # End if ( $CheckRegEditNumlockQuestion.InitialKeyboardIndicators -Eq "2" )
          Else  
           { # Start Else ( $CheckRegEditNumlockQuestion.InitialKeyboardIndicators -Eq "2" )
            Write-Warning "... Something went wrong in, Numlock is still Disabled"
            Write-Warning $Error[0]
            Write-Host "Stopping Transcript and Script! see logfile $TranScriptLogFile for further investigation"
            Stop-Transcript
            Exit
           } # End Else ( $CheckRegEditNumlockQuestion.InitialKeyboardIndicators -Eq 2" )    
     }# End If ($RegEditNumlockQuestion -Eq "Y")  
         
    elseif ($RegEditNumlockQuestion -Eq "N") 
     { # Start elseif ($RegEditNumlockQuestion -Eq "N")   
      Get-Date -Format "yyyy/MM/dd HH:mm:ss"
      Write-Host "User does not want to do any changes"
      Write-Host "Stopping Transcript and Script!" 
      Write-Host $Section "100%" -ForegroundColor Green
      Stop-Transcript
      Exit
     } # End elseif ($RegEditNumlockQuestion -Eq "N")   
 
 Write-Host ""
} # End Try

Catch
{ # Start Catch
Get-Date -Format "yyyy/MM/dd HH:mm:ss"
Write-Host "ERROR on $Section" -ForegroundColor Red
Write-Warning $Error[0]
Write-Host "Stopping Transcript and Script!" -ForegroundColor Red
Stop-Transcript
Exit
} # End Catch
