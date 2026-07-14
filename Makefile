EMACS ?= emacs
ELPA_DIRS := $(shell find ~/.emacs.d/elpa* -maxdepth 0 -type d 2>/dev/null)
LOAD_PATH = -L . $(patsubst %,-L %,$(wildcard $(addsuffix /*,$(ELPA_DIRS))))

.PHONY: check compile lint clean

check: compile lint

compile: clean
	$(EMACS) --batch $(LOAD_PATH) \
	  -f batch-byte-compile call-graph.el

lint:
	$(EMACS) --batch $(LOAD_PATH) \
	  --eval "(require 'checkdoc)" \
	  --eval "(require 'package-lint nil t)" \
	  --eval "(with-current-buffer (find-file-noselect \"call-graph.el\") \
	    (princ (format \"package-lint: %s\n\" (package-lint-buffer))) \
	    (princ (format \"checkdoc: %s\n\" (checkdoc-current-buffer t))) \
	    (kill-buffer))"

clean:
	rm -f *.elc
