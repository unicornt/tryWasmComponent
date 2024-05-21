run: build
	wasmtime run final.wasm 1 2 add

build: calculator/app.wasm adder/adder-compo.wasm command/target/wasm32-wasi/release/command.wasm
	wasm-tools compose calculator/app.wasm -d adder/adder-compo.wasm -o composed.wasm
	wasm-tools compose command/target/wasm32-wasi/release/command.wasm -d composed.wasm -o final.wasm

calculator/app.wasm: calc.wit calculator/app.py
	cd calculator && componentize-py -d ../calc.wit -w calculator componentize --stub-wasi app -o app.wasm && cd ..

command/target/wasm32-wasi/release/command.wasm: command/src/main.rs command/src/bindings.rs
	cd command && cargo component build --release && cd ..

adder/adder-compo.wasm: adder/adder_impl.c adder/adder.c adder/adder.h adder/adder_component_type.o
	${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot adder_impl.c adder_component_type.o adder.c -o adder.wasm -mexec-model=reactor
	wasm-tools component new adder.wasm -o adder-compo.wasm
