class FaqsController < ApplicationController
  def index
    @faqs = Faq.all
    @faq = Faq.new
  end

  def create
    @faq = FaqService.create(faq_params[:content])
    if @faq.persisted?
      redirect_to faqs_path, notice: 'FAQ created successfully.'
    else
      @faqs = Faq.all
      render :index
    end
  end

  def destroy
    @faq = Faq.find(params[:id])
    FaqService.delete(@faq)
    redirect_to faqs_path, notice: 'FAQ deleted successfully.'
  end

  private

  def faq_params
    params.require(:faq).permit(:content)
  end
end
