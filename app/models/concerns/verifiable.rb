module Verifiable
  extend ActiveSupport::Concern

  def verification_key
    ActiveSupport::MessageEncryptor
      .new(Rails.application.config.secret_key_base)
      .encrypt_and_sign("#{self.class} #{id}")
  end

  module ClassMethods
    def find_by_verification_key(value)
      class_name, id = ActiveSupport::MessageEncryptor
        .new(Rails.application.config.secret_key_base)
        .decrypt_and_verify(value).split

      find(id) if class_name == self.name
    rescue ActiveSupport::MessageVerifier::InvalidSignature
    end
  end
end
