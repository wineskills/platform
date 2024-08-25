namespace :protos do
  desc "Build GRPC ruby libraries from protos"
  task build: :environment do
    puts "Generating gRPC Ruby files..."

    Dir.chdir(Rails.root) do
      proto_dir = "protos"
      ruby_out_dir = "lib"

      Dir
        .glob("#{proto_dir}/*.proto")
        .each do |file|
          puts "Generating Ruby files for #{file}..."

          system(
            "grpc_tools_ruby_protoc --ruby_out=#{ruby_out_dir} --grpc_out=#{ruby_out_dir} #{file}",
          )
        end
    end
  end
end
