import boto3


def lambda_handler(event, context):

    ec2 = boto3.resource('ec2', region_name='eu-central-1')

    filters = [
        {'Name': 'tag:artem', 'Values': ['stop']},
        {'Name': 'instance-state-name', 'Values': ['running']}
    ]

    instances = ec2.instances.filter(Filters=filters)

    instance_ids = [instance.id for instance in instances]

    if instance_ids:
        ec2.instances.filter(InstanceIds=instance_ids).stop()
        print(f"instance successfull stop: {instance_ids}")
    else:
        print("no instance running.")




