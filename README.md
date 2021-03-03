# generate-csr
Tool to generate a Certificate Signing Request (CSR).

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Requirements
 * openssl
 * 7za

## Usage
Generate a CSR
```
./generate-csr --domain=example.com
```

### Arguments,
 * `--domain` (Required) is the FQDN to generate the CSR for
 * `--config_path` (Optional) the path to the configuration file (default: /etc/generate-csr/config)

## Example
1. Install
```
sudo ./install.sh
```
2. First Run (setting certificate fields)
```
$ generate-csr --domain=example.com
Configuration file not found at /etc/generate-csr/config. Create? [y/N] Y
Making folder . Done
Enter ISO 3166 2 digit country code [ENTER]: US
Enter state name [ENTER]: California
Enter locality (city name) [ENTER]: Eureka
Enter organisation name [ENTER]: Global Dynamics
Enter organisation unit [ENTER]: Sector 5
Writing configuration file . . . . . . Done
Generating private key for example.com Done
Removing passphrase from private key Done
Generate certificate signing request (CSR) Done
Generating encrypted zip Done


CSR for example.com
-----BEGIN CERTIFICATE REQUEST-----
MIICuzCCAaMCAQAwdjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWEx
DzANBgNVBAcMBkV1cmVrYTEYMBYGA1UECgwPR2xvYmFsIER5bmFtaWNzMREwDwYD
VQQLDAhTZWN0b3IgNTEUMBIGA1UEAwwLZXhhbXBsZS5jb20wggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDfFcnvZHseJMzyAk5B9bUuR7WBfljNGKyy4DH6
PTokF76SRm+svcJKTtV/i3GP7TPhg/cvwI0MTOVfr3p7jJCVOoEw8LEZN+KrM50U
wObb+YRvE6Xjj1irhQKbbme2kFuXH+mCakiGOT40blvvyXsufr6onlu36818QRel
ZxKZw6bggnyn39nwhB19O8OrXVV+WKWo+UTQG0PV5qlP2FMctldZAYvg4iVyCaSm
tL58NrbMyFfOaWZntG7it58edhVFg1wieonU8CwUrAHJL9Qdpz+5MAoBk14GjeIt
AdYrsRy6isn9I755MdMGKWAQtGN+drm3U/iye7EYyN/SEUpjAgMBAAGgADANBgkq
hkiG9w0BAQsFAAOCAQEANaoJ4gCpacYYXyhiGW8gFfSyR1m2LcjK9ZsO7asssyhk
jSftT+qYz5plxgzvRQ1DJfA4oPFQLjAwX9xI3WRpfdSR9WQDaCVTJlhnGS/ldM/e
ybgi9dD7NmltpgkL4G6OKOI7l2RyPCf2eG9yuvv1cPR0ufdGsoicHVRwjgWlhYGI
XMDMC1Mpy+Rxzct3HLnVlW4BkWt+3+mpDxxFavl7izlZX2iKMgTI/6UuPiz/3Vkl
z9/+RLI/p6zRlYKfV1G8YR6RRLEcoDr7xB1OgdJZ0I6IgmFc1JHoVvuzqLlw55Da
x63fcvNmRYNHFmk6S2baiAtu4FVbvJZR/EEQN3cMPg==
-----END CERTIFICATE REQUEST-----

Passphrase for zip: aG3UrtpZmOV0LIPS67DZ8A==
```
3. Subsequent runs will already have your ORG data saved
```
$ generate-csr --domain=example.com
Generating private key for example.com Done
Removing passphrase from private key Done
Generate certificate signing request (CSR) Done
Generating encrypted zip Done


CSR for example.com
-----BEGIN CERTIFICATE REQUEST-----
MIICuzCCAaMCAQAwdjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWEx
DzANBgNVBAcMBkV1cmVrYTEYMBYGA1UECgwPR2xvYmFsIER5bmFtaWNzMREwDwYD
VQQLDAhTZWN0b3IgNTEUMBIGA1UEAwwLZXhhbXBsZS5jb20wggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDbeT1wfX1pZge6MpH/0wWUDqbjXnC5L2NvMBrM
Ug9Y+dK7h6bg7VDMFFOii+gpmQLbFtm3s1V0sXoo0LjD34qf47BkPKxXj9VqLBnp
8kxCVrHvXio+WqzR7tiieDQsE3M7PXEa+LAos51j5lLukcxAT2JViybXgKbeeo3a
1WvoA3E5q5awBlUQBaRbjJd628Lc00K7KNhNHqUL8vu9GYcB6K83BuRlB006My0y
1UW5q2p7cWD4IdXawZkxYz5mXP1nGXfxSoD6igAIMhsgDA/8E8n0M+xYva6VG8cL
adF4iypwKAVeATaYLa96/AXoxjxS+c08y0aQDcSc6XsL2LP/AgMBAAGgADANBgkq
hkiG9w0BAQsFAAOCAQEAeYTKMo3MZkneblz7V7+lt8TK1KhJcmPfi3zKiYH2bkSJ
I4GHvHQzbpnPURhNTQHFyEqMLGlAWZZIGifcpkvuxap1d/o/7Anhdt7wi9QrhG6k
OcYTtacMEO21so5J7b7pt/QFprM0K3ETydUXE9zehoEvKKlMpU6VHZJqJ7dUlIiX
saZIz75DJ9J9OLCzpFh1Cp+E+BtiotL+E1wC3/sbWjjhATqXMLIXTcjmsg8QbTl3
RTAjdT6wgPYHp17ZDI/6JFztl2IaCqaLohnG+R02Hoz0zDwED0rNBW4hjHfO1epD
IDb5rZoiH9vzsTnCUFE8auqxU9s2LB3F6ObpSDY5pg==
-----END CERTIFICATE REQUEST-----

Passphrase for zip: S+xHGXEdqLdUlA6eNG77Ng==
```
4. Your CSR is displayed above for signing, and your private key should be kept safe and not shared with anyone.
