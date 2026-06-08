;; -*- lexical-binding: t -*-

;;; Startup

(set-language-environment "UTF-8") ; ensure UTF-8 encoding

(setq gc-cons-threshold (* 64 1024 1024) ; reduce GC frequency
      inhibit-startup-message t          ; skip startup screen
      initial-scratch-message nil        ; empty scratch buffer
      ring-bell-function 'ignore         ; disable bell
      make-backup-files nil              ; no backup files
      auto-save-default nil)             ; no auto-save

;;; UI

(scroll-bar-mode -1)     ; hide scroll bar
(menu-bar-mode -1)       ; hide menu bar
(tool-bar-mode -1)       ; hide tool bar
(tooltip-mode -1)        ; disable tooltips
(global-subword-mode 1)  ; treat CamelCase as separate words

(setq default-frame-alist '((width . 140) (height . 38)))
(setq frame-title-format nil)

;; Center the frame on startup
(defun center-frame ()
  "Center the Emacs frame on the current monitor."
  (let* ((frame (selected-frame))
         (geo   (frame-monitor-geometry frame))
         (mx    (nth 0 geo))
         (my    (nth 1 geo))
         (mw    (nth 2 geo))
         (mh    (nth 3 geo))
         (x     (+ mx (/ (- mw (frame-pixel-width))  2)))
         (y     (+ my (/ (- mh (frame-pixel-height)) 3))))
    (set-frame-position frame x y)))
(add-hook 'window-setup-hook #'center-frame)


(load-theme 'modus-vivendi-tinted t)

(set-face-attribute 'default nil :font "Maple Mono NF CN" :weight 'normal :height 164)

;;; Editing

(setq-default indent-tabs-mode nil  ; use spaces instead of tabs
              tab-width 4)          ; indent width

(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'prog-mode-hook #'flymake-mode)
(add-hook 'emacs-lisp-mode-hook
          (lambda () (remove-hook 'flymake-diagnostic-functions #'elisp-flymake-checkdoc t)))
(electric-pair-mode 1)
(add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "C-c C-c") #'compile)))

;;; Utils

(defun neil/find-program (program)
  "Find PROGRAM using xcrun on macOS, or `executable-find' otherwise."
  (if (eq system-type 'darwin)
      (let ((path (string-trim (shell-command-to-string (concat "xcrun --find " program " 2>/dev/null")))))
        (if (string-empty-p path) (executable-find program) path))
    (executable-find program)))

(defun neil/compile-command (build-file build-command fallback)
  "Use BUILD-COMMAND if BUILD-FILE exists, otherwise use FALLBACK."
  (if (and build-file (locate-dominating-file default-directory build-file))
      build-command
    fallback))

;;; Package Management

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(setq use-package-always-ensure t)

;;; Completion

(use-package ivy
  :hook (after-init . ivy-mode)
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t))

(use-package counsel
  :after ivy
  :bind (("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c f"   . counsel-recentf)
         ("C-c g"   . counsel-git)))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper-isearch-backward)))

;;; Auto Completion

(use-package company
  :hook (after-init . global-company-mode)
  :custom
  (company-idle-delay .2)
  (company-minimum-prefix-length 1))

;;; Navigation

(use-package avy
  :bind ("C-'" . avy-goto-char-timer))

;;; Version Control

(use-package magit
  :bind ("C-M-;" . magit-status))

;; Use .dotfiles as the git dir when no .git exists (bare repo dotfiles)
;; ref: https://emacs.stackexchange.com/a/46913
(defvar dotfiles-magit-hook? nil)
(defvar magit-git-global-arguments)
(unless dotfiles-magit-hook?
  (eval-after-load 'magit
    '(let ((dotfiles-path (expand-file-name ".dotfiles")))
       (when (and (file-exists-p dotfiles-path)
                  (not (file-exists-p ".git")))
         (add-to-list 'magit-git-global-arguments
                      (format "--work-tree=%s" (directory-file-name (file-name-directory dotfiles-path))))
         (add-to-list 'magit-git-global-arguments
                      (format "--git-dir=%s" dotfiles-path)))))
  (setq dotfiles-magit-hook? t))

;;; LSP

