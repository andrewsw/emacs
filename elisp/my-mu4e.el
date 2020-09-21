;; make sure mu4e is in your load-path
(add-to-list 'load-path "/usr/local/Cellar/mu/1.4.12/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)
(require 'smtpmail)

(setq mu4e-maildir "~/Mail/bright.md")

(setq mu4e-sent-folder "/[Gmail].Sent Mail"
      mu4e-drafts-folder "/[Gmail].Drafts"
      mu4e-trash-folder  "/[Gmail].Trash"
      user-mail-address "andrewsackville-west@bright.md"
      user-full-name "Andrew Sackville-West"
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-mail-address "Andrew Sackville-West <andrewsackville-west@bright.md>"
      smtpmail-local-domain "bright.md"
      smtpmail-smtp-user "andrewsackville-west@bright.md"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-stream-type 'starttls
      smtpmail-smtp-service 587)

(setq mu4e-get-mail-command "/usr/local/bin/offlineimap"
      send-mail-function 'smtpmail-send-it
      mu4e-update-interval 300
      message-kill-buffer-on-exit t)

;; don't save sent messages. Gmail does the automagically
(setq mu4e-sent-messages-behavior 'delete)

(require 'mu4e-contrib)
(setq mu4e-html2text-command "textutil -stdin -format html -convert txt -stdout")

;; you can quickly switch to your Inbox -- press ja
(setq mu4e-maildir-shortcuts
      '(("INBOX"               . ?a)
      ;; Add others if needed.
       ))
;; http://www.djcbsoftware.nl/code/mu/mu4e/Bookmarks.html
;; Add new bookmarks to searches -- press br
;; (add-to-list 'mu4e-bookmarks
;; 	     '("from:pipelines or from:p4admin or from:aloha-automation"
;; 	       "Trash to Delete"
;; 	       ?r))

(setq mu4e-headers-fields '((:human-date . 12) (:flags . 6) (:mailing-list . 10) (:from-or-to . 22) (:thread-subject . nil)))
(setq mu4e-headers-include-related '()) ;; disabled! shows related messages in a search result -- allows seeing sent messages in thread views :)
(setq mu4e-headers-skip-duplicates t) ;; does what it says on the tin
(setq mu4e-view-show-images t)

;; custom actions when viewing a message
(add-to-list 'mu4e-view-actions
             '("View in browser" . mu4e-action-view-in-browser ) t)

;; let's help our spelling!
(add-hook 'mu4e-compose-mode-hook 'flyspell-mode)

(defun asw/launch-mu4e ()
  (interactive)
  "ensures any active python environment is deactivated before starting mu4e"
  (pyvenv-deactivate)
  (mu4e))

(global-set-key (kbd "C-c m") 'asw/launch-mu4e)

(provide 'my-mu4e)
