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
;(require 'yatex)
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
