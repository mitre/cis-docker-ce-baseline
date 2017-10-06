SWARM_MODE = attribute(
  'swarm_mode',
  description: 'define the swarm mode, `active` or `inactive`',
  default: 'inactive'
)

SWARM_PORT = attribute(
  'swarm_port',
  description: 'port of the swarm node',
  default: 2377
)

control "M-7.3" do
  title "7.3 Ensure swarm services are binded to a specific host
interface(Scored)"
  desc  "
    By default, the docker swarm services will listen to all interfaces on the
host, which may
    not be necessary for the operation of the swarm where the host has multiple
network
    interfaces.
    When a swarm is initialized the default value for the --listen-addr flag is
0.0.0.0:2377
    which means that the swarm services will listen on all interfaces on the
host. If a host has
    multiple network interfaces this may be undesirable as it may expose the
docker swarm
    services to networks which are not involved in the operation of the swarm.
    By passing a specific IP address to the --listen-addr, a specific network
interface can be
    specified limiting this exposure.

  "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "7.3"
  tag "cis_control": ["9", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SC-7", "4"]
  tag "check_text": "List the network listener on port 2377/TCP (the default for
docker swarm) and confirm\nthat it is only listening on specific interfaces.
For example, using ubuntu this could be done\nwith the following
command:\nnetstat -lt | grep -i 2377\n"
  tag "fix": "Remediation of this requires re-initialization of the swarm
specifying a specific interface\nfor the --listen-addr parameter.\n"
  tag "Default Value": "By default, docker swarm services listen on all
available host interfaces.\n"
  ref '#--listen- addr', url: 'https://docs.docker.com/engine/reference/commandline/swarm_init/#--listen- addr'
  ref 'recover-from-disaster', url: 'https://docs.docker.com/engine/swarm/admin_guide/#recover-from-disaster'

  only_if { SWARM_MODE == 'active' }
  describe port(SWARM_PORT) do
    its('addresses') { should_not include '0.0.0.0' }
    its('addresses') { should_not include '::' }
  end
end
