module Paginate 
  def paginate(objects, page, per_page)
    objects.limit(per_page).offset((page.to_i - 1) * per_page)
  end
end
