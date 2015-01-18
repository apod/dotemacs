;;; ap-ido.el
;;; ido-mode configuration

(use-package ido
  :init (progn
          (ido-mode t)
          (ido-everywhere t))
  :config (setq ido-create-new-buffer 'always
                ido-use-filename-at-point 'guess
                ido-default-file-method 'selected-window
                ido-save-directory-list-file (expand-file-name "ido.last" ap-data-directory)))

;; Use ido everywhere
(use-package ido-ubiquitous
  :ensure t
  :init (ido-ubiquitous-mode t))

;; Vertical ido
(use-package ido-vertical-mode
  :ensure t
  :init (ido-vertical-mode t))

;; Fuzzy matching
(use-package flx-ido
  :ensure t
  :init (progn
          (defun ap-setup-ido ()
            ;; Toggle flx-ido-mode
            (define-key ido-completion-map (kbd "C-q")
              (lambda ()
                (interactive)
                (if flx-ido-mode
                    (progn
                      (setq ido-enable-flex-matching nil)
                      (setq ido-use-faces t)
                      (flx-ido-mode -1))
                  (progn
                    (setq ido-enable-flex-matching t)
                    (setq ido-use-faces nil)
                    (flx-ido-mode t))))))

          (add-hook 'ido-setup-hook 'ap-setup-ido)))

;; M-x enhancement
(use-package smex
  :ensure t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands))
  :init (smex-initialize)
  :config (setq smex-save-file (expand-file-name ".smex-items" ap-data-directory)))

(provide 'ap-ido)
