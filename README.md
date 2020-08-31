# ci-deploy

This is just simple rsync command that i use to deploy my project. If you confuse about the name of this app just chage it, i pick the name because this is the first time i learn CI/CD. I make this script just to hide what i do when i deploy my project rather tahn i type `rsync -rvn ...`. hehehe

## How To Use

just modify `.env` file based on your project and load it from your `.bashrc`

## How to implement it

this is my `.yml` file to implement this script

```yml
stages:
    - deploy
deploy_testing:
    stage: deploy
    tags:
        - testing_env
    script:
        - ci-deploy deploy PROJECT1 "Deploying testing env..."
    only:
        - /^hotfix-/
        - /^feature-/
deploy_prod:
    stage: deploy
    tags:
        - production_env
    script:
        - ci-deploy deploy PROJECT1 "Deploying production env..."
    only:
        - master
```

of course i'm use gitlab and gitlab-runner

**Hopefully useful :)**
