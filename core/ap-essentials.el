;;; ap-essentials.el
;;; Essential packages

;;; Projectile
(use-package projectile
  :ensure t
  :init (setq projectile-cache-file
              (expand-file-name "projectile.cache" ap-data-directory)
              projectile-known-projects-file
              (expand-file-name "projectile-bookmarks.eld" ap-data-directory))
  :config (projectile-global-mode t))

;;; Magit
(use-package magit
  :ensure t
  :init (setq magit-last-seen-setup-instructions "1.4.0"))

;;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;;; Smartparens
(use-package smartparens
  :ensure t
  :diminish ""
  :config (progn
            (require 'smartparens-config)

            (setq sp-show-pair-delay 0
                  sp-show-pair-from-inside t)
            (smartparens-global-mode t)
            (show-smartparens-global-mode t)))

;;; Expand-region
(use-package expand-region
  :ensure t)

;;; Zygospore, make C-x 1 toggleable
(use-package zygospore
  :ensure t
  :bind ("C-x 1" . zygospore-toggle-delete-other-windows))

;;; Perspective
(use-package perspective
  :ensure t
  :config (persp-mode))

;;; Eldoc
(use-package eldoc-mode
  :diminish eldoc-mode)

;;; Comint
(use-package comint
  :bind ("C-c M-o" . ap-comint-clear-buffer)
  :config (defun ap-comint-clear-buffer ()
            (interactive)
            (let ((comint-buffer-maximum-size 0))
              (comint-truncate-buffer))))

;;; Ace-window
(use-package ace-window
  :ensure t
  :bind ("C-x o" . ace-window)
  :config (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
                aw-background nil))

;;; Hydra
(use-package hydra
  :ensure t
  :config (progn
            (defhydra hydra-frame (:color blue
                                   :hint nil)
              "
   Frames
  ───────────────────────────────
   [_n_] new-frame [_f_] other-frame [_d_] delete-frame [_q_] quit
  ─────────────────────────────── "
              ("n" new-frame)
              ("d" delete-frame)
              ("f" other-frame)
              ("q" nil))

            (defhydra hydra-window (:color blue
                                    :idle 0.5
                                    :hint nil)
              "
   Navigation   Resize      Split              Windows                   Other
  ─────────────────────────────────────────────
       ^_k_^            ^_K_^       [_v_] vert & focus   [_w_] ace-window            [_f_] Frames
       ^^↑^^            ^^↑^^       [_s_] horz & focus   [_m_] ace-swap-window
   _h_ ←   → _l_    _H_ ←   → _L_   [_V_] vert           [_d_] ace-delete-window
       ^^↓^^            ^^↓^^       [_S_] horz           [_q_] delete-window
       ^_j_^            ^_J_^       ^^                   [_z_] zoom/unzoom
  ─────────────────────────────────────────────"
              ("w" ace-window)
              ("m" ace-swap-window)
              ("d" ace-delete-window)
              ("h" windmove-left  :exit nil)
              ("j" windmove-down  :exit nil)
              ("k" windmove-up    :exit nil)
              ("l" windmove-right :exit nil)
              ("H" hydra-move-splitter-left  :exit nil)
              ("J" hydra-move-splitter-down  :exit nil)
              ("K" hydra-move-splitter-up    :exit nil)
              ("L" hydra-move-splitter-right :exit nil)
              ("=" balance-windows)
              ("s" ap-split-window-vertically-and-focus)
              ("v" ap-split-window-horizontally-and-focus)
              ("S" split-window-vertically)
              ("V" split-window-horizontally)
              ("z" zygospore-toggle-delete-other-windows)
              ("f" hydra-frame/body)
              ("q" delete-window))))

(provide 'ap-essentials)
