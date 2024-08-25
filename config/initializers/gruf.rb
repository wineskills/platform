Gruf.configure do |c|
  c.server_binding_url = ENV.fetch("GRPC_BINDING_URL", "0.0.0.0:50051")
  c.interceptors.use(
    Gruf::Interceptors::Instrumentation::RequestLogging::Interceptor,
    formatter: :logstash,
  )
  c.health_check_enabled = true
end
