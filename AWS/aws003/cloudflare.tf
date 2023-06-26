# Fetch Zone ID
data "cloudflare_zones" "domain" {
  filter {
    name = var.site_domain
  }
}

# Configure CNAME for Site
resource "cloudflare_record" "site_name" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.environment != "prod" ? format("%s-carlos.%s", var.environment, var.domain-name) : format("carlos.%s", var.domain-name)
  value   = aws_s3_bucket_website_configuration.aws003-bucket.website_endpoint
  type    = "CNAME"

  ttl     = 1
  proxied = true
}