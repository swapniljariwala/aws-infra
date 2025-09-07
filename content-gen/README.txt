## What is this?

This creates AWS infrastructure components for corp-announcement generative pipeline pipeline. This is how it works overall-

Step 1: Corporate announcement tracking
    A lambda job runs every minute to fetch latest the corporate announcement.
    It sends the new announcements to an SQS queue.
    And turns on an ec2 instance 
    So we need to create a SQS queue, permissions to read/write SQS queue and turn on/off ec2 instance
Step 2: Announcment processing
    The VM boots up, it reads the previous sqs queue and downloads the pdf of announcement (the url is provided in the message).
    Queue is processed, and then the machine shuts itself down after 15 minutes of inactivity
IAM roles and policies
To simplify things, we can create a single IAM policy for the whole project with all required permissions
And a single role which can be assumed by lambda as well as EC2 in instance profile