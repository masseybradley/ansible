# ansible

[`ansible`](https://www.ansible.com/) [`docker`](https://www.docker.com/) container image build.

The container image build clones `ansible/ansible`'s [`devel`](https://github.com/ansible/ansible/tree/devel) branch.

## Requirements

- [`docker`](https://docs.docker.com/install/)
- (optional) [`make`](https://www.gnu.org/software/make/)

## Development

Build the image using `make`: `make`

## Usage

Run `ansible` / `ansible-playbook` commands ad-hoc:
    
    docker run --rm -it \  
        -v ${PWD}/playbooks:/ansible/playbooks \  
        -v ${PWD}/inventory/hosts:/etc/ansible/hosts:ro \  
        -e ANSIBLE_HOME=/ansible \  
        -e PYTHONPATH=/ansible/lib \  
        --entrypoint /ansible/bin/ansible-playbook \  
        --network host \  
        ansible:deadbeef /ansible/playbooks/playbook.yml
