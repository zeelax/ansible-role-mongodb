#!/bin/bash
set -e

ansible-playbook test_defaults.yml

# running a second time to verify playbook's idempotence
set +e
ansible-playbook test_defaults.yml > /tmp/second_run.log
{
    cat /tmp/second_run.log | tail -n 5 | grep 'changed=0' &&
    echo 'Playbook is idempotent'
} || {
    cat /tmp/second_run.log
    echo 'Playbook is **NOT** idempotent'
    exit 1
}
