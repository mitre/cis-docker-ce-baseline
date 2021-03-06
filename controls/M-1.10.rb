control 'M-1.10' do
  title "1.10 Ensure auditing is configured for Docker files and directories
  /etc/default/docker (Scored)"
  desc  "Audit /etc/default/docker, if applicable.
  Apart from auditing your regular Linux file system and system calls, audit
  all Docker related files and directories. Docker daemon runs with root privileges. Its
  behavior depends on some key files and directories. /etc/default/docker is one such
  file. It holds various parameters for Docker daemon. It must be audited, if applicable."
  impact 0.5
  tag "severity": 'medium'
  tag "cis_id": '1.10'
  tag "cis_control": ['14.6', '6.1']
  tag "cis_level": 'Level 1 - Linux Host OS'
  tag "nist": ['AU-2', '4']
  tag "check_text": "Verify that there is an audit rule corresponding to
  /etc/default/docker file. For example, execute below command: auditctl -l |
  grep /etc/default/docker This should list a rule for /etc/default/docker
  file."
  tag "fix": "Add a rule for /etc/default/docker file. For example, Add the
  line as below in /etc/audit/audit.rules file: -w /etc/default/docker -k
  docker Then, restart the audit daemon. For example, service auditd restart"
  tag "Default Value": "By default, Docker related files and directories are
  not audited. The file /etc/default/docker may not be available on the system.
  In that case, this recommendation is not applicable."
  ref 'System auditing', url: 'https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security_Guide/chap-system_auditing.html'

  describe auditd do
    its('lines') { should include '-w /etc/default/docker -p rwxa -k docker' }
  end
end

