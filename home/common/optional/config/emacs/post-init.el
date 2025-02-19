;;; post-init.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-
(use-package compile-angel
  :ensure t
  :demand t
  :config
  (compile-angel-on-load-mode)
  (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode))

;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(add-hook 'after-init-hook #'global-auto-revert-mode)

;; recentf is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(add-hook 'after-init-hook #'recentf-mode)

;; savehist is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(add-hook 'after-init-hook #'savehist-mode)

;; save-place-mode enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(add-hook 'after-init-hook #'save-place-mode)

;; Tip: You can remove the `vertico-mode' use-package and replace it
;;      with the built-in `fido-vertical-mode'.
(use-package vertico
  ;; (Note: It is recommended to also enable the savehist package.)
  :ensure t
  :defer t
  :commands vertico-mode
  :hook (after-init . vertico-mode))

(use-package orderless
  ;; Vertico leverages Orderless' flexible matching capabilities, allowing users
  ;; to input multiple patterns separated by spaces, which Orderless then
  ;; matches in any order against the candidates.
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  ;; Marginalia allows Embark to offer you preconfigured actions in more contexts.
  ;; In addition to that, Marginalia also enhances Vertico by adding rich
  ;; annotations to the completion candidates displayed in Vertico's interface.
  :ensure t
  :defer t
  :commands (marginalia-mode marginalia-cycle)
  :hook (after-init . marginalia-mode))

