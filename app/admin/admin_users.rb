ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role

  batch_action :give_admin_permission_to do |ids|
    batch_action_collection.find(ids).each do |v|
      v.update role:'admin'
    end
    redirect_to collection_path, alert: "Users have been updated"
  end

  batch_action :give_user_permission_to do |ids|
    batch_action_collection.find(ids).each do |v|
      v.update role:'user'
    end
    redirect_to collection_path, alert: "Users have been updated"
  end

  batch_action :ban do |ids|
    batch_action_collection.find(ids).each do |v|
      v.update role:'banned'
    end
    redirect_to collection_path, alert: "Users have been updated"
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :role
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :role

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: AdminUser::ROLES.invert, :label_method => :role_name
    end
    f.actions
  end

  action_item(:Home) do
    link_to :Home, store_index_path
  end

end
