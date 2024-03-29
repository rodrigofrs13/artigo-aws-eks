resource "aws_eks_addon" "kube_proxy" {
  addon_name        = "kube-proxy"
  cluster_name      = var.cluster_name
  addon_version     = var.version_kube_proxy
  resolve_conflicts = "PRESERVE"  
  tags = merge(
    {
      "eks_addon" = "kube-proxy"
    }
  )
  depends_on = [
      aws_eks_addon.ebs-csi
  ]  
}

resource "aws_eks_addon" "core_dns" {
  addon_name        = "coredns"
  cluster_name      = var.cluster_name
  addon_version     = var.version_coredns 
  resolve_conflicts = "OVERWRITE"
  tags = merge(
    {
      "eks_addon" = "coredns"
    }
  )
  depends_on = [
      aws_eks_addon.ebs-csi
  ]  
}

resource "aws_eks_addon" "vpc-cni" {
  addon_name        = "vpc-cni"
  cluster_name      = var.cluster_name
  addon_version     = var.version_vpc-cni
  resolve_conflicts = "OVERWRITE"
  tags = merge(
    {
      "eks_addon" = "vpc-cni"
    }
  )
  # depends_on = [
  #     aws_eks_addon.ebs-csi
  # ]  
}

# https://aws.amazon.com/blogs/containers/amazon-ebs-csi-driver-is-now-generally-available-in-amazon-eks-add-ons/ 
data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

resource "aws_eks_addon" "ebs-csi" {
  cluster_name             = module.eks.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = var.version_ebs-csi
  service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  tags = {
    "eks_addon" = "ebs-csi"
    "terraform" = "true"
  }
}
