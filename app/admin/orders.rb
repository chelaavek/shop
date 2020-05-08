ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :address, :email, :pay_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :email, :pay_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :address, :email, :pay_type
  action_item(:Home) do
    link_to :Home, store_index_path
  end
end
