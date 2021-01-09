API_POD=$(shell kubectl get pod -l app=yotify-api -o jsonpath="{.items[0].metadata.name}")
APP_POD=$(shell kubectl get pod -l app=yotify-app -o jsonpath="{.items[0].metadata.name}")


.SILENT: get-api-pod-name
get-api-pod-name:
	echo $(API_POD)


run:
	skaffold dev --port-forward


shell:
	kubectl exec -it $(API_POD) bash


db-init:
	kubectl exec -it $(API_POD) rails db:setup


db-reset:
	kubectl exec -it $(API_POD) rails db:reset


db-seed:
	kubectl exec -it $(API_POD) rails db:seed


db-migrate:
	kubectl exec -it $(API_POD) rails db:migrate


db-rollback:
	kubectl exec -it $(API_POD) rails db:rollback
