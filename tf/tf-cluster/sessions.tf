resource "oci_bastion_session" "test_session" {
    #Required
    bastion_id = oci_bastion_bastion.test_bastion.id
    key_details {
        #Required
        public_key_content = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5d0YXI6+3KwhISgpk02TdIxBgm/Wp9Gg40b//5YE6aco0KeaXECvZqIenidmOYKmG7iYCTUbq+8S35K4ZD27Kw8yVlKax0kQ9jvywogOyStAgLeOtK20eSSXQWvpyAhveakxaEIU9vUOUvpQ7UI/JR2V9eg1wi1ALvBjZQvMysdS2flYiWFaBq2i1nDDfuholMDq6/bJgHHqhLA+6/UYzwicIFvNKyk5CIwCiboz8fbgN3h5KTko4sd5HT+aBJEudHe3rmMB6sUjuK2E3E09P1B8g35NHUPs0aA6s11XrDM95ADIzMyNJg6v5bhExHM8E4u3mGe5p9OiM/plzip5dc/xhoswbcG/v8DojL19b+u3IOnfRx9qSIh8Eq5cOfMC/MCcPaqgKiDlebEO6mEkVvwxVSt+ugvslJWqGy1lCMZRKZHOCH0/SvAjh2f3au2YgqzYsdNjY/4AJ9gcjXRf09vJ/j6c6Udbrkm84duPKzxaeI/cGPGh/na4gAckum/M= ubuntu@cloudinfra"
    }
    target_resource_details {
        #Required
        session_type = "Managed_SSH"

        #Optional
        
        target_resource_fqdn = "oke-c76j644gueq-nkaj6n4aizq-sipfeu6zy7q-0"
         target_resource_id = "ocid1.instance.oc1.eu-paris-1.anrwiljrbhshxnyce2dd3igkxcx4phrtq54owwosrwzov5zsosq2im3docua"
        target_resource_operating_system_user_name = "opc"
    }

    #Optional
    display_name = "worker1"
    session_ttl_in_seconds = 8500
    }

resource "oci_bastion_session" "test_session2" {
    #Required
    bastion_id = oci_bastion_bastion.test_bastion.id
    key_details {
        #Required
        public_key_content = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5d0YXI6+3KwhISgpk02TdIxBgm/Wp9Gg40b//5YE6aco0KeaXECvZqIenidmOYKmG7iYCTUbq+8S35K4ZD27Kw8yVlKax0kQ9jvywogOyStAgLeOtK20eSSXQWvpyAhveakxaEIU9vUOUvpQ7UI/JR2V9eg1wi1ALvBjZQvMysdS2flYiWFaBq2i1nDDfuholMDq6/bJgHHqhLA+6/UYzwicIFvNKyk5CIwCiboz8fbgN3h5KTko4sd5HT+aBJEudHe3rmMB6sUjuK2E3E09P1B8g35NHUPs0aA6s11XrDM95ADIzMyNJg6v5bhExHM8E4u3mGe5p9OiM/plzip5dc/xhoswbcG/v8DojL19b+u3IOnfRx9qSIh8Eq5cOfMC/MCcPaqgKiDlebEO6mEkVvwxVSt+ugvslJWqGy1lCMZRKZHOCH0/SvAjh2f3au2YgqzYsdNjY/4AJ9gcjXRf09vJ/j6c6Udbrkm84duPKzxaeI/cGPGh/na4gAckum/M= ubuntu@cloudinfra"
    }
    target_resource_details {
        #Required
        session_type = "Managed_SSH"

        #Optional
        
        target_resource_fqdn = "oke-c76j644gueq-nkaj6n4aizq-sipfeu6zy7q-1"
         target_resource_id = "ocid1.instance.oc1.eu-paris-1.anrwiljrbhshxnyctsrmbaod3egfvjdkuecjdhrg74cuhb6sdcanx2uckvra"
        target_resource_operating_system_user_name = "opc"
    }

    #Optional
    display_name = "worker2"
    session_ttl_in_seconds = 8500
    }

resource "oci_bastion_session" "test_session3" {
    #Required
    bastion_id = oci_bastion_bastion.test_bastion.id
    key_details {
        #Required
        public_key_content = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5d0YXI6+3KwhISgpk02TdIxBgm/Wp9Gg40b//5YE6aco0KeaXECvZqIenidmOYKmG7iYCTUbq+8S35K4ZD27Kw8yVlKax0kQ9jvywogOyStAgLeOtK20eSSXQWvpyAhveakxaEIU9vUOUvpQ7UI/JR2V9eg1wi1ALvBjZQvMysdS2flYiWFaBq2i1nDDfuholMDq6/bJgHHqhLA+6/UYzwicIFvNKyk5CIwCiboz8fbgN3h5KTko4sd5HT+aBJEudHe3rmMB6sUjuK2E3E09P1B8g35NHUPs0aA6s11XrDM95ADIzMyNJg6v5bhExHM8E4u3mGe5p9OiM/plzip5dc/xhoswbcG/v8DojL19b+u3IOnfRx9qSIh8Eq5cOfMC/MCcPaqgKiDlebEO6mEkVvwxVSt+ugvslJWqGy1lCMZRKZHOCH0/SvAjh2f3au2YgqzYsdNjY/4AJ9gcjXRf09vJ/j6c6Udbrkm84duPKzxaeI/cGPGh/na4gAckum/M= ubuntu@cloudinfra"
    }
    target_resource_details {
        #Required
        session_type = "Managed_SSH"

        #Optional
        
        target_resource_fqdn = "oke-c76j644gueq-nkaj6n4aizq-sipfeu6zy7q-2"
         target_resource_id = "ocid1.instance.oc1.eu-paris-1.anrwiljrbhshxnyctescea6coyxosisw5p2c73gwsnqddhnhinx4yaspuhbq"
        target_resource_operating_system_user_name = "opc"
    }

    #Optional
    display_name = "worker3"
    session_ttl_in_seconds = 8500
    }