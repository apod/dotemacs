;;; ap-org.el
;;; Org configuration

(use-package org
  :ensure t
  :defer t
  :init (setq org-log-done 'time)
  :config (evil-leader/set-key-for-mode 'org-mode
            "h" 'org-metaleft
            "j" 'org-metadown
            "k" 'org-metaup
            "l" 'org-metaright
            "mt" 'org-todo))

(provide 'ap-org)
