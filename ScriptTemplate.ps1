
<#
.SYNOPSIS
  	<Script Overview>
 
.DESCRIPTION
  	<Script Description>
  
.PARAMETER <Parameter_Name>
    <Command line Parameter information>
 
.INPUTS
	<External files or sources that script needs>
	 
.OUTPUTS
  	<Outputs if any>
 
.NOTES
  	Version:        
	Author:         
	Creation Date:  
	Purpose/Change: 
  
.EXAMPLE
	<Example goes here. Repeat this attribute for more than one example>
#>

#------------------------------------------------------[Command Line Switches]-----------------------------------------------------

param
(
	[switch]$debug
)
 
#---------------------------------------------------------[Initialisations]--------------------------------------------------------
 
#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"
 
#----------------------------------------------------------[Declarations]----------------------------------------------------------
 
#Script Version
$sScriptVersion = "1.0"
 
 
#-----------------------------------------------------------[Functions]------------------------------------------------------------
 
Function <FunctionName>
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
    	
 	}  
  	Process
	{
    	Try
		{
      		<code goes here>
    	}    
    	Catch
		{
      		
      		Break
    	}
  	}  
 	End
	{
    	If($?)
		{
		    
    	}
  	}
}
 
 
#-----------------------------------------------------------[Execution]------------------------------------------------------------
 
#Code Goes Here

