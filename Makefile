build:
	@echo "Building the project..."
	uv run ./craft.py
	uv run ./completion_creator.py
	@echo "Build complete."

install: build
	@echo "Preparing the environment..."
	WEAPON_LOCATION=$(shell pwd)/weapon_test ./installer.sh
	@echo "Installation complete."

install-trace: build
	@echo "Preparing the environment with trace..."
	WEAPON_LOCATION=$(shell pwd)/weapon_test ./installer.sh --trace-mode
	@echo "Installation with trace complete."

clean:
	rm -rf ./hosts ./users ./weapon_test ./createhackenv.sh ./zsh_history