;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;install IVY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install emacs-async
;;(add-to-list 'load-path 
;;	     "C:\\emacs\\init\\plugin\\helm\\")
;;(require 'helm-config)
;;;;(helm-mode t)
;;(global-set-key (kbd "M-x") 'helm-M-x)
;;(global-set-key (kbd "C-x C-f") 'helm-find-files)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install ivy
(add-to-list 'load-path 
	     (concat micro-plugin-path "deft\\"))
(require 'deft)

(setq deft-extensions '("md" "txt" "tex" "org"))
(setq deft-directory "D:\\Github\\micro-notes")
(setq deft-recursive t)

(global-set-key [f8] 'deft)

(provide 'deft-config)

