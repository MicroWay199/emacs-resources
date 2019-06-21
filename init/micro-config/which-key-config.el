;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install emacs-which-key config
(add-to-list 'load-path 
	     (concat micro-plugin-path "emacs-which-key\\"))
(require 'which-key)
;;(which-key-mode)  ;;;default not enable
(provide 'which-key-config)
