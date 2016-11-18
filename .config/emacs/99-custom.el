(setq custom-file "~/dotfiles/.emacs.d/custom-file.el")
(if (file-exists-p (expand-file-name "~/dotfiles/.emacs.d/custom-file.el"))
      (load (expand-file-name custom-file) t nil nil))
