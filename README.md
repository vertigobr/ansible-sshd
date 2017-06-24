# ansible-sshd
Small SSHD daemon with ansible pre-installed

This image is used in conjunction with `vertigo/tiny-sshd` to create testbeds for playbooks by emulating several VMs of different distros.

## How to use

The `docker-compose.yml` below shows how you can create a "multiple VMs" scenario with containers, a much lighter setup:

```
version: '2'
services:
  controller:
    image: vertigo/ansible-sshd:alpine
    hostname: controller
    ports:
      - "2200:22"
    volumes:
      - ./ansible-hosts:/etc/ansible/hosts
    environment:
      - HOSTCHECK=false
  node1:
    image: vertigo/tiny-sshd:alpine
    hostname: node1
  node2:
    image: vertigo/tiny-sshd:centos
    hostname: node2
```

To run this set of "VMs" (i.e. containers emulating VMs with SSHD) just type:

```sh
docker-compose up -d
```

Notice the mounting of an ansible inventory file that contains the node names (as defined in the compose file) into the controller "VM":

```
node1
node2
```

You can login into the controller "VM" and test with the commands below (password "secret"):

```sh
ssh -p 2200 user@localhost
ansible -k -m ping all
SSH password:
node1 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
node2 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

The same thing can be achieved with a single one-liner:

```sh
docker exec -u user -ti ansiblesshd_controller_1 ansible -k -m ping all
SSH password:
node1 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
node2 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```


