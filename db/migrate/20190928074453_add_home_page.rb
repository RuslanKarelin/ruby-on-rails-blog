class AddHomePage < ActiveRecord::Migration
  def change
    Page.create name: 'home', title: 'home', alias: 'home'
  end
end
