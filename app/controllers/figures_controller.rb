class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    # @figures = Figure.new <-- not necessary unless you are using data from Figures
    erb :'/figures/new'
  end

  post '/figures/create' do
    @figure = Figure.create(figure_params)
    # save or create new title section
    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end
    @figure.titles << Title.find_or_create_by!(name: params[:title][:name]) unless params[:title][:name].empty?
    # save or create new landmark section
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end
    @figure.landmarks << Landmark.find_or_create_by!(name: params[:landmark][:name]) unless params[:landmark][:name].empty?
    # save and redirect
    @figure.save
    redirect :'/figures'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure = @figure.update(figure_params)
    # save or create new title section
    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end
    @figure.titles << Title.find_or_create_by!(name: params[:title][:name]) unless params[:title][:name].empty?
    # save or create new landmark section
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end
    @figure.landmarks << Landmark.find_or_create_by!(name: params[:landmark][:name]) unless params[:landmark][:name].empty?
    # save and redirect
    @figure.save
    redirect :"/figures/#{@figure.id}"
  end

  private

  def figure_params
    {name: params[:figure][:name]}
    # {name: params[:figure][:name], titles: params[figure][title_ids][], landmarks: params[figure][landmark_ids][]}
  end

end
