(Given "^I run jq on \"\\([^\"]+\\)\"$"
  (lambda (filename)
    (jq (f-join jq-features-path "fixtures" filename))))

(Then "^I should see jq output:$"
  (lambda (expected-output)
    (with-current-buffer jq-output-buffer
      (let ((actual-output (buffer-substring-no-properties (point-min) (point-max))))
        (should (s-contains? expected-output actual-output))))))
