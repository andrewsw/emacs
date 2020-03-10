;
;; Setup the load path to include our local stuff
;;
(add-to-list 'load-path "~/.emacs.d/elisp/")

(require 'my-packages)

;;
;;
;; various configuration and setup routines ()
;;
;;
;;
;;
;;
;;

(require 'my-ui)

;; try out recentf
(require 'recentf)
(recentf-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(column-number-mode t)
 '(company-backends
   (quote
    (company-lsp company-bbdb company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
                 (company-dabbrev-code company-gtags company-etags company-keywords)
                 company-oddmuse company-dabbrev)))
 '(company-idle-delay 0.3)
 '(company-minimum-prefix-length 2)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(elpy-project-root-finder-functions
   (quote
    (elpy-project-find-git-root elpy-project-find-hg-root elpy-project-find-svn-root)))
 '(elpy-rpc-python-command "python3")
 '(elpy-test-runner (quote elpy-test-pytest-runner))
 '(exec-path
   (quote
    ("/home/local/ANT/asackvil/.cargo/bin" "/home/local/ANT/asackvil/bin" "/home/local/ANT/asackvil/.local/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/usr/local/games" "/snap/bin" "/home/local/ANT/asackvil/.gem/ruby/2.3.0/bin" "/usr/lib/x86_64-linux-gnu/emacs/26.2/x86_64-linux-gnu")))
 '(flycheck-checker-error-threshold 1000)
 '(flycheck-disabled-checkers (quote (ruby-rubylint ruby-leek ruby-jruby)))
 '(flycheck-rubocoprc "~/flycheck-rubocoprc.yml")
 '(fringe-mode nil nil (fringe))
 '(global-company-mode t)
 '(indent-tabs-mode nil)
 '(latex-run-command "pdflatex")
 '(linum-format "%d ")
 '(lsp-enable-indentation nil)
 '(lsp-enable-on-type-formatting nil)
 '(lsp-java-completion-import-order
   ["" "java" "javax" "org.junit" "com" "org" "com.amazon" "com.amazonaws"])
 '(org-agenda-files (quote ("~/doc/notes.org" "~/doc/journal.org")))
 '(org-agenda-todo-ignore-scheduled (quote future))
 '(org-deadline-warning-days 5)
 '(package-selected-packages
   (quote
    (helm-ag helm-projectile lsp-ui company-lsp project-explorer "project-explorer" exec-path-from-shell mu4e-overview helm dap-mode treemacs lsp-java lsp-mode yaml-mode web-mode smartparens ruby-test-mode ruby-hash-syntax ruby-electric rubocop robe py-autopep8 projectile minimap markdown-mode magit loccur json-mode jinja2-mode idle-highlight-mode highlight flymake-ruby flymake-json flx-ido elpy csv-mode ag)))
 '(projectile-completion-system (quote helm))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "build")))
 '(projectile-globally-ignored-file-suffixes (quote ("class")))
 '(py-autopep8-options (quote ("--max-line-length=120")))
 '(ruby-test-rspec-options (quote ("--drb" "-b")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
 '(tool-bar-mode nil)
 '(tramp-terminal-type "tramp")
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify))
 '(warning-suppress-types (quote ((undo discard-info))))
 '(web-mode-attr-indent-offset 2)
 '(web-mode-attr-value-indent-offset 2)
 '(web-mode-auto-close-style 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-enable-auto-closing t)
 '(web-mode-enable-auto-pairing t)
 '(web-mode-markup-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "light grey" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 96 :width normal :foundry "PfEd" :family "Inconsolata"))))
 '(dap-ui-pending-breakpoint-face ((t (:foreground "red"))))
 '(erc-default-face ((t (:foreground "dark gray"))))
 '(erc-input-face ((t (:foreground "white"))))
 '(magit-diff-added ((t (:background "forest green" :foreground "#ddffdd"))))
 '(magit-diff-added-highlight ((t (:background "forest green" :foreground "brightblack"))))
 '(magit-diff-removed ((t (:background "darkred" :foreground "#ffdddd"))))
 '(magit-diff-removed-highlight ((t (:background "dark red" :foreground "white"))))
 '(minibuffer-prompt ((t (:foreground "Cyan"))))
 '(minimap-active-region-background ((t (:background "dark slate gray"))))
 '(show-paren-match ((t (:background "gray18")))))

;;
;;
;;
;; Programming hooks
;;
;;
(defun asackvil/setup-prog-mode ()
  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t)))
  (hs-minor-mode 1)
  (idle-highlight-mode 1)
  (electric-pair-mode)
  (setq c-electric-flag nil) ;; this thing is breaking indentation in java.. need to properly diagnose, this is a stop-gap
  (define-key prog-mode-map (kbd "C-c h") 'hs-toggle-hiding)
  (define-key prog-mode-map (kbd "C-c C-h") 'hs-hide-level))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook 'asackvil/setup-prog-mode)
;;
;; Lisp, SLIME
;;

;; SLIME
;;(setq inferior-lisp-program "clisp")
;; (add-to-list 'load-path "~/.slime")
;; (require 'slime)
;; (slime-setup)

(defun move-past-close ()
  "Move past next `)', close up any gaps before that `, and ensure just one space after it."
  (interactive)
  (let ((new-point (search-forward ")" nil t))
        )
    (if new-point
        (save-excursion
          (progn (backward-word)
                 (forward-word)
                 (just-one-space)
                 (backward-char 1)
                 (delete-char 1)
                 ))
        (insert ")")))
  (insert " "))

;; Lisp hooks
(add-hook 'lisp-mode-hook '(lambda ()
                             (define-key lisp-mode-map (kbd "RET") 'newline-and-indent)
                             (define-key lisp-mode-map (kbd "(") 'insert-parentheses)
                             (define-key lisp-mode-map (kbd ")") 'move-past-close)
                             (define-key lisp-mode-map (kbd "C-=") (lambda () (interactive) (insert "(")))
                             (define-key lisp-mode-map (kbd "C-\\") (lambda () (interactive) (insert ")")))
                             ))

;; some basic stuff for org-mode

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook
          '(lambda ()
             (auto-fill-mode t)
             (flyspell-mode t)))
(setq org-src-fontify-natively t)
(setq org-default-notes-file "~/doc/notes.org")
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ct" 'org-todo-list)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-capture-templates
      '(("t" "Task" entry (file+headline "" "Tasks")
         "* TODO %?\n  %u\n  %a")
        ("j" "Journal" entry (file+olp+datetree "~/doc/journal.org")
         "**** %<%H:%M> %^{header}\n %?\n%a\n"
         :tree-type week
         :empty-lines 1)))

;;
;;
;; ido-mode
;;
;; (require 'ido)
;; (require 'flx-ido)

;; (ido-mode t)
;; (ido-everywhere t)
;; (flx-ido-mode t)
;; (setq ido-enable-flex-matching t) ;; enable fuzzy matching
;; (setq ido-use-faces nil)

;;
;; word counting stuff
;;; Final version: while
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")

;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)

;;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))

;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))

;;
;; unicode/utf-8 stuff
;;
;; not really sure what this is doing, but it lets me insert unicode stuff...
;;
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;;
;; text-mode hook
;;
(add-hook
 'text-mode-hook
  (auto-fill-mode t)
  (flyspell-mode t))

;;
;; helper functions
;;
;;

