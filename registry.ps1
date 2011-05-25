function Get-RegistryValue () {
<# 
.Synopsis 
    Returns from the Registry the value of a key/value pair.  If key or value does not exist, returns default provided. 
.Description 
    Returns from the Registry the value of a key/value pair.  If key or value does not exist, returns default provided.  
.Example
    Get-RegistryValue -KeyName "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ValueName "RegisteredOwner" -DefaultValue "Not Found"
.Parameter KeyName
    Registry key to find value under
.Parameter ValueName
    Registry value under key to return  
.Parameter DefaultValue
	Default object to return if key or value not found
.ReturnValue 
    [Object]
.Link 
    about_functions_advanced 
    about_functions_advanced_methods 
    about_functions_advanced_parameters 
.Notes 
NAME:      Get-RegistryValue
AUTHOR:    Robert Joshua Nylander 
LASTEDIT:  05/25/2011 13:00:00
#Requires -Version 2.0 
#> 
	[CmdletBinding()]
	Param (
		[ValidateNotNullOrEmpty()]
		[parameter(Position=0, ValueFromPipeline=$false, Mandatory=$True, HelpMessage="Registry key to find values of.")]
		[String] $KeyName,
		
		[ValidateNotNullOrEmpty()]
		[parameter(Position=1, ValueFromPipeline=$false, Mandatory=$True, HelpMessage="Registry key value to return value for.")]
		[String] $ValueName,
		
		[ValidateNotNull()]
		[parameter(Position=2, ValueFromPipeline=$false, HelpMessage="Default value if Key/Value not found.")]
		[Object] $DefaultValue
	)
	process {
		$keyArray = @($KeyName)
		$valueArray = @($ValueName)
		if (Test-Path -Path $keyArray) {
			if ((Get-ItemProperty $keyArray) -ne $null) {
				(Get-ItemProperty $keyArray $valueArray).$value
			} else {
				return $DefaultValue
			}
		} else {
			return $DefaultValue
		}
	}
}

function Set-RegistryValue () {
<# 
.Synopsis 
    Sets in the Registry the value of a key/value pair.  If key or value does not exist, returns default provided. 
.Description 
    Sets in the Registry the value of a key/value pair.  If key or value does not exist, returns default provided. 
.Example
    Set-RegistryValue -KeyName "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ValueName "RegisteredOwner" -Value "Employee"
.Parameter KeyName
    Registry key
.Parameter ValueName
    Registry value, leave as blank string to use (Default)
.Parameter Value
	Value to save
.ReturnValue 
    none
.Link 
    about_functions_advanced 
    about_functions_advanced_methods 
    about_functions_advanced_parameters 
.Notes 
NAME:      Set-RegistryValue
AUTHOR:    Robert Joshua Nylander 
LASTEDIT:  05/25/2011 13:00:00
#Requires -Version 2.0 
#> 
	[CmdletBinding()]
	Param (
		[ValidateNotNullOrEmpty()]
		[parameter(Position=0, ValueFromPipeline=$false, Mandatory=$True, HelpMessage="Registry key name.")]
		[String] $KeyName,
		
		[parameter(Position=1, ValueFromPipeline=$false, Mandatory=$$False, HelpMessage="Registry key value name, do not provide to set (default) for key")]
		[String] $ValueName = "(default)",
		
		[ValidateNotNull()]
		[parameter(Position=2, ValueFromPipeline=$false, HelpMessage="Value to save")]
		[Object] $Value
	)
	process {
		#[TODO]
		
		#Create key if not already exists.
		#Determine if key exists
		$keyArray = @($KeyName)
		While ((Test-Path -Path $keyArray) -eq $false) {
			
			#Key does not exist
			#Need to create key, recursevly [TODO]
			New-Item -Path $KeyName
		}
		
		#Does property already exist?
		if ((Get-RegistryValue -KeyName $Keyname -KeyValue $KeyValue -DefaultValue "not found") -eq "not found") {
			#no, create it
			New-ItemProperty $KeyName $KeyValue $Value
		} else {
			#yes, just change it
			Set-ItemProperty $KeyName $KeyValue $Value
		}
	}
}

Get-RegistryValue "HKCU:\Software\Nylander\SendToKindle\" "emailFrom" "test"

Set-RegistryValue "HKCU:\Software\Nylander\SendToKindle\" "emailFrom" "test"