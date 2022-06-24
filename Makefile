.PHONY: format
format:
	terraform fmt -recursive .

.PHONY: lint
lint:
	terraform fmt -check -recursive  .

.PHONY: init-test
init-test:
	cd test && \
	terraform init

.PHONY: plan-test
plan-test:
	cd test && \
	terraform plan -out=tf.plan

.PHONY: apply-test
apply-test: plan-test
	cd test && \
	terraform apply tf.plan
