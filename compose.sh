cd calculator
componentize-py -d ../calc.wit -w calculator componentize --stub-wasi app -o app.wasm
cd ..
cd command
cargo component build --release
cd ..
cd adder
${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot adder_impl.c adder_component_type.o adder.c -o adder.wasm -mexec-model=reactor
wasm-tools component new adder.wasm -o adder-compo.wasm
cd ..
wasm-tools compose calculator/app.wasm -d adder/adder-compo.wasm -o composed.wasm
wasm-tools compose command/target/wasm32-wasi/release/command.wasm -d composed.wasm -o final.wasm
