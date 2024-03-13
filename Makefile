.PHONY: generate_go_frr generate_go_network pb docker_pb

generate_go_frr:
	protoc -I ./pb/third_party/frr \
	--go_out=. --go_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-bgp-controller \
	--go-grpc_out=. --go-grpc_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-bgp-controller \
	--grpc-gateway_out=. --grpc-gateway_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-bgp-controller \
	--validate_out=. --validate_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-bgp-controller --validate_opt=lang=go \
	$(shell find ./pb/third_party/frr -iname "*.proto")

generate_go_network:
	protoc -I ./pb/network \
	-I ./pb/third_party \
	--go_out=. --go_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-bgp-controller \
	--go-grpc_out=. --go-grpc_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-bgp-controller \
	--grpc-gateway_out=. --grpc-gateway_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-bgp-controller \
	--validate_out=. --validate_opt=module=gitlab.bj.sensetime.com/elementary/boson/boson-bgp-controller --validate_opt=lang=go \
	$(shell find ./pb/network -iname "*.proto")

pb: generate_go_frr generate_go_network

docker_pb:
	docker run --rm -v `pwd`:/src  registry.sensetime.com/sensecore-boson/pb-tools:latest make pb

