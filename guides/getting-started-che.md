## Getting Started with Quarkus in Che

In this lab you will get familiar with the using Eclipse Che for developing using Quarkus.

For completing the following labs, you can either use your own workstation or as an 
alternative, Eclipse Che web IDE. The advantage of your own workstation is that you use the 
environment that you are familiar with while the advantage of Eclipse Che is that all 
tools needed (Maven, Git, OpenShift CLI, etc ) are pre-installed in it (not on your workstation!) and all interactions 
takes place within the browser which removes possible internet speed issues and version incompatibilities 
on your workstation.

The choice is yours but whatever you pick, like most things in life, stick with it for all the labs. We 
ourselves are in love with Eclipse Che and highly recommend it.

## Setup Your Workspace on Eclipse Che

Follow these instructions to setup the development environment on Eclipse Che.

You might be familiar with the Eclipse IDE which is one of the most popular IDEs for Java and other
programming languages. [Eclipse Che](https://www.eclipse.org/che/) is the next-generation Eclipse IDE which is web-based
and gives you a full-featured IDE running in the cloud. You have an Eclipse Che instance deployed on your OpenShift cluster
which you will use during these labs.

Go to the [Eclipse Che url]({{ ECLIPSE_CHE_URL }}) in order to configure your development workspace: {{ ECLIPSE_CHE_URL }}

First, you need to login user the Id that you have been assigned which we will refer to as X for the rest of the workshop

Username: `userX`
Password: `{{ECLIPSE_CHE_PASSWORD}}`

![Eclipse Che - Register]({% image_path bootstrap-che-login.png %}){:width="700px"}

Log into Eclipse Che with your user. You can now create your workspace based on a stack. A 
stack is a template of workspace configuration. For example, it includes the programming language and tools needed
in your workspace. Stacks make it possible to recreate identical workspaces with all the tools and needed configuration
on-demand.

For this lab, click on the **Quarkus Development** stack and then on the **Create** button. 

![Eclipse Che Workspace]({% image_path bootstrap-che-create-workspace.png %})

Click on **Create** to create and open the workspace.

You can click on the left arrow icon to switch to the wide view:

![Eclipse Che Workspace]({% image_path bootstrap-che-wide.png %}){:width="600px"}

It takes a little while for the workspace to be ready. When it's ready, you will see a fully functional 
Eclipse Che IDE running in your browser.

![Eclipse Che Workspace]({% image_path bootstrap-che-workspace.png %})

Now you can import the project into your workspace.

In the project explorer pane, click on the **Import Projects...** and enter the following:

  * Type: `GITHUB`
  * URL: `{{QUARKUS_QUICKSTART_REPO}}`
  * Name: `quarkus-quickstarts`
  * Branch: `{{QUARKUS_QUICKSTART_BRANCH}}`

![Eclipse Che - Import Project]({% image_path bootstrap-che-import.png %}){:width="700px"}

Click on **Import**. Make sure you choose the **Java - Maven** project configuration. Click on **Save**

![Eclipse Che - Import Project]({% image_path bootstrap-che-import-save.png %}){:width="700px"}

The projects are imported now into your workspace and is visible in the project explorer.

Note the **Terminal** window in Eclipse Che. For the rest of these labs, anytime you need to run 
a command in a terminal, you can use the Eclipse Che **Terminal** window.

![Eclipse Che - Terminal]({% image_path bootstrap-che-terminal.png %})

## Explore OpenShift with OpenShift CLI

In order to login, we will use the `oc` command and then specify the server that we
want to authenticate to.

Issue the following command in Eclipse Che terminal and replace `{{OPENSHIFT_CONSOLE_URL}}` 
with your OpenShift Web Console url.

~~~shell
$ oc login {{OPENSHIFT_CONSOLE_URL}}
~~~

You may see the following output:

~~~shell
The server uses a certificate signed by an unknown authority.
You can bypass the certificate check, but any data you send to the server could be intercepted by others.
Use insecure connections? (y/n):
~~~

Enter in `Y` to use a potentially insecure connection.  The reason you received
this message is because we are using a self-signed certificate for this
workshop, but we did not provide you with the CA certificate that was generated
by OpenShift. In a real-world scenario, either OpenShift's certificate would be
signed by a standard CA (eg: Thawte, Verisign, StartSSL, etc.) or signed by a
corporate-standard CA that you already have installed on your system.

Enter the username and password provided to you by the instructor.

Username: `{{OPENSHIFT_USER}}`
Password: `{{OPENSHIFT_PASSWORD}}`

Congratulations, you are now authenticated to the OpenShift server.

[Projects]({{OPENSHIFT_DOCS_BASE}}/architecture/core_concepts/projects_and_users.html#projects) 
are a top level concept to help you organize your deployments. An
OpenShift project allows a community of users (or a user) to organize and manage
their content in isolation from other communities. Each project has its own
resources, policies (who can or cannot perform actions), and constraints (quotas
and limits on resources, etc). Projects act as a "wrapper" around all the
application services and endpoints you (or your teams) are using for your work.

For this lab, let's create a project that you will use in the following when we deploy application to OpenShift. 

> Make sure you replace `X` in the project name with your student ID, In OpenShift all project needs to
> have a unique name

~~~shell
$ oc new-project {{OPENSHIFT_PROJECT_NAME}}

Now using project "{{OPENSHIFT_PROJECT_NAME}}" on server ...
...
~~~

Now you are ready to get started with the Workshop!
