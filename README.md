# Yotify

## Requirements

* Docker
* MiniKube
* Vault
* Skaffold

## To run

Create `k8s/secrets.yaml` file with

```yaml

# k8s/secrets.yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: yotify-credentials
type: Opaque
data:
  yotify_db_password: <GET_YOUR_OWN>
  alphavantage_token: <SHARING_IS_CARING>

```

Then do:

```
$ start dockerd
$ minikube start --driver=docker -p yotify-mk
$ make run
```

The db is a bit slow to start, try the connection with `psql -U yotify yotify_dev`
The internal api will be accessible on http://localhost:3000/, it can be used directly but shouldn't be public
The admin interface will be accessible on http://localhost:5000/
The customer API will be accessible on http://localhost:5050/

You can run the task to compute the TWR from the `api` folder with `command`

### To dev

* Ruby
* RoR 5

## Known issues

### Envs

* Stop reloading on .swp files
* Only `dev` is working

### Backend

* Security and authentication is weak
* First load of Backyard is really load
    * Assets should be pre-compiled
* Many http calls for no good reasons
* Better api\_client

### Frontend

* Hide menu in backyard signin page
* The notify button doesn't work when coming from messages list, page needs to be reload
