;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;yasnippet configure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-yasnippet-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
              (concat micro-plugin-path "yasnippet\\"))
      (add-to-list 'load-path 
              (concat micro-plugin-path "yasnippet/"))))

(micro-yasnippet-dir-set)
(require 'yasnippet)
(yas-global-mode 1)
(provide 'yasnippet-config)

