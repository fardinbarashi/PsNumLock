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



#----------------------------------- Start Script ------------------------------------------
# Section 1 : Connect To RegEdit to $RegistryFilePath
Try
{ # Start Try
Get-Date -Format "yyyy/MM/dd HH:mm:ss"
$Section = "Section 1 : Connect To RegEdit to $RegistryFilePath"
Write-Host $Section "0%" -ForegroundColor Yellow

# Run Query
$GetRegEditNumlockStatus = Get-ItemProperty -Path $RegistryFilePath -Name "InitialKeyboardIndicators" 
 If ($GetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "2")
  { # Start, IF ($GetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "2")
    # InitialKeyboardIndicators Value is 2
    # Numlock is Enabled in regedit
     $Choice = Read-Host "Question : Numlock is enabled in reg-edit. Do you want to disable it? Y/N"
     if ($Choice -Eq "Y") 
      { # Start if ($Choice -Eq "Y") 
        # User Wants to disable numlock
         # Run Query
           Set-ItemProperty -Path 'Registry::HKU\.DEFAULT\Control Panel\Keyboard' -Name "InitialKeyboardIndicators" -Value "0"
           
           # Recheck if InitialKeyboardIndicators Value is 0 in RegEdit
           $RecheckGetRegEditNumlockStatus = Get-ItemProperty -Path $RegistryFilePath -Name "InitialKeyboardIndicators"
           If ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "0")  
            { # Start If ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "0")  
               Write-Host "Numlock is disabled"
               Write-Host "Stopping Transcript and Script"
               Stop-Transcript
               Exit
            } # End If ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "0")  

            Else 
            { # Start Else ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "0")  
              Write-Warning "... Something went wrong, Numlock is still Enabled"
              Write-Warning $Error[0]
              Write-Host "Stopping Transcript and Script! see logfile $TranScriptLogFile for further investigation"
              Stop-Transcript
              Exit
            } # End Else ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "0")       
      } # End if ($Choice -Eq "Y") 
    
      if ($Choice -Eq "N")
       { # Start If, ($Choice -Eq "N")
         Write-Host "Numlock is still enabled"
         Write-Host "Stopping Transcript and Script"
         Stop-Transcript
         Exit
       }  # End If, ($Choice -Eq "N") 
  } # End, IF ($GetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "2")
 
  Else
 { # Start, IF ($GetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "2")
   # InitialKeyboardIndicators Value is 0
   # Numlock is Disabled in regedit
   $Choice = Read-Host "Question : Numlock is Disabled in reg-edit. Do you want to Enable it? Y/N"
   if ($Choice -Eq "Y") 
    { # Start if ($Choice -Eq "Y") 
      # User Wants to disable numlock
       # Run Query
         Set-ItemProperty -Path 'Registry::HKU\.DEFAULT\Control Panel\Keyboard' -Name "InitialKeyboardIndicators" -Value "2"
         
         # Recheck if InitialKeyboardIndicators Value is 0 in RegEdit
         $RecheckGetRegEditNumlockStatus = Get-ItemProperty -Path $RegistryFilePath -Name "InitialKeyboardIndicators"
         If ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "2")  
          { # Start If ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "0")  
             Write-Host "Numlock is enabled"
             Write-Host "Stopping Transcript and Script"
             Stop-Transcript
             Exit
          } # End If ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "0")  

          Else 
          { # Start Else ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "0")  
            Write-Warning "... Something went wrong, Numlock is still Disabled"
            Write-Warning $Error[0]
            Write-Host "Stopping Transcript and Script! see logfile $TranScriptLogFile for further investigation"
            Stop-Transcript
            Exit
          } # End Else ($RecheckGetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "0")       
    } # End if ($Choice -Eq "Y") 
  
    if ($Choice -Eq "N")
     { # Start If, ($Choice -Eq "N")
       Write-Host "Numlock is still disabled"
       Write-Host "Stopping Transcript and Script"
       Stop-Transcript
       Exit
     }  # End If, ($Choice -Eq "N") 
 } # End, IF ($GetRegEditNumlockStatus.InitialKeyboardIndicators -Eq "2")
 
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
