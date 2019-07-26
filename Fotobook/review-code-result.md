## Review 1st 20190712 - Revision cb81826

1. Chú ý follow về css best practice về naming class

    - app/assets/javascripts/script.js: class/id trong CSS thường được đặt theo kiểu hypen `heart-animation`, ko ai đặt kiểu `HeartAnimation`. Tương tự `openImageDialog`, `myImage` nên naming theo hyphen-separated

2. Coding style thấy ghê quá: file thì dùng indent = 2 spaces, file thì indent = 4 spaces. Break line thì cũng ko consitency theo quy luật gì cả.

    - app/assets/javascripts/users.coffee
    - app/assets/javascripts/login_signup.js
    - app/assets/stylesheets/login_signup.css
    - ...
    - app/assets/stylesheets/users.scss: ident lúc thì = space, lúc thì bằng tab @.@
    - app/controllers/photos_controller.rb: sau dấu `,` cần có space (nhiều file khác nữa)
    - app/controllers/users_controller.rb: trước và sau dấu `=` cần có space

3. File nào ko cần dùng tới thì xoá đi + đừng commit

    - app/assets/javascripts/animals.coffee/*
    - app/assets/stylesheets/login.scss/*

4. Code dư thừa:

    - app/assets/stylesheets/login_signup.css:  Ko cần khai báo đơn vị cho zero trong css vì `0px=0pt=0em=...=0`. Nên cái gì `0` chỉ cần khai báo `0` là đủ.
    - app/controllers/photos_controller.rb: nếu action chỉ handle đúng 1 format HTML thì việc dùng `respond_to do |format|` là ko cần thiết
    - app/controllers/users_controller.rb: tương tự trên
    - app/controllers/users_controller.rb#get_albums_count: method này ko cần thiết. Nếu có 1 `user` thì cứ việc `user.albums.size` là ra con số mình cần, tách nó ra thành 1 cái hàm ko thấy việc sử dụng hàm này ngắn gọn hơn việc sử dụng `user.albums.size` và cũng chẳng làm rõ nghĩa hơn vì `user.albums.size` tự bản thân nó cũng mo tả dc nó làm gì.
    - app/models/user.rb: association khai báo duplicate?

5. Code chung trong controller nên tách ra method riêng và dùng filter để auto invoke (nếu cần thiết)

    - app/controllers/albums_controller.rb: `@current_album = Album.find(params[:id])` -> dùng filter để làm chuyện này.
    - app/controllers/photos_controller.rb

6. Khi sử dụng câu sql có mở transaction (insert/update/delete) trong vòng lặp thì cần wrap vòng lặp vào ActiveRecord transaction để tránh issue về performance.

    - app/controllers/albums_controller.rb: line 25-33

7. Code ko hiểu dc:

    - app/controllers/albums_controller.rb#update:

    ```
    photo_params[:title] = photo_params.delete(:name)
    photo_params[:title] = "Give me a title..."
    ```

    => sao lại cần 2 dòng để gán `photo_params[:title]`?

    - app/controllers/users_controller.rb#add_album_action: method này dùng làm gì, sao y hệt bên controller album vậy?. Mà sao trong controller user lại có code handle việc tạo album @.@

8. Trường hợp action của user ko thành công thì ngoài việc render ra view lại cần phải show message ra cho user

    - app/controllers/photos_controller.rb

9. Chưa tận dụng được sức mạnh của ActiveRecord Association

    - app/controllers/users_controller.rb#get_all_photos

    ```
    @album = user.albums.includes(:photos).all.map{|x| x.photos.map{|y| y}}.flatten
    ```

    => tạo 1 association ở model user để có thể lấy dc `album_photos` through qua `album` cuối cùng chỉ cần `@photos = user.photos + user.album_photos` là xong.

10. Ko nên quăng tất cả code vào 1 nơi dù nó có liên quan đến nhau.

    - app/controllers/users_controller.rb: Tuy follow cần gắn với 2 user nhưng nên tách ra 1 resource riêng, controller riêng để code clean và dễ quản lý hơn.

11. Khai báo route ưu tiên sử dụng resource, hạn chế sử dụng custom route.

12. Migration lỗi ko chạy dc.

13. Column kiểu boolean nên có giá trị default

    - db/migrate/20190625133404_add_is_public_to_photo.rb

14. Phải đảm bảo file migration khi chạy được rollback, và rollback xong trả lại database schema như trước khi chạy migrate

    - db/migrate/20190702022911_change_attached_imgage_in_photos.rb => file này ko chạy rollback dc
    - db/migrate/20190704014940_change_is_public_to_sharing_mode_in_albums.rb: tương tự trên

----

## Review 2nd 20190721 - Revision d7eddb7

1. Khi bỏ gem vào Gemfile thì nên đưa thêm version vào => cái này ko cần sửa, sau này làm nhớ là dc. Tốt nhất muôn xài gem nào lên `rubygems.org` copy + paste cái chỗ `Gemfile:` vào app mình.

2. Configure editor dùng space thay cho tab, tabsize là 2 space. => search google là ra cách configure

    - Fotobook/app/assets/javascripts/admins.coffee -> do dùng tab nên nhìn change history trên github rất ghê. Sau này làm chung với người khác thì sự khác nhau giữa space và tab sẽ gây ra conflict code ko đáng có.
    - Fotobook/app/assets/javascripts/homes.coffee: cùng 1 file nhưng lúc indent = tab, lúc = space @.@
    - Fotobook/app/controllers/application_controller.rb
    - Fotobook/app/controllers/follows_controller.rb
    - (còn nhiều chỗ khác nữa)

3. Không nên dùng js để set css cho HTML nếu ko cần thiết

    - Fotobook/app/assets/javascripts/homes.coffee: `$(this).css 'background-image', 'linear-gradient(to right, #fe8c00 51%, #f83600 100%)'` => `$(this).addClass('class gì đó')`

4. Không nên cùng cộng chuỗi trong coffee

    - Fotobook/app/assets/javascripts/homes.coffee: `"data[param]="+user_id.toString()+"&data[mode]=follow&data[followees_id]="+followees_id.toString()` => `"data[param]=#{user_id}&data[mode]=follow&data[followees_id]=#{followees_id}`
    - (còn nhiều chỗ khác nữa)

5. Code dư thừa

    - Fotobook/app/assets/javascripts/homes.coffee: option `success` khi dùng ajax là optional. ko cần dùng thì ko khai báo.

    ```
    success: () ->
       false
    ```

    => chỗ này ko có ý nghĩa gì hết, remove đi

    - (còn nhiều chỗ khác nữa)

    - Fotobook/app/controllers/admins_controller.rb: `Photo.all.page` => chỗ này ko cần `all`, chỉ `Photp.page` là đủ
    - Fotobook/app/controllers/albums_controller.rb, Fotobook/app/controllers/follows_controller.rb: Ko thấy dùng ajax ở javascript sao trên controller có xử lý để trả về format `js` nữa? Có thật có chỗ dùng format này ko? Controller chỉ còn xử lý để trả về response cho format nào mà dưới client có dùng thôi, ko phải lúc nào cũng cần `respond_to` rồi trả nhiều format về.
    - Fotobook/app/controllers/users_controller.rb#show: chỗ này dùng `.includes` ko cần thiết, ở đây mình chỉ có 1 user không thể nào xảy ra issue `N+1` query trên những association link trực tiếp đến user được.
    - Fotobook/app/views/albums/_current_album_photo.html.slim: `id="#{current_album.id}"` => chỗ này ko cần dùng string interpolation, chỉ `id=current_album.id` là đủ

6. Hạn chế sử dụng `!important` khi viết CSS.

    - Fotobook/app/assets/stylesheets/users.scss

7. Dùng asset ko đúng cách thì asset chỉ available ở mode development. Khi chạy mode production hay deploy heroku sẽ lỗi

    - Fotobook/app/assets/stylesheets/users.scss:36

8. Duplicate code sẽ gây app khó maintainance và dễ sinh bug

    - Fotobook/app/controllers/albums_controller.rb#create + Fotobook/app/controllers/albums_controller.rb#update

9. App ko có cơ chế authorization phù hợp

    - Fotobook/app/controllers/albums_controller.rb#get_current_album: `current_album` nếu chỉ find = mỗi cái `id` thì thằng user Nguyễn Văn A hoàn toàn có thể gởi 1 request lên để update/destroy/remove_img 1 cái album của thằng Nguyễn Văn B
    - Fotobook/app/controllers/users_controller.rb: có vẻ controller này ai cũng có thể vào để update/destroy 1 thằng user bất kỳ nào đó?

10. Những chức năng của admin nên có riêng những controllers để handle và những controller này nằm trong namespace `admin`

11. Code quá dài cho những logic đơn giản

    - Fotobook/app/controllers/application_controller.rb#get_all_photos: method này chỉ cần `@arr = (user.photos + user.albums_photos).sort_by(&:created_at)`

12. Cần đảm bảo tính đúng đắn của dữ liệu

    - Fotobook/app/controllers/follows_controller.rb#create: nên check xem `current_user` có follow thằng user đang muốn follow chưa, có rồi thì ignore request này đi, chưa có thì tiến hành follow. User nó có nhiều cách gởi request lên server mà vượt qua được validate ở dưới client, nên server cần check lại lần nữa để chắc chắn.

13. Tên varibale, method cần đặt sao cho meaningful

    - Fotobook/app/controllers/homes_controller.rb#switchpa, #switchpa_discover: ko hiểu method này có chức năng gì.

14. Nên tím hiểu `rails enum` hoặc gem `rolify` để thay thế để thay thế cách check user role hiện giờ

15. Đừng commit những file ko dùng tới

    - Fotobook/app/helpers/*
    - Fotobook/public/uploads/*
    - Fotobook/test/*

16. Coding style vẫn còn gớm quá

    - Fotobook/app/views/admins/_album.html.slim: sau dấu `,` cần có 1 space
    - (còn nhiều chỗ khác nữa)

17. Hiện giờ em đang làm 1 mình có thể thêm/xoá/sửa file migration thoải mái. Nhưng chú ý sau này làm việc nhóm thì file migration  đã commit thì ko được xoá/sửa. Cần update lại database schema thì tạo 1 migration mới update lại cái sai của migration cũ.