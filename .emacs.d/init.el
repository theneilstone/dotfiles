(setq default-file-name-coding-system 'utf-8-unix)
(setq default-sendmail-coding-system  'utf-8-unix)
(setq default-terminal-coding-system  'utf-8-unix)
(setq keyboard-coding-system          'utf-8-unix)
(setq buffer-file-coding-system       'utf-8-unix)
(setq selection-coding-system         'utf-8-unix)
(setq save-buffer-coding-system       'utf-8-unix)

;; Quiet Startup
(setq gc-cons-threshold (* 64 1024 1024))
(setq frame-inhibit-implied-resize t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(setq frame-title-format nil)
(setq frame-resize-pixelwise t)
(setq package-enable-at-startup nil)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq delete-by-moving-to-trash t)

(setq comment-style 'indent)
(setq ring-bell-function 'ignore)
(setq initial-major-mode 'fundamental-mode)

(setq-default truncate-lines nil)

(setq-default fill-column 120)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'prog-mode-hook 'turn-on-auto-fill)
;;(add-hook 'org-mode-hook 'turn-on-auto-fill)
;;(add-hook 'elisp-mode-hook 'turn-off-auto-fill)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
;;(column-number-mode 1)
(transient-mark-mode 1)
(global-subword-mode 1)
;;(global-visual-line-mode 1)

(setq default-frame-alist
      '((width . 128)
        (height . 32)))

(defun neil/center-emacs-frame ()
  "Center the Emacs frame on the screen."
  (let* ((frame (selected-frame))
         (width (frame-pixel-width frame))
         (height (frame-pixel-height frame))
         (screen-width (display-pixel-width))
         (screen-height (display-pixel-height))
         (x (/ (- screen-width width) 2))
         (y (/ (- screen-height height) 2)))
    (set-frame-position frame x y)))
(add-hook 'window-setup-hook 'neil/center-emacs-frame)

;;; font
(set-face-attribute 'default        nil :font "Maple Mono NF CN" :weight 'normal :height 164)
(set-face-attribute 'fixed-pitch    nil :font "Maple Mono NF CN" :weight 'normal :height 164)
(set-face-attribute 'variable-pitch nil :font "Maple Mono NF CN" :weight 'normal :height 164)

(use-package prog-mode
  :hook ((prog-mode . column-number-mode)
	 (prog-mode . display-line-numbers-mode)
	 (prog-mode . electric-pair-mode)
	 (prog-mode . flymake-mode)
	 (prog-mode . hs-minor-mode)
	 (prog-mode . prettify-symbols-mode)))

(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode -1))))

;;; packages
(use-package package
  :config
  (add-to-list 'package-archives '("melpa"        . "https://melpa.org/packages/"))
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
  (add-to-list 'package-archives '("org"          . "https://orgmode.org/elpa/"))
  :unless (bound-and-true-p package--initialized)
  (package-initialize))

(use-package nerd-icons
  :ensure t)

(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-bio t))

(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-icon t)
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (setq doom-modeline-env-version t)
  (setq doom-modeline-major-mode-icon t)
;;  (setq doom-modeline-minor-modes t)
  (setq doom-modeline-buffer-state-icon t))

(use-package ivy
  :ensure t
  :hook (after-init . ivy-mode)
  :config (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
 enable-recursive-minibuffers t))

(use-package counsel
  :ensure t
  :after (ivy)
  :bind (("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c f"   . counsel-recentf)
         ("C-c g"   . counsel-git)))

(use-package swiper
  :ensure t
  :after (ivy)
  :bind (("C-s" . swiper)
         ("C-r" . swiper-isearch-backward))
  :config
  (setq swiper-action-recenter t
        swiper-include-line-number-in-search t))

(use-package magit
  :ensure t
  :bind ("C-M-;" . magit-status))

(use-package yasnippet
  :ensure t
  :commands (yas-global-mode)
  :config (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after (yasnippet))

(use-package auto-yasnippet
  :bind
  (("C-c & w" . aya-create)
   ("C-c & y" . aya-expand))
  :config
  (setq aya-persist-snippets-dir (concat user-emacs-directory "snippets")))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-tooltip-align-annotations t
        company-tooltip-limit 20
        company-show-numbers t
        company-idle-delay .2
        company-minimum-prefix-length 1))

(use-package projectile
  :ensure t
  :config
  (setq projectile-cache-file (expand-file-name ".cache/projectile.cache" user-emacs-directory))
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map))

(use-package avy
  :ensure t
  :bind (("C-'" . avy-goto-char-timer)
         ("C-c C-j" . avy-resume))
  :config
  (setq avy-background t
        avy-all-windows t
        avy-timeout-seconds 0.3))

(use-package eglot
  :ensure t
  :config
  (setq eglot-eldoc-function 'ignore)
  (setq eldoc-echo-area-use-multiline-p nil)
  :hook ((python-mode . eglot-ensure)
	 (python-ts-mode . eglot-ensure)
	 (lua-mode . eglot-ensure))
  :bind ("C-c e f" . eglot-format))

(use-package lua-mode
  :ensure t
  :mode ("\\.lua\\'" . lua-mode))

(use-package treesit
  :when (and (fboundp 'treesit-available-p)
         (treesit-available-p))
  :config (setq treesit-font-lock-level 4)
  :init
  (setq treesit-language-source-alist
    '((bash       . ("https://github.com/tree-sitter/tree-sitter-bash"))
      (c          . ("https://github.com/tree-sitter/tree-sitter-c"))
      (cpp        . ("https://github.com/tree-sitter/tree-sitter-cpp"))
      (css        . ("https://github.com/tree-sitter/tree-sitter-css"))
      (cmake      . ("https://github.com/uyha/tree-sitter-cmake"))
      (csharp     . ("https://github.com/tree-sitter/tree-sitter-c-sharp.git"))
      (dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
      (elisp      . ("https://github.com/Wilfred/tree-sitter-elisp"))
      (go         . ("https://github.com/tree-sitter/tree-sitter-go"))
      (gomod      . ("https://github.com/camdencheek/tree-sitter-go-mod.git"))
      (html       . ("https://github.com/tree-sitter/tree-sitter-html"))
      (java       . ("https://github.com/tree-sitter/tree-sitter-java.git"))
      (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
      (json       . ("https://github.com/tree-sitter/tree-sitter-json"))
      (lua        . ("https://github.com/MunifTanjim/tree-sitter-lua"))
      (make       . ("https://github.com/alemuller/tree-sitter-make"))
      (markdown   . ("https://github.com/MDeiml/tree-sitter-markdown" nil "tree-sitter-markdown/src"))
      (ocaml      . ("https://github.com/tree-sitter/tree-sitter-ocaml" nil "ocaml/src"))
      (org        . ("https://github.com/milisims/tree-sitter-org"))
      (python     . ("https://github.com/tree-sitter/tree-sitter-python"))
      (php        . ("https://github.com/tree-sitter/tree-sitter-php"))
      (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src"))
      (tsx        . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src"))
      (ruby       . ("https://github.com/tree-sitter/tree-sitter-ruby"))
      (rust       . ("https://github.com/tree-sitter/tree-sitter-rust"))
      (sql        . ("https://github.com/m-novikov/tree-sitter-sql"))
      (vue        . ("https://github.com/merico-dev/tree-sitter-vue"))
      (yaml       . ("https://github.com/ikatyang/tree-sitter-yaml"))
      (toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))
      (zig        . ("https://github.com/GrayJack/tree-sitter-zig"))))
  (add-to-list 'major-mode-remap-alist '(sh-mode         . bash-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c-mode          . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode        . c++-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c-or-c++-mode   . c-or-c++-ts-mode))
  (add-to-list 'major-mode-remap-alist '(css-mode        . css-ts-mode))
  (add-to-list 'major-mode-remap-alist '(js-mode         . js-ts-mode))
  (add-to-list 'major-mode-remap-alist '(java-mode       . java-ts-mode))
  (add-to-list 'major-mode-remap-alist '(js-json-mode    . json-ts-mode))
  (add-to-list 'major-mode-remap-alist '(makefile-mode   . cmake-ts-mode))
  (add-to-list 'major-mode-remap-alist '(python-mode     . python-ts-mode))
  (add-to-list 'major-mode-remap-alist '(ruby-mode       . ruby-ts-mode))
  (add-to-list 'major-mode-remap-alist '(conf-toml-mode  . toml-ts-mode))
  (add-to-list 'auto-mode-alist '("\\(?:Dockerfile\\(?:\\..*\\)?\\|\\.[Dd]ockerfile\\)\\'" . dockerfile-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
  (add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.y[a]?ml\\'" . yaml-ts-mode))
  ;;  (add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-ts-mode))
  )

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this-symbol)
         ("C-M->" . mc/skip-to-next-like-this)
         ("C-<" . mc/mark-previous-like-this-symbol)
         ("C-M-<" . mc/skip-to-previous-like-this)
         ("C-c C->" . mc/mark-all-symbols-like-this)))

(use-package simple-httpd :ensure t)

(require 'org)
(require 'org-capture)
(require 'org-agenda)
(require 'org-refile)
(require 'org-clock)
(org-load-modules-maybe)

(require 'ido)

;;;
;;; Org Mode
;;;
(use-package org
  :ensure t
  :mode ("\$\\.org\\|org_archive\$$" . org-mode)
  :bind (("C-c a" . org-agenda)
	 ("C-c b" . org-switchb)
	 ("C-c c" . org-capture)
	 ("C-c l" . org-store-link))
  :hook ((org-mode . org-indent-mode)
	 ; (org-mode . visual-line-mode)
	 ; (org-mode . org-agenda-start-with-log-mode)
	 (org-mode . (lambda () (ido-mode 'both))))
  :config
  ;; (require 'org-tempo)
  (setq org-directory "~/project")
  (setq org-agenda-files '("~/project/org"))
  (setq org-default-notes-file "~/project/org/inbox.org")
  ;; Task states
  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
	  (sequence "WAIT(w@/!)" "HOLD(h@/!)" "|" "CANC(c@/!)")))
  ;; States color
  (setq org-todo-keyword-faces
	'(("TODO" :foreground "red"          :weight bold)
	  ("NEXT" :foreground "blue"         :weight bold)
	  ("DONE" :foreground "forest green" :weight bold)
	  ("WAIT" :foreground "orange"       :weight bold)
	  ("HOLD" :foreground "magenta"      :weight bold)
	  ("CANC" :foreground "forest green" :weight bold)))
  ;; Fast todo selection
  (setq org-use-fast-todo-selection t)
  ;; `C-cC-t' change states
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)
  (setq org-todo-state-tags-triggers
	'(("CANC" ("CANC" . t))
	  ("WAIT" ("WAIT" . t))
	  ("HOLD" ("HOLD" . t))
	  ( done  ("WAIT") ("HOLD"))
	  ("TODO" ("WAIT") ("CANC") ("HOLD"))
	  ("NEXT" ("WAIT") ("CANC") ("HOLD"))
	  ("DONE" ("WAIT") ("CANC") ("HOLD"))))
  (defun neil/org-mode-disable-modify-agenda-files-keybinding ()
    "Disable Ctrl-c [ | ] in Org Mode to modify org-agenda-files."
    (local-set-key (kbd "C-c [") nil)
    (local-set-key (kbd "C-c ]") nil))
  (add-hook 'org-mode-hook 'neil/org-mode-disable-modify-agenda-files-keybinding)

  (defun neil/org-mode-disable-comment-keybinding ()
    "Disable Ctrl-c ; in Org Mode to prevent accidental comments."
    (local-set-key (kbd "C-c ;") nil))
  (add-hook 'org-mode-hook 'neil/org-mode-disable-comment-keybinding)

  ;; Set templates
  (setq org-capture-templates
	'(("t" "Todo" entry (file "~/project/org/inbox.org")
           "* TODO %?\n%U\n%a\n"
	   :clock-in t :clock-resume t)
          ("n" "Note" entry (file "~/project/org/inbox.org")
           "* %? :NOTE:\n%U\n%a\n"
	   :clock-in t :clock-resume t)
          ("j" "Journal" entry (file+datetree "~/project/org/journal.org")
           "\n* %<%I:%M %p> - Journal :JONL:\n%?\n"
	   :clock-in t :clock-resume t)))
  (defun neil/org-mode-remove-empty-drawer-on-clock-out ()
    (interactive)
    (save-excursion (beginning-of-line 0)
		    (org-remove-empty-drawer-at (point))))
  (add-hook 'org-clock-out-hook 'neil/org-mode-remove-empty-drawer-on-clock-out)

  ;; Targets include this file and any file contributing to the agenda - up to 9 levels deep
  (setq org-refile-targets
	'((nil :maxlevel . 9)
	  (org-agenda-files :maxlevel . 9)))
  ;; Use full outline paths for refile targets - we file directly with IDO
  (setq org-refile-use-outline-path t)
  ;; Targets complete directly with IDO
  (setq org-outline-path-complete-in-steps nil)
  ;; Allow refile to create parent tasks with confirmation
  (setq org-refile-allow-creating-parent-nodes (quote confirm))
  ;; Use IDO for both buffer and file completion and ido-everywhere to t
  ; (setq org-completion-use-ido t) ; Not Found
  (setq ido-everywhere t)
  (setq ido-max-directory-size 100000)
  ;; (ido-mode (quote both))
  ;; Use the current window when visiting files and buffers with ido
  (setq ido-default-file-method 'selected-window)
  (setq ido-default-buffer-method 'selected-window)
  ;; Use the current window for indirect buffer display
  (setq org-indirect-buffer-display 'current-window)
  ;; Exclude DONE state tasks from refile targets
  (defun neil/org-mode-verify-refile-target ()
    "Exclude todo keywords with a done state from refile targets"
    (not (member (nth 2 (org-heading-components)) org-done-keywords)))
  (setq org-refile-target-verify-function 'neil/org-mode-verify-refile-target)

  ;; Do not dim blocked tasks
  (setq org-agenda-dim-blocked-tasks nil)
  ;; Compact the block agenda view
  (setq org-agenda-compact-blocks t)
  ;; Custom agenda command definitions, Need modify
  (setq org-agenda-custom-commands
	'(("T" "TODO"
	   ((todo "TODO"
		  ((org-agenda-overriding-header "In Planning")))))
	  ("N" "Notes" tags "NOTE"
           ((org-agenda-overriding-header "Notes")
            (org-tags-match-list-sublevels t)))
	  (" " "Agenda"
	   ((agenda "" nil)
	    (tags "INBOX"
                  ((org-agenda-overriding-header "Tasks to Inbox")
                   (org-tags-match-list-sublevels nil)))
	    (todo "NEXT"
		  ((org-agenda-overriding-header "Ready to Work")
		   (org-agenda-files org-agenda-files)))
	    (todo "WAIT"
		  ((org-agenda-overriding-header "Waiting on External")
		   (org-agenda-files org-agenda-files)))
	    (todo "HOLD"
		  ((org-agenda-overriding-header "On Hold")
		   (org-agenda-files org-agenda-files)))
	    (todo "CANC"
		  ((org-agenda-overriding-header "Cancelled Project")
		   (org-agenda-files org-agenda-files)))))))
  ;;; Clock
  ;; Resume clocking task when emacs is restarted
  (org-clock-persistence-insinuate)
  ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
  (setq org-clock-history-length 23)
  ;; Resume clocking task on clock-in if the clock is open
  (setq org-clock-in-resume t)
  ;; Separate drawers for clocking and logs
  ;; (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
  ;; Save clock data and state changes and notes in the LOGBOOK drawer
  (setq org-clock-into-drawer t)
  ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)
  ;; Clock out when moving task to a done state
  (setq org-clock-out-when-done t)
  ;; Save the running clock and all clock history when exiting Emacs, load it on startup
  (setq org-clock-persist t)
  ;; Do not prompt to resume an active clock
  (setq org-clock-persist-query-resume nil)
  ;; Enable auto clock resolution for finding open clocks
  (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
  ;; Include current clocking task in clock reports
  (setq org-clock-report-include-clocking-task t)
  ;; Change tasks to NEXT when clocking in
  (defun neil/org-mode-clock-in-to-next (kw)
    "Switch a task from TODO to NEXT when clocking in."
    (when (not (and (boundp 'org-capture-mode) org-capture-mode))
      (cond
       ((and (member (org-get-todo-state) (list "TODO"))
             (neil/is-task))
	"NEXT")
       ((and (member (org-get-todo-state) (list "NEXT"))
             (neil/is-project))
	"TODO"))))
  (defun neil/is-project ()
    "Any task with a todo keyword subtask"
    (save-restriction
      (widen)
      (let ((has-subtask)
            (subtree-end (save-excursion (org-end-of-subtree t)))
            (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
	(save-excursion
          (forward-line 1)
          (while (and (not has-subtask)
                      (< (point) subtree-end)
                      (re-search-forward "^\*+ " subtree-end t))
            (when (member (org-get-todo-state) org-todo-keywords-1)
              (setq has-subtask t))))
	(and is-a-task has-subtask))))
  (defun neil/is-task ()
    "Any task with a todo keyword and no subtask"
    (save-restriction
      (widen)
      (let ((has-subtask)
            (subtree-end (save-excursion (org-end-of-subtree t)))
            (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
	(save-excursion
          (forward-line 1)
          (while (and (not has-subtask)
                      (< (point) subtree-end)
                      (re-search-forward "^\*+ " subtree-end t))
            (when (member (org-get-todo-state) org-todo-keywords-1)
              (setq has-subtask t))))
	(and is-a-task (not has-subtask)))))
  (defun neil/is-project ()
    "Any task with a todo keyword subtask"
    (save-restriction
      (widen)
      (let ((has-subtask)
            (subtree-end (save-excursion (org-end-of-subtree t)))
            (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
	(save-excursion
          (forward-line 1)
          (while (and (not has-subtask)
                      (< (point) subtree-end)
                      (re-search-forward "^\*+ " subtree-end t))
            (when (member (org-get-todo-state) org-todo-keywords-1)
              (setq has-subtask t))))
	(and is-a-task has-subtask))))

  (setq org-clock-in-switch-to-state 'neil/org-mode-clock-in-to-next)
  ;; Add a time stamp to the task
  (setq org-log-done 'time)
  ;; Non-nil means insert state change notes and time stamps into a drawer.
  (setq org-log-into-drawer t)
  ;;The ellipsis to use in the Org mode outline.
  (setq org-ellipsis " ▾ ")
  ;; Non-nil means font-lock should hide the emphasis marker characters.
  (setq org-hide-emphasis-markers t)
  )

(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


(use-package gnuplot
  :ensure t
  :after org
  :config
  ;; (setq org-gnuplot-program "/opt/homebrew/bin/gnuplot")
)

(use-package visual-fill-column
  :ensure t
  :defer t
  :config
  (setq visual-fill-column-width 100
	visual-fill-column-center-text t)
  :hook ((org-mode . visual-fill-column-mode)))

(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)
