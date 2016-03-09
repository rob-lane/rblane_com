module FixturesHelper
  def fixture_file(filename)
    File.new(Rails.root.join('spec', 'fixtures', filename))
  end
end