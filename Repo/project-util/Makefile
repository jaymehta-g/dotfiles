src := ~/Repo/project-util
info:
	@echo "python"
	@echo "kattis"
	@echo "cargo"
	@echo "godot"
git:
	git init
	touch .gitignore
	git add .
	git commit -m "initial"
code:
	code . -n
python: git code
	echo "#!/usr/bin/env python3" > ./main.py
	echo "" >> ./main.py
	chmod 700 ./main.py
	git add .
	git commit --amend --no-edit
kattis: python
	@echo kattis target
	touch input
	touch output
	cp $(src)/test.sh .
	chmod 700 ./test.sh
	git add .
	git commit --amend --no-edit
cargo: git code
	cargo init
godot: git
	cp $(src)/godot-template/* .
