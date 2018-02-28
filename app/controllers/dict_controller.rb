class DictController < ApplicationController
  def index
  end

  def search
    @query = params.require(:q)
    @answer = DexOnline.new(@query).call
    respond_to do |format|
      format.js
    end
  end
end
