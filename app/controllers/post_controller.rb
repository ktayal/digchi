class PostController < ApplicationController
   skip_before_filter :verify_authenticity_token
  def index
    if params[:id]
      post_by_id(params[:id]);
      @meta_title=@posts[0].title;
      @meta_description=@posts[0].message;
    else
      find_all_posts(params[:company],params[:start_date],params[:end_date],params[:category],params[:city]);
     @meta_title='Digchi- Real people, Real companies, Real Messages'
    @meta_description='want to post the notices inside your own company ? Use digchi !'

    end
    #    @total_posts=Post.find(:all,:order => "created_at DESC");
    @total_count=@all_posts.count;
    @popular_post=@all_posts[rand(5)];
    # find records with different companies and their count
    @companies=Post.find(:all, :select => 'count(*) count, company', :group => 'company');
 end

  def putnotice
    color_array=["#99FF00","#FF3399","#FFCCCC","#FFFF66","#FFCC66","#FF66FF","#CCCC33","#FF6633","#CCA2F0","#D6FF29","#C7FF38","#ADFF52","#99FF33","#FF6666","yellow","greenyellow","yellowgreen","pink","66FF33","cyan","#00FF99","orange"];
    @chit_color=color_array[rand(21)];
    notice_categories();
  end

  def delete_notice
    if params[:share] and id=params[:share][:id]
      id=params[:share][:id];
      @notice=Post.find_by_id(id);
      ref_no= @notice.refno if @notice
      if ref_no==params[:share][:ref_id]
        @notice.delete;
      else
        flash[:notice] ="<div>Sorry :(</div>
               <strong>Invalid reference id , Try again !</strong>"
      end
      redirect_to :action=>"index",:company=>params[:share][:company];
    else
      send_to_root();
    end
  end

  def save_edit_notice
    if params[:share] and id=params[:share][:id]
      id=params[:share][:id];
      @notice=Post.find_by_id(id);
      ref_no= @notice.refno if @notice
      if ref_no==params[:share][:ref_id]
        @notice.name=params[:share][:name];
        @notice.email=params[:share][:email];
        @notice.phone=params[:share][:phone];
        @notice.company=params[:share][:company];
        @notice.city=params[:share][:city];
        @notice.title=params[:share][:title];
        @notice.message=params[:share][:message_formatted];
        @notice.category=params[:share][:category];
        @notice.save;
      else
        flash[:notice] ="<div>Sorry :(</div>
               <strong>Invalid reference id , Try again !</strong>"
      end
      redirect_to :action=>"index",:company=>params[:share][:company];
    else
      send_to_root();
    end
  end

  def edit_notice_page
    @notice=Post.find_by_id(params[:id]);
    if @notice
      @id=params[:id];
      @chit_color=@notice.color;
      @ref_id=@notice.refno;
      notice_categories();
      @category=@notice.category;
    else
      send_to_root();
    end
  end

  def post_notice
    if params[:share] and params[:share][:email]
      @msg = Post.new;
      @msg.name=params[:share][:name];
      @msg.email=params[:share][:email];
      @msg.phone=params[:share][:phone];
      @msg.company=params[:share][:company];
      @msg.city=params[:share][:city];
      @msg.title=params[:share][:title];
      @msg.message=params[:share][:message_formatted];
      @msg.category=params[:share][:category];
      @msg.color=params[:share][:color];

      alphabets=["a","b","c","d","e","f","x","y","z","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w"];
      @msg.refno=params[:share][:phone].to_s+alphabets[rand(26)]+"#{rand(10)}"+alphabets[rand(26)];

      if @msg.save
        flash[:notice] ="<div>Congrats!</div>
              Your notice id is <strong style='color:red;'>#{@msg.refno}</strong>. Remember it to edit or delete your notice."
      else
        flash[:notice] ="<div>Sorry :(</div>
               <strong>some error occured while saving</strong>"
      end
      redirect_to :action=>"index",:company=>params[:share][:company],:category=>params[:share][:category],:city=>params[:share][:city];
    else
      send_to_root();
    end

  end

  def notices_from_company
    if params[:company]
      find_all_posts(params[:company],params[:start_date],params[:end_date],params[:category],params[:city]);
      render:partial=>"notice_list.rhtml";
    else
      send_to_root();
    end
  end


  def notices_from_category
    if params[:category]
      find_all_posts(params[:company],params[:start_date],params[:end_date],params[:category],params[:city]);
      render:partial=>"notice_list.rhtml";
    else
      send_to_root();
    end
  end


  def select_for_dates
    if params[:start_date] and params[:end_date]
      find_all_posts(params[:company],params[:start_date],params[:end_date],params[:category],params[:city]);
      @dates_selected=true;
      render:partial=>"notice_list.rhtml";
    else
      send_to_root();
    end
  end


  def update_popular_post
    index=rand(5);
    @total_posts=Post.find(:all,:order => "created_at DESC");
    @popular_post=@total_posts[index];
    render:partial=>"popular_posts.rhtml";
  end


  
  def find_all_posts(company,start_date,end_date,category,city)
    @company=company||"ALL";
    @category=category||"ALL"
    @city=city||"ALL"

    if start_date
      @start_date=start_date.to_date
    else
      @start_date=("01/12/2010").to_date;
    end
    if end_date
      @end_date=end_date.to_date+1
    else
      @end_date=Date.today+2;
    end


    if @company=="ALL"
      @company_range=Post.find(:all,:select=>'DISTINCT company').map(&:company);
    else
      @company_range=@company;
    end

    if @category=="ALL"
      @category_range=Post.find(:all,:select=>'DISTINCT category').map(&:category);
    else
      @category_range=@category;
    end

    if @city=="ALL"
      @city_range=Post.find(:all,:select=>'DISTINCT city').map(&:city);
    else
      @city_range=@city;
    end

   
    #@today_posts=Post.find(:all,:order => "created_at DESC",:conditions => ["created_at >= ? and created_at < ? and company IN (?) and category IN (?) and city IN (?)",Date.today,(Date.today+2),@company_range,@category_range,@city_range ]);
    @date_posts=Post.find(:all,:order => "created_at DESC",:conditions => ["created_at >= ? and created_at < ?  and company IN (?) and category IN (?) and city IN (?)",@start_date, @end_date,@company_range,@category_range,@city_range ]);
    @all_posts=Post.find(:all,:order => "created_at DESC");

    # find records with different companies and their count
    @categories=Post.find(:all, :select => 'count(*) count, category', :group => 'category',:conditions=>["company IN(?) and city IN(?)",@company_range,@city_range])


    # find records with different cities and their count
    @cities=Post.find(:all, :select => 'count(*) count, city', :group => 'city',:conditions=>["company IN(?)",@company_range])


    #@company_today_count=@today_posts.count;
    #@selected_date_counts=@date_posts.count;
    #@company_all_count= @all_posts.count;

    @company_name=@company;
    @category_name=@category;
    @city_name=@city;

    #    if params[:start_date] and params[:end_date]
    #      @posts=@date_posts;
    #    else
    #      @posts=@all_posts;
    #    end

    @posts=@date_posts;
    #@dates_selected=false;

    @action="index"
    page=params[:page]||1;
    @posts=@posts.paginate(:page => page, :per_page => 10);
    return ;

  end




 def post_by_id(id)
  @posts=Post.find_all_by_id(id);
  @all_posts=Post.find(:all,:order => "created_at DESC");

  @company_name=@posts[0].company;
  @category_name=@posts[0].category;
  @city_name=@posts[0].city;

      # find records with different companies and their count
    @categories=Post.find(:all, :select => 'count(*) count, category', :group => 'category',:conditions=>["company IN(?) and city IN(?)",@company_name,@city_name])
    # find records with different cities and their count
    @cities=Post.find(:all, :select => 'count(*) count, city', :group => 'city',:conditions=>["company IN(?)",@company_name])


            #    if params[:start_date] and params[:end_date]
            #      @posts=@date_posts;
            #    else
            #      @posts=@all_posts;
            #    end

