guard :rspec, cmd: "bundle exec rspec --order rand" do
  watch(%r{^lib/(.+).rb$}) do |m|
    "spec/"
  end

  watch(%r{^lib/playparser/(.+).rb$}) do |m|
    "spec/"
  end

  watch(%r{^lib/playparser/models/(.+).rb$}) do |m|
    "spec/"
  end

  watch(%r{^lib/playparser/services/(.+).rb$}) do |m|
    "spec/"
  end

  watch(%r{^spec/(.+).rb$}) do |m|
    "spec/"
  end

  watch(%r{^spec/models/(.+).rb$}) do |m|
    "spec/"
  end

  watch(%r{^spec/services/(.+).rb$}) do |m|
    "spec/"
  end
end
