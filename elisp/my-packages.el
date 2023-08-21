;;
;; package configuration
;;
(require 'package)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; something about these next three sexps isn't working properly...
(defvar my-packages
  '(ag
    auto-virtualenv
    elpy
    exec-path-from-shell
    flx-ido
    flymake-json
    flymake-easy
    flymake-ruby
    helm
    highlight
    idle-highlight-mode
    json-mode
    loccur
    lsp-java
    magit
    minimap
    markdown-mode
    projectile
    py-autopep8
    robe
    rubocop
    ruby-electric
    ruby-hash-syntax
    ruby-test-mode
    use-package
    web-mode
    yaml-mode
    yasnippet))

(when (not package-archive-contents)
  (package-refresh-contents))

(mapc (lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      my-packages)

(provide 'my-packages)
