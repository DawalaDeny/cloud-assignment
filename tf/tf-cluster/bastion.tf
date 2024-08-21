resource "oci_bastion_bastion" "test_bastion" {
    
    bastion_type = "standard"
    compartment_id = oci_identity_compartment.tf-compartment.id
    target_subnet_id = oci_core_subnet.vcn-public-subnet.id
    client_cidr_block_allow_list    = [
        "0.0.0.0/0"
                  ]
    }
    