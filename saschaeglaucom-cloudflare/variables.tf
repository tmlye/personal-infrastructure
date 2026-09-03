variable "site_origin" {
  description = "Where the website is served from. \"cloudfront\" during the DNS move, \"pages\" after the cutover."
  type        = string
  default     = "cloudfront"
  validation {
    condition     = contains(["cloudfront", "pages"], var.site_origin)
    error_message = "site_origin must be \"cloudfront\" or \"pages\"."
  }
}

variable "cloudfront_domain" {
  description = "Domain name of the existing CloudFront distribution, e.g. d111111abcdef8.cloudfront.net. Required while site_origin is \"cloudfront\"."
  type        = string
  default     = null
  validation {
    condition     = var.site_origin != "cloudfront" || can(regex("^d[a-z0-9]+\\.cloudfront\\.net$", coalesce(var.cloudfront_domain, "unset")))
    error_message = "Set cloudfront_domain to the dXXXX.cloudfront.net name while site_origin is \"cloudfront\"."
  }
}
