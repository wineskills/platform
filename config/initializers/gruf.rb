Gruf.configure do |c|
  c.server_binding_url = "0.0.0.0:50052"
  c.interceptors.use(
    Gruf::Interceptors::Instrumentation::RequestLogging::Interceptor,
    formatter: :logstash,
  )
  c.health_check_enabled = true
end
