# ProjectONE
## Automated ELK Stack Deployment
Repository for Week 13 Project of Harsh Desai

The files in this repository were used to configure the network depicted below.

[Network Diagram](Diagrams/NetworkDiagram.drawio.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the [Ansible](Ansible) directory may be used to install only certain pieces of it, such as Filebeat.

  - _[Filebeat Playbook](Ansible/Filebeat-Playbook.yml)_

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- _As said above, load balancers protect the A in the CIA triad: Availability. Ensuring as little down time as possible to our services._ 
- _We also use the jumpbox to ensure the integrity of our web servers by restricting where access can come from._

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the servers and system files.
- _Filebeat handles the system files by monitoring log files._
- _Metricbeat handles the servers by collecting metrics from the system and services running on it._

The configuration details of each machine may be found below.

| Name                 | Function     | IP Address    | Operating System |
|----------------------|--------------|---------------|------------------|
| JumpBoxProvisioner   | Gateway      | 20.231.96.111 | Linux            |
| Web #1               | Web Server   | 20.25.102.34  | Linux            |
| Web #2               | Web Server   | 20.25.102.34  | Linux            |
| Web #3               | Web Server   | 20.25.102.34  | Linux            |
| ELK-SERVER           | Log Server   | 20.9.58.72    | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the web machines can accept connections from the Internet (port 80). Access to this machine is only allowed from the following IP addresses:
- _73.101.106.120_

Machines within the network can only be accessed by the Jump Box. More specifically the Docker container within the Jumpbox with the proper ssh keys.
- _The ELK server can also be accessed through my personal computer using the IP 73.101.106.120 on port 5601 to view the Kibana dashboard._

A summary of the access policies in place can be found in the table below.

| Name       | Publicly Accessible | Allowed IP Addresses  |
|------------|---------------------|-----------------------|
| Jump Box   | No                  | 73.101.106.120           |
| Web #1     | Yes                 | 73.101.106.120, 10.0.0.4 |
| Web #2     | Yes                 | 73.101.106.120, 10.0.0.4 |
| Web #3     | Yes                 | 73.101.106.120, 10.0.0.4 |
| Elk Server | No                  | 73.101.106.120, 10.0.0.4 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _This allows us to quickly implament this on other ELK servers consistently._

The playbook implements the following tasks:
- _The playbook begins by installing the relevant software, being Docker, Python and the module to help Docker work with python._
- _Next, the playbook increases the memory usage of the server so that the container has the resources to run._
- _Finally, it downloads the correct docker image and enables the service on boot to make sure it is always running._

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
`
![](Images/DockerPS.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _Web #1: 10.0.0.5_
- _Web #2: 10.0.0.6_
- _Web #3: 10.0.0.7_

We have installed the following Beats on these machines:
- _Filebeats and Metricbeats_

These Beats allow us to collect the following information from each machine:
- _Filebeat follows and harvests info on files that we specify and many other modules. EX: We can receive info from a syslog for number of sudo commands or ssh logins._
- _Metricbeat allows us to collect metrics or numbers the system or other modules keep track of. EX: We can recieve info from the system on cpu usage and remaining space on the hard drive._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy both the filebeat and metricbeat playbooks and config files to the `/etc/ansible` directory.
- Update the config files to include the IPs and ports of the machines you are looking to monitor.
- Run the playbook, and navigate to `http://[your.VM.IP]:5601/app/kibana#/home/tutorial/systemLogs` to check that the installation worked as expected. Check this by scrolling to the bottom and hit the "Check Data" button. You should receive a message similar to this
![](Images/FileBeat.PNG)
- For Meatricbeat, navigate to `http://[your.VM.IP]:5601/app/kibana#/home/tutorial/dockerMetrics`, and again scroll to the bottom and hit check data. You should receive a message similar to this.
![](Images/MetricBeat.PNG)

### FAQ
- _Which file is the playbook? Where do you copy it?_
  - _The playbook files are found in the [Ansible](Ansible) directory with playbook in their file name (Also seen at the top of this page). These can be copied though either copy/paste into a file you create on the system, or downloaded and moved to the `/etc/ansible` directory._
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
  - _While in the `/etc/ansible` directory you should see a file called `hosts`. In this file you can create web server groups in which to specify what computers you want to install files on._
- _Which URL do you navigate to in order to check that the ELK server is running?_
  - _To check if the ELK server is running you can navigate to `http://[your.VM.IP]:5601/app/kibana`. It should look similar to the following image:_
![](Images/Kibana.PNG)
