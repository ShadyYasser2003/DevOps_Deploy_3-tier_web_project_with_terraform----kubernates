# ----------------------
# IAM for EBS CSI Driver
# ----------------------
data "aws_eks_cluster" "ebs_csi_cluster" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "ebs_csi_auth" {
  name = aws_eks_cluster.eks.name
}

resource "aws_iam_policy" "ebs_csi_driver_policy" {
  name   = "${var.cluster_name}-EBSCSIDriverPolicy"
  policy = file("${path.module}/ebs-csi-policy.json")

  tags = var.tags
}

resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "${var.cluster_name}-EBS-CSI-DriverRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_attach" {
  role       = aws_iam_role.ebs_csi_driver_role.name
  policy_arn = aws_iam_policy.ebs_csi_driver_policy.arn
}

# ----------------------
# IAM Role for EBS CSI Driver with IRSA
# ----------------------
resource "aws_iam_role" "ebs_csi_irsa_role" {
  name = "${var.cluster_name}-EBS-CSI-DriverRole-IRSA"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Condition = {
          StringEquals = {
            "${replace(data.aws_eks_cluster.ebs_csi_cluster.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
        Principal = {
          Federated = aws_iam_openid_connect_provider.oidc_provider.arn
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ebs_csi_attach" {
  role       = aws_iam_role.ebs_csi_irsa_role.name
  policy_arn = aws_iam_policy.ebs_csi_driver_policy.arn
}