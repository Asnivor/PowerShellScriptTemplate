####################################################################################################################################
#--------------------------------------------------------[Script Information]------------------------------------------------------#
####################################################################################################################################
<#
.SYNOPSIS
  			Base template for developing PowerShell scripts
 
.DESCRIPTION
  			<Script Description>
  
.PARAMETER	[string]action		
    		Specific action that will be performed.

.PARAMETER	[bool]LogResults		
    		Default is $true. Set to $false to disables logging to file 
 
.INPUTS
			<External files or sources that script needs>
	 
.OUTPUTS
  			<Outputs if any>
 
.NOTES
  			Version:    	1.0    
			Author:         asnivor
			Creation Date:  17/06/2014
			Purpose/Change: Script creation
  
.EXAMPLE
			ScriptTemplate.ps1 -action "DoSomething" -LogResults $false
#>

####################################################################################################################################
#------------------------------------------------------[Command Line Switches]-----------------------------------------------------#
####################################################################################################################################

param
(
	[string]$action,
	[bool]$LogResults = $true
)

####################################################################################################################################
#---------------------------------------------------------[Initialisations]--------------------------------------------------------#
####################################################################################################################################
 
#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

#################################################################################################################################### 
#----------------------------------------------------------[Declarations]----------------------------------------------------------#
####################################################################################################################################

#Script Name
$global:sName = "PowerShell Script Template"
#Script Version
$global:sScriptVersion = "1.0"
#Author
$global:sAuthor = "asnivor"
#Email
$global:sAuthorEmail = "coding@asnitech.co.uk"

#Script Path
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

#Log File Info
$sLogPath = "$scriptPath"
$sLogName = "$($sName)_$(get-date -format `"yyyymmdd_HH-mm-ss`")_log.txt"
$LogFile = $sLogPath + "\" + $sLogName

####################################################################################################################################
#--------------------------------------------------------[Generic Functions]-------------------------------------------------------#
####################################################################################################################################

Function DisplayHeader
{
<#
.SYNOPSIS
			Write header for the script
.DESCRIPTION
			Writes script header to terminal and if command line param $LogResults is $true (this is default) then header is
			written to log file also
.PARAMETER
			None
.RETURNS
			Nothing
.EXAMPLE
			DisplayHeader
#>
	"-----------------------------------------------------"
	"Script:`t $sName"
	"Author:`t $sAuthor"
	"Email:`t $sAuthorEmail"
	"Version: $sScriptVersion"
	"-----------------------------------------------------"
	if ($LogResults)
	{
		WriteLog "-----------------------------------------------------"
		WriteLog "Script:`t $sName"
		WriteLog "Author:`t $sAuthor"
		WriteLog "Email:`t $sAuthorEmail"
		WriteLog "Version:`t $sScriptVersion"
		WriteLog "-----------------------------------------------------"
	}
} #END Function DisplayHeader

Function WriteLog
{
<#
.SYNOPSIS
			Write output to a log file
.DESCRIPTION
			<Description of function>
.PARAMETER
			<Input params and descriptions>
.RETURNS
			<What the function returns>
.EXAMPLE
			<Function example>
#>
  	Param
	(
		[string]$strOut,
		[bool]$blnNoDate
	)    
    $strDateTime = get-date -uFormat "%d-%m-%Y %H:%M:%S"
	If (-not ($blnNoDate)) 
	{
  		$strOutPut = ($strDateTime+ ": " + $strOut)
 	} 
	else 
	{
  		$strOutPut = $strOut
 	}
 	If ($LogFile -and $LogResults) {"$strOutPut" | out-file -filepath $LogFile -append}
} #END WriteLog

