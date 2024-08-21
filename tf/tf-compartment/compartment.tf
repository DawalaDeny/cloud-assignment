resource "oci_identity_compartment" "tf-compartment" {
    # Required
    compartment_id = "ocid1.tenancy.oc1..aaaaaaaa6mre6si5yuhye477u3dsh2exyow2iyrm2ee3sanv2mfmuc3hh5oa"
    description = "test compartement"
    name = "eersteCompartement"
}