class Usuario < ApplicationRecord
	has_secure_password

	mount_uploader :avatar, AvatarUploader

	#macro de associacao, dependent destroy apaga todos os posts escritos
	#por determinado usuario
    has_many :posts, dependent: :destroy  
    has_many :likes, dependent: :destroy
    belongs_to :cidade, optional: true

	validates_presence_of :avatar
	validates :nome, presence: true, length: { in: 2..20 }
	validates :sobrenome, presence: true, length: { in: 5..50 }
	validates :email, presence: true, length: { in: 5..50 }, uniqueness: true
	validates :telefone, presence: true, numericality: { only_integer: true },
	                           length: { in: 8..15 }
	validates :data_nascimento, presence: true
	validates :password, length: { in: 6..16}, allow_nil: true

	validate :data_correta_maioridade
	validate :data_correta_passado
	validate :tamanho_foto

	def data_correta_maioridade
	  if data_nascimento && data_nascimento > (DateTime.now - 18.years)
	  	errors.add(:data_nascimento, "não pode ter menos de 18 anos")
	  end
	end

	def data_correta_passado
	  if data_nascimento && data_nascimento < (DateTime.now - 150.years)
	  	errors.add(:data_nascimento, "você é uma múmia")
	  end
	end

	def tamanho_foto
	  if avatar.size > 5.megabytes
	  	errors.add(:avatar, "muito grande, não pode possuir mais de 5 MB")
	  end
	end
end
