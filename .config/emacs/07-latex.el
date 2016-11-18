;; auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-PDF-mode t)
(setq japanese-LaTeX-default-style "jsarticle")
(setq TeX-default-mode 'japanese-latex-mode)

;; latexmk
(auctex-latexmk-setup)

(add-hook 'TeX-mode-hook
          '(lambda ()
             (setq TeX-command-default "LatexMk")
             (setq TeX-view-program-selection
                   '((output-dvi "Skim")
                     (output-pdf "Skim")))
             (setq TeX-view-program-list
                   '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %s.pdf %b")))))

;; hooks
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-default-bibliography '(
         "~/dotfiles/bib/bib_01.bib"
         ;; ...))
