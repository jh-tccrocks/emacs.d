
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
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
 '(package-selected-packages
   (quote
    (highlight-indent-guides auto-package-update dtrt-indent indent-guide evil-nerd-commenter powerline-evil evil-leader key-chord powerline evil-surround evil-goggles evil-expat evil-visualstar evil-replace-with-register evil-collection use-package evil)))
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




;;; packages
;(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ;("org" . "http://orgmode.org/elpa/")
                        ;("marmalade" . "http://marmalade-repo.org/packages/")
                         ;("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
;(package-initialize)


;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

  (use-package powerline
    :ensure t
    :config
    (powerline-default-theme))

;;; load evil
;(use-package evil
  ;:ensure t ;; install the evil package if not installed
  ;:init ;; tweak evil's configuration before loading it
  ;(setq evil-search-module 'evil-search)
  ;(setq evil-ex-complete-emacs-commands nil)
  ;(setq evil-vsplit-window-right t)
  ;(setq evil-split-window-below t)
  ;(setq evil-shift-round nil)
  ;(setq evil-want-C-u-scroll t)
  ;:config ;; tweak evil after loading it
  ;(evil-mode)

  ;;; example how to map a command in normal mode (called 'normal state' in evil)
  ;(define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit))

(use-package evil
  :ensure t
  :defer .1 ;; don't block emacs when starting, load evil immediately after startup
  :init
  (setq evil-want-integration nil) ;; required by evil-collection
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
  :config
  (evil-mode)

  ;; vim-like keybindings everywhere in emacs
  (use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init))

  ;;; gl and gL operators, like vim-lion
  ;(use-package evil-lion
    ;:ensure t
    ;:bind (:map evil-normal-state-map
                ;("g l " . evil-lion-left)
                ;("g L " . evil-lion-right)
                ;:map evil-visual-state-map
                ;("g l " . evil-lion-left)
                ;("g L " . evil-lion-right)))

  ;;; gc operator, like vim-commentary
  ;(use-package evil-commentary
    ;:ensure t
    ;:bind (:map evil-normal-state-map
                ;("gc" . evil-commentary)))

  ;;; gx operator, like vim-exchange
  ;;; NOTE using cx like vim-exchange is possible but not as straightforward
  ;(use-package evil-exchange
    ;:ensure t
    ;:bind (:map evil-normal-state-map
                ;("gx" . evil-exchange)
                ;("gX" . evil-exchange-cancel)))

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
    (evil-define-key 'visual global-map "gS" 'evil-Surround-region))

  (use-package evil-leader
    :after evil
    :ensure t)

  (use-package powerline-evil
    :after evil
    :after powerline
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

;;; flycheck
;(use-package flycheck)
;(add-hook 'after-init-hook #'global-flycheck-mode)

;(after 'flycheck
  ;(setq flycheck-check-syntax-automatically '(save mode-enabled))
  ;(setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
  ;(setq flycheck-checkers (delq 'html-tidy flycheck-checkers))
  ;(setq flycheck-standard-error-navigation nil))

;(global-flycheck-mode t)

;;; flycheck errors on a tooltip (doesnt work on console)
;(when (display-graphic-p (selected-frame))
  ;(eval-after-load 'flycheck
    ;'(custom-set-variables
      ;'(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))

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

;; make cursor movement stop in between camelCase words.
;(global-subword-mode 1)

;; remember cursor position, for emacs 25.1 or later
(save-place-mode 1)

;;; remember cursor position. When file is opened, put cursor at last position
;(if (version< emacs-version "25.0")
    ;(progn
      ;(require 'saveplace)
      ;(setq-default save-place t))
  ;(save-place-mode 1))

;; when a file is updated outside emacs, make it update if it's already opened in emacs
(global-auto-revert-mode 1)

;; wrap long lines by word boundary, and arrow up/down move by visual line, etc
(global-visual-line-mode 1)


;(use-package indent-guide
;(use-package highlight-indention
(use-package highlight-indent-guides
  :hook prog-mode
  :ensure t
  :config
  ;(add-hook 'prog-mode-hook 'highlight-indent-guides-mode))
  (highlight-indent-guides-mode))

(use-package latex-preview-pane-enable
  :ensure t)

(defalias 'list-buffers 'ibuffer) ; make ibuffer default

;bash-completion
;load-bash-alias
;pushbullet
