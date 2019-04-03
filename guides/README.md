Quarkus Workshop
===
This one day hands-on cloud-native workshops provides developers and introduction to cloud-natives applications and gives them an experience of building cloud-native applications using OpenShift, Spring Boot, WildFly Swarm, Vert.xt and more.

Agenda
===
* Guides to develop Quarkus apps using Eclipse Che


Guides on OpenShift
===

Note that if you have used the above workshop installer, the lab instructions are already deployed.

```
$ oc new-app quay.io/osevg/workshopper:latest --name=guides \
    -p LOG_TO_STDOUT=true \
    -p WORKSHOPS_URLS="https://raw.githubusercontent.com/tqvarnst/quarkus-workshop/master/_quarkus-workshop.yml"
$ oc expose svc/guides
```

Local Guide Instructions
===
```
$ docker run -it --rm -p 8080:8080 \
      -v $(pwd):/app-data \
      -e LOG_TO_STDOUT=true \
      -e CONTENT_URL_PREFIX="file:///app-data" \
      -e WORKSHOPS_URLS="file:///app-data/_quarkus-workshop.yml" \
      quay.io/osevg/workshopper:latest
```
