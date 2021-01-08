POD=$(shell kubectl get pod -l app=yotify-app -o jsonpath="{.items[0].metadata.name}")


run:
	skaffold dev --port-forward


shell:
	kubectl exec -it $(POD) bash


db-init:
	kubectl exec -it $(POD) rails db:setup
	make db-migrate


db-migrate:
	kubectl exec -it $(POD) rails db:migrate


db-rollback:
	kubectl exec -it $(POD) rails db:rollback
