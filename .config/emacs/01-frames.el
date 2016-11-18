(menu-bar-mode 0)
(tool-bar-mode 0)
(setq visible-bell t)
(setq ring-bell-function 'ignore)
(setq display-buffer-function 'popwin:display-buffer)


;; default frame setting
(setq default-frame-alist
      (append
       '((height . 50)
         (background-color . "#102048")
         (foreground-color . "AntiqueWhite1")
         (cursor-color . "LightSkyBlue1")
         (Pointer-color . "LightSkyBlue1")
         (top . 3)
         (tool-bar-lines . nil)
         (minibuffer . t)
         (alpha . (85 65))
         (vertical-scroll-bars . nil))
       default-frame-alist))

(setq minibuffer-frame-alist
    '((top . -1)
      (left . 1)
      (width . 115)
      (height . 1)
      (alpha . (85 65))
      (name . "minibuf")))


;; font setting for OSX/window mode
(if window-system (progn
  (when (equal system-type 'darwin)
    (add-to-list 'default-frame-alist '(font . "ricty-18")))
))


;; frame utilities
(defun kill-buffer-and-delete-frame (arg)
  (interactive "P")
  (if arg
      (let ((buffers nil))
        (walk-windows
         '(lambda (x)
            (let ((buf (window-buffer x)))
              (if (not (memq buf buffers))
                  (setq buffers (cons buf buffers))))))
        (or (memq nil (mapcar '(lambda (x)(kill-buffer x)) buffers))
            (delete-frame)))
    (if (kill-buffer (current-buffer))
        (delete-frame))))

(defun Kill-buffer-and-delete-frame ()
  (interactive)
  (kill-buffer-and-delete-frame t))

(defun find-frame-by-name (name)
  (let ((frames (frame-list)) tmp)
    (catch 'break
      (mapcar
       '(lambda (x)
          (if (string-equal name (cdr (assq 'name (frame-parameters x))))
              (throw 'break x)))
       (frame-list))
      nil)))

(defun command-execute-other-frame (cmd)
  "Pop up another frame and execute command in it"
  (interactive "CCommand : ")
  (select-frame (make-frame))
  (call-interactively cmd))


;; for Info
(defun info-other-frame ()
  "Pop up another frame and run info in it"
  (interactive)
  (let ((frame (find-frame-by-name "*info*")))
    (if frame
        (progn
          (raise-frame frame)
          (select-frame frame))
      (select-frame (make-frame))
      (info))))

;; key-bindings
(global-unset-key "\C-z")
(global-set-key "\C-zb" 'switch-to-buffer-other-frame)
(global-set-key "\C-z\C-f" 'find-file-other-frame)
(global-set-key "\C-zk" 'kill-buffer-and-delete-frame)
(global-set-key "\C-zK" 'Kill-buffer-and-delete-frame)
(global-set-key "\C-z\C-z" 'suspend-emacs)

(global-set-key "\C-zx" 'command-execute-other-frame)
(global-set-key "\C-zI" 'info-other-frame)
(global-set-key "\C-z." 'find-tag-other-frame)

(global-set-key "\C-z2" 'make-frame)
(global-set-key "\C-zi" 'iconify-frame)
(global-set-key "\C-z0" 'delete-frame)
(global-set-key "\C-z\C-o" 'other-frame)
(global-set-key "\C-z\C-n" 'next-multiframe-window)
(global-set-key "\C-z\C-p" 'previous-multiframe-window)
