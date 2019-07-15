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