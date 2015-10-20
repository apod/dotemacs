;;; ap-ocaml.el
;;; OCaml configuration
;;; Opam packages required: utop merlin

(use-package tuareg
  :ensure t
  :mode (("\\.ml[ily]?\\'" . tuareg-mode)
         ("\\.topml\\'" . tuareg-mode))
  :config (progn
            (use-package merlin
              :ensure t
              :config (progn
                        (add-to-list 'company-backends 'merlin-company-backend)
                        (add-hook 'tuareg-mode-hook 'merlin-mode)
                        (add-hook 'tuareg-mode-hook 'company-mode)))

            (use-package utop
              :ensure t
              :init (setq utop-command "opam config exec utop -- -emacs"
                          utop-edit-command nil)
              :config (add-hook 'tuareg-mode-hook 'utop-minor-mode))

            (defun ap-utop-eval-region-or-line ()
              (interactive)
              (if (use-region-p)
                  (utop-eval-region (region-beginning)
                                    (region-end))
                (utop-eval-region (line-beginning-position)
                                  (line-beginning-position 2))))

            (evil-leader/set-key-for-mode 'tuareg-mode
              "mj" 'utop
              "me" 'utop-eval-phrase
              "mr" 'ap-utop-eval-region-or-line
              "mk" 'utop-eval-buffer)))

(provide 'ap-ocaml)
