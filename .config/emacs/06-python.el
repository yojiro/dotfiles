(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;;(setq py-autopep8-options '("--max-line-length=79"))
;;(setq flycheck-flake8-maximum-line-length 79)
(py-autopep8-enable-on-save)
