;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;org-mode capture function config here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun micro-org-capture-dir-set()
  (if (eq system-type `windows-nt)
      (setq micro-org-capture-path 
        "C:\\Users\\Administrator\\Desktop\\org-gtd\\")
      (setq micro-org-capture-path 
        "~/note-gtd-ebook/org-gtd/")))
(micro-org-capture-dir-set)

(defun v-open-todo-list()
  """open todo file and agenda mode"""
  (interactive)
  (find-file (concat micro-org-capture-path "todo.org")
  (org-mode)
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-files '(file-expand-wildcards (concat micro-org-capture-path "*.org")))
  (org-agenda)
  (org-agenda-day-view)))
(setq org-agenda-files '(file-expand-wildcards (concat micro-org-capture-path "*.org")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;¨¦¨¨??org-capture
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-capture-templates 
      ;;;;add todo task
      '(("t" "Todo" entry
         (file+headline (concat micro-org-capture-path "Todo.org")
                        "task") 
         "* %?\n %i\n %a")
      ;;;;use to collect ideas and brainstorm
        ("b" "Brainstorm" entry 
         (file+datetree (concat micro-org-capture-path "Brainstorm.org"))
         "* %?\n¨º?¨¨?¨®¨²¡êo %U\n %i\n %a")))

(provide 'org-capture-config)