Function Write-Terminal
{
<#
.SYNOPSIS
			Write output to the screen
.DESCRIPTION
			<Description of function>
.PARAMETER
			<Input params and descriptions>
.RETURNS
			<What the function returns>
.EXAMPLE
			<Function example>
#>
  	Param
	(
		[string]$strOut,
		[string]$strType
	)  
	
	switch -wildcard ($strOut)
	{
		"ERR:*" 	{ write-host $strOut -ForegroundColor RED -BackgroundColor BLACK }
		"WARN:*"	{ write-host $strOut -ForegroundColor CYAN -BackgroundColor BLACK }
		"WARNING:*"	{ write-host $strOut -ForegroundColor CYAN -BackgroundColor BLACK }
		"INFO:*"	{ write-host $strOut -ForegroundColor YELLOW -BackgroundColor BLACK }
		"DEBUG:*"	{ write-host $strOut -ForegroundColor DARKGREEN -BackgroundColor BLACK }
		"OTH:*"		{ write-host $strOut -ForegroundColor MAGENTA -BackgroundColor BLACK }	
		default		{ write-host $strOut }		
	}
	If ($LogResults) {WriteLog $strOut}
} #END Write-Terminal

Function LogError
{
<#
.SYNOPSIS
			Writes an error to screen and log file
.DESCRIPTION
			Writes the passed error to a new line at the end of the log file (and also to terminal)
.PARAMETER 	-ErrorDesc
    		Mandatory. The description of the error you want to pass (use $_.Exception)
.RETURNS
			<What the function returns>
.EXAMPLE
			LogError -ErrorDesc $_.Exception
#>
	[CmdletBinding()]
  	Param
	(
	[Parameter(Mandatory=$true)][string]$ErrorDesc,
	[Parameter(Mandatory=$true)][boolean]$ExitGracefully
	)  
  	Process
	{
		Write-Terminal "ERR: An error has occurred [$ErrorDesc]." 
		#If $ExitGracefully = True then write to log file and exit script
    	If ($ExitGracefully -eq $True)
		{
      		Write-Terminal "INFO: Exiting Gracefully"
      		Break
    	}
	}
}

#################################################################################################################################### 
#-----------------------------------------------------[Script Specific Functions]--------------------------------------------------#
####################################################################################################################################
 
Function FunctionTemplate
{
<#
.SYNOPSIS
			<What the function does>
.DESCRIPTION
			<Description of function>
.PARAMETER
			<Input params and descriptions>
.RETURNS
			<What the function returns>
.EXAMPLE
			<Function example>
#>
  	Param
	(
	
	)  
  	Begin
	{
    	$getFunctionName = '{0}' -f $MyInvocation.MyCommand
		Write-Terminal "INFO: Function $getFunctionName started." 
 	}  
  	Process
	{
    	Try
		{
      		#<code goes here>
    	}    
    	Catch
		{
      		LogError -ErrorDesc $_.Exception -ExitGracefully $True
       		Break
    	}
  	}  
 	End
	{
    	If($?)
		{			
		 	Write-Terminal "INFO: Execution of function $getFunctionName completed successfully."   
    	}
  	}
}
 
#################################################################################################################################### 
#-----------------------------------------------------------[Execution]------------------------------------------------------------#
####################################################################################################################################

# Build MAIN function // This is where all the execution code goes

Function MAIN
{
	Begin
	{
		# Set console colours
		$objHost = (get-host).UI.RawUI
		$objHost.BackgroundColor = "BLACK"
		$objHost.foregroundcolor = "GREEN"
		# Clear Screen 
		CLS
		# Display Header
		DisplayHeader
		Write-Terminal "INFO: Starting '$sName' - '$sScriptVersion'"
	}  
	Process
	{
		Try
		{
###########################################################################################################
# EXECUTION CODE GOES HERE
			
If (($action -eq $null) -or ($action -eq '')) 
{
	# No Action Exists	
}
# Check action param
$strAction = $action
switch ($strAction) 
{
	"someaction"
	{
		# Perform code
	}
	"anotheraction" 
	{
		# Do something else
	}
	default 
	{
		# Otherwise do this		
	}
}
			
# EXECUTION CODE ENDS
###########################################################################################################
		}    
		Catch
		{
			# If an error is caught, log the error and quit
	  		LogError -ErrorDesc $_.Exception -ExitGracefully $True
       		Break
		}
	}  
	End
	{
		If($?)
		{
		    Write-Terminal "INFO: Execution of $sName completed successfully."
		}
	}
	}

# Call MAIN function to run the script
MAIN



