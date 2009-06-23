# Modified RFC822 Email Address Regex
# --------------------------
#
# - restricted domain literals
# - restricted first-level domains in addresses (like 'address@com')
#
module RFC822
  atom = '[a-zA-Z0-9-]+'
  localpart_atom = '[a-zA-Z0-9_-]+'
  domain = "#{atom}(?:\\x2e#{atom})+"
  local_part = "#{localpart_atom}(?:\\x2e#{localpart_atom})*"
  domain_part = "#{atom}\\x2e#{atom}"
  addr_spec = "(#{local_part})\\x40(#{domain})"
  DomainSpec = /\A#{domain}\z/
  EmailSpec = /\A#{addr_spec}\z/
  LocalPartSpec = /\A#{local_part}\z/
  DomainPartSpec = /\A#{domain_part}\z/

end
