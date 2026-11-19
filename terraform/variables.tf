variable "resource_group_name" {
  description = "Name der bestehenden Ressourcengruppe"
  type        = string
  default     = "rg-sentinel-dac-lab"
}

variable "location" {
  description = "Azure-Region für die Ressourcengruppe"
  type        = string
  default     = "westeurope"
}

variable workspace_name {
  description = "Name des Log Analytics Workspace"
  type        = string
  default     = "law-sentinel-dac-lab"
}

variable "retention_in_days" {
  description = "Aufbewahrungszeitraum für Log Analytics Workspace in Tagen"
  type        = number
  default     = 30
}

variable "daily_quota_gb" {
  description = "Tägliches Datenlimit für Log Analytics Workspace in GB"
  type        = number
  default     = 0.5
}

variable "tags" {
  description = "Ressourcen-Tags für FinOps & Governance"
  type        = map(string)
  default     = {
    Environment = "Lab"
    Project     = "Sentinel-DaC-SOAR"
    ManagedBy   = "Terraform"
  }
}