require("bundler/setup")
require("pry")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/stores') do
  @all_stores = Store.all()
  erb(:stores)
end

post('/stores/create_new_store') do
  name_input = params[:name_input]
  @new_store = Store.create({:name => name_input})
  if @new_store.save
    redirect('/stores')
  else
    erb(:error)
  end
end

get('/stores/store/:id') do
  @current_store = Store.find(params[:id])
  erb(:store)
end

patch('/store/:id/update_name') do
  @current_store = Store.find(params[:id])
  new_name = params[:new_name]
  if @current_store.update({:name => new_name})
    puts "Wtf"
    redirect("/stores/store/#{@current_store.id}")
  else
    erb(:error)
  end
end

get('/brands') do
  @all_brands = Brand.all()
  erb(:brands)
end

post('/brands/create_new_brand') do
  name_input = params[:name_input]
  @new_brand = Brand.create({:name => name_input})
  if @new_brand.save
    redirect('/brands')
  else
    erb(:error)
  end
end
