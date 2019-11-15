;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;org-mode setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Org Mode �Ĭ������� _ �����ַ��ᱻ���ɱ������������ת�塣
;;��������� Org Mode ��Ĭ������£���ת�� _ �ַ��أ�
;;���� org �ļ��Ľ���취
;;�������һ�� org �ļ��Ŀ�ͷ����������������ر�������ܡ�
;;#+OPTIONS: ^:nil
;;�������Ҫ����������ã����԰����������Ϊ
;;#+OPTIONS: ^:{}
;;��������д a_{b} ʱ��_�� {} �����������ݾͻᱻת�壬��д a_b ʱ���Ͱ���ͨ�ķ�ʽ����ʾ��

;;org sites �Ľ���취
;;��������� org sites ��д�ʼǣ�����ĳ�� site ������ org �ļ���ת�� _ �ַ�����Ҳ����ֱ���� org sites �����ļ������������ôһ�䣬һ�˰��ˣ�
;;(setq org-export-with-sub-superscripts nil)
;;Ҳ������ org sites ������������ԣ�ֻ������ĳһ�� site��
;;    :sub-superscript nil
;;�����Ҫ������һ��������������ܵ� {} ��ʽ���������ó�
;;:sub-superscript {}
;;����ֱ���� elisp ������ȫ�ֵ����ԣ�

(defun micro-htmlize-dir-set()
  (if (eq system-type `windows-nt)
      (add-to-list 'load-path 
              (concat micro-plugin-path "emacs-htmlize\\"))
      (add-to-list 'load-path 
              (concat micro-plugin-path "emacs-htmlize/"))))
(micro-htmlize-dir-set)

;;(require 'htmlize)

(require 'ox-freemind)
(setq org-export-with-sub-superscripts '{}) ;;�����ͻ��� {} ��ת���ˡ�
;;org-mode �������ʱ����ʾȫ������
(setq org-html-table-default-attributes
      '(:border "2"
        :cellspacing "0"
        :cellpadding "6"
        :rules "all"
        :frame "border"))

(setq org-startup-indented t)
;;ִ��emacs org-mode�еĴ���C-c C-c
(org-babel-do-load-languages 'org-babel-load-languages
     '(;;can also add other langue here
           (emacs-lisp . t)
           (python . t)
           (dot . t)  ;;graphiz ��ͼ add xxx/griphviz/bin to ����PATH
           (org . t)
           (latex . t)))

(setq default-fill-column 80)
(auto-fill-mode t)
;;���Ҫ��ӣ�����sequence����ӣ��������sequence
;;�����Ӹ�̾��!������Զ����ʱ�����@/��˼�ǲ�ѭ���л� ,
;;;���û��"|"�����һ���ʾ���,�����"|"����"|"��������ʾ���
;;;(setq org-todo-keywords
;;;  '((type "����(w!)" "ѧϰ(s!)" "����(l!)" "|")
;;;    (sequence "PENDING(p!)" "TODO(t!)"  "|" "DONE(d!)" "ABORT(a@/!)")))
;;;(setq org-todo-keywords 
;;;  '((sequence "TODO(t)" "STARTING(s)" "|" "DONE(d)")
;;;    (sequence "|" "CONCELED(c)")))
(setq org-log-done 'time) ;;��¼done��ʱ��
(setq org-todo-keywords
  '((type "����---(w!)" "ѧϰ---(s!)" "����---(l!)" "|")
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
;;;add for org-mode ���ٲ���ͼƬ
(defun micro-org-insert-picture ()
  """use this function to insert picture 
   link @current directory/diagram/xxx.png"""
   (interactive)
   (setq micro-file-name (read-string "�����ļ����֣���")) 
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
