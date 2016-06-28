;;; ap-osx.el
;;; OSX configuration

;; Activate menu bar
(menu-bar-mode t)

(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))

;; Fn key as Hyper
(setq mac-function-modifier 'hyper)

;; Command as meta
(setq mac-command-modifier 'meta)

;; Option as super
(setq mac-option-modifier 'super)

;; Use all the screen height
(set-frame-parameter nil 'fullscreen 'fullheight)

(defun ap-toggle-fullscreen ()
  "Toggle fullscreen"
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (eq (frame-parameter nil 'fullscreen) 'fullheight)
                           'fullboth
                         'fullheight)))

;; Keybindings
(bind-key* "H-f" 'ap-toggle-fullscreen)

;; Disable railwaycat's touchpad gestures
(global-set-key [magnify-up] 'ignore)
(global-set-key [magnify-down] 'ignore)
(global-set-key [S-magnify-up] 'ignore)
(global-set-key [S-magnify-down] 'ignore)

;; Disable beeping
(setq ring-bell-function 'ignore)

(provide 'ap-osx)
