# oc_rest-api
Communicating with IBM operation center


## For the powershell example:

Update the uri, user and pass variable to fit your system

Just fetching the help page
```
> $rapi.help


StoragePool   : {@{GET=System.Object[]}}
Server        : {@{GET=System.Object[]}}
StorageDevice : {@{GET=System.Object[]}}
Schedule      : {@{GET=System.Object[]}}
General       : {@{POST=System.Object[]; GET=System.Object[]}}
Alerts        : {@{GET=System.Object[]}}
Client        : {@{POST=System.Object[]; GET=System.Object[]; PUT=System.Object[]}}
Domain        : {@{GET=System.Object[]}}

```


An example of how to use convertto-json to format the output

```
> $rapi.help.General|ConvertTo-json
{
    "POST":  [
                 {
                     "issueCommand":  "oc/api/cli/issueCommand",
                     "issueConfirmedCommand":  "oc/api/cli/issueConfirmedCommand"
                 }
             ],
    "GET":  [
                {
                    "clients":  "oc/api/clients",
                    "servers":  "oc/api/servers",
                    "schedules":  "oc/api/schedules",
                    "storagepools":  "oc/api/storagepools",
                    "storagedevices":  "oc/api/storagedevices",
                    "domains":  "oc/api/domains"
                }
            ]
}
```


### Links
[IBM technote, end-point documentation](https://www-01.ibm.com/support/docview.wss?uid=swg21997347)
[Cristie Blog, older post about the API](https://www.cristie.dk/single-post/2017/09/22/How-to-work-with-the-new-REST-API-for-Operation-Center-713)
[The SOS filesl, IBM storage blog](https://www.sosfiles.com/blog/2016/1/13/spectrum-protect-rest-api)
