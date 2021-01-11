POD=$(shell kubectl get pod -l app=yotify-apps -o jsonpath="{.items[0].metadata.name}")


.SILENT: get-pod-name
get-pod-name:
	echo $(POD)


shell:
	kubectl exec -it $(POD) -c yotify-api bash


db-init:
	kubectl exec -it $(POD) -c yotify-api rails db:setup


db-reset:
	kubectl exec -it $(POD) -c yotify-api rails db:reset


db-seed:
	kubectl exec -it $(POD) -c yotify-api rails db:seed


db-migrate:
	kubectl exec -it $(POD) -c yotify-api rails db:migrate


db-rollback:
	kubectl exec -it $(POD) -c yotify-api rails db:rollback
