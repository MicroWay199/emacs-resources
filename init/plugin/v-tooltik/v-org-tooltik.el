;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;add for org-mode 快速插入图片
(defun micro-org-insert-picture ()
  """use this function to insert picture 
   link @current directory/diagram/xxx.png"""
   (interactive)
   (setq micro-file-name (read-string "输入文件名字：：")) 
   (insert "#+CAPTATION: <typing in>  \n")
   (insert "#+LABEL:  \n")
   (insert "#+ATTR_HTML: :TITLE <typing in> :WIDTH 500  \n") 
   (insert (concat "[[" default-directory "diagram/" micro-file-name "]]")))
(global-set-key (kbd "C-c p i") 'micro-org-insert-picture)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;org do screenshots and insert to org files

(defvar v-snip-exe-path "D:\\software\\snipaste\\Snipaste.exe")
(defvar v-snip-quick-save "D:\\software\\snipaste\\quick-save\\snip-quick-save.png")
(defun v-org-snip-insert ()
  "Take a screenshot into a unique-named file in the current buffer file
   directory and insert a link to this file."
  (interactive)
  (lower-frame)
  (let* ((capture-name (concat
                       (format-time-string "%Y%m%d%H%M%S") ".png"))
         (capture-imag-dir (concat
				"_images_"
				(concat (file-name-nondirectory buffer-file-name))
				"/"))
         (capture-save-path (concat
			       (file-name-directory buffer-file-name)
				capture-imag-dir))
         (capture-file (concat capture-save-path capture-name))
         (v-org-file-path (replace-regexp-in-string "/" "\\\\" capture-file)))
;;(setq capture-file (concat capture-save-path capture-name))
  (progn (message v-org-file-path)
 ;;;;; comment for version V0.01 snipaste not support filename output command ;;;;;;;;;;;;;
     ;;  (shell-command (concat "del " v-snip-quick-save))
     ;;  (shell-command (concat v-snip-exe-path " snip -o quick-save")) ;;命令和参数使用/区分开才能正确执行
     ;;  (unless (file-exists-p  capture-save-path)
     ;;      (make-directory capture-save-path))
     ;; (while (not (file-exists-p v-snip-quick-save))
     ;;    (run-with-idle-timer 23 nil (lambda() (message "waiting picture capture none......"))))
     ;;  (run-with-idle-timer 23 nil
     ;;	(lambda(v-snip-quick-save v-org-file-path)
     ;;            (progn (shell-command (concat "copy " v-snip-quick-save " " v-org-file-path))
     ;;		  (shell-command (concat "del " v-snip-quick-save))
     ;;		  )
     ;;	   ) v-snip-quick-save v-org-file-path)
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (unless (file-exists-p  capture-save-path)
             (make-directory capture-save-path))
         (shell-command (concat v-snip-exe-path " snip -o \"" v-org-file-path "\"")) ;;命令和参数使用/区分开才能正确执行
         (insert "#+CAPTATION: <typing in>  \n")
         (insert "#+LABEL:  \n")
         (insert "#+ATTR_HTML: :TITLE <typing in> :WIDTH 500  \n") 
         (insert (concat "[[./" capture-imag-dir capture-name "]]"))
         (org-display-inline-images)
	 )))

(defun v-org-snip-del ()
  "del org link and its file  "
  (interactive)
  (beginning-of-line)
  (search-forward "[[")
  (setq path-string-begin (point))
  (search-forward "png")
  (setq path-string-end (point))
  (setq v-line-path-get
	(replace-regexp-in-string "/" "\\\\"
	  (buffer-substring path-string-begin path-string-end)))
  (shell-command (concat "del " v-line-path-get))
  (beginning-of-line)
  (kill-line))

(global-set-key (kbd "C-c p s") 'v-org-snip-insert)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;org drag picture to org files and 
;;insert picture path to org files
;; drag file to org mode
;; http://kitchingroup.cheme.cmu.edu/blog/2015/07/10/Drag-images-and-files-onto-org-mode-and-insert-a-link-to-them/
(defun my-dnd-func (event)
  (interactive "e")
  (goto-char (nth 1 (event-start event)))
  (x-focus-frame nil)
  (let* ((payload (car (last event)))
         (type (car payload))
         (fname (cadr payload))
         (img-regexp "\\(png\\|jp[e]?g\\|svg\\)\\>"))
    (cond
     ;; insert image link
     ((and  (eq 'drag-n-drop (car event))
            (eq 'file type)
            (string-match img-regexp fname))
      (dired-copy-file fname (format "./imgs/%s" (file-name-nondirectory fname)) t)
      (insert "#+ATTR_HTML: :width 100%\n")
      (insert (format "[[%s]]" (format "./imgs/%s" (file-name-nondirectory fname))))
      (org-display-inline-images))
     ;; regular drag and drop on file
     (t
      (error "I am not equipped for dnd on %s" payload)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;person config end here
(provide 'v-org-tooltik)
