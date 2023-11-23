[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/NN.pfSense?style=flat-square&logo=powershell&label=NN.pfSense&color=%235391fe)](https://www.powershellgallery.com/packages/NN.pfSense)
[![GitHub last commit](https://img.shields.io/github/last-commit/NorskNoobing/NN.pfSense?logo=github&style=flat-square&label=Last%20Commit)](https://github.com/norsknoobing/NN.pfSense)

# Installation
Run the following command in your PowerShell terminal to install the module.
```powershell
Install-Module NN.pfSense -Repository PSGallery -Force
```

# SSL cert issue
```powershell
Invoke-RestMethod : The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.
```
This error is a result of the pfSense install having a self-signed SSL certificate.
## Solution
Either get a "normal" SSL cert, or use this [code snippet](https://gist.github.com/jmassardo/2e0dd7cce292f16ff8f6945b8b3752b5) before running the pfSense functions. Once this is loaded, you won't have to load it again in that PowerShell session.
```powershell
#SkipCertificateCheck
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[Net.ServicePointManager]::SecurityProtocol = @(
    [Net.SecurityProtocolType]::Ssl3,
    [Net.SecurityProtocolType]::Tls,
    [Net.SecurityProtocolType]::Tls11,
    [Net.SecurityProtocolType]::Tls12
)
```
