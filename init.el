;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package go-mode
  :ensure t)

(use-package company
  :init (global-company-mode)
  :config
  (progn
    (bind-key (kbd "C-TAB") #'company-complete company-mode-map)
    (add-to-list 'company-backends 'company-irony 'company-jedi)
    (setq jedi:setup-keys t)
    (setq jedi:complete-on-dot t)
    (add-hook 'python-mode-hook 'jedi:setup)))

(use-package org
  :config
  (progn
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((shell . t)
       (python . t)
       (org . t)
       (haskell . t)
       ))
    (setq org-use-sub-superscripts '{})
    (setq org-export-with-sub-superscripts '{})
    (setq org-src-window-setup 'current-window)
    (setq org-src-preserve-indentation t)
    (setq org-startup-indented t)
    (define-key global-map "\C-ca" 'org-agenda)
    (setq org-todo-keywords
      '((sequence "TODO(t!)" "BLOCK" "|" "DONE(d!)")))
    (setq org-agenda-files
      '("~/journal.org"))
    (setq org-image-actual-width '(300))
    (setq org-clock-mode-line-total 'today)
    (setq org-refile-targets
      '((nil :maxlevel . 2)))))


(use-package ob-async
  :ensure t)
(use-package ivy
 :config
 (progn
   (ivy-mode 1)
   (setq ivy-use-virtual-buffers t)
   (setq ivy-count-format "(%d/%d) ")
   (global-set-key (kbd "C-c C-r") 'ivy-resume)))
(use-package swiper
  :ensure t
  :config
   (global-set-key (kbd "C-s") 'swiper))
(use-package counsel
  :ensure t
  :config
  (progn
   (global-set-key (kbd "M-x") 'counsel-M-x)
   (global-set-key (kbd "C-x C-f") 'counsel-find-file)
   (global-set-key (kbd "<f1> f") 'counsel-describe-function)
   (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
   (global-set-key (kbd "<f1> l") 'counsel-find-library)
   (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
   (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
   (global-set-key (kbd "C-c g") 'counsel-git)
   (global-set-key (kbd "C-c j") 'counsel-git-grep)
   (global-set-key (kbd "C-c k") 'counsel-ag)
   (global-set-key (kbd "C-x l") 'counsel-locate)
   (global-set-key (kbd "C-c C-SPC") 'counsel-mark-ring)))
(use-package magit
  :ensure t
  :config
  (setq magit-completing-read-function 'ivy-completing-read))
(use-package elpy
  :ensure t
  :config
  (elpy-enable))
;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq c-default-style "stroustrup")

(setq tab-width 4)
(setq indent-tabs-mode nil)


(setq mac-option-key-is-meta nil) ;; mac keybindings
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)


(setq backup-directory-alist `(("." . "~/.emacs-saves"))) ;; store buffers and backups
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq doc-view-continuous t)

;; override text color in ansi-term
(add-hook 'shell-mode-hook
      (lambda ()
        (face-remap-set-base 'comint-highlight-prompt :inherit nil)))

;; PYTHON CONFIGURATION
;; --------------------------------------

(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")


;; EXTENDED PACKAGE CONFIG
;; ----------------------------------------



(defvar ansi-color-names-vector
  ["#101010" "#803030" "#4b762f" "#aa9943"
   "#324c80" "#a06c9a" "#82b4ae" "#ededed"])

;; Ugly hack to avoid warnings that ansi-color-make-color-map is not defined.
(eval-when-compile (defun ansi-color-make-color-map ()))

;;; make the shell beautifull
;; (eval-after-load 'shell
;;    '(progn
;      (setenv "ESHELL" (expand-file-name "~/bin/eshell"))
;      (defvar ansi-color-map (ansi-color-make-color-map))))

;;; make the term beautifull
;; order of colours is wrong?
(eval-after-load 'term
  '(progn
     (let ((term-face-names (vector 'term-color-black
            'term-color-red
            'term-color-green
            'term-color-yellow
            'term-color-blue
            'term-color-magenta
            'term-color-cyan
            'term-color-white
            'term))
     (term-color-names (vconcat ansi-color-names-vector ["#d2dec4"])))
       (set-face-background 'term 'nil)
       (cl-mapc 'set-face-foreground term-face-names term-color-names)
       (custom-set-variables
  '(term-default-bg-color "#000000")
  '(term-default-fg-color "#dddd00")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#D3D7CF" "#cc0000" "#4E9A06" "#C4A000" "#3465A4" "#75507B" "#06989A" "#000000"])
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (dashboard treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil treemacs minimap use-package py-autopep8 ob-async material-theme magit gruvbox-theme go-mode flycheck exec-path-from-shell elpygen elpy ein counsel better-defaults)))
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "#dddd00"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; treemacs is a package for displaying directory structure within emacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-file-event-delay              5000
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-desc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         40)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)


;; show startup screen showing recent activity
(require 'dashboard)
(dashboard-setup-startup-hook)
;; Or if you use use-package
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; sublime style minimap
;; (require 'sublimity)
;;  (require 'sublimity-scroll)
;;  (require 'sublimity-map) ;; experimental
;;  (require 'sublimity-attractive)
;; (sublimity-mode 1)
