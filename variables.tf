# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}


variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = []
}



variable "cluster_endpoint_public_access_cidrs" {
  description = "A list of Allow Public IP"
  type        = list(string)
  default     = []
}


variable "eks_version" {
  description = "Versão do EKS"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Nome do EKS"
  type        = string
  default     = ""
}

### Add-ons
variable "version_kube_proxy" {
  description = "Versão do Kube-Proxy"
  type        = string
  default     = ""
}

variable "version_coredns" {
  description = "Versão do Coredns"
  type        = string
  default     = ""
}

variable "version_vpc-cni" {
  description = "Versão do VPC-CNI"
  type        = string
  default     = ""
}

variable "version_ebs-csi" {
  description = "Versão do EBS-CSI"
  type        = string
  default     = ""
}


## VPC
variable "cidr" {
  description = "Bloco de IP da VPC"
  type        = string
  default     = ""
}


variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway"
  type        = string
  default     = ""
}

variable "single_nat_gateway" {
  description = "Habilitar NAT Gateway"
  type        = string
  default     = ""
}

variable "enable_dns_hostnames" {
  description = "Habilitar DNS Hostname"
  type        = string
  default     = ""
}

variable "namespace" {
  type    = string
  default = "monitoring"
}