(use-package eglot
  :ensure nil
  :bind ("C-c e f" . eglot-format)
  :custom
  (eglot-eldoc-function 'ignore)
  (eldoc-echo-area-use-multiline-p nil))

;;; DAP

(declare-function dap-auto-configure-mode "dap-mode")
(use-package dap-mode
  :bind (("C-c d d" . dap-debug)
         ("C-c d b" . dap-breakpoint-toggle)
         ("C-c d n" . dap-next)
         ("C-c d i" . dap-step-in)
         ("C-c d o" . dap-step-out)
         ("C-c d c" . dap-continue)
         ("C-c d q" . dap-disconnect))
  :custom
  (dap-auto-configure-features '(sessions locals breakpoints))
  (dap-lldb-debug-program (list (neil/find-program "lldb-dap")))
  (dap-python-debugger 'debugpy)
  :config
  (dap-auto-configure-mode 1)
  ;; C / C++ / Rust — lldb-dap
  (require 'dap-lldb)
  ;; Go — delve
  (require 'dap-dlv-go)
  ;; Python — debugpy
  (require 'dap-python))

;;; Tree-sitter

(use-package treesit
  :ensure nil
  :config
  (setq treesit-font-lock-level 4)
  ;; Grammar sources, install via M-x treesit-install-language-grammar
  (setq treesit-language-source-alist
    '((bash       . ("https://github.com/tree-sitter/tree-sitter-bash"))
      (c          . ("https://github.com/tree-sitter/tree-sitter-c"))
      (cmake      . ("https://github.com/uyha/tree-sitter-cmake"))
      (cpp        . ("https://github.com/tree-sitter/tree-sitter-cpp"))
      (css        . ("https://github.com/tree-sitter/tree-sitter-css"))
      (dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
      (go         . ("https://github.com/tree-sitter/tree-sitter-go"))
      (html       . ("https://github.com/tree-sitter/tree-sitter-html"))
      (java       . ("https://github.com/tree-sitter/tree-sitter-java.git"))
      (json       . ("https://github.com/tree-sitter/tree-sitter-json"))
      (lua        . ("https://github.com/MunifTanjim/tree-sitter-lua"))
      (markdown   . ("https://github.com/MDeiml/tree-sitter-markdown" nil "tree-sitter-markdown/src"))
      (python     . ("https://github.com/tree-sitter/tree-sitter-python"))
      (rust       . ("https://github.com/tree-sitter/tree-sitter-rust"))
      (toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))
      (yaml       . ("https://github.com/ikatyang/tree-sitter-yaml"))))
  (dolist (lang (mapcar #'car treesit-language-source-alist))
    (unless (treesit-language-available-p lang)
      (treesit-install-language-grammar lang))))

;;; Languages

;; C / C++
(add-to-list 'major-mode-remap-alist '(c-mode        . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode      . c++-ts-mode))
(add-to-list 'major-mode-remap-alist '(c-or-c++-mode . c-or-c++-ts-mode))
(add-hook 'c-ts-mode-hook
          (lambda ()
            (eglot-ensure)
            (setq-local compile-command
                        (neil/compile-command "Makefile" "make"
                         (concat "gcc -o " (file-name-sans-extension buffer-file-name)
                                 " " buffer-file-name)))))
(add-hook 'c++-ts-mode-hook
          (lambda ()
            (eglot-ensure)
            (setq-local compile-command
                        (neil/compile-command "Makefile" "make"
                         (concat "g++ -o " (file-name-sans-extension buffer-file-name)
                                 " " buffer-file-name)))))

;; Python
(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
(add-hook 'python-ts-mode-hook
          (lambda ()
            (eglot-ensure)
            (setq-local compile-command (concat "python3 " buffer-file-name))))

;; Java
(add-to-list 'major-mode-remap-alist '(java-mode . java-ts-mode))
(add-hook 'java-ts-mode-hook
          (lambda ()
            (eglot-ensure)
            (setq-local compile-command
                        (neil/compile-command "pom.xml" "mvn package"
                         (concat "javac " buffer-file-name)))))

;; Go
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
(add-hook 'go-ts-mode-hook
          (lambda ()
            (eglot-ensure)
            (setq-local compile-command "go run .")))

;; Rust
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
(add-hook 'rust-ts-mode-hook
          (lambda ()
            (eglot-ensure)
            (setq-local compile-command "cargo run")))

;; Lua
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-ts-mode))
(add-hook 'lua-ts-mode-hook
          (lambda ()
            (eglot-ensure)
            (setq-local compile-command (concat "lua " buffer-file-name))))

;; Swift
(use-package swift-mode)
(add-to-list 'auto-mode-alist '("\\.swift\\'" . swift-mode))
(add-hook 'swift-mode-hook
          (lambda ()
            (eglot-ensure)
            (setq-local compile-command "swift run")))
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(swift-mode . (,(neil/find-program "sourcekit-lsp")))))

;; Bash
(add-to-list 'major-mode-remap-alist '(sh-mode . bash-ts-mode))

;; CSS
(add-to-list 'major-mode-remap-alist '(css-mode . css-ts-mode))

;; JSON
(add-to-list 'major-mode-remap-alist '(js-json-mode . json-ts-mode))

;; TOML
(add-to-list 'major-mode-remap-alist '(conf-toml-mode . toml-ts-mode))

;; HTML
(add-to-list 'auto-mode-alist '("\\.html?\\'" . html-ts-mode))

;; YAML
(add-to-list 'auto-mode-alist '("\\.y[a]?ml\\'" . yaml-ts-mode))

;; CMake
(add-to-list 'auto-mode-alist '("\\(CMakeLists\\.txt\\|\\.cmake\\)\\'" . cmake-ts-mode))

;; Dockerfile
(add-to-list 'auto-mode-alist '("\\(?:Dockerfile\\(?:\\..*\\)?\\|\\.[Dd]ockerfile\\)\\'" . dockerfile-ts-mode))

;;; Custom File

;; Keep auto-generated config out of init.el
(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)
