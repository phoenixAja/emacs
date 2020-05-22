;;; jupyter-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "jupyter-base" "jupyter-base.el" (0 0 0 0))
;;; Generated autoloads from jupyter-base.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-base" '("jupyter-")))

;;;***

;;;### (autoloads nil "jupyter-channel-ioloop" "jupyter-channel-ioloop.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from jupyter-channel-ioloop.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-channel-ioloop" '("jupyter-")))

;;;***

;;;### (autoloads nil "jupyter-channels" "jupyter-channels.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from jupyter-channels.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-channels" '("jupyter-")))

;;;***

;;;### (autoloads nil "jupyter-client" "jupyter-client.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from jupyter-client.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-client" '("jupyter-")))

;;;***

;;;### (autoloads nil "jupyter-ioloop" "jupyter-ioloop.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from jupyter-ioloop.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-ioloop" '("jupyter-ioloop")))

;;;***

;;;### (autoloads nil "jupyter-julia" "jupyter-julia.el" (0 0 0 0))
;;; Generated autoloads from jupyter-julia.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-julia" '("jupyter-julia-")))

;;;***

;;;### (autoloads nil "jupyter-kernel-manager" "jupyter-kernel-manager.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from jupyter-kernel-manager.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-kernel-manager" '("jupyter-")))

;;;***

;;;### (autoloads nil "jupyter-kernelspec" "jupyter-kernelspec.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from jupyter-kernelspec.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-kernelspec" '("jupyter-")))

;;;***

;;;### (autoloads nil "jupyter-messages" "jupyter-messages.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from jupyter-messages.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-messages" '("jupyter-")))

;;;***

;;;### (autoloads nil "jupyter-mime" "jupyter-mime.el" (0 0 0 0))
;;; Generated autoloads from jupyter-mime.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-mime" '("jupyter-")))

;;;***

;;;### (autoloads nil "jupyter-org-client" "jupyter-org-client.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from jupyter-org-client.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-org-client" '("jupyter-org-")))

;;;***

;;;### (autoloads nil "jupyter-repl" "jupyter-repl.el" (0 0 0 0))
;;; Generated autoloads from jupyter-repl.el

(autoload 'jupyter-repl-associate-buffer "jupyter-repl" "\
Associate the `current-buffer' with a REPL CLIENT.
If the `major-mode' of the `current-buffer' is the
`jupyter-repl-lang-mode' of CLIENT, call the function
`jupyter-repl-interaction-mode' to enable the corresponding mode.

CLIENT should be the symbol `jupyter-repl-client' or the symbol
of a subclass. If CLIENT is a buffer or the name of a buffer, use
the `jupyter-current-client' local to the buffer.

\(fn CLIENT)" t nil)

(defvar jupyter-repl-persistent-mode nil "\
Non-nil if Jupyter-Repl-Persistent mode is enabled.
See the `jupyter-repl-persistent-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `jupyter-repl-persistent-mode'.")

(custom-autoload 'jupyter-repl-persistent-mode "jupyter-repl" nil)

(autoload 'jupyter-repl-persistent-mode "jupyter-repl" "\
Global minor mode to persist Jupyter REPL connections.
When the `jupyter-current-client' of the current buffer is a REPL
client, its value is propagated to all buffers switched to that
have the same `major-mode' as the client's kernel language and
`jupyter-repl-interaction-mode' is enabled in those buffers.

\(fn &optional ARG)" t nil)

(autoload 'jupyter-run-repl "jupyter-repl" "\
Run a Jupyter REPL connected to a kernel with name, KERNEL-NAME.
KERNEL-NAME will be passed to `jupyter-find-kernelspecs' and the
first kernel found will be used to start the new kernel.

With a prefix argument give a new REPL-NAME for the REPL.

Optional argument ASSOCIATE-BUFFER, if non-nil, means to enable
the REPL interaction mode by calling the function
`jupyter-repl-interaction-mode' in the `current-buffer' and
associate it with the REPL created. When called interactively,
ASSOCIATE-BUFFER is set to t. If the `current-buffer's
`major-mode' does not correspond to the language of the kernel
started, ASSOCIATE-BUFFER has no effect.

Optional argument CLIENT-CLASS is the class that will be passed
to `jupyter-start-new-kernel' and should be a class symbol like
the symbol `jupyter-repl-client', which is the default.

When called interactively, DISPLAY the new REPL buffer.
Otherwise, in a non-interactive call, return the REPL client
connected to the kernel.

\(fn KERNEL-NAME &optional REPL-NAME ASSOCIATE-BUFFER CLIENT-CLASS DISPLAY)" t nil)

(autoload 'jupyter-connect-repl "jupyter-repl" "\
Run a Jupyter REPL using a kernel's connection FILE-OR-PLIST.
FILE-OR-PLIST can be either a file holding the connection
information or a property list of connection information.
ASSOCIATE-BUFFER has the same meaning as in `jupyter-run-repl'.

With a prefix argument give a new REPL-NAME for the REPL.

Optional argument CLIENT-CLASS is the class of the client that
will be used to initialize the REPL and should be a class symbol
like the symbol `jupyter-repl-client', which is the default.

Return the REPL client connected to the kernel. When called
interactively, DISPLAY the new REPL buffer as well.

\(fn FILE-OR-PLIST &optional REPL-NAME ASSOCIATE-BUFFER CLIENT-CLASS DISPLAY)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-repl" '("jupyter-")))

;;;***

;;;### (autoloads nil "jupyter-widget-client" "jupyter-widget-client.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from jupyter-widget-client.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jupyter-widget-client" '("httpd/jupyter" "jupyter-widget")))

;;;***

;;;### (autoloads nil "ob-jupyter" "ob-jupyter.el" (0 0 0 0))
;;; Generated autoloads from ob-jupyter.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ob-jupyter" '("org-babel-")))

;;;***

;;;### (autoloads nil nil ("jupyter-javascript.el" "jupyter-pkg.el"
;;;;;;  "jupyter-python.el" "jupyter.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; jupyter-autoloads.el ends here
