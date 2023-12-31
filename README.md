We recommend that you install AWS ParallelCluster in a virtual environment to avoid requirement version conflicts with other pip packages.
* References doc to install Virtual Env: https://docs.aws.amazon.com/parallelcluster/latest/ug/install-v3-virtual-environment.html

Prerequisites
AWS ParallelCluster requires Python 3.7 or later. If you don't already have it installed, download a compatible version for your platform at python.org.

To install AWS ParallelCluster in a virtual environment

1) If virtualenv isn't installed, install virtualenv using pip3. If python3 -m virtualenv help displays help information, go to step 2.

```
python3 -m pip install --upgrade pip
python3 -m pip install --user --upgrade virtualenv
```
Run exit to leave the current terminal window and open a new terminal window to pick up changes to the environment.


2) Create a virtual environment and name it.
```
$ python3 -m virtualenv /Users/dubaria/Desktop/Exercises/ParallelCluster/apc-ve
```

Alternatively, you can use the -p option to specify a specific version of Python.
```
$ python3  -m virtualenv -p $(which python3) /Users/dubaria/Desktop/Exercises/ParallelCluster/apc-ve
```

3) Activate your new virtual environment.
```
$ source /Users/dubaria/Desktop/Exercises/ParallelCluster/apc-ve/bin/activate
```

4) Install AWS ParallelCluster into your virtual environment.
```
(apc-ve)~$ python3 -m pip install --upgrade "aws-parallelcluster"
```

5) Install Node Version Manager and the latest Long-Term Support (LTS) Node.js version. AWS Cloud Development Kit (AWS CDK) (AWS CDK) requires Node.js for CloudFormation for template generation.

**Note:**
If your Node.js installation isn't working on your platform, you can install an LTS version prior to the latest LTS version. For more information, see the Node.js release schedule and the AWS CDK prerequisites.

Example Node.js installation command:
```
$  nvm install --lts=Gallium
```
```
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
$ chmod ug+x ~/.nvm/nvm.sh
$ source ~/.nvm/nvm.sh
$ nvm install --lts
$ node --version
```

6) Verify that AWS ParallelCluster is installed correctly.
```
$ pcluster version
{
  "version": "3.6.1"
}
```
You can use the deactivate command to exit the virtual environment. Each time you start a session, you must reactivate the environment.

To upgrade to the latest version of AWS ParallelCluster, run the installation command again.
```
(apc-ve)~$ python3 -m pip install --upgrade "aws-parallelcluster"
```

### 1. AWS Batch
```
pcluster configure --config batch-cluster-config.yaml --region us-east-2

Allowed values for EC2 Key Pair Name:
1. us-east-2
EC2 Key Pair Name [us-east-2]: 1
Allowed values for Scheduler:
1. slurm
2. awsbatch
Scheduler [slurm]: 2
Head node instance type [t2.micro]: t2.small
Name of queue 1 [queue1]: 
Maximum vCPU [10]: 8
Automate VPC creation? (y/n) [n]: y
Beginning VPC creation. Please do not leave the terminal until the creation is finalized
Creating CloudFormation stack...
Do not leave the terminal until the process has finished.
Stack Name: parallelclusternetworking-pubpriv-20230731183322 (id: arn:aws:cloudformation:us-east-2:xxx:stack/parallelclusternetworking-pubpriv-20230731183322/c68fa5f0-2fd0-11ee-a819-0a23ce2c4719)
Status: parallelclusternetworking-pubpriv-20230731183322 - CREATE_COMPLETE      
The stack has been created.
Configuration file written to batch-cluster-config.yaml
You can edit your configuration file or simply run 'pcluster create-cluster --cluster-configuration batch-cluster-config.yaml --cluster-name cluster-name --region us-east-2' to create your cluster.

```
```
AWS Batch

# pcluster create-cluster --cluster-name batch-pcluster --cluster-configuration batch-cluster-config.yaml --region us-east-2
# pcluster describe-cluster --cluster-name batch-pcluster --region us-east-2
# pcluster ssh --cluster-name batch-pcluster --region us-east-2 -i /Users/dubaria/Desktop/Keys/us-east-2.pem
########## pcluster delete-cluster --region us-east-2 --cluster-name batch-pcluster
#####
# pcluster describe-cluster-instances -n batch-pcluster -r us-east-2
# sudo scp -i /Users/dubaria/Desktop/Keys/us-east-2.pem /Users/dubaria/Desktop/Exercises/ParallelCluster/Batch-files/* ec2-user@3.14.130.120:/home/ec2-user
# sudo scp -i /Users/dubaria/Desktop/Keys/us-east-2.pem /Users/dubaria/Desktop/Exercises/ParallelCluster/Batch-files/* ec2-user@$(pcluster describe-cluster-instances -n batch-pcluster -r us-east-2 | jq -r '.instances[] | select(.nodeType=="HeadNode") | .publicIpAddress'):/home/ec2-user
# sudo scp -i /Users/dubaria/Desktop/Keys/us-east-2.pem /Users/dubaria/Desktop/Keys/us-east-2.pem ec2-user@$(pcluster describe-cluster-instances -n batch-pcluster -r us-east-2 | jq -r '.instances[] | select(.nodeType=="HeadNode") | .publicIpAddress'):/home/ec2-user
# pcluster ssh --cluster-name batch-pcluster --region us-east-2 -i /Users/dubaria/Desktop/Keys/us-east-2.pem


## https://docs.aws.amazon.com/parallelcluster/latest/ug/awsbatchcli-v3.html
# awsbsub -n 3 -cf submit_mpi.sh
# awsbhosts
# awsbhosts -d
# watch awsbstat -d
# awsbstat -s ALL
# awsbstat -s ALL -e
# awsbout 28bc9514-bc20-40f5-8c0d-48ba1ac0af3a#0
# awsbout 28bc9514-bc20-40f5-8c0d-48ba1ac0af3a#1
# awsbout 28bc9514-bc20-40f5-8c0d-48ba1ac0af3a#2
# awsbout 28bc9514-bc20-40f5-8c0d-48ba1ac0af3a#0 -s 
# awsbout 28bc9514-bc20-40f5-8c0d-48ba1ac0af3a#1 -s
# awsbout 28bc9514-bc20-40f5-8c0d-48ba1ac0af3a#2 -s
```