(defun this-line ()
  (interactive)
  "handy little tool."
  (buffer-substring (point-at-bol) (point-at-eol)))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(add-hook 'yaml-mode-hook
      '(lambda ()
         (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


;;
;; experiment with a different visible bell because the default one is terrible over the network
;;
(defun my-terminal-visible-bell ()
  "A friendlier visual bell effect, flashes the mode-line"
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil 'invert-face 'mode-line))


(setq visible-bell nil)
(setq ring-bell-function #'my-terminal-visible-bell)

(global-display-line-numbers-mode t)

;;
;; eshell
;;

;; gives us eshell sudo instead of system sudo
(require 'em-tramp)
(setq eshell-prefer-lisp-function t)
(setq eshell-prefer-lisp-variables t)

(setq eshell-scroll-to-bottom-on-input 'all)

(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

(defun eshell/x ()

  (insert (concat "exit"))
  (eshell-send-input nil 1 nil)
  (delete-window))

;;
;; nxml code folding
;;
(require 'nxml-mode)
(add-hook 'nxml-mode-hook 'hs-minor-mode)
(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]*[^/]>"
               "-->\\|</[^/>]*[^/]>"
               "<!--"
               nxml-forward-element
               nil))
(define-key nxml-mode-map (kbd "C-c h") 'hs-toggle-hiding)


;;
;; swagger-mode
;;
(require 'swagger-mode)

;;
;; json stuff
;;
(add-hook 'json-mode-hook 'flymake-json-load)

;;
;; highlighting columns
;;

;;
;; python
;;
(elpy-enable) ; commented as it throws errors on emacs26. might need to reinstall elpy

;; (when (require 'flycheck nil t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;
;; ruby
;;
(require 'ruby-test-mode)
(define-key ruby-test-mode-map (kbd "C-c t") 'ruby-test-toggle-implementation-and-specification)

(add-hook 'ruby-mode-hook 'flycheck-mode)
(add-hook 'ruby-mode-hook 'robe-mode)


(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map (kbd "C-c d") 'flymake-popup-current-error-menu)
            (define-key ruby-mode-map (kbd "C-c h") 'hs-toggle-hiding)))


(add-hook 'ruby-mode-hook 'hs-minor-mode)
(add-hook 'ruby-mode-hook 'ruby-test-mode)
;; I don't know why this is here, but it doesn't work...
;;(add-hook 'ruby-mode-hook 'smartparens-mode)


(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
                `(ruby-mode
                  ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
                  ,(rx (or "}" "]" "end"))                       ; Block end
                  ,(rx (or "#" "=begin"))                        ; Comment start
                  ruby-forward-sexp nil)))


;;
;; window management
;;
;; look into switch-window or ace-window as alternatives that only use
;; a single keybinding
;;
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)

;;
;; magit stuff
;;
(require 'seq)
(defun my/find-magit-status-buffer()
  (interactive)
  (if (projectile-project-p)
      (projectile-vc)
    (let* ((magit-buffers (seq-filter '(lambda (n) (string-match "magit: " (buffer-name n))) (buffer-list)))
           (buffer-names (mapcar 'buffer-name magit-buffers))
           (selected-magit-buffer (if (and buffer-names (< 1 (seq-length buffer-names)))
                                      (completing-read "Which project status? " buffer-names)
                                    (car buffer-names))))
      (if selected-magit-buffer
          (switch-to-buffer selected-magit-buffer)
        (magit-status)))))

(global-set-key (kbd "C-c g") 'my/find-magit-status-buffer)

;;
;; js-mode
;;

;; (defun my-js-mode-hook ()
;;   (setq js-indent-level 2))
;; (add-hook 'js-mode-hook 'my-js-mode-hook)

;;
;; loccur
;;
(require 'loccur)

(global-set-key (kbd "C-o") 'loccur-current)
(global-set-key (kbd "C-M-o") 'loccur)
(global-set-key (kbd "C-S-o") 'loccur-previous-match)

;;
;; web-mode
;;
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))


;;
;; projectile mode
;;
(require 'projectile)
(projectile-global-mode t)
(global-set-key (kbd "C-c p") 'projectile-command-map)

(projectile-register-project-type 'brazil '("build.xml")
                                  :compile "brazil-build"
                                  :test "brazil-build test"
                                  :run "brazil-build server"
                                  :test-suffix "Test"
                                  :test-dir "tst"
                                  :src-dir "src")

(put 'downcase-region 'disabled nil)


;;
;; highlight duplicate lines
;;
(require 'highlight)
(defun highlight-line-dups-region (&optional start end face msgp)
  (interactive `(,@(hlt-region-or-buffer-limits) nil t))
  (let ((count  0)
        line-re)
    (save-excursion
      (goto-char start)
      (while (< (point) end)
        (setq count    0
              line-re  (concat "^" (regexp-quote (buffer-substring-no-properties
                                                  (line-beginning-position)
                                                  (line-end-position)))
                               "$"))
        (save-excursion
          (goto-char start)
          (while (< (point) end)
            (if (not (re-search-forward line-re nil t))
                (goto-char end)
              (setq count  (1+ count))
              (unless (< count 2)
                (hlt-highlight-region
                 (line-beginning-position) (line-end-position)
                 face)
                (forward-line 1)))))
        (forward-line 1)))))

;;
;; java lsp
;;
(require 'lsp-java)
(require 'dap-java)

;;
;; if in a projectile project, save impl and test files related to this file, run dap-java-run-test-class,
;; else just run dap-java-run-test-class
(defun asackvil/dap-java-run-test-class ()
  (interactive)
  (save-current-buffer
    (save-excursion
      (if (projectile-project-p)
          (let ((impl-buffer (if (projectile-test-file-p (buffer-file-name))
                                 (find-file-noselect (projectile-find-implementation-or-test (buffer-file-name)))
                               (current-buffer)))
                (test-buffer (if (projectile-test-file-p (buffer-file-name))
                                 (current-buffer)
                               (find-file-noselect (projectile-find-implementation-or-test (buffer-file-name))))))
            (if (buffer-modified-p impl-buffer)
                (save-buffer impl-buffer))
            (if (buffer-modified-p test-buffer)
                (save-buffer test-buffer))
            (if (get-buffer-window test-buffer)
                (with-current-buffer test-buffer (sleep-for 1) (dap-java-run-test-class))
              (progn
                (pop-to-buffer test-buffer)
                (sleep-for 1)
                (dap-java-run-test-class))))
        (dap-java-run-test-class)))))

(defun asackvil/setup-dap-mode ()
  "Setup dap-mode bits for java"
  (dap-mode 1)
  (define-key java-mode-map (kbd "C-c C-t") #'asackvil/dap-java-run-test-class))

(defun asackvil/setup-lsp-mode ()
  "Setup lsp bits"
  (lsp)
  (define-key lsp-mode-map (kbd "M-RET") 'lsp-execute-code-action)
  (define-key lsp-mode-map (kbd "C-c f i") 'lsp-goto-implementation)
  (define-key lsp-mode-map (kbd "C-c f r") 'lsp-find-references)
  (define-key lsp-mode-map (kbd "C-c r r") 'lsp-rename))

(add-hook 'java-mode-hook #'asackvil/setup-lsp-mode)
(add-hook 'java-mode-hook #'asackvil/setup-dap-mode)




;;
;; pretty colors in compilation buffers
;;
(require 'ansi-color)
(defun asackvil/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'asackvil/colorize-compilation)

(defun asackvil/compilation-finish-function (buf strg)
  (save-current-buffer
    (set-buffer "*compilation*")
    (read-only-mode)
    (goto-char (point-min))
    (local-set-key (kbd "q")
                   (lambda () (interactive) (quit-restore-window nil "bury")))))

(add-hook 'compilation-finish-functions
          #'asackvil/compilation-finish-function)

;;
;; org-issues-mode
;;
;; SIM integration, aw yeah
;;

(add-to-list 'load-path "~/src/Emacs-org-issues-mode/src")

(require 'org-issues-mode)
(org-issues-update/monitor-issues)


;;
;; enable mu4e
(require 'my-mu4e)

;;
;; with mu4e enabled, bring in org-mode support
;;
(require 'org-mu4e)

;; allow capturing directly in mu4e buffers
(define-key mu4e-headers-mode-map (kbd "C-c c") 'org-mu4e-store-and-capture)
(define-key mu4e-view-mode-map    (kbd "C-c c") 'org-mu4e-store-and-capture)

;;
;; snippets!
;;
(require 'yasnippet)
(yas-global-mode 1)

;; Amazon custom libraries
;;
;; this mostly seems broken for local development...
;;(require 'amz-common)


;;
;; helm
;;
;; trying this thing out...
(require 'helm-config)
(setq helm-split-window-inside-p t)
(helm-mode 1)

;;
;; company
;;
;;
(setq company-dabbrev-downcase nil)

(eval-after-load "cc-mode"
  '(define-key c-mode-base-map ";" nil))

;;
;; eda-mode
;;
(add-to-list 'load-path "~/src/eda-mode/src/Emacs-eda-mode/src")
(require 'eda)
(define-key global-map (kbd "C-c e") 'eda-status)
