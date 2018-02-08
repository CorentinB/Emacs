;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/elpa/*")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(package-selected-packages
   (quote
    (ac-c-headers auto-package-update indent-guide aggressive-indent zoom beacon hlinum neotree yasnippet-snippets yasnippet)))
 '(rainbow-delimiters-max-face-count 90)
 '(zoom-mode t nil (zoom)))

;; keep the superior line to get mistteriosos and make next line on comment
;; keep the original background color, ie. transparent terminal
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
 (add-hook 'window-setup-hook 'on-after-init)

;; Asciidoc, yaml, Dockerfile, jinja2 and .rst support
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(require 'adoc-mode)
(add-to-list 'auto-mode-alist '("\\.adoc\\'" . adoc-mode))
(require 'rst)
(add-to-list 'auto-mode-alist '("\\.rst\\'" . rst))
(require 'jinja2-mode)
(add-to-list 'auto-mode-alist '("\\.j2\\'" . jinja2-mode))
(require 'go-mode-autoloads)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; matching {} [] () in the same color
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; automatically make pairs for (), [] and {}, and automatically
;; delete pairs
(electric-pair-mode 1)

;; Highlight matching (), {}, and []
(show-paren-mode 1)

;; Autocompletion
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories "/home/gregory.voloir/.include_own"))
(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#CCCCCC"))))
 '(col-highlight ((t (:background "color-233"))))
 '(font-lock-comment-face ((t (:foreground "pink"))))
 '(font-lock-function-name-face ((t (:foreground "royalblue"))))
 '(font-lock-keyword-face ((t (:foreground "purple"))))
 '(font-lock-string-face ((t (:foreground "red"))))
 '(font-lock-type-face ((t (:foreground "#00FFFF"))))
 '(font-lock-variable-name-face ((t (:foreground "orangered"))))
 '(hl-line ((t (:background "color-233"))))
 '(lazy-highlight ((t (:background "black" :foreground "white" :underline t))))
 '(neo-)
 '(neo-dir-link-face ((t (:foreground "cyan"))))
 '(neo-file-link-face ((t (:foreground "yellow"))))
 )

;; Uncomment this lines to get a spaces-only indentation
;;(setq-default indent-tabs-mode nil)

;; Make characters after column 80 purple and trailing spaces red
;; This also show tabulations, delete 'tab-mark' from the lines below to
;; cancel this
(require 'whitespace)
(setq whitespace-style
      (quote (face trailing tab-mark lines-tail)))
(add-hook 'find-file-hook 'whitespace-mode)

;; scroll only one line at once
(setq mouse-wheel-progressive-speed nil)
(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;;uncomment to display line numbers
(global-linum-mode 1)
(setq linum-format "%4d \u2502")
(require 'hlinum)
(hlinum-activate)

;; keybindings to toggle functions, use CTRL and arrow keys
(add-hook 'prog-mode-hook
  (lambda()
    (local-set-key (kbd "C-<right>") 'hs-show-block)
    (local-set-key (kbd "C-<left>")  'hs-hide-block)
    (local-set-key (kbd "C-<up>")    'hs-hide-all)
    (local-set-key (kbd "C-<down>")  'hs-show-all)
    (hs-minor-mode t)))
;; ----------------------------------
;;           EPITECH CONFIG
;; ----------------------------------
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "std.el")
(load "std_comment.el")
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(require 'neotree)
(setq-default neo-show-hidden-files t)
(neotree-show)
(switch-to-buffer-other-window "*scratch*")
(global-set-key [f8] 'neotree-toggle)

(beacon-mode 1)

(require 'zoom)

(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)
(global-aggressive-indent-mode 1)
(add-to-list
 'aggressive-indent-dont-indent-if
 '(and (derived-mode-p 'c++-mode)
       (null (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
			   (thing-at-point 'line)))))

(require 'auto-package-update)
(auto-package-update-at-time "03:00")
;; (require 'indent-guide)
;; (indent-guide-global-mode)
;; (set-face-background 'indent-guide-face "white")
