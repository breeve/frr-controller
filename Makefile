
generate_go:
	$(info ******************** generate_go ********************)
	protoc -I ./pb \
	--go_out=. --go_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-provider \
	--go-grpc_out=. --go-grpc_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-provider \
	--grpc-gateway_out=. --grpc-gateway_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-provider \
	--validate_out=. --validate_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-provider --validate_opt=lang=go \
	$(shell find ./pb -iname "*.proto")

pb: generate_go

docker_pb:
	docker run --rm -v `pwd`:/src  registry.sensetime.com/sensecore-boson/pb-tools:latest make pb

