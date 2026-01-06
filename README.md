# call-graph - Generate call graph for c/c++ functions

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](COPYING.md)
[![https://github.com/beacoder/call-graph/actions][file:https://github.com/beacoder/call-graph/workflows/CI/badge.svg]]
[![MELPA](https://melpa.org/packages/call-graph-badge.svg)](https://melpa.org/#/call-graph)
[![MELPA Stable](https://stable.melpa.org/packages/call-graph-badge.svg)](https://stable.melpa.org/#/call-graph)
[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)

Generate call graph for c/c++ functions.

# Where does this library come from?

How many times do you have this feeling that
why can't we have this in emacs when you see
the fancy function call hierarchy in "modern" IDEs?
I hope one day, with this library, we won't have
to envy those "modern" IDEs for this again.

# Installation

Clone the repo, then in your Emacs init file:

```lisp
(add-to-list 'load-path "/path/to/repo")
(require 'call-graph)
(call-graph) ;; to launch it
```

Or install from [melpa](https://melpa.org/#/call-graph).

## External dependency
You could choose either Git (default) or Global as search backend for call-graph to use.
* `Git`

`call-graph` will recursively call `git grep` to find caller of
current function and eventually build up a `call-graph` tree.

* `GNU Global`

`call-graph` will recursively call `Global` to find caller of
current function and eventually build up a `call-graph` tree.

# Usage

Place your cursor in the c/c++ function which you want to generate
call-graph for and execute call-graph.
You could bind it to <kbd>C-c g</kbd>.

```lisp
    (global-set-key (kbd "C-c g") 'call-graph)
```

# Keys

```lisp
    (define-key map (kbd "e") 'call-graph-widget-expand-all)
    (define-key map (kbd "c") 'call-graph-widget-collapse-all)
    (define-key map (kbd "p") 'widget-backward)
    (define-key map (kbd "n") 'widget-forward)
    (define-key map (kbd "q") 'call-graph-quit)
    (define-key map (kbd "+") 'call-graph-expand)
    (define-key map (kbd "_") 'call-graph-collapse)
    (define-key map (kbd "o") 'call-graph-goto-file-at-point)
    (define-key map (kbd "d") 'call-graph-remove-caller)
    (define-key map (kbd "l") 'call-graph-select-caller-location)
    (define-key map (kbd "r") 'call-graph-reset-caller-cache)
    (define-key map (kbd "?") 'call-graph-help)
    (define-key map (kbd "<RET>") 'call-graph-goto-file-at-point)
```

# Customization

## Backend configuration: Git (Default)
```
    ;; not needed, as Git is default backend.
    ;; (customize-set-variable 'call-graph-search-backend "Git")
    ;; (customize-set-variable 'call-graph-path-to-git-repo "/workspace/git/$username/repo/")
```
## Backend configuration: Gnu Global
```
    ;; install "GNU Global" with universal-ctags support
    ;; "cd /path/to/project && gtags"
    (customize-set-variable 'call-graph-search-backend "Global")
    (customize-set-variable 'call-graph-path-to-global "/home/huming/private/gtags-6.5.7/bin/")
```
## Common configuration
Specify the parse depth of the call-graph, 
default is 2, the more the depth is, the longer it takes
```
    (customize-set-variable 'call-graph-initial-max-depth 3)
```
Ignore reference which has function name but no `(...)'
```
    (customize-set-variable 'call-graph-ignore-invalid-reference t)
```
Display function together with its args
```
    (customize-set-variable 'call-graph-display-func-args t)
```
Avoid truncating Imenu entries
```
    (customize-set-variable 'imenu-max-item-length "Unlimited")
```
Exclude UT/CT directories like /Dummy_SUITE/ /Dummy_Test/
```
    (dolist (filter '("grep -v \"Test/\""
                    "grep -v \"_SUITE/\""
                    "grep -v \"/test-src/\""
                    "grep -v \"/TestPkg/\""))
    (add-to-list 'call-graph-search-filters filter))
```
## Sample configuration
```
(progn
  (require 'call-graph)
  (global-set-key (kbd "C-c g") #'call-graph)
  (customize-set-variable 'imenu-max-item-length "Unlimited")
  (customize-set-variable 'call-graph-display-func-args t)
  (dolist (filter '("grep -v \"Test/\""
                    "grep -v \"Stub/\""
                    "grep -v \"_SUITE/\""
                    "grep -v \"/test-src/\""
                    "grep -v \"/TestPkg/\""
                    "grep -v \"/unittest/\""
                    "grep -v \"/test_src/\""
                    "grep -v \"/ct/\""))
    (add-to-list 'call-graph-search-filters filter)))
```
# Screenshots

![call-graph-demo-1.gif](img/call-graph-demo-1.gif)
![call-graph-demo-2.gif](img/call-graph-demo-2.gif)

# Limitations

Currently when parsing calling relations, header files is excluded.
Lots more need to be improved.

# Features

- [x] Navigate to caller file location.
- [x] Cache searching result.
- [x] Incremental searching.
- [x] Manual removing wrong callers.
- [x] Manual adding missing callers.
- [x] Show function name and args in call-graph.
- [x] Save cache data to survive emacs restart.
- [x] Support multiple backends, e.g: gnu global, git.

# Contributing
Yes, please do! See [CONTRIBUTING](CONTRIBUTING.md) for guidelines.

# License

See [LICENSE](LICENSE). Copyright (c) 2018-2025 Huming Chen <chenhuming@gmail.com>

# Donate

If you think that it's helpful for you, please consider paying a cup of coffee
for me. Thank you! :smile:

<img
src="WeChatQR.jpg"
alt="Wechat Pay" width="120"/>

<a href="https://www.buymeacoffee.com/s9giES1" target="_blank">
<img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee"
width="160"/>
</a>
