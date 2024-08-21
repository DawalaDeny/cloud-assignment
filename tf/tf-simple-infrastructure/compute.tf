

resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = oci_identity_compartment.tf-compartment.id
    shape = "VM.Standard2.1"
    source_details {
        source_id = "ocid1.image.oc1.eu-paris-1.aaaaaaaarhah2jin62ricnfgjhorbki42fp7dqs3gczq3lac4zzpkii6qjya"
        source_type = "image"
    }

    # Optional
    display_name = "EersteVm"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.vcn-public-subnet.id
    }
    metadata = {
        ssh_authorized_keys = file("/home/ubuntu/.ssh/cloudkey.pub")
    } 
    preserve_boot_volume = false
}