ActiveAdmin.register LineItem do
  belongs_to :product, optional: true
  belongs_to :order, optional: true
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :product_id, :cart_id, :quantity, :order_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:product_id, :cart_id, :quantity, :order_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  action_item(:Home) do
    link_to :Home, store_index_path
  end
end
