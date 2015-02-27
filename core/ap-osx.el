;;; ap-osx.el
;;; OSX configuration

;; Activate menu bar
(menu-bar-mode t)

(use-package exec-path-from-shell
  :ensure t
  :init (exec-path-from-shell-initialize))

;; Fn key as Hyper
(setq mac-function-modifier 'hyper)

;; Command as meta
(setq mac-command-modifier 'meta)

;; Option as super
(setq mac-option-modifier 'super)

(defun ap-toggle-fullscreen ()
  "Toggle fullscreen"
  (interactive)
  (set-frame-parameter nil 'fullscreen (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; Keybindings
(bind-key* "H-h" 'ns-do-hide-emacs)
(bind-key* "H-f" 'ap-toggle-fullscreen)

;; Disable railwaycat's touchpad gestures
(global-set-key [magnify-up] 'ignore)
(global-set-key [magnify-down] 'ignore)
(global-set-key [S-magnify-up] 'ignore)
(global-set-key [S-magnify-down] 'ignore)

;; Disable beeping
(setq ring-bell-function 'ignore)

(provide 'ap-osx)
