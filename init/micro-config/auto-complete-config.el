;;;; auto complete configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-auto-complete-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
         (concat micro-plugin-path "auto-complete\\"))
      (add-to-list 'load-path 
         (concat micro-plugin-path "auto-complete/"))))
(micro-auto-complete-dir-set)


(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories 
             (concat micro-plugin-path "auto-complete\\dict\\"))
(auto-complete-mode 1)
(ac-config-default)
(require 'pos-tip)
(setq ac-quick-help-prefer-pos-tip t)   ;default is t
(setq ac-use-quick-help t)
(setq ac-delay 0)
(setq ac-dwim t)
(setq ac-trigger-commands
      (cons 'backward-delete-char-untabify ac-trigger-commands))
(provide 'auto-complete-config)
