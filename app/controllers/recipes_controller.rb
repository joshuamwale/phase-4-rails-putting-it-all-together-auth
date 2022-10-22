class RecipesController < ApplicationController
    before_action :authorize
    def index 
        user = User.find_by(id: session[:user_id])
       if session[:user_id]
            render json: Recipe.all, status: :created
        else  
            render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    def create 
        user = User.find_by(id: session[:user_id])
        if session[:user_id]
            recipe = user.recipes.new(recipe_params)
            if recipe.valid?
                recipe.save!
                render json: recipe, status: :created 
            else
                render json: { errors: recipe.errors.full_messages}, status: :unprocessable_entity
            end
        end

        private 
        def recipe_params 
            params.permit(:title, :instructions, :minutes_to_complete)
        end

        def authorize 
            return render json: { errors: "Not authorized" }, status: :unauthorized unless session.include? :user_id
        end
    end
end
