
;; Added by Package.el.
;; This must come before configurations of installed packages.  Don't delete this line.
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("melpa-stable" . "https://melpa.org/packages/") t)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(display-battery-mode t)
 '(display-time-mode t)
 '(evil-collection-setup-minibuffer t)
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(package-selected-packages
   (quote
    (neotree evil-matchit git-gutter web-beautify company helm-projectile projectile helm all-the-icons latex-preview-pane flycheck highlight-indent-guides auto-package-update dtrt-indent indent-guide evil-nerd-commenter powerline-evil evil-leader key-chord powerline evil-surround evil-goggles evil-expat evil-visualstar evil-replace-with-register evil-collection use-package evil)))
 '(show-paren-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono for Powerline" :foundry "outline" :slant normal :weight normal :height 90 :width normal))))
 '(evil-goggles-change-face ((t (:inherit diff-removed))))
 '(evil-goggles-delete-face ((t (:inherit diff-removed))))
 '(evil-goggles-paste-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-add-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-change-face ((t (:inherit diff-changed))))
 '(evil-goggles-undo-redo-remove-face ((t (:inherit diff-removed))))
 '(evil-goggles-yank-face ((t (:inherit diff-changed)))))



;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package powerline
             :ensure t
             :config
             (powerline-vim-theme))


;;; example how to map a command in normal mode (called 'normal state' in evil)
;(define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit))

