require "rails_helper"

RSpec.describe CoverImageUploader do
  it 'allows only images' do
    uploader = described_class.new(Meal.new, :cover_image)

    expect do
      File.open("#{Rails.root}/spec/fixtures/empty_pdf.pdf") do |f|
        uploader.store!(f)
      end
    end.to raise_exception(CarrierWave::IntegrityError)
  end
end