### 2. AWS Slurm
```
# Slurm

$ pcluster configure --config slurm-cluster-config.yaml --region us-east-2
INFO: Configuration file slurm-cluster-config.yaml will be written.
Press CTRL-C to interrupt the procedure.


Allowed values for EC2 Key Pair Name:
1. us-east-2
EC2 Key Pair Name [us-east-2]: 1
Allowed values for Scheduler:
1. slurm
2. awsbatch
Scheduler [slurm]: 1
Allowed values for Operating System:
1. alinux2
2. centos7
3. ubuntu1804
4. ubuntu2004
5. rhel8
Operating System [alinux2]: 1
Head node instance type [t2.micro]: t2.small
Number of queues [1]: 1
Name of queue 1 [queue1]: 
Number of compute resources for queue1 [1]: 
Compute instance type for compute resource 1 in queue1 [t2.micro]: t2.medium
Maximum instance count [10]: 3
Automate VPC creation? (y/n) [n]: n
Allowed values for VPC ID:
  #  id                     name                                               number_of_subnets
---  ---------------------  -----------------------------------------------  -------------------
  1  vpc-e26a768a           default                                                            3
  2  vpc-09a4b838e4069c49e  ParallelClusterVPC-20230731183322                                  2
  3  vpc-055bb846caa6b819a  eksctl-Karpenter-Neuron-Linux-v1-23-cluster/VPC                    6
VPC ID [vpc-e26a768a]: 2
The creation of a public and private subnet combination will result in
charges for NAT gateway creation that are not covered under the free tier.
Please refer to https://aws.amazon.com/vpc/pricing/ for more details.
Automate Subnet creation? (y/n) [y]: n
Allowed values for head node subnet ID:
  #  id                        name                              size  availability_zone
---  ------------------------  ------------------------------  ------  -------------------
  1  subnet-0e5e9e09eaa14d678  parallelcluster:public-subnet      256  us-east-2a
  2  subnet-0f93eb66d6fe88a1e  parallelcluster:private-subnet    4096  us-east-2a
head node subnet ID [subnet-0e5e9e09eaa14d678]: 1
Allowed values for compute subnet ID:
  #  id                        name                              size  availability_zone
---  ------------------------  ------------------------------  ------  -------------------
  1  subnet-0e5e9e09eaa14d678  parallelcluster:public-subnet      256  us-east-2a
  2  subnet-0f93eb66d6fe88a1e  parallelcluster:private-subnet    4096  us-east-2a
compute subnet ID [subnet-0e5e9e09eaa14d678]: 2
Configuration file written to slurm-cluster-config.yaml
You can edit your configuration file or simply run 'pcluster create-cluster --cluster-configuration slurm-cluster-config.yaml --cluster-name cluster-name --region us-east-2' to create your cluster.

```
##
```
# pcluster create-cluster --cluster-name slurm-pcluster --cluster-configuration slurm-cluster-config.yaml --region us-east-2
# pcluster describe-cluster --cluster-name slurm-pcluster --region us-east-2
# pcluster ssh --cluster-name slurm-pcluster --region us-east-2 -i /Users/dubaria/Desktop/Keys/us-east-2.pem
######### pcluster delete-cluster --region us-east-2 --cluster-name slurm-pcluster


# pcluster describe-cluster-instances -n slurm-pcluster -r us-east-2
# sudo scp -i /Users/dubaria/Desktop/Keys/us-east-2.pem /Users/dubaria/Desktop/Exercises/ParallelCluster/Slurm-files/* ec2-user@3.17.79.105:/home/ec2-user
# sudo scp -i /Users/dubaria/Desktop/Keys/us-east-2.pem /Users/dubaria/Desktop/Exercises/ParallelCluster/Slurm-files/* ec2-user@$(pcluster describe-cluster-instances -n slurm-pcluster -r us-east-2 | jq -r '.instances[] | select(.nodeType=="HeadNode") | .publicIpAddress'):/home/ec2-user
# pcluster ssh --cluster-name slurm-pcluster --region us-east-2 -i /Users/dubaria/Desktop/Keys/us-east-2.pem



sbatch -N 2 --wrap "srun hellojob.sh"
sbatch hellojob.sh
squeue


scontrol show node




## Head Node
cd /var/log/parallelcluster

[ec2-user@ip-10-0-0-135 parallelcluster]$ ls -al 
total 1584
drwxrwxrwt  2 root           root               250 Aug  1 01:19 .
drwxr-xr-x 18 root           root              4096 Aug  1 15:08 ..
-rw-r--r--  1 root           root             60746 Aug  1 17:08 cfn-hup-runner.log
-rw-r--r--  1 root           root           1074188 Aug  1 17:08 clustermgtd
-rw-------  1 pcluster-admin pcluster-admin   16878 Aug  1 17:03 clustermgtd.events
-rw-r-----  1 root           root            328412 Aug  1 17:08 clusterstatusmgtd
-rw-------  1 pcluster-admin pcluster-admin       0 Aug  1 01:19 compute_console_output.log
-rw-r-----  1 pcluster-admin pcluster-admin       0 Aug  1 01:19 slurm_fleet_status_manager.log
-rw-r--r--  1 pcluster-admin pcluster-admin       0 Aug  1 01:19 slurm_resume.events
-rw-r--r--  1 pcluster-admin pcluster-admin   20911 Aug  1 17:04 slurm_resume.log
-rw-r--r--  1 pcluster-admin pcluster-admin    2672 Aug  1 17:03 slurm_suspend.log




scontrol show node
# Get IP of the Compute node

scontrol show node | grep -i NodeAddr
   NodeAddr=queue1-dy-t2medium-1 NodeHostName=queue1-dy-t2medium-1 
   NodeAddr=10.0.22.95 NodeHostName=queue1-dy-t2medium-2 Version=23.02.2
   NodeAddr=10.0.28.114 NodeHostName=queue1-dy-t2medium-3 Version=23.02.2





[ec2-user@ip-10-0-0-135 ~]$ ssh ec2-user@10.0.22.95 -i us-east-2.pem 
Warning: Permanently added '10.0.22.95' (ECDSA) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/

## Your are in the Compute node

[ec2-user@queue1-dy-t2medium-2 ~]$ 
[ec2-user@queue1-dy-t2medium-2 ~]$ 
[ec2-user@queue1-dy-t2medium-2 ~]$ 
[ec2-user@queue1-dy-t2medium-2 ~]$ 
[ec2-user@queue1-dy-t2medium-2 ~]$ cd 
[ec2-user@queue1-dy-t2medium-2 ~]$ cd /var/log/parallelcluster
[ec2-user@queue1-dy-t2medium-2 parallelcluster]$ 
[ec2-user@queue1-dy-t2medium-2 parallelcluster]$ 
[ec2-user@queue1-dy-t2medium-2 parallelcluster]$ ls -al 
total 20
drwxrwxrwt  2 root root    88 Aug  1 17:05 .
drwxr-xr-x 18 root root  4096 Aug  1 17:03 ..
-rw-r--r--  1 root root  2480 Aug  1 17:11 computemgtd
-rw-r--r--  1 root root     0 Aug  1 17:05 slurm_health_check.events
-rw-r--r--  1 root root 10324 Aug  1 17:08 slurm_health_check.log
```







