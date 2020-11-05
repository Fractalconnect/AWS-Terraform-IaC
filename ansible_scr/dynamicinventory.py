#!/bin/python

# Return server list form AWS EC2 instances #

import json
import pprint
import boto3

def get_ec2_hosts(ec2):
    allhosts = {}
    
    for ec2_group in ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}]):
        for tag in ec2_group.tags:
            if tag["Key"] in allhosts:
                hosts = allhosts.get(tag["Key"])
                hosts.append(ec2_group.public_ip_address)
                allhosts[tag["Key"]] = hosts
            else:
                hosts = [ec2_group.public_ip_address]
                allhosts[tag["Key"]] = hosts
                
            if tag["Value"] in allhosts:
                hosts = allhosts.get(tag["Value"])
                hosts.append(ec2_group.public_ip_address)
                allhosts[tag["Value"]] = hosts
            else:
                hosts =[ec2_group.public_ip_address]
                allhosts[tag["Value"]] = hosts
                
    return allhosts
    
def main():
    ec2 = boto3.resource("ec2")
    all_groups = get_ec2_hosts(ec2)
    inventory = {}
    for key, value in all_groups.items():
        hostsobj = {'hosts': value}
        inventory[key] = hostsobj
    print(json.dumps(inventory))
    
if __name__=="__main__":
    main()