class ActionController::Request
  def remote_ip_with_x_real_ip
    return @env['HTTP_X_REAL_IP'] if @env['HTTP_X_REAL_IP']
    remote_ip_without_x_real_ip
  end
  alias_method_chain :remote_ip, :x_real_ip
end