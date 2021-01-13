# Yotify

## Requirements

* Docker
* MiniKube
* Skaffold
* to dev:
    * Ruby
    * RoR 5

## Run

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

The db is a bit slow to start, check state of the pods with `kubectl get pod`

### Uages

#### Internal API

The internal api will be accessible on http://localhost:3000/, it can be used directly but shouldn't be public

* Get a token with `POST http://localhost:5000/oauth/token`
```
http POST http://localhost:3000/oauth/token grant_type=password email=urs.elmer@yova.ch password=secret
```
* Use the routes by adding a header `Authorization: Bearer <access_token>` to your calls
* Signin with one of the yova user
* You can run the task to compute the TWR from the `api` folder with 
```
ALPHAVANTAGE_TOKEN="<yours>" API_DATABASE_PASSWORD="<yours>" API_DATABASE_HOST=localhost make portfolios:twr
```


#### Admin

* Access from http://localhost:5000/
* Signin with one of the yova users
* View existing messages or create new ones
* Display a message to send notifications to specific customers
    * Use `seeds.db` in the internal API or any others means to create new customers

#### Customer API

* Get a token with `POST http://localhost:5000/oauth/token`
    * Use one of the user with a customer
```
http POST http://localhost:3000/oauth/token email=jean.dupond@good.inc password="good\!secret"
```
* Use the routes by adding the value `access_token=<access_token>` in the querstring
* `/notifications` will list all the notifications
* `/notifications/:id` will display one notification and update `read_at` of `nil`
* `/portfolios` will list all the portfolios
* `/portfolios/:id` will display one notification with all its positions


## Known issues / Improvements

### Envs

* Only `dev` is working

### Backend

* Security and authentication is weak
    * No real restrictions between admin and customers
    * Avoid signin from the bot
* First load of Backyard is really load
    * Assets should be pre-compiled
* Many http calls for no good reasons
* Better api\_client
* Switch to [Resque](https://github.com/resque/resque)
* Look up NArray & Cumo

### Frontend

* Hide menu in backyard signin page
* The notify button doesn't work when coming from messages list, page needs to be reload
