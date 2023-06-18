# Do not mimic this. Use of this resource for production deployments is not recommended
resource "tls_private_key" "oci" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}
