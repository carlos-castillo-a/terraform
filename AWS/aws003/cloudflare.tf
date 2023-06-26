# Fetch Zone ID
data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

# Configure CNAME for Site
resource "cloudflare_record" "site_name" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.environment != "prod" ? format("%s-carlos", var.environment) : "carlos"
  value   = aws_s3_bucket_website_configuration.aws003-site.website_endpoint
  type    = "CNAME"

  ttl     = 1
  proxied = true
}