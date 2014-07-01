# workaround for unlocking user accounts:
# Locked user accounts are identified via '!' in /etc/shadow
# SSH will deny login to locked accounts, unless UsePAM is active
# To keep UsePAM dactivated, user accounts are 'unlocked',
# but still get an impossible password - so the aim of locking
# is still present, while SSH login is possible.
exec { "unlock users":
  command => "sed 's/^\\([^:]*:\\)\\!/\\1*/' -i /etc/shadow",
  onlyif => 'test -n "$(grep "^[^:]*:\!" -o /etc/shadow)"'
}

class { 'ssh_hardening': }
