# terraform-patch-manager
Create patching groups for three teir architecture VPC's with both scan and patch for all OS types.

NOT YET PROD READY. WIP.

This is a module in progress for deploying patch manager with maintenance windows across three days, over three AZ's. 

this will deploy perfect with no arguments. 

Updates will follow shortly with full documentation.

Apply a "Patch Group" tag key to all your EC2 instances. the value needs to be either "SCAN" "AZ-A", "AZ-B", or "AZ-C".
You cannot use more than one Key here, so all machines should have the Patch Group tag with SCAN or one of your AZ's. 

Vars file overrides are available for not using the default patch baselines, testing in progress soon for overriding the defaults 
for specific supplied baselines. those will be compatible with the patch groups, or you can also override the tags. 

Patches should be applied to all EC2 machines with "Patch Group" as the key. machines that are pets should all get the value
of the AZ that they reside in. "AZ-A". if the machine should not be patched (its an ASG), then it should get the "SCAN" tag value.