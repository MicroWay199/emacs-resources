
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install ivy
(defun micro-ranger-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
              (concat micro-plugin-path "ranger\\"))
      (add-to-list 'load-path 
              (concat micro-plugin-path "ranger"))))
(micro-ranger-dir-set)
(require 'ranger)

(setq ranger-cleanup-on-disable t)
(setq ranger-parent-depth 2)
(setq ranger-preview-file t)
(setq ranger-show-literal t)
(setq ranger-excluded-extensions '("mkv" "iso" "mp4"))
(setq ranger-dont-show-binary t)

(provide 'ranger-config)
