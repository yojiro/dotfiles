;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "/usr/local/Cellar/cask/0.8.1/cask.el")
(cask-initialize)
(require 'pallet)

(require 'jedi)
(require 'py-autopep8)

(require 'volatile-highlights)
(require 'auctex-latexmk)
(require 'init-loader)
(require 'whitespace)
(require 'osx-dictionary)
(require 'popwin)
(require 'server)
(unless (server-running-p) (server-start))

(pallet-mode t)

(setq inhibit-startup-message t)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.config/emacs/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet web-mode volatile-highlights use-package smex smartparens py-autopep8 projectile prodigy popwin pallet nyan-mode multiple-cursors magit jedi init-loader idle-highlight-mode htmlize fuzzy flycheck-cask expand-region exec-path-from-shell drag-stuff auctex-latexmk ac-js2))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
