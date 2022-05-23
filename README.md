# Alpine SSH Client Docker Image

This is a minimal Alpine image based on `alpine:latest` that embeds an SSH client.

Useful within CI/CD pipelines when it's necessary to SSH into a server.

*Use Github version of this repo (instead of Gitlab) because of automatic Build trigger from Docker Hub*

*Push to both Gitlab (origin) and Github (github_build)*

*Update Image upon new Alpine version by manually triggering a build in [Docker Hub build tab](https://hub.docker.com/repository/docker/altdsoy/alpine-ssh/builds)*

## Usage in terminal

```sh
docker pull altdsoy/alpine-ssh
docker run --rm -it --env SSH_PRIVATE_KEY=abcd altdsoy/alpine-ssh
```

## Usage in a CI/CD pipeline

- Set the `SSH_PRIVATE_KEY` environment with the SSH private key within you CI/CD environment
- Use the image in your scripts: `image: altdsoy/alpine-ssh`
- You can now SSH into your server in following scripts: `ssh user@example.com 'ls -alh'`

Example with Gitlab

```yml
#.gitlab-ci.yml
deploy_job:
  image: altdsoy/alpine-ssh
  script:
    - ssh example.com 'rm -rf ~/project && mkdir -p ~/project'
    - scp -r ./project example.com:~/project/
    - ssh example.com 'docker-compose up -d'
```

## Usage with overriding the default environment variable

In case the name of the SSH Private Key environemnt variable name is already set, it's possible to use another name.

Just `echo` the environment variable into `~/ssh_key` (set as the IdentityFile in ssh config)

Example with Gitlab

```yml
#.gitlab-ci.yml
deploy_job:
  image: altdsoy/alpine-ssh
  script:
    - echo "$CUSTOM_SERVER_SSH" > ~/ssh_key
    - ssh example.com 'rm -rf ~/project && mkdir -p ~/project'
    - scp -r ./project example.com:~/project/
    - ssh example.com 'docker-compose up -d'
```

## Generating SSH key pair dedicated to the CI/CD server

### Generate a key pair in any computer

Here the pair is named `id_ed25519` and `id_ed25519.pub` and it's generated in the current directory:

```sh
ssh-keygen -o -a 128 -t ed25519 -f ./id_ed25519 -C "gitlab-ci"
```

### Copying the Public key to the server

This will add the public key to the server.

Regular SSH login/password might be required here.

```sh
ssh-copy-id -f ./id_ed25519 user@example.com
```

### Copying the Private Key to the CI/CD server

⚠️ The private key must not be shared in any case.

Nor be in any version controlled file.

Use the GUI of your CI/CD tool or any other way to securely set the environment variable `SSH_PRIVATE_KEY` in yout CI/CD environment.

In Gitlab, go under: Settings (on the left) > CI / CD > Variables (Expand) > Add Variable
