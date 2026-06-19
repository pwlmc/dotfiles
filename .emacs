;; Package repos
(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))


;; Mouse / wheel
(mouse-wheel-mode 1)
(xterm-mouse-mode 1)
(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)
(setq scroll-conservatively 101)

;; Show line / column
(global-display-line-numbers-mode 1)
(column-number-mode 1)

;; Spaces not tabs
(setq-default indent-tabs-mode nil)

;; Pair brackets/parens
(electric-pair-mode 1)
(show-paren-mode 1)

;; Auto-save and backups
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Markdown mode
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

(require 'markdown-mode)

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

;; Fuzzy search
(unless (package-installed-p 'vertico)
  (package-install 'vertico))
(require 'vertico)
(vertico-mode 1)

(unless (package-installed-p 'orderless)
  (package-install 'orderless))
(require 'orderless)
(setq completion-styles '(orderless basic))

(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

;; TS / TSX
(setq treesit-language-source-alist
      '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src")))

(defun ensure-treesit-language (lang)
  (unless (treesit-language-available-p lang)
    (message "Installing Tree-sitter grammar for %s..." lang)
    (treesit-install-language-grammar lang)))

(ensure-treesit-language 'typescript)
(ensure-treesit-language 'tsx)

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
