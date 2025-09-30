EC2 
9 Sep 2025

1. Create Security Group. Create new security, DO NOT USE DEFAULT
2. Create EC2
3. Copy public DNS, make it into a usable link, and paste the link to the chat

Notes:
- Key pair connects a user's computers to the AWS EC2 via secure shell (SSH)
- make sure to type http://before any links are made.
	example: http://ec2-34-203-35-250.compute-1.amazonaws.com - It did not work 
	#1 thing to check, security group, it was because Security Group was incorrect
	New example: http:ec2-54-85-68-135.compute-1.amazonaws.com
- Tags are useful for organizational purpose, as well as tracking resources

Shortcuts
- control + A = select all


Conclave lab Teardown:
1. delete ASG
2. delete Load Balance Listener
3. delete Target Group
4. delete load balancer
5. delete instances
