
craft: clean
	python3 craft.py 

clean:
	rm -f ./.vscode/zdotdir/.zcompdump* 
	rm -f .web-delivery/*
	rm -rf ./venv/ 
	rm -f ./.vscode/zdotdir/.zsh_history