(use-package embark
  ;; Embark is an Emacs package that acts like a context menu, allowing
  ;; users to perform context-sensitive actions on selected items
  ;; directly from the completion interface.
  :ensure t
  :defer t
  :commands (embark-act
             embark-dwim
             embark-export
             embark-collect
             embark-bindings
             embark-prefix-help-command)
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package consult
  :ensure t
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x t b" . consult-buffer-other-tab)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))

  ;; Enable automatic preview at point in the *Completions* buffer.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init
  ;; Optionally configure the register formatting. This improves the register
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

;; evil-want-keybinding must be declared before Evil and Evil Collection
(setq evil-want-keybinding nil)

(use-package evil
  :ensure t
  :init
  (setq evil-undo-system 'undo-fu)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :custom
  (evil-want-Y-yank-to-eol t)
  :config
  (evil-select-search-module 'evil-search-module 'evil-search)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package undo-fu
  :ensure t
  :commands (undo-fu-only-undo
             undo-fu-only-redo
             undo-fu-only-redo-all
             undo-fu-disable-checkpoint)
  :custom
  ;; 3 times the default values
  (undo-limit (* 3 160000))
  (undo-strong-limit (* 3 240000)))

(use-package undo-fu-session
  :ensure t
  :config
  (undo-fu-session-global-mode))

(use-package corfu
  :ensure t
  :defer t
  :commands (corfu-mode global-corfu-mode)

  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode))

  :custom
  (corfu-cycle t)                 ; Allows cycling through candidates
  (corfu-auto t)                  ; Enable auto completion
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-preview-current 'insert) ; insert previewed candidate
  (corfu-preselect 'prompt)
  (corfu-on-exact-match nil)      ; Don't auto expand tempel snippets
  ;; Hide commands in M-x which do not apply to the current mode.
  ;(read-extended-command-predicate #'command-completion-default-include-p)
  ;; Disable Ispell completion function. As an alternative try `cape-dict'.
  (text-mode-ispell-word-completion nil)
  (tab-always-indent 'complete)

  ;; Enable Corfu
  :config
  (global-corfu-mode))

(use-package cape
  :ensure t
  :defer t
  :commands (cape-dabbrev cape-file cape-elisp-block)
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-package go-ts-mode
  :mode ("\\.go\\'" . go-ts-mode)
  :config
  (setq gofmt-command "gofmt") ;; Use "goimports" if preferred
  (add-hook 'go-mode-hook (lambda () (setq format-all-formatters '("Go" gofmt)))))

;;(use-package lspce
;;:config (progn
;;            (setq lspce-send-changes-idle-time 0.1)
;;            (setq lspce-show-log-level-in-modeline t) ;; show log level in mode line
;;
;;            ;; You should call this first if you want lspce to write logs
;;            (lspce-set-log-file "/tmp/lspce.log")
;;
;;            ;; By default, lspce will not write log out to anywhere. 
;;            ;; To enable logging, you can add the following line
;;            (lspce-enable-logging)
;;            ;; You can enable/disable logging on the fly by calling `lspce-enable-logging' or `lspce-disable-logging'.
;;
;;            ;; enable lspce in particular buffers
;;            ;; (add-hook 'rust-mode-hook 'lspce-mode)
;;
;;            ;; modify `lspce-server-programs' to add or change a lsp server, see document
;;            ;; of `lspce-lsp-type-function' to understand how to get buffer's lsp type.
;;            ;; Bellow is what I use
;;            (setq lspce-server-programs `(("nix"  "nixd" "--nixpkgs-expr=\"import <nixpkgs> { }\"")
;;                                        ("go" "gopls" "")
;;                                        ("java" "java" lspce-jdtls-cmd-args lspce-jdtls-initializationOptions)))))

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("go"     (gofmt "c")))))

(use-package doom-themes
  :init (load-theme 'doom-tokyo-night t))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package nyan-mode
  :init
  (nyan-mode))

(use-package dashboard
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "It is too late for me, son")
  (setq dashboard-footer-messages '("Well cum to the dark side; we have cookies"))
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-center-content t) 
  (setq dashboard-startupify-list '(dashboard-insert-banner
                                    dashboard-insert-banner-title
                                    dashboard-insert-navigator
                                    dashboard-insert-newline
                                    dashboard-insert-items
                                    dashboard-insert-newline
                                    dashboard-insert-footer))
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(use-package general
  :config
    (general-evil-setup)
    ;; Set up 'SPC' as the leader key
    (general-create-definer haam/leader-keys
      :states '(normal insert visual motion emacs)
      :keymaps'override
      :prefix "SPC"           ;; Set leader key
      :global-prefix "C-SPC") ;; Set global leader key

    (haam/leader-keys
      "."     '(find-file :wk "Find file")
      "TAB"   '(comment-line :wk "Comment lines"))

    (haam/leader-keys
      "b"     '(:ignore t :wk "Buffer Bookmarks")
      "b b"   '(consult-buffer :wk "Switch buffer")
      "b k"   '(kill-this-buffer :wk "Kill this buffer")
      "b i"   '(ibuffer :wk "Ibuffer")
      "b n"   '(next-buffer :wk "Next buffer")
      "b p"   '(previous-buffer :wk "Previous buffer")
      "b r"   '(revert-buffer :wk "Reload buffer")
      "b j"   '(consult-bookmark :wk "Bookmark jump"))

    (haam/leader-keys
      "e"     '(:ignore t :wk "[E]macs") ;; To get more help use C-h commands (describe variable, function, etc.)
      "e q"   '(save-buffers-kill-emacs :wk "[E]macs [Q]uit")
      "e r"   '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :wk "[E]macs [R]eload config")
      "e s t" '(hydra-text-scale/body :which-key "[E]macs [S]cale [T]ext"))

    (haam/leader-keys
      "s"     '(:ignore t :wk "[S]earch")
      "s d"   '(find-file :wk "[S]earch [D]irectory")
      "s f"   '(consult-fd :wk "[S]earch [F]iles")
      "s w"   '(consult-line :wk "[S]earch [W]ord")
      "s t"   '(consult-ripgrep :wk "[S]earch [T]ext")
      "s b"   '(consult-buffer :wk "[S]earch [B]uffer")
      "s r"   '(consult-recent-file :wk "[S]earch [R]ecent"))

    (haam/leader-keys
      "c"     '(:ignore t :wk "[C]ode")
      "c a s" '(:ignore t :wk "[C]ode [A]utocompletion [S]tart" )
      "c a p" '(:ignore t :wk "[C]ode [A]utocompletion [P]ause" )
      "c r"   '(:ignore t :wk "[C]ode [R]un" )
      "c t"   '(:ignore t :wk "[C]ode [T]est" )
      "c f"   '(:ignore t :wk "[C]ode [F]ormat" )
      "c l d" '(:ignore t :wk "[C]ode" )  ;; View LSP diagnostics
      "c l r" '(:ignore t :wk "[C]ode")   ;; Find references
      "c l s" '(:ignore t :wk "[C]ode")      ;; Search for symbols
      "c l f "'(:ignore t :wk "[C]ode"))) ;; Search file-local symbols

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(defvar haam/default-font-size 150)
(defvar haam/default-variable-font-size 150)

(set-face-attribute 'default nil :font "SF Mono" :height haam/default-font-size :weight 'bold)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "SF Mono" :height haam/default-font-size :weight 'bold)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "SF Pro" :height haam/default-variable-font-size :weight 'bold)

(use-package nix-ts-mode
:after lsp-mode
:ensure t
:hook
(nix-mode . lsp-deferred) ;; So that envrc mode will work
:custom
(lsp-disabled-clients '((nix-ts-mode . nix-nil))) ;; Disable nil so that nixd will be used as lsp-server
:config
(setq lsp-nix-nixd-server-path "nixd"
      lsp-nix-nixd-formatting-command [ "nixfmt" ]
      lsp-nix-nixd-nixpkgs-expr "import <nixpkgs> { }"
      lsp-nix-nixd-nixos-options-expr "(builtins.getFlake "/home/haam/projects/privet/configs/nixos/flake-0").nixosConfigurations.laptop.options"
      lsp-nix-nixd-home-manager-options-expr "(builtins.getFlake "/home/haam/projects/privet/configs/nixos/flake-0").homeConfigurations.haam.options"))
(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-completion-provider :capf)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-lens-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-signature-render-documentation nil)
  (setq lsp-completion-show-detail nil)
  (setq lsp-inlay-hint-enable t))
