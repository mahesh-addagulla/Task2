rgname             = "testrg1"
location           = "East US"
env                = "dev"
address_space_list = ["10.40.0.0/16"]
web_subnets_cidr   = ["10.40.1.0/24", "10.40.2.0/24", "10.40.3.0/24", "10.40.4.0/24"]
app_subnets_cidr   = ["10.40.10.0/24", "10.40.11.0/24", "10.40.12.0/24", "10.40.13.0/24"]
db_subnets_cidr    = ["10.40.20.0/24", "10.40.21.0/24", "10.40.22.0/24", "10.40.23.0/24"]
containername      = "AZB40BLOBDATA"
batch              = "B42"
admin_username     = "adminsree"
vm_size            = "Standard_B1s"
dns_zone           = "manojdemo.com"
deploy_sub_id      = "9ce91e05-4b9e-4a42-95c1-4385c54920c6"
prod_sub_id        = "298f2c19-014b-4195-b821-e3d8fc25c2a8"