(use-package evil
             :ensure t
             :defer .1 ;; don't block emacs when starting, load evil immediately after startup
             :init
             (setq evil-want-integration t) ;; required by evil-collection
             (setq evil-want-keybinding nil) ;; required by evil-collection
             (setq evil-search-module 'evil-search)
             (setq evil-ex-complete-emacs-commands nil)
             (setq evil-vsplit-window-right t) ;; like vim's 'splitright'
             (setq evil-split-window-below t) ;; like vim's 'splitbelow'
             (setq evil-shift-round nil)
             (setq evil-want-C-u-scroll t)
             (setq evil-emacs-state-cursor '("red" box))
             (setq evil-normal-state-cursor '("green" box))
             (setq evil-visual-state-cursor '("orange" box))
             (setq evil-insert-state-cursor '("red" bar))
             (setq evil-replace-state-cursor '("red" bar))
             (setq evil-operator-state-cursor '("red" hollow))
             (global-evil-leader-mode)
             :config
             (evil-mode 1)

             ;; vim-like keybindings everywhere in emacs
             (use-package evil-collection
                          :after evil
                          :ensure t
                          :custom (evil-collection-setup-minibuffer t)
                          :config
                          (evil-collection-init))

             ;; gr operator, like vim's ReplaceWithRegister
             (use-package evil-replace-with-register
                          :after evil
                          :ensure t
                          :bind (:map evil-normal-state-map
                                      ("gr" . evil-replace-with-register)
                                      :map evil-visual-state-map
                                      ("gr" . evil-replace-with-register)))

             ;; * operator in visual mode
             (use-package evil-visualstar
                          :after evil
                          :ensure t
                          :bind (:map evil-visual-state-map
                                      ("*" . evil-visualstar/begin-search-forward)
                                      ("#" . evil-visualstar/begin-search-backward)))

             ;; ex commands, which a vim user is likely to be familiar with
             (use-package evil-expat
                          :after evil
                          :ensure t
                          :defer t)

             ;; visual hints while editing
             (use-package evil-goggles
                          :after evil
                          :ensure t
                          :config
                          (evil-goggles-use-diff-faces)
                          (evil-goggles-mode))

             ;; like vim-surround
             (use-package evil-surround
                          :after evil
                          :ensure t
                          :commands
                          (evil-surround-edit
                            evil-Surround-edit
                            evil-surround-region
                            evil-Surround-region)
                          :init
                          (evil-define-key 'operator global-map "s" 'evil-surround-edit)
                          (evil-define-key 'operator global-map "S" 'evil-Surround-edit)
                          (evil-define-key 'visual global-map "S" 'evil-surround-region)
                          (evil-define-key 'visual global-map "gS" 'evil-Surround-region)
                          :config
                          (global-evil-surround-mode))

             (use-package evil-leader
                          :after evil
                          :ensure t)

             (use-package powerline-evil
                          :after evil powerline
                          :ensure t
                          :config
                          (powerline-evil-vim-color-theme)
                          (display-time-mode t))

             (use-package evil-nerd-commenter
                          :after evil
                          :ensure t)

(message "Loading evil-mode...done"))


(use-package key-chord
             :after evil
             :ensure t
             :config
             (key-chord-mode 1)
             (key-chord-define evil-insert-state-map  "jj" 'evil-normal-state))


;;; esc quits
;(defun minibuffer-keyboard-quit ()
;"Abort recursive edit.
;In Delete Selection mode, if the mark is active, just deactivate it;
;then it takes a second \\[keyboard-quit] to abort the minibuffer."
;(interactive)
;(if (and delete-selection-mode transient-mark-mode mark-active)
;(setq deactivate-mark  t)
;(when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
;(abort-recursive-edit)))
;(define-key evil-normal-state-map [escape] 'keyboard-quit)
;(define-key evil-visual-state-map [escape] 'keyboard-quit)
;(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
;(global-set-key [escape] 'evil-exit-emacs-state)

;(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
;(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; flycheck
(use-package flycheck
             :ensure t
             :config
             (setq flycheck-check-syntax-automatically '(save mode-enabled))
             (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
             (setq flycheck-checkers (delq 'html-tidy flycheck-checkers))
             (setq flycheck-standard-error-navigation nil)
             (add-hook 'after-init-hook #'global-flycheck-mode)
             (global-flycheck-mode t))


;; flycheck errors on a tooltip (doesnt work on console)
(when (display-graphic-p (selected-frame))
(eval-after-load 'flycheck
'(custom-set-variables
'(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))



(use-package auto-package-update
             :ensure t
             :config
             (auto-package-update-at-time "23:00")
             (auto-package-update-maybe))

(use-package dtrt-indent
             :ensure t
             :config
             (dtrt-indent-mode 1))

(define-key global-map (kbd "RET") 'newline-and-indent)

;(use-package autopair)
;(autopair-global-mode)

;(setq save-place-file "~/.emacs.d/saveplace")
;(setq-default save-place t)
;(use-package saveplace)

(setq-default show-trailing-whitespace t)

;; save/restore opened files
(desktop-save-mode 1)

;; for isearch-forward, make these equivalent: space newline tab hyphen underscore
(setq search-whitespace-regexp "[-_ \t\n]+")


;; save minibuffer history
(savehist-mode 1)

(show-paren-mode t)
;(initial-frame-alist (quote ((fullscreen . maximized))))) ;; start maximized

(with-eval-after-load 'evil-maps
                      (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
                      (define-key evil-motion-state-map (kbd ";") 'evil-ex))

;; remember cursor position, for emacs 25.1 or later
(save-place-mode 1)

;;; remember cursor position. When file is opened, put cursor at last position
;(if (version< emacs-version "25.0")
;(progn
;(require 'saveplace)
;(setq-default save-place t))
;(save-place-mode 1))
;always display line numbers
(global-display-line-numbers-mode)

;; when a file is updated outside emacs, make it update if it's already opened in emacs
(global-auto-revert-mode 1)

;; wrap long lines by word boundary, and arrow up/down move by visual line, etc
(global-visual-line-mode 1)
(setq visible-bell 1)

(setq-default indent-tabs-mode nil)

(use-package highlight-indent-guides
             ;:hook prog-mode
             :ensure t;)
             :config
             ;(highlight-indent-guides-mode))
             (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(use-package latex-preview-pane
             :ensure t
             :config
             (latex-preview-pane-enable))

(defalias 'list-buffers 'ibuffer) ; make ibuffer default

;bash-completion
;load-bash-alias
;pushbullet

(use-package all-the-icons
             :ensure t)

(use-package neotree
             :ensure t)

(use-package helm
             :ensure t
             :config
             (helm-mode 1)
             (setq helm-autoresize-mode t)
             (setq helm-buffer-max-length 40)
             (global-set-key (kbd "M-x") #'helm-M-x)
             (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
             (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level))

(use-package projectile
             :ensure t
             :defer t
             :config
             (projectile-mode))


(use-package helm-projectile
             :after helm projectile
             :bind (("C-S-P" . helm-projectile-switch-project)
                    :map evil-normal-state-map
                    ("C-p" . helm-projectile))
             :ensure t
             :config
             (evil-leader/set-key
               "ps" 'helm-projectile-ag
               "pa" 'helm-projectile-find-file-in-known-projects
               ))


(use-package company
             :ensure t
             :config
             (global-company-mode)
             (setq company-idle-delay 0.2)
             (setq company-selection-wrap-around t)
             (define-key company-active-map [tab] 'company-complete)
             (define-key company-active-map (kbd "C-n") 'company-select-next)
             (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package web-beautify
             :ensure t)

(use-package git-gutter
             :ensure t
             :config
             (global-git-gutter-mode +1))


(use-package org
             :ensure t)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

(put 'dired-find-alternate-file 'disabled nil)

(setq frame-title-format "%b")

(require 'midnight)
(midnight-mode t)
(message "Loading init.el...done"))

