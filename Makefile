build:
	@echo "Building the project..."
	uv run ./craft.py
	uv run ./completion_creator.py
	@echo "Build complete."

install: build
	@echo "Preparing the environment..."
	WEAPON_LOCATION=$(shell pwd)/weapon_test ./installer.sh
	@echo "Installation complete."

clean:
	rm -rf ./hosts ./users ./weapon_test ./createhackenv.sh ./zsh_history