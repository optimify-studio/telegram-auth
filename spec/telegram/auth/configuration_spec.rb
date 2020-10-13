require 'spec_helper'

module Telegram
  describe Configuration do
    it 'implements singleton' do
      expect{Configuration.new}.to raise_error(NoMethodError)
    end

    describe '#valid?' do
      let(:instance){ Configuration.instance }

      it 'returns true when token is provided' do
        instance.token = "foo"
        expect(instance.valid?).to eq(true)
      end
      
      it 'returns false when no token is provided' do
        instance.token = nil
        expect(instance.valid?).to eq(false)
      end
    end

    describe '#auth_expires_in' do
      let(:instance){ Configuration.instance }

      it 'sets an auth expiration policy' do
        expect{
          instance.auth_expires_in = 1000
        }.to change{instance.auth_expires_in}.from(nil).to(1000)
      end
    end

    describe '#verify!' do
      let(:instance){ Configuration.instance }

      it 'returns true when valid' do
        instance.token = 'foo'
        expect(instance.verify!).to be(true)
      end

      it 'throws configuration error when invalid' do
        instance.token = nil
        expect{
          instance.verify!
        }.to raise_error(ConfigurationError, "Invalid token")
      end
    end
  end
end