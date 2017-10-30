;;
;; General purpose UI tweaks


(setq inhibit-startup-message t)

;; Change title bar to ~/file-directory if the current buffer is a
;; real file or buffer name if it is just a buffer.
(setq frame-title-format
      '(:eval
        (if buffer-file-name
            (replace-regexp-in-string
             (getenv "HOME") "~"
             (file-name-directory buffer-file-name))
          (buffer-name))))


;; enable column numbering by default
(setq column-number-mode t)

;; font-lock-mode
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

;; make sure parens are highlighted
(show-paren-mode t)
(setq show-paren-style 'expression)

;; subword mode rocks with camelCase and doesn't seem to get in the way otherwise...
(global-subword-mode t)

(provide 'my-ui)
