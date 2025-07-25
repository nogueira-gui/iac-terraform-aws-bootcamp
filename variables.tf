variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
  default     = "postgresuser"
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  default     = "adminpass123"
}

variable "user_data_users" {
  description = "Caminho do script de inicialização para Users"
  type        = string
  default     = "user_data_users.sh"
}

variable "user_data_products" {
  description = "Caminho do script de inicialização para Products"
  type        = string
  default     = "user_data_products.sh"
}

variable "user_data_orders" {
  description = "Caminho do script de inicialização para Orders"
  type        = string
  default     = "user_data_orders.sh"
} 