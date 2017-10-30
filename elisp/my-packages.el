;;
;; package configuration
;;
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; something about these next three sexps isn't working properly...
(defvar my-packages
  '(ag
    elpy
    flymake-json
    flymake-easy
    flymake-ruby
    flycheck
    json-mode
    idle-highlight-mode
    magit
    minimap
    markdown-mode
    py-autopep8
    yaml-mode))

(when (not package-archive-contents)
  (package-refresh-contents))

(mapc (lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      my-packages)

(provide 'my-packages)
