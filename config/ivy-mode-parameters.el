;; Emacs configuration

;; Parameters for Ivy autocompletion and related tools.

(use-package counsel
  :ensure t
  :config
  (setq-default enable-recursive-minibuffers t)
  :bind
  (("C-s" . counsel-grep-or-swiper)
   ("C-r" . counsel-grep-or-swiper)))

;; Facilitated access to SSH hosts listed in `~/.ssh/config'.
(use-package counsel-tramp
  :ensure t
  :config
  (setq-default tramp-default-method "ssh")
  :bind
  (("C-c s" . counsel-tramp)
   ("C-c q" . counsel-tramp-quit)))

(use-package swiper
  :ensure t
  :bind
  (("C-M-s" . swiper-all)))

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :config
  (setq-default ivy-wrap t
                ivy-use-virtual-buffers t
                ivy-count-format "(%d/%d) ")
  :bind
  (("C-c C-r" . ivy-resume)))

(use-package hydra
  :ensure t)

(use-package ivy-hydra
  :ensure t
  :requires (ivy hydra)
  :after (ivy hydra))