### 3. Logs to collect 
1. **Required Info**
 - AWS ParallelCluster version [e.g. 3.1.4]:
 - Full cluster configuration without any credentials or personal data.
 - Cluster name:
 - Output of pcluster describe-cluster command (3.x only).
 - [Optional] Arn of the cluster CloudFormation main stack:


2. **If you are reporting issues about scaling or job failure**
* From Head node: 
  `/var/log/parallelcluster/clustermgtd`
  `/var/log/parallelcluster/clusterstatusmgtd` (if version >= 3.2.0)
  `/var/log/parallelcluster/slurm_resume.log`
  `/var/log/parallelcluster/slurm_suspend.log`
  `/var/log/parallelcluster/slurm_fleet_status_manager.log` (if version >= 3.2.0)
  `/var/log/slurmctld.log`. 

* From Compute node: 
  `/var/log/parallelcluster/computemgtd.log`
  `/var/log/slurmd.log`

**For issues with Slurm scheduler and ParallelCluster < 2.9.0 please attach the following logs:**
* From Head node: 
  `/var/log/jobwatcher`
  `/var/log/sqswatcher`
  `/var/log/slurmctld.log` if scheduler == slurm.
* From Compute node:
  `/var/log/nodewatcher`
  `/var/log/slurmd.log` 


3. **If you are reporting issues about cluster creation failure or node failure**

If the cluster fails creation, please re-execute `create-cluster` action using `--rollback-on-failure` false option (3.x) or create action using `--norollback` option (2.x).

* From Head node: 
  `/var/log/cloud-init.log`
  `/var/log/cfn-init.log`
  `/var/log/chef-client.log`

* From Compute node: 
  `/var/log/cloud-init-output.log`

