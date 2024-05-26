---
- hosts: servers
  connection: local
  become: yes
  tasks:
  - name: Executar comando 'df -h'
    become_user: mat
    command: /etc/ansible/playbooks/df.sh
    register: script
