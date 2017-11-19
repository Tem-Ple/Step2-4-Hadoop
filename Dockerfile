# 选择一个已有的os镜像作为基础  
FROM docker.io/centos:6.6

# 镜像的作者  
MAINTAINER temple.zhou

# 安装openssh-server和sudo软件包，并且将sshd的UsePAM参数设置成no  
RUN yum install -y openssh-server sudo  
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config  
#安装openssh-clients
RUN yum install -y openssh-clients
RUN yum install -y which

# 添加测试用户root，密码root，并且将此用户添加到sudoers里  
RUN echo "root:root" | chpasswd  
RUN echo "root   ALL=(ALL)       ALL" >> /etc/sudoers  
RUN mkdir /root/.ssh
# 替换成自己宿主机的共钥，方便从宿主机免密登陆
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbcPQ2s+6u99CiC4hlczADf/6VReax1iBLdss+lw9VnRpNBfQXj+cNrebdREhQ00VFdzaGuQc5IRBxVDqiDC/zXhgP/3rETxoZDd09JRVaOFASdKz+VxQ6HxsSJMBz7GRvCjod5w+fVaTop9rTPx4oUl6RqGjUZmXbaBq+owwNcMrg92RCF4d4srpxF/dTYR+jm23g8hKkmcGl0rDn27Y8fwS96ClIM5Z5CGdovfKppDsnjyzPTIToLn4VHhi4oAiKuItUEblcLLN1ez/Sq5RuZ/rae78dwE3sLDwbL2mCNnTeJzw1rgjRDGl2Tc+QnCKZ/yEHJmAsfJKzuuO6Ox15 root@mydocker" >> /root/.ssh/authorized_keys
# 设置相同rsa id方便节点之间ssh互信
RUN echo -e "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEA0ig/KjqC+Nu/w/rEh4/c6gvaKMJ0PEQ27j80XDxk107D96dx\nMGfxp5BlBkq6+AMMQYnYX/LZarg2foC2NPeDHP5xZBQLawrEk/jblVtV66a/RrAZ\nU9biCs8V8SWQG1h9W6w7hSZN9DaI5gONgJ71wTdVg/XhxbZ3wGZc6ZFA7Ob1vyE9\nnl+IhSXtHrEp/v0b2sCgCac8Y50UDNasI95br2zdTRv/aL1ud4Z0wgoPhoFstn5Y\nGlk5w/J3botfcZce2xdONzgobPyfFq3hVYNfdTZT7LyztVbRlJuzvHDOdxXfzgAM\nZgN5wGfkOWT3fMuHv3GgST3jS3kyhln1HC5p0wIBIwKCAQBgEmYErQisRzMXwxgD\ndPdGa9Fxt/qfNSBs6bGJQC4ZSJQZcR3M/FE2qGiya04oO+hYeYd8UcJ57c/EzSAY\nNqJWZbAtwAU4P2/OnaY1phimPZlE4sm/7TQiMsgzuWZy5p+04QVELsSM5brszmyS\nkc9uRS5oNeONlT4Oz7VyFoQUhgKDQ+gI9/AlyXmrBOwoN1WOfOmUvVBjCJ+WJEpd\nrlLtDgqiToa8rgsNHwDqxKdqZCEJZpA7RE90I3gIp38n400T4vUVokeZXK0UzKiI\nORmdyT1iPBuwcVchODhVxOkil//M95zRFfcNr5ciLnElLByirqfSGsd/b8sODY4A\ngJsLAoGBAPEqvMCQrZ6b/3Jk8lRyXoVBNwnAOvGdm7+N31lZhhm7c7iggDnKkCTw\nTg6jTFPrasJ0aJVrZwvrOD5spMEuF4/4+OSyxrjaLg6Y7+hk0QcnRP6qhNcQQa/Y\nFc8e1Q7onhgAiUUubltRZPn8qQ/GuzuZlQYuBVP1wd7nS6dcuwTtAoGBAN8VP/F6\nE4yWfcCTpBD0pYtx2FdUDirtXndmh/AdauyNam1pj/7hcJFahJQdL41iW6H9hWct\nTMAKrKJu+DgcPlZGnfFlHnLzU9XgPkhGtXBEyR77VGATHTMj2ulh/QGSy0g9GSAu\nNRIBEs+h9lA0v82B/or/nfru8sdwUKceWhG/AoGADcfth1i5dscV6UeY0aAiqIdi\nOxJMgtXOYremXOCLUe10U7FmabPNuPfJ8jU3j8RPPk/LdkCmzXsnyQ2FweVgbqCD\nQES65f3WvwFsy3N5qKMog5S3Ijtxd8M0cjxGsGUQWSSaITXaa55ASMyb8kXe0DSp\nbhFCIg4LFA03hegKr9MCgYEArBe0/BxYOUDkqoCF4THBiNQqjIKr1/jxGkfH877s\nFZGp32AP/yLwcCFBtBaDxNbY+U6Le3q3jNUI1RPGzDMLhGJclaXHCDgNeRqztBlK\nI2hDYQsGk0Hx9EA7KREToiDItBHgLsSPVwgkdEm+A1vka1WnGsUwukNNkonX0WCO\nn/kCgYEAqkteiV/jXFXhJQ6vqWoyJhwhjQYKer5uERyk6ufn54RJYdMRcNLgXij6\nfena9rIMU5mXRtjZ88t7RqT/z+mOHXSo9zP77O30Y3EOWAn7gw0lqb9kXUlH5xk7\nbAYqE2JSKxJ2dltWzIYaijRPeYwbVsWMu2MvzogxvoCzqtQmkgU=\n-----END RSA PRIVATE KEY-----" > /root/.ssh/id_rsa
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0ig/KjqC+Nu/w/rEh4/c6gvaKMJ0PEQ27j80XDxk107D96dxMGfxp5BlBkq6+AMMQYnYX/LZarg2foC2NPeDHP5xZBQLawrEk/jblVtV66a/RrAZU9biCs8V8SWQG1h9W6w7hSZN9DaI5gONgJ71wTdVg/XhxbZ3wGZc6ZFA7Ob1vyE9nl+IhSXtHrEp/v0b2sCgCac8Y50UDNasI95br2zdTRv/aL1ud4Z0wgoPhoFstn5YGlk5w/J3botfcZce2xdONzgobPyfFq3hVYNfdTZT7LyztVbRlJuzvHDOdxXfzgAMZgN5wGfkOWT3fMuHv3GgST3jS3kyhln1HC5p0w== root@localhost" > /root/.ssh/id_rsa.pub
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0ig/KjqC+Nu/w/rEh4/c6gvaKMJ0PEQ27j80XDxk107D96dxMGfxp5BlBkq6+AMMQYnYX/LZarg2foC2NPeDHP5xZBQLawrEk/jblVtV66a/RrAZU9biCs8V8SWQG1h9W6w7hSZN9DaI5gONgJ71wTdVg/XhxbZ3wGZc6ZFA7Ob1vyE9nl+IhSXtHrEp/v0b2sCgCac8Y50UDNasI95br2zdTRv/aL1ud4Z0wgoPhoFstn5YGlk5w/J3botfcZce2xdONzgobPyfFq3hVYNfdTZT7LyztVbRlJuzvHDOdxXfzgAMZgN5wGfkOWT3fMuHv3GgST3jS3kyhln1HC5p0w== root@localhost" >> /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/authorized_keys
# 下面这两句比较特殊，在centos6上必须要有，否则创建出来的容器sshd不能登录  
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key  
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key  

# 启动sshd服务并且暴露22端口  
RUN mkdir /var/run/sshd  
EXPOSE 22  
CMD ["/usr/sbin/sshd", "-D"]

# 添加JDK
ADD jdk7u79linuxx64.tar.gz /usr/local/
RUN mv /usr/local/jdk1.7.0_79 /usr/local/jdk1.7
ENV JAVA_HOME /usr/local/jdk1.7
ENV PATH $JAVA_HOME/bin:$PATH

# 添加Hadoop
ADD hadoop-2.7.4.tar.gz /usr/local
RUN mv /usr/local/hadoop-2.7.4 /usr/local/hadoop
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $HADOOP_HOME/bin:$PATH
