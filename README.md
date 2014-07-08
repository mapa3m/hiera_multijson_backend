hiera_multijson_backend
=======================

Hiera backend to allow loading multiple JSON files as a single variable

1. Copy multijson_backend.rb to your $RUBLIB/hiera/backend directory
2. Add multijson to the list of backends in hiera.yaml
3. Add :multijson: section to hiera.yaml
```
---
:backends:
  - json
  - multijson
:json:
 :datadir: "%{settings::confdir}/config/hiera"
:multijson:
 :datadir: "%{settings::confdir}/config/hiera"
:hierarchy:
 - "clients/%{::clientcert}"
 - "roles/%{::role}"
 - "domains/%{::domain}"
 - common
```


4. Create a directory in multijson :datadir: - directory name should be the variable, i.e if the variable you're looking to set is "clientname" - the directory name should be "clientname", if the variable is "client::config::user" - the directory should be "client\_\_config\_\_user" (replace :: with double underscore)
5. Within the directory, create any number of JSON files. Name of each file becomes the hash key
  Example:
client1.json
```
{
	"uid":5001,
	"password":"supersecret"
}
```
client2.json
```
{
	"uid":5002,
	"password":"evenmoresecret"
}
```
Resulting hash will be:
```
{
    "client1":{
        "uid":5001,
        "password":"supersecret"
    },
    "client2":{
        "uid":5002,
        "password":"evenmoresecret"
    }
}
```
