# Known issues
## SSL cert
### Issue
```powershell
Invoke-RestMethod : The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.
```
This error is a result of the pfSense install having a self-signed SSL certificate.
### Solution
Either get a "normal" SSL cert, or use this code snippet before running the pfSense functions. Once this is loaded, you won't have to load it again in that PowerShell session.
Use line 1-14: https://gist.github.com/jmassardo/2e0dd7cce292f16ff8f6945b8b3752b5
