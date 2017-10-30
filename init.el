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

;; extra key bindings
;(global-set-key "\M-C" 'compile)
;(global-set-key "\C-^" 'next-error)
;(global-set-key "\C-\M-g" 'goto-line)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(company-minimum-prefix-length 1)
 '(ensime-default-server-root "/home/andrew/src/ensime_2.9.2-0.9.8.1/")
 '(indent-tabs-mode nil)
 '(latex-run-command "pdflatex")
 '(proof-electric-terminator-enable t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tramp-remote-path
   (quote
    ("/usr/local/bin" "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin")))
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify))
 '(web-mode-attr-indent-offset 2)
 '(web-mode-attr-value-indent-offset 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-markup-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "light grey" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 96 :width normal :foundry "PfEd" :family "Inconsolata"))))
 '(flymake-errline ((((class color)) (:foreground "red" :underline "red"))))
 '(flymake-warnline ((((class color)) (:foreground "cyan" :underline "cyan"))))
 '(minibuffer-prompt ((t (:foreground "Cyan"))))
 '(minimap-active-region-background ((t (:background "dark slate gray"))))
 '(proof-locked-face ((t (:background "dark slate gray"))))
 '(show-paren-match ((((class color) (background dark)) (:background "grey22")))))

;; (setq load-path (cons (expand-file-name "/usr/share/doc/git/contrib/emacs") load-path))
;; (require 'vc-git)
;; (when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
;; (require 'git)
;; (autoload 'git-blame-mode "git-blame"
;;   "Minor mode for incremental blame for Git." t)

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
          (auto-fill-mode t)
          (flyspell-mode t))

;;
;;
;; ido-mode
;;
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;;
;;
;; code to put flymake output in the mini-buffer
;;
;;
;;
(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))


;;
;;
;; and add a key-binding
;;
;;
(add-hook
 'haskell-mode-hook
 '(lambda ()
    (define-key haskell-mode-map "\C-cd"
      'credmp/flymake-display-err-minibuf)))

;; (add-hook
;;  'python-mode-hook
;;  '(lambda ()
;;     (define-key py-mode-map "\C-cd"
;;      'credmp/flymake-display-err-minibuf)))

(add-hook
 'html-mode-hook
 '(lambda ()
    (define-key html-mode-map "\C-cd"
     'credmp/flymake-display-err-minibuf)))

(add-hook
 'perl-mode-hook
 '(lambda ()
    (define-key perl-mode-map "\C-cd"
      'credmp/flymake-display-err-minibuf)))

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


(set-frame-parameter (selected-frame) 'alpha '(100 70))
(add-to-list 'default-frame-alist '(alpha 100 70))

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


;;
;; ag
;;
(global-set-key (kbd "C-c C-g") 'ag)


(global-linum-mode 1)

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
(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
