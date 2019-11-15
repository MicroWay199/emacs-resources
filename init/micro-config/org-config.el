;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;org-mode setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Org Mode 里，默认情况下 _ 这种字符会被当成标记语言来进行转义。
;;如何设置让 Org Mode 在默认情况下，不转义 _ 字符呢？
;;单个 org 文件的解决办法
;;你可以在一个 org 文件的开头，用下面的设置来关闭这个功能。
;;#+OPTIONS: ^:nil
;;如果你需要更方便的设置，可以把上面这个改为
;;#+OPTIONS: ^:{}
;;这样，当写 a_{b} 时，_后被 {} 括起来的内容就会被转义，而写 a_b 时，就按普通的方式来显示。

;;org sites 的解决办法
;;如果你是用 org sites 来写笔记，想让某个 site 的所有 org 文件不转义 _ 字符，则也可以直接在 org sites 配置文件里，配置下面这么一句，一了百了：
;;(setq org-export-with-sub-superscripts nil)
;;也可以在 org sites 里设置这个属性，只作用于某一个 site：
;;    :sub-superscript nil
;;如果需要像上面一样，采用相对智能的 {} 方式，可以设置成
;;:sub-superscript {}
;;或是直接用 elisp 来设置全局的属性：

(defun micro-htmlize-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
              (concat micro-plugin-path "emacs-htmlize\\"))
      (add-to-list 'load-path 
              (concat micro-plugin-path "emacs-htmlize/"))))
(micro-htmlize-dir-set)

;;(require 'htmlize)

(require 'ox-freemind)
(setq org-export-with-sub-superscripts '{}) ;;这样就会用 {} 来转义了。
;;org-mode 输出表格的时候显示全部框线
(setq org-html-table-default-attributes
      '(:border "2"
        :cellspacing "0"
        :cellpadding "6"
        :rules "all"
        :frame "border"))

(setq org-startup-indented t)
;;执行emacs org-mode中的代码C-c C-c
(org-babel-do-load-languages 'org-babel-load-languages
     '(;;can also add other langue here
           (emacs-lisp . t)
           (python . t)
           (dot . t)  ;;graphiz 画图 add xxx/griphviz/bin to 环境PATH
           (org . t)
           (latex . t)))

(setq default-fill-column 80)
(auto-fill-mode t)
;;如果要添加，就在sequence中添加，或者添加sequence
;;如果添加感叹号!，则会自动添加时间戳，@/意思是不循环切换 ,
;;;如果没有"|"则最后一项表示完成,如果有"|"，则"|"后面的项表示完成
;;;(setq org-todo-keywords
;;;  '((type "工作(w!)" "学习(s!)" "休闲(l!)" "|")
;;;    (sequence "PENDING(p!)" "TODO(t!)"  "|" "DONE(d!)" "ABORT(a@/!)")))
;;;(setq org-todo-keywords 
;;;  '((sequence "TODO(t)" "STARTING(s)" "|" "DONE(d)")
;;;    (sequence "|" "CONCELED(c)")))
(setq org-log-done 'time) ;;记录done的时间
(setq org-todo-keywords
  '((type "工作---(w!)" "学习---(s!)" "休闲---(l!)" "|")
    (sequence "TODO===(t!)" "ONGO>>>(o!)" "|" "DONE---(d!)" "ABORT--(a!)")))
;; (setq org-todo-keyword-faces 
;;       '(("TODO===" :foreground "red")
;;         ("ONGO>>>" :foreground "yellow")
;;         ("DONE---" :foreground "green")
;;         ("ABORT--" :foreground "gray")))

(setq org-todo-keyword-faces 
      '(("TODO===" . "red")
        ("ONGO>>>" . "yellow")
        ("DONE---" . "green")
        ("ABORT--" . "gray")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;add for org-mode 快速插入图片
(defun micro-org-insert-picture ()
  """use this function to insert picture 
   link @current directory/diagram/xxx.png"""
   (interactive)
   (setq micro-file-name (read-string "输入文件名字：：")) 
   (insert (concat "[[" default-directory "diagram/" micro-file-name "]]")))
(global-set-key (kbd "C-c p") 'micro-org-insert-picture)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;org do screenshots and insert to org files
;;; https://emacs-china.org/t/org-mode/79
(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (org-display-inline-images)

  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-directory (buffer-file-name))
                  "/imgs/"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (unless (file-exists-p (file-name-directory filename))
    (make-directory (file-name-directory filename))) ; take screenshot

  (if (eq system-type 'darwin)
      (progn
        (call-process-shell-command "screencapture" nil nil nil nil " -s " (concat
                                                                            "\"" filename "\"" ))
        (call-process-shell-command "convert" nil nil nil nil (concat "\"" filename "\" -resize  \"50%\"" ) (concat "\"" filename "\"" ))
        ))

  (setq relative-dir (concat "./imgs/" (file-name-nondirectory filename)))
  (if (file-exists-p filename)
      (insert (concat "[[file:" relative-dir "]]")))
  (org-display-inline-images)
  )
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
      (org-display-inline-images t t))
     ;; regular drag and drop on file
     (t
      (error "I am not equipped for dnd on %s" payload)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;org setting end here
(provide 'org-config)
