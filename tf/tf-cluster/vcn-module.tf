module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.1.0"
  # insert the 5 required variables here
  compartment_id = oci_identity_compartment.tf-compartment.id
  internet_gateway_route_rules = null
  local_peering_gateways = null
  nat_gateway_route_rules = null
  region = "eu-paris-1 "

   # Optional Inputs
  vcn_name = "vcn-deny"
  vcn_dns_label = "deny"
  vcn_cidrs = ["10.0.0.0/16"]
  
  create_internet_gateway = true
  create_nat_gateway = true
  create_service_gateway = true  
}