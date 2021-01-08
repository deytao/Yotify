POD=$(shell kubectl get pod -l app=yotify-app -o jsonpath="{.items[0].metadata.name}")

run:
	skaffold dev --port-forward

shell:
	kubectl exec -it $(POD) bash

db-setup:
	kubectl exec -it $(POD) rails db:setup

db-migrate:
	kubectl exec -it $(POD) rails db:migrate
