;; Init time optimizations
;; https://emacs.stackexchange.com/a/34367
(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 1024 1024 100))
(setq file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
;;;;;; Set deferred timer to reset them

(run-with-idle-timer
 5 nil
 (lambda ()
   (setq gc-cons-threshold gc-cons-threshold-original)
   (setq file-name-handler-alist file-name-handler-alist-original)
   (makunbound 'gc-cons-threshold-original)
   (makunbound 'file-name-handler-alist-original)))

;; First, setup load path and package sources by initializing
;; package.el. This has the benefit of ensuring the latest org-mode is
;; used to load the emacs-init.org script
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
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
