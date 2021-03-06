class BooksController < ApplicationController
   
    before_action :ensure_corrent_user, {only: [:edit, :update, :destroy]}
    
    def create
        @user = current_user
        @books = Book.all
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            flash[:notice] = "You have creatad book successfully."
            redirect_to book_path(@book.id)
        else
         render :index
        end
    end
    def index
        
        @user = current_user
        @books = Book.all
        @book = Book.new
    end
    def show
        @user = current_user
        @book_show = Book.find(params[:id])
        @book = Book.new
    end
    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end
    def edit
        @book = Book.find(params[:id])
    end
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book.id)
        else
            render :edit
        end
    end

    private

    def book_params
       params.require(:book).permit(:title, :body)
    end
    def ensure_corrent_user
        @book = Book.find_by(id: params[:id])
        if @book.user_id != current_user.id
            redirect_to books_path
        end
    end
    
    
end
