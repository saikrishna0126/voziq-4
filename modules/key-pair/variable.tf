variable "key_name" {
  description = "The name of the key pair"
  type        = string
  default     = "test"  # You can change this default value
}

variable "private_key_filename" {
  description = "The filename to save the private key"
  type        = string
  default     = "test-key"  # You can change this default value
}

variable "rsa_bits" {
  description = "The number of bits for the RSA key"
  type        = number
  default     = 4096  # You can change this value if needed
}