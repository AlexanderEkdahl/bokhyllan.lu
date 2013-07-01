module Verifiable
  extend ActiveSupport::Concern

  def verification_key
    ActiveSupport::MessageEncryptor
      .new(Rails.application.config.secret_key_base)
      .encrypt_and_sign(id)
  end

  module ClassMethods
    def find_by_verification_key(value)
      id = ActiveSupport::MessageEncryptor
        .new(Rails.application.config.secret_key_base)
        .decrypt_and_verify(value)

      find(id)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
    end
  end
end