#    @dates_selected=false;

    @action="index"
    page=params[:page]||1;
    @posts=@posts.paginate(:page => page, :per_page => 10);
    return ;
  end



  def edit_notice_id
    if params[:share] and params[:share][:ref_id]
      @posts=Post.find_by_refno(params[:share][:ref_id])
      if @posts
        redirect_to :action => "edit_notice_page" ,:id=>@posts.id ;
      else
        flash[:notice] = "No Result For This Notice Id !  "
        redirect_to :action => "index";
      end
    else
      flash.now[:notice] = "Enter Notice Id.."
      send_to_root();
    end
  end

  def search_notice_id
    if params[:ref_id]
      @posts=Post.find_all_by_refno(params[:ref_id])
      if @posts.count>0
        #@action="index"
        page=params[:page]||1;
        @posts=@posts.paginate(:page => page, :per_page => 1);
      else
        flash.now[:notice] = "No Result For This Notice Id !  "
      end
      render:partial=>"notice_list.rhtml";
    else
      flash.now[:notice] = "Enter Notice Id..";
      send_to_root();
    end
  end

  def notice_categories
    @categories=["Buy","Sell","Jobs","Rent","Sale","Matrimonials","Training & Education","Fun & Extra Co.","Policies","Misc.","Circulars","Room Sharings","News"].sort! { |a,b| a.downcase <=> b.downcase };
    return;
  end

  def send_to_root
    redirect_to :action => "index";
    return;
  end

 def do_login
# Retrieve the user’s facebook user id
#fbid = cookies[$AppKey+"_user"] # $AppKey is a global constant that stores the value of the application key
# Perform sign-in operations
# …
redirect_to request.referrer
#redirect_to :action=>"index";
  end


  


end