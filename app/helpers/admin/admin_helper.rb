module Admin::AdminHelper
  def checked?(ids, id)
    ids.include?(id) ? true : false if ids
  end
end
