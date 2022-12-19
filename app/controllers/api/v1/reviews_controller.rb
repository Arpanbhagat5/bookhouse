# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < ApplicationController
      # before_action :authenticate_request!
      before_action :find_book

      # GET /books/book_id/reviews
      def index
        @reviews = @book.reviews.all
        render json: ReviewsRepresenter.new(@reviews).as_json
      end

      # GET /books/book_id/reviews/:id
      def show
        @review = @book.reviews.find(params[:id])
        render json: ReviewRepresenter.new(@review).as_json
      end

      # POST /review
      def create
        @review = @book.reviews.create(review_params)
        if @review.save
          render json: ReviewRepresenter.new(@review).as_json, status: :created
        else
          render json: @review.errors, status: :unprocessable_entity
        end
      end

      # PUT /reviews/:id
      def update
        @review = Review.find(params[:id])
        @review.update(review_params)
        head :no_content
      end

      # DELETE /reviews/:id
      def destroy
        @review = Review.find(params[:id])
        @review.destroy
        head :no_content
      end

      private

      # #TODO: Handle usage of user_id for POST and PUT separately
      def review_params
        params.permit(:title, :comment, :book_id, :id, :user_id)
      end

      def find_book
        @book = Book.find(params[:book_id])
      end
    end
  end
end
