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
(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

(require 'markdown-mode)

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

