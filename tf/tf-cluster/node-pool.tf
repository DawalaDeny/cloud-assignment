# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool

resource "oci_containerengine_node_pool" "oke-node-pool" {
    # Required
    cluster_id = oci_containerengine_cluster.oke-cluster.id
    compartment_id = oci_identity_compartment.tf-compartment.id
    kubernetes_version = "v1.25.4"
    name = "pool1"
    node_config_details{
        placement_configs{
            availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
            subnet_id = oci_core_subnet.vcn-private-subnet.id
        } 

        size = 3
        
    }
    
    node_shape = "VM.Standard2.1"

    # Using image Oracle-Linux-7.x-<date>
    # Find image OCID for your region from https://docs.oracle.com/iaas/images/ 
    node_source_details {
         image_id = "ocid1.image.oc1.eu-paris-1.aaaaaaaa65w4bx24cobzzih4c5c2eviuojspawyvyubzki6skcsmak5u3phq"
         source_type = "image"
    }
 
    # Optional
    initial_node_labels {
        key = "name"
        value = "cloudinfra"
    }   
    ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5d0YXI6+3KwhISgpk02TdIxBgm/Wp9Gg40b//5YE6aco0KeaXECvZqIenidmOYKmG7iYCTUbq+8S35K4ZD27Kw8yVlKax0kQ9jvywogOyStAgLeOtK20eSSXQWvpyAhveakxaEIU9vUOUvpQ7UI/JR2V9eg1wi1ALvBjZQvMysdS2flYiWFaBq2i1nDDfuholMDq6/bJgHHqhLA+6/UYzwicIFvNKyk5CIwCiboz8fbgN3h5KTko4sd5HT+aBJEudHe3rmMB6sUjuK2E3E09P1B8g35NHUPs0aA6s11XrDM95ADIzMyNJg6v5bhExHM8E4u3mGe5p9OiM/plzip5dc/xhoswbcG/v8DojL19b+u3IOnfRx9qSIh8Eq5cOfMC/MCcPaqgKiDlebEO6mEkVvwxVSt+ugvslJWqGy1lCMZRKZHOCH0/SvAjh2f3au2YgqzYsdNjY/4AJ9gcjXRf09vJ/j6c6Udbrkm84duPKzxaeI/cGPGh/na4gAckum/M= ubuntu@cloudinfra" 
}