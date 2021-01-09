POD=$(shell kubectl get pod -l app=yotify-api -o jsonpath="{.items[0].metadata.name}")


.SILENT: get-api-pod-name
get-api-pod-name:
	echo $(POD)


shell:
	kubectl exec -it $(API_POD) bash


db-init:
	kubectl exec -it $(POD) rails db:setup


db-reset:
	kubectl exec -it $(POD) rails db:reset


db-seed:
	kubectl exec -it $(POD) rails db:seed


db-migrate:
	kubectl exec -it $(POD) rails db:migrate


db-rollback:
	kubectl exec -it $(POD) rails db:rollback
