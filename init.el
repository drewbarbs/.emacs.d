;; First, setup load path and package sources by initializing
;; package.el. This has the benefit of ensuring the latest org-mode is
;; used to load the emacs-init.org script
(require 'package)
(setq my/package-archives '(("melpa" . "https://melpa.org/packages/")
                            ("org" . "http://orgmode.org/elpa/")))
(mapc (lambda (archive)
        (let ((id (car archive))
              (location (cdr archive)))
          (unless (assoc-default id package-archives)
            (add-to-list 'package-archives archive t)))) my/package-archives)
;; This modifies the load path
(package-initialize)

;; We are manually calling package-initialize, so we set
;; package-enable-at-startup to nil to disable the default behavior
;; of package-initialize being run (again) after processing of the init.el
;; file (see http://emacs.stackexchange.com/a/5888).
(setq package-enable-at-startup nil)

(require 'org)
(org-babel-load-file
 (expand-file-name "emacs-init.org"
                   user-emacs-directory))
