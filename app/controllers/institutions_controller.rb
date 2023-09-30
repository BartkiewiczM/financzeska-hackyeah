# app/controllers/institutions_controller.rb

class InstitutionsController < ApplicationController
  def index
    @institutions = Institution.all
  end
end
