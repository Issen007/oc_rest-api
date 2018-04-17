<#
Basic powershell example with basic HTTP auth
Tested with IBM operation center 8.1.5 and powershell 5
#>

<#
Without this section Powershell will fail with the default self-signed cert
CN on the default cert is localhost
System.Net.WebException: The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.
---> System.Security.Authentication.AuthenticationException: The remote certificate is invalid according to the validation procedure.
#>
if (-not ([System.Management.Automation.PSTypeName]'ServerCertificateValidationCallback').Type)
{
$certCallback = @"
    using System;
    using System.Net;
    using System.Net.Security;
    using System.Security.Cryptography.X509Certificates;
    public class ServerCertificateValidationCallback
    {
        public static void Ignore()
        {
            if(ServicePointManager.ServerCertificateValidationCallback ==null)
            {
                ServicePointManager.ServerCertificateValidationCallback +=
                    delegate
                    (
                        Object obj,
                        X509Certificate certificate,
                        X509Chain chain,
                        SslPolicyErrors errors
                    )
                    {
                        return true;
                    };
            }
        }
    }
"@
    Add-Type $certCallback
}
[ServerCertificateValidationCallback]::Ignore()




# <TLS1.2 is disabled in OC, PS will default to TLS1...
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


$uri = "https://oc.example.com:11090/oc/api/help"
$method = "GET"

# Promting for user credentials and passing as argument instead of in the header
$prompted = Get-Credential
$cred = New-Object PSCredential -ArgumentList $prompted

# The required headers by OC for a GET request
$headers = @{}
$headers.Add( "OC-API-Version", "1.0" )
$headers.Add( "accept" , "application/json" )

try{
  $rapi = Invoke-RestMethod -method $method -uri $uri -Credential $cred -Headers $headers
  $rapi.help|ConvertTo-json
}
catch{
  write-host $_.Exception | Format-List -Force
}

<#
To see something useful:
$rapi.help
$rapi.help.General
$rapi.help.General|ConvertTo-json
#>
