class User < ActiveRecord::Base

  def self.total_users
    User.count()
  end

  def self.new_users_in_last_n_days( n )
    User.where("created_at > ( CURRENT_DATE - #{n} )").count
  end

  def self.top_states
    join_billing_state.select("states.name, COUNT(states.name) AS state_count").group("states.name").order("state_count DESC").limit(3)
  end

  def self.top_cities
    join_billing_city.select("cities.name, COUNT(cities.name) AS city_count").group("cities.name").order("city_count DESC").limit(3)
  end

  def self.join_billing_state
    User.joins( "JOIN addresses ON users.billing_id = addresses.id JOIN states ON addresses.state_id = states.id" )
  end

  def self.join_billing_city
    User.joins( "JOIN addresses ON users.billing_id = addresses.id JOIN cities ON addresses.city_id = cities.id" )
  end

end
