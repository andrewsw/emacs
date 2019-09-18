;; make sure mu4e is in your load-path
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(require 'smtpmail)

(setq mu4e-maildir "~/Mail")

(setq mu4e-sent-folder "/Amazon/Sent Items"
      mu4e-drafts-folder "/Amazon/Drafts"
      mu4e-trash-folder  "/Amazon/Deleted Items"
      user-mail-address "asackvil@amazon.com"
      user-full-name "Andrew Sackville-West"
      smtpmail-default-smtp-server "ballard.amazon.com"
      smtpmail-mail-address "Andrew Sackville-West <asackvil@amazon.com>"
      smtpmail-local-domain "amazon.com"
      smtpmail-smtp-user "ANT\\asackvil"
      smtpmail-smtp-server "ballard.amazon.com"
      smtpmail-stream-type 'starttls
      smtpmail-smtp-service 1587)

(setq mu4e-get-mail-command "offlineimap"
      send-mail-function 'smtpmail-send-it
      mu4e-update-interval 300
      message-kill-buffer-on-exit t)

(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)

;; you can quickly switch to your Inbox -- press ja
(setq mu4e-maildir-shortcuts
      '(("/Amazon/INBOX"               . ?a)
      ;; Add others if needed.
       ))
;; http://www.djcbsoftware.nl/code/mu/mu4e/Bookmarks.html
;; Add new bookmarks to searches -- press br
;; (add-to-list 'mu4e-bookmarks
;; 	     '("from:pipelines or from:p4admin or from:aloha-automation"
;; 	       "Trash to Delete"
;; 	       ?r))

(setq mu4e-headers-fields '((:human-date . 12) (:flags . 6) (:mailing-list . 10) (:from-or-to . 22) (:thread-subject . nil)))
(setq mu4e-headers-include-related t) ;; shows related messages in a search result -- allows seeing sent messages in thread views :)
(setq mu4e-view-show-images t)

;; let's help our spelling!
(add-hook 'mu4e-compose-mode-hook 'flyspell-mode)

(global-set-key (kbd "C-c m") 'mu4e)

(provide 'my-mu4e)
