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
 '(company-minimum-prefix-length 1)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(exec-path
   (quote
    ("/home/local/ANT/asackvil/.cargo/bin" "/home/local/ANT/asackvil/bin" "/home/local/ANT/asackvil/.local/bin" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/usr/local/games" "/snap/bin" "/home/local/ANT/asackvil/.gem/ruby/2.3.0/bin" "/usr/lib/x86_64-linux-gnu/emacs/26.2/x86_64-linux-gnu")))
 '(flycheck-checker-error-threshold 1000)
 '(flycheck-disabled-checkers (quote (ruby-rubylint ruby-leek ruby-jruby)))
 '(flycheck-rubocoprc "~/flycheck-rubocoprc.yml")
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(indent-tabs-mode nil)
 '(latex-run-command "pdflatex")
 '(linum-format "%d ")
 '(org-agenda-files (quote ("~/doc/notes.org")))
 '(package-selected-packages
   (quote
    (mu4e-overview helm dap-mode treemacs lsp-java lsp-mode yaml-mode web-mode smartparens ruby-test-mode ruby-hash-syntax ruby-electric rubocop robe py-autopep8 projectile minimap markdown-mode magit loccur json-mode jinja2-mode idle-highlight-mode highlight flymake-ruby flymake-json flx-ido elpy csv-mode auto-complete ag)))
 '(ruby-test-rspec-options (quote ("--drb" "-b")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
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
 '(erc-default-face ((t (:foreground "dark gray"))))
 '(erc-input-face ((t (:foreground "white"))))
 '(magit-diff-added ((t (:background "forest green" :foreground "#ddffdd"))))
 '(magit-diff-added-highlight ((t (:background "forest green" :foreground "brightblack"))))
 '(magit-diff-removed ((t (:background "darkred" :foreground "#ffdddd"))))
 '(magit-diff-removed-highlight ((t (:background "dark red" :foreground "white"))))
 '(minibuffer-prompt ((t (:foreground "Cyan"))))
 '(minimap-active-region-background ((t (:background "dark slate gray"))))
 '(show-paren-match ((t (:background "color-232")))))

;;
;;
;;
;; Programming hooks
;;
;;

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t)))))

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
(require 'ido)
(require 'flx-ido)

(ido-mode t)
(ido-everywhere t)
(flx-ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching
(setq ido-use-faces nil)

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
;; prog mode
;;
(add-hook 'prog-mode-hook 'idle-highlight-mode)

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
  (insert "exit")
  (eshell-send-input)
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

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;
;; ruby
;;
(require 'ruby-test-mode)
(define-key ruby-test-mode-map (kbd "C-c t") 'ruby-test-toggle-implementation-and-specification)

(add-hook 'ruby-mode-hook 'flycheck-mode)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'yas-minor-mode)

(add-hook 'ruby-mode-hook
          (lambda ()
            (define-key ruby-mode-map (kbd "C-c d") 'flymake-popup-current-error-menu)
            (define-key ruby-mode-map (kbd "C-c h") 'hs-toggle-hiding)
            (define-key ruby-mode-map (kbd "C-c p") 'ruby-hash-syntax-toggle)))


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

;; nice control for ruby tests. puts point at the bottom of the
;; compilation buffer with `q` as a nice quit

(add-hook 'compilation-finish-functions
          (lambda (buf strg)
;;            (switch-to-buffer-other-window "*compilation*")
            (save-current-buffer
              (set-buffer "*compilation*")
              (read-only-mode)
              (goto-char (point-min))
              (local-set-key (kbd "q")
                             (lambda () (interactive) (quit-restore-window nil "bury"))))))

;;
;; completion
;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)


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
  (let* ((magit-buffers (seq-filter '(lambda (n) (string-match "magit: " (buffer-name n))) (buffer-list)))
         (buffer-names (mapcar 'buffer-name magit-buffers))
         (selected-magit-buffer (if (< 1 (seq-length buffer-names))
                                    (ido-completing-read "Which project status? " buffer-names)
                                  (car buffer-names))))
    (switch-to-buffer selected-magit-buffer)
    (set-buffer selected-magit-buffer)))

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
(add-hook 'java-mode-hook #'lsp)

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
