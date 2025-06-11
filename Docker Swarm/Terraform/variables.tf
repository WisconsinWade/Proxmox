variable pm_api_url {
    type    =   string
    default =   "" # Insert API URL for Proxmox host http://xxx.xxx.xxx.xxx:8006/api2/json
}

variable pm_api_token_id {
    type    =   string
    default =   "" # Insert API user
} 

variable pm_api_token_secret {
    type    =   string
    default =   "" # Insert API secret received when creating terraform user
}   

variable pm_node_name {
    type    =   string
    default =   "" # Insert PVE Node
} 

variable ci_password {
    type    =   string
    default =   ""  # Insert cloud-init password (if created) 
} 

variable public_key {
    type    =   string
    default =   ""  # Insert Public Key
} 
