;; cursor color setting to indicate input method
(when (fboundp 'mac-input-source)
  (defun my-mac-selected-keyboard-input-source-chage-function ()
    (let ((mac-input-source (mac-input-source)))
      (set-cursor-color
       (if (string-match "com.apple.inputmethod.Kotoeri.Roman" mac-input-source)
           "LightSkyBlue1" "Red"))))
  (add-hook 'mac-selected-keyboard-input-source-change-hook
            'my-mac-selected-keyboard-input-source-chage-function))

;; force us-ascii mode in mini-buffer
(when (functionp 'mac-auto-ascii-mode)
  (mac-auto-ascii-mode 1))

;; highlight mode
(global-hl-line-mode t)
(show-paren-mode t)
(setq show-paren-style 'mixed)
(transient-mark-mode t)
(volatile-highlights-mode t)

;; spell checker
(require 'flyspell)
(setq ispell-program-name "/usr/local/bin/aspell")
(eval-after-load "ispell"
 '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
(setq ispell-parser 'tex)

;; auto-complete setting
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'latex-mode)
;(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ

;; space
(setq whitespace-style '(face
                         trailing       ; 行末
                         tabs           ; タブ
                         spaces         ; スペース
                         empty
                         space-mark     ; 表示のマッピング
                         tab-mark
             ))
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\u25a1])
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
;; visible full-width white space charactor
(setq whitespace-space-regexp "\\(\x3000+\\)")
;; auto creanup when the buffer is saving
(setq whitespace-action '(auto-cleanup))
(global-whitespace-mode 1)
(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
                    :background my/bg-color
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :background my/bg-color
                    :foreground "LightSkyBlue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :background my/bg-color
                    :foreground "GreenYellow"
                    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
                    :background my/bg-color)
