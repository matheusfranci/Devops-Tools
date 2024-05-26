---
- hosts: servers
  become: yes
  tasks:
  - name: Executar comando 'df -h'
    become_user: mat
    command: df -h
    register: df_output

  - name: Salvar saída em um arquivo de spool
    become_user: mat
    copy:
      content: "{{ df_output.stdout }}"
      dest: /etc/ansible/playbooks/df_output.txt
