;;; ap-org.el
;;; Org configuration

(use-package org
  :ensure t
  :mode ("\\.org\\'" . org-mode)
  :config
  (setq org-log-done 'time)
  (evil-leader/set-key-for-mode 'org-mode
    "h" 'org-metaleft
    "j" 'org-metadown
    "k" 'org-metaup
    "l" 'org-metaright
    "mt" 'org-todo))

(provide 'ap-org)
