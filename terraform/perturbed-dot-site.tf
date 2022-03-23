resource "google_dns_managed_zone" "perturbed-dot-site" {
  name        = "perturbed-dot-site"
  dns_name    = "perturbed.site."
  description = "DNS zone for domain: perturbed.site"
}

resource "google_dns_record_set" "perturbed-dot-site-root-a" {
  managed_zone = google_dns_managed_zone.perturbed-dot-site.name
  name         = google_dns_managed_zone.perturbed-dot-site.dns_name
  type         = "A"
  ttl          = "300"

  rrdatas = [
    "35.185.44.232"
  ]
}

resource "google_dns_record_set" "perturbed-dot-site-_gitlab-pages-verification-code-txt" {
  managed_zone = google_dns_managed_zone.perturbed-dot-site.name
  name         = "_gitlab-pages-verification-code.${google_dns_managed_zone.perturbed-dot-site.dns_name}"
  type         = "TXT"
  ttl          = "300"

  rrdatas = [
    "gitlab-pages-verification-code=ff8964198733a617e05379f596a18bf5"
  ]
}
