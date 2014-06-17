PowerShellScriptTemplate
========================
coding@asnitech.co.uk

Basic template for starting PowerShell projects. Much of this code is borrowed from other sites on the internet but my aim is to build a template base that I can use for all of my projects.

Instructions
------------

- The template generates a log file in the same directory as the script (edit the $sLogPath variable under [Declarations] to change this. Logging to file can be disabled by using the -LogResults switch on the command line (eg, scriptname -LogResults $false).
- Edit the first 4 variables defined in the [Declarations] section.
- Copy and use the 'FunctionTemplate' under the [Script Specific Functions] section as necessary.
- All execution code should go within the 'MAIN' function at the bottom of the template (marked '# EXECUTION CODE GOES HERE'). Ideally execution code will primarily be calling other functions (at least this is how I try to do it). 


Original code taken, then modified from:

http://9to5it.com/powershell-script-template/

http://blogs.msdn.com/b/canberrapfe/archive/2011/08/21/powershell-script-template-amp-out-line-logging-function-to-help-get-you-started.aspx?Redirected=true

http://technet.microsoft.com/en-us/magazine/hh360993.aspx
