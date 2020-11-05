#!/usr/bin/python3
import boto3

session=boto3.session.Session(profile_name="root_dev")
ec2_console_resource=session.resource(service_name='ec2',region_name='ca-central-1')
my_instance=ec2_console_resource.Instance(id='i-0a0897b8ad507853a')
print(my_instance.state)