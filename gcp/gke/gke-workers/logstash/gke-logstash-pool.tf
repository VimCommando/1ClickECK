resource "google_container_node_pool" "logstash" {
  
  name    = "logstash"

  count = var.logstash_create_node_pool == true ? 1 : 0
  
  cluster  = data.terraform_remote_state.k8s.outputs.gke_cluster_id
  
  version    = var.gke_version


  node_count = var.logstash_instance_count
  node_locations = [var.zones[0]]

  management {
    auto_repair  = var.gke_auto_repair
    auto_upgrade = var.gke_auto_upgrade
  }

  node_config {
    preemptible  = true
    machine_type = var.logstash_instance_type
    image_type   = var.gke_image_type
    disk_size_gb = var.logstash_volume
    disk_type    = var.logstash_volume_type


    labels = var.logstash_instance_k8s_label

    service_account = data.terraform_remote_state.k8s.outputs.gcp_service_account_email
    oauth_scopes = var.gke_oauth_scopes
  }
}