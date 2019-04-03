# Setting up a Che environment with Quarkus stack

## Minishift preparation

    minishift profile set quarkus-workshop
    minishift addon enable admin-user
    minishift config set memory 8192
    minishift config set cpus 3
    minishift start

## OpenShift

Run the following command:

    oc login -u system:admin

Test if `oc whoami -t` successfully prints a token.  If it prints an error (e.g. on Minishift), use `oc login -u admin` (instead of `system:admin`).  Make sure that you are indeed logged in as a user with full `cluster-admin` role privilege, e.g. by testing that `oc get projects` shows you all 15+ `kube-*` and `system-*` projects.  (On Minishift, the `minishift addon enable admin-user` above does this via `oc create user admin --full-name=admin; oc adm policy add-cluster-role-to-user cluster-admin admin`, which you could also do manually.)

Then continue as follows:

    oc new-project labs-infra

    oc run apb --restart=Never --image="quay.io/tqvarnst/quarkus-workshop-apb" \
               --image-pull-policy="Always" \
               -- provision -vvv \
               -e namespace="$(oc project -q)"  \
               -e openshift_token=$(oc whoami -t) \
               -e che_generate_user_count=10

If you are using Minishift locally, you may want to use only `che_generate_user_count=1` (instead of `10`).

Then follow the logs:

    oc logs apb -f

until they print something like this:

    PLAY RECAP *********************************************************************
    localhost                  : ok=38   changed=18   unreachable=0    failed=0

If there are failures, and you need to start over from scratch, the easiest is to delete the project and re-create a new one before running the APB again:

    oc delete project labs-infra
    oc new-project labs-infra
    oc run apb ...

## Using Che

_TODO This chapter will later move into a "real" Guide instead of being here..._

Find the URL of _Che_ e.g. via `oc get route che` and login as `user1` with `password`.

...
