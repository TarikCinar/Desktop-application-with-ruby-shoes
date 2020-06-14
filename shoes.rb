Shoes.app(title: "Login",resizable: false,width:550,height:350) do
  require 'sqlite3'
  require 'nokogiri'
  require 'open-uri'

  @db = SQLite3::Database.open 'user.db'
  @db.execute "CREATE TABLE IF NOT EXISTS user(tc TEXT,ad TEXT,soyad TEXT,email TEXT ,kullanici_ad TEXT, parola TEXT)"
  background "#1B2136"
  @login=stack do
    nesne2=rect 0,0,550,350,30
    nesne2.style(left:150,fill:"#1F283E")

    para "Kullanıcı adı " , stroke: '#FFF' , size: 17 ,top:50,:margin_left => 20
    isim = edit_line width:"50%",top:50,:margin_left => 200,height:40

    para "Şifre  " , stroke: "#FFF" , size: 17,top:130,:margin_left => 20
    sifre = edit_line width: "50%",:margin_left => 200,top:130,height:40

    giris=rect 0,0,150,50,25
    kayit=rect 0,0,150,50,25
    kayit.style(top:250,left:180,fill:"#0072FF")
    giris.style(top:250,left:370,fill:"#6BD406")
    title "Kayıt ol",size:20,stroke:"#FFF",left:205,top:255
    title "Giriş",size:20,stroke:"#FFF",left:410,top:255


    kayit.click do
      kullanici_kayit
    end

    giris.click do
      if isim.text.length ==0 and sifre.text.length==0
        alert("kullanıcı adı ve şifre alanı boş bırakılamaz.")
      else
        @db = SQLite3::Database.open 'user.db'
        query = @db.execute "SELECT * FROM user WHERE kullanici_ad=\"#{isim.text}\" and parola=\"#{sifre.text}\""
        if query.length>0
          home(isim.text)
          @login.close
        else
          alert("kullanıcı adı veya şifre yanlış")
        end
      end
    end
    end


  def kullanici_kayit
    window width:550,height:500,title:"Kayıt" do
      background "#1B2136"
      stack do
          nesne2=rect 0,0,550,500,30
          nesne2.style(left:160,fill:"#1F283E")

          @db = SQLite3::Database.open 'user.db'
        para "Tc : " , stroke:"#FFF" , size: 15,top:50,:margin_left => 20
        tc = edit_line width: "60%",:margin_left => 200,top:50,height:40

        para "İsim: " , stroke: '#FFF' , size: 15 ,top:110,:margin_left => 20
        isim = edit_line width:"60%",top:110,:margin_left => 200,height:40

        para "Soyisim : " , stroke: "#FFF" , size: 15,top:170,:margin_left => 20
        soyisim = edit_line width: "60%",:margin_left => 200,top:170,height:40

        para "Email : " , stroke: "#FFF" , size: 15,top:230,:margin_left => 20
        email = edit_line width: "60%",:margin_left => 200,top:230,height:40

        para "Kullanıcı Adı : " , stroke:"#FFF" , size: 15,top:290,:margin_left => 20
        kullanici_ad = edit_line width: "60%",:margin_left => 200,top:290,height:40

        para "Şifre : " , stroke: "#FFF" , size: "15",top:350,:margin_left => 20
        password = edit_line width: "60%",:margin_left => 200,top:350,height:40

          kayit_button=rect 0,0,150,50,25
          iptal=rect 0,0,150,50,25
          iptal.style(top:430,left:180,fill:"#0072FF")
          kayit_button.style(top:430,left:370,fill:"#6BD406")
          title "İptal",size:20,stroke:"#FFF",left:225,top:435
          title "Giriş",size:20,stroke:"#FFF",left:415,top:435

          iptal.click do
            close
          end

        kayit_button.click do
          if not (isim.text.empty? and soyisim.text.empty? and email.text.empty? and kullanici_ad.text.empty? and password.text.empty?)
            @db = SQLite3::Database.open 'user.db'
            @db.execute "INSERT INTO user (tc, ad , soyad,email,kullanici_ad,parola) VALUES ('#{tc.text}','#{isim.text}','#{soyisim.text}','#{email.text}','#{kullanici_ad.text}','#{password.text}')"
            close
            alert("Kayıt oluşturuldu.")
          else
            alert("Tüm alanların doldurulması zorunludur.")
          end
        end
      end
    end
  end



  def home(kullanici_adi)
    @db = SQLite3::Database.open 'user.db'
    query = @db.execute "SELECT * FROM user WHERE kullanici_ad=\"#{kullanici_adi}\""
    Shoes.app(title: "Anasayfa",resizable: false,width:1400,height:700) do
      background "#1B2136"
      flow do
        stack width:300,height:690 do
          fill "#1F283E"
          panel=rect 5, 5, 290, 685,50
          @profil=stack width:200,height:120,margin_left:90 do
                  resim=image "images/kullanici.png"
                  resim.style(width:100,height:100,top:20)
          end
          para
          para "#{query[0][1]}",stroke:"#FFF",size:15,:family=>"ubuntu",align:"center"
          para "#{query[0][3]}",stroke:"#FFF",size:11,:family=>"ubuntu",align:"center"
          para

          stack top:250,margin_left:7 do
            fill "#1F283E"
            @anasayfa=rect 5, 5, 275,50,15
            @anasayfa.style(top:8,stroke:"#FFF")
            @anasayfa_title = title "Anasayfa"
            @anasayfa_title.style(size:18,left:80,stroke:"#FBFBFB",margin_top:18)
            @anasayfa.hover do
              @anasayfa.style(fill:"#FFF")
              @anasayfa_title.style(stroke:"#1F283E")
            end
            @anasayfa.leave do
              @anasayfa.style(fill:"#1F283E")
              @anasayfa_title.style(stroke:"#FBFBFB")
            end
            @hesaplarim=rect 5, 5, 275,50,15
            @hesaplarim.style(top:70,stroke:"#253881")
            @hesaplarim_title =title "Hesaplarım"
            @hesaplarim_title.style(size:18,left:80,stroke:"#FBFBFB",margin_top:25)
            @hesaplarim.hover do
              @hesaplarim.style(fill:"#FFF")
              @hesaplarim_title.style(stroke:"#1F283E")
            end
            @hesaplarim.leave do
              @hesaplarim.style(fill:"#1F283E")
              @hesaplarim_title.style(stroke:"#FBFBFB")
            end

            @hesap_ac=rect 5, 5, 275,50,15
            @hesap_ac.style(top:135,stroke:"#253881")
            @hesap_ac_title=title "Hesap Aç"
            @hesap_ac_title.style(size:18,left:80,stroke:"#FBFBFB",margin_top:25)
            @hesap_ac.hover do
              @hesap_ac.style(fill:"#FFF")
              @hesap_ac_title.style(stroke:"#1F283E")
            end
            @hesap_ac.leave do
              @hesap_ac.style(fill:"#1F283E")
              @hesap_ac_title.style(stroke:"#FBFBFB")
            end

            @islemler=rect 5, 5, 275,50,15
            @islemler.style(top:200,stroke:"#253881")
            @islemler_title=title "İşlemler",size:18,left:90,stroke:"#FBFBFB",margin_top:25
            @islemler.hover do
              @islemler.style(fill:"#FFF")
              @islemler_title.style(stroke:"#1F283E")
            end
            @islemler.leave do
              @islemler.style(fill:"#1F283E")
              @islemler_title.style(stroke:"#FBFBFB")
            end

            @eposta=rect 5, 5, 275,50,15
            @eposta.style(top:260,stroke:"#253881")
            @eposta_title=title "E-posta gönder"
            @eposta_title.style(size:18,left:70,stroke:"#FBFBFB",margin_top:25)
            @eposta.hover do
              @eposta.style(fill:"#FFF")
              @eposta_title.style(stroke:"#1F283E")
            end
            @eposta.leave do
              @eposta.style(fill:"#1F283E")
              @eposta_title.style(stroke:"#FBFBFB")
            end

            @cikis=rect 5, 5, 275,50,15
            @cikis.style(top:320,stroke:"#253881")
            @cikis_title=title "Çıkış"
            @cikis_title.style(size:18,left:120,stroke:"#FBFBFB",margin_top:20)
            @cikis.hover do
              @cikis.style(fill:"#FFF")
              @cikis_title.style(stroke:"#1F283E")
            end
            @cikis.leave do
              @cikis.style(fill:"#1F283E")
              @cikis_title.style(stroke:"#FBFBFB")
            end
          end


          @anasayfa.click do
            @anasayfa.style(stroke:"#FFF")
            @hesaplarim.style(stroke:"#253881")
            @hesap_ac.style(stroke:"#253881")
            @islemler.style(stroke:"#253881")
            @eposta.style(stroke:"#253881")
            @home.clear do
              @home=stack width:1100, height:700, left:300 do
                page = Nokogiri::HTML(open("http://bigpara.hurriyet.com.tr/doviz/"))
                header= page.css("div[class='tBody']")
                ul=header.css("ul")
                list=ul[0...10]
                stack width:950,height:50,top:60,left:50 do
                  background "#1F283E"
                  para "Döviz Cinsi",left:20,stroke:"#FFF",top:10,weight:"300",size:15
                  para "Alış",left:310,stroke:"#FFF",top:10,weight:"300",size:15
                  para "Satış",left:530,stroke:"#FFF",top:10,weight:"300",size:15
                  para "Değişim",left:820,stroke:"#FFF",top:10,weight:"300",size:15
                end
                top=110
                i=0
                for index in list
                  if i%2==0
                    stack width:950,height:50,top:top,left:50 do
                      para "#{index.css("li")[0].text}",left:20,stroke:"#FFF",top:10,weight:200,size:12
                      para "#{index.css("li")[2].text}",left:310,stroke:"#FFF",top:10,weight:200,size:12
                      para "#{index.css("li")[3].text}",left:530,stroke:"#FFF",top:10,weight:200,size:12
                      para "#{index.css("li")[4].text}",left:820,stroke:"#FFF",top:10,weight:200,size:12
                    end
                  else
                    stack width:950,height:50,top:top,left:50 do
                      background "#1F283E"
                      para "#{index.css("li")[0].text}",left:20,stroke:"#FFF",top:10,weight:200,size:12
                      para "#{index.css("li")[2].text}",left:310,stroke:"#FFF",top:10,weight:200,size:12
                      para "#{index.css("li")[3].text}",left:530,stroke:"#FFF",top:10,weight:200,size:12
                      para "#{index.css("li")[4].text}",left:820,stroke:"#FFF",top:10,weight:200,size:12
                    end
                  end
                  top+=50
                  i+=1
                end
              end
            end
          end

          @hesaplarim.click do
            @hesaplarim.style(stroke:"#FFF")
            @anasayfa.style(stroke:"#253881")
            @hesap_ac.style(stroke:"#253881")
            @islemler.style(stroke:"#253881")
            @eposta.style(stroke:"#253881")
            @home.clear do
                background "#1B2136"
              @db = SQLite3::Database.open 'user.db'
              user = @db.execute "SELECT * FROM user WHERE kullanici_ad=\"#{kullanici_adi}\""
              query=@db.execute "SELECT * FROM hesap WHERE tc=\"#{user[0][0]}\""
              if query.length ==1
                  stack width:500,height:200,left:25,top:50 do
                    image "images/kart.PNG",width:500
                    para "#{query[0][0]} Hesap",size:18,top:75,left:17,stroke:"#FFF",family:"Days",weight:"200"
                    para "#{query[0][5]}",size:18,top:75,left:400,stroke:"#FFF",family:"Days",weight:"200"
                    para "#{query[0][3]} #{query[0][4]}",size:18,top:130,left:17,stroke:"#FFF",family:"Days",weight:"200"
                    para "#{query[0][1]}",size:18,top:130,left:400,stroke:"#FFF",family:"Days",weight:"200",right:40
                  end
              elsif query.length>1
                top=50
                for i in 0..query.length-1
                  if i %2 ==0
                    stack width:500,height:200,left:25,top:top do
                      image "images/kart.PNG",width:500
                      para "#{query[i][0]} Hesap",size:18,top:75,left:17,stroke:"#FFF",family:"Days",weight:"200"
                      para "#{query[i][5]}",size:18,top:75,left:400,stroke:"#FFF",family:"Days",weight:"200"
                      para "#{query[i][3]} #{query[0][4]}",size:18,top:130,left:17,stroke:"#FFF",family:"Days",weight:"200"
                      para "#{query[i][1]}",size:18,top:130,left:400,stroke:"#FFF",family:"Days",weight:"200",right:40
                    end
                  else
                    stack width:500,height:200,left:550,top:top do
                      image "images/kart.PNG",width:500
                      para "#{query[i][0]} Hesap",size:18,top:75,left:17,stroke:"#FFF",family:"Days",weight:"200"
                      para "#{query[i][5]}",size:18,top:75,left:400,stroke:"#FFF",family:"Days",weight:"200"
                      para "#{query[i][3]} #{query[0][4]}",size:18,top:130,left:17,stroke:"#FFF",family:"Days",weight:"200"
                      para "#{query[i][1]}",size:18,top:130,left:400,stroke:"#FFF",family:"Days",weight:"200",right:40
                    end
                    top+=210
                  end
                end
              else
                para "Hesabınız Bulunmaktadır.",align:"center",size:30,family:"ubuntu",weight:300,top:250,stroke:"#FFF"
              end
            end

          end


          @hesap_ac.click do
            @hesap_ac.style(stroke:"#FFF")
            @anasayfa.style(stroke:"#253881")
            @hesaplarim.style(stroke:"#253881")
            @islemler.style(stroke:"#253881")
            @eposta.style(stroke:"#253881")
            @home.clear do
                title "Fırsatlardan yaralanmak için hemen\n    yeni bir hesap aç.",size:20,stroke:"#FFF",top:18,align:"center"

              stack width:450,height:250,left:50,top:150 do
                fill "#1572E8"
                rect 5, 5,440,200,25
                para "Vadeli\nHesap Aç",stroke:"#FFF",size:25,:family=>"ubuntu",align:"center",top:15
                but=rect 0,0,150,50,15
                but.style(left:140,top:130,fill:"#FFF")
                title "Hesap Aç",size:18,left:160,top:138,stroke:"#262626"
                but.click do
                  hesap_ac("vadeli",kullanici_adi)
                end
              end

              stack width:450,height:250,left:550,top:150 do
                fill "#48ABF7"
                rect 5, 5,440,200,25
                para "Faizli\nHesap Aç",stroke:"#FFF",size:25,:family=>"ubuntu",align:"center",top:15
                but=rect 0,0,150,50,15
                but.style(left:150,top:130,fill:"#FFF")
                title "Hesap Aç",size:18,left:170,top:138,stroke:"#262626"
                but.click do
                  hesap_ac("faizli",kullanici_adi)
                end
              end
              stack width:970,height:200,left:50,top:20 do
                fill "#1F283E"
                bilgi_paneli=rect 5, 5, 950,100,10
                title "Fırsatlardan yaralanmak için hemen\n    yeni bir hesap aç.",size:20,stroke:"#FFF",top:18,align:"center"
              end
              stack width:450,height:250,left:50,top:400 do
                fill "#31CE36"
                rect 5, 5,440,200,25
                para "Döviz\nHesabı Aç",stroke:"#FFF",size:25,:family=>"ubuntu",align:"center",top:15
                but=rect 0,0,150,50,15
                but.style(left:140,top:130,fill:"#FFF")
                title "Hesap Aç",size:18,left:160,top:138,stroke:"#262626"
                but.click do
                  hesap_ac("doviz",kullanici_adi)
                end
              end

              stack width:450,height:250,left:550,top:400 do
                fill "#6861CE"
                rect 5, 5,440,200,25
                para "Vadesiz\nHesap Aç",stroke:"#FFF",size:25,:family=>"ubuntu",align:"center",top:15
                but=rect 0,0,150,50,15
                but.style(left:150,top:130,fill:"#FFF")
                title "Hesap Aç",size:18,left:170,top:138,stroke:"#262626"
                but.click do
                  hesap_ac("vadesiz",kullanici_adi)
                end
              end
            end
          end

          @islemler.click do
            @islemler.style(stroke:"#FFF")
            @anasayfa.style(stroke:"#253881")
            @hesaplarim.style(stroke:"#253881")
            @hesap_ac.style(stroke:"#253881")
            @eposta.style(stroke:"#253881")
            @home.clear do
              stack width:990,height:80,left:50,top:50 do
                fill "#007bff"
                rect 5, 5,980,70,25
                para "Hesabıma Para yatır",size:18,stroke:"#FFF",weight:200,family:"ubuntu",left:15,top:20
                button=rect 5, 5,150,50,15
                button.style(left:800,top:15,fill:"#DBDCDF")
                title "Para Yatır",size:15,left:820,top:25,stroke:"#262626"
                button.click do
                  window width:550,height:380,title:"Para Yatırma" do
                    background "#1B2136"
                    nesne2=rect 0,0,470,400,30
                    nesne2.style(left:180,fill:"#1F283E")

                    @db = SQLite3::Database.open 'user.db'
                    user = @db.execute "SELECT * FROM user WHERE kullanici_ad=\"#{kullanici_adi}\""
                    query=@db.execute "SELECT * FROM hesap WHERE tc=\"#{user[0][0]}\""
                    list=[]
                    for i in query
                      tutucu="#{i[0]} | #{i[5]} | #{i[1]}"
                      list.push(tutucu)
                    end
                    title "Hesap",top:50,left:20,size:20,stroke:"#FFF"
                    hesap=list_box items: list,top:50,left:260,width:250
                    title "Para miktarı",top:150,left:20,size:20,stroke:"#FFF"
                    para=edit_line width:250,top:150,left:230,height:40

                    yatir=rect 0,0,150,50,25
                    iptal=rect 0,0,150,50,25
                    iptal.style(top:280,left:200,fill:"#EB0F01")
                    yatir.style(top:280,left:370,fill:"#6BD406")
                    title "İptal",size:20,stroke:"#FFF",left:240,top:285
                    title "Yatır",size:20,stroke:"#FFF",left:405,top:285

                    iptal.click do
                      close
                    end
                    yatir.click do
                      for i in list
                        if i == hesap.text
                          hesap_no=query[list.index(i)][5]
                          hesap_parasi=query[list.index(i)][1].to_f
                          @db.execute "UPDATE hesap SET para_miktari='#{hesap_parasi+para.text.to_f}' WHERE hesap_no='#{hesap_no}'"
                          alert("Para Hesaba Yatırıldı.")
                          close
                          break
                        end
                      end
                    end

                  end
                end
              end
              stack width:990,height:80,left:50,top:150 do
                fill "#007bff"
                rect 5, 5,980,70,25
                para "Hesabımdan Para Çek",size:18,stroke:"#FFF",weight:200,family:"ubuntu",left:15,top:20
                button=rect 5, 5,150,50,15
                button.style(left:800,top:15,fill:"#DBDCDF")
                title "Para Çek",size:15,left:830,top:25,stroke:"#262626"
                button.click do
                  window width:550,height:380,title:"Para Çekme" do
                    background "#1B2136"
                    nesne2=rect 0,0,470,400,30
                    nesne2.style(left:180,fill:"#1F283E")

                    @db = SQLite3::Database.open 'user.db'
                    user = @db.execute "SELECT * FROM user WHERE kullanici_ad=\"#{kullanici_adi}\""
                    query=@db.execute "SELECT * FROM hesap WHERE tc=\"#{user[0][0]}\""
                    list=[]
                    for i in query
                      tutucu="#{i[0]} | #{i[5]} | #{i[1]}"
                      list.push(tutucu)
                    end
                    title "Hesap",top:50,left:20,size:20,stroke:"#FFF"
                    hesap=list_box items: list,top:50,left:260,width:250
                    title "Para miktarı",top:150,left:20,size:20,stroke:"#FFF"
                    para=edit_line width:250,top:150,left:230,height:40

                    cek=rect 0,0,150,50,25
                    iptal=rect 0,0,150,50,25
                    iptal.style(top:280,left:200,fill:"#EB0F01")
                    cek.style(top:280,left:370,fill:"#6BD406")
                    title "İptal",size:20,stroke:"#FFF",left:240,top:285
                    title "Çek",size:20,stroke:"#FFF",left:415,top:285

                    iptal.click do
                      close
                    end
                    cek.click do
                      for i in list
                        if i == hesap.text
                          hesap_no=query[list.index(i)][5]
                          hesap_parasi=query[list.index(i)][1].to_f
                          mevduat=query[list.index(i)][0]
                          if mevduat=="vadeli"
                            alert("Vadeli hesabınızdan para çekerseniz vadesi bozulacaktır.")
                          end
                          if hesap_parasi >0
                            if hesap_parasi-para.text.to_f >0
                            @db.execute "UPDATE hesap SET para_miktari='#{hesap_parasi-para.text.to_f}' WHERE hesap_no='#{hesap_no}'"
                              alert("Para Çekildi.")
                              close
                            else
                              alert("Sadece #{hesap_parasi} kadar para çekebilirsiniz.")
                            end
                          else
                            alert("Bakiye Yetersiz.")
                          end
                          break
                        end
                      end
                    end

                  end
                end
              end

              stack width:990,height:80,left:50,top:250 do
                fill "#007bff"
                rect 5, 5,980,70,25
                para "Hesaplar Arası Transfer",size:18,stroke:"#FFF",weight:200,family:"ubuntu",left:15,top:20
                button=rect 5, 5,150,50,15
                button.style(left:800,top:15,fill:"#DBDCDF")
                title "Transfer",size:15,left:830,top:25,stroke:"#262626"
                button.click do
                  window width:550,height:440,title:"Hesaplar Arası Transfer" do
                    background "#1B2136"
                    nesne2=rect 0,0,550,450,30
                    nesne2.style(left:200,fill:"#1F283E")

                    @db = SQLite3::Database.open 'user.db'
                    user = @db.execute "SELECT * FROM user WHERE kullanici_ad=\"#{kullanici_adi}\""
                    query=@db.execute "SELECT * FROM hesap WHERE tc=\"#{user[0][0]}\""
                    list=[]
                    for i in query
                      tutucu="#{i[0]} | #{i[5]} | #{i[1]}"
                      list.push(tutucu)
                    end
                    title "Gonderecek Hesap",top:50,left:20,size:14,stroke:"#FFF"
                    gonderecek_hesap=list_box items: list,top:50,left:260,width:250

                    title "Alacak Hesap",top:150,left:20,size:14,stroke:"#FFF"
                    alacak_hesap=list_box items: list,top:150,left:260,width:250

                    title "Para miktarı",top:250,left:20,size:14,stroke:"#FFF"
                    para=edit_line width:190,top:250,left: 230,height:40

                    transfer=rect 0,0,150,50,25
                    iptal=rect 0,0,150,50,25
                    iptal.style(top:335,left:210,fill:"#EB0F01")
                    transfer.style(top:335,left:380,fill:"#6BD406")
                    title "İptal",size:20,stroke:"#FFF",left:250,top:340
                    title "Transfer",size:20,stroke:"#FFF",left:410,top:340

                    iptal.click do
                      close
                    end

                    transfer.click do
                      if para.text.length ==0
                        alert("Transfer edilecek para miktarını girin.")
                      else
                        if gonderecek_hesap.text == alacak_hesap.text
                          alert("Gönderen hesap ile alıcı hesap aynı olamaz.")
                        else
                          gonderecek_hesap_no=""
                          alacak_hesap_no=""
                          gonderen_para=0
                          alan_para=0
                          for i in list
                            if i == gonderecek_hesap.text
                              gonderecek_hesap_no=query[list.index(i)][5]
                              gonderen_para=query[list.index(i)][1].to_f
                            elsif i == alacak_hesap.text
                              alacak_hesap_no=query[list.index(i)][5]
                              alan_para=query[list.index(i)][1].to_f
                            end
                          end
                          if gonderen_para-para.text.to_f >=0
                            @db.execute "UPDATE hesap SET para_miktari='#{gonderen_para-para.text.to_f}' WHERE hesap_no='#{gonderecek_hesap_no}'"
                            @db.execute "UPDATE hesap SET para_miktari='#{alan_para+para.text.to_f}' WHERE hesap_no='#{alacak_hesap_no}'"
                            alert("Transfer tamamlandı.")
                            close
                          else
                            alert("Sadece #{gonderen_para} kadar transfer yapabilirsiniz.")
                          end
                        end
                      end
                    end
                  end
                end
              end

              stack width:990,height:80,left:50,top:350 do
                fill "#007bff"
                rect 5, 5,980,70,25
                para "Başka Hesaba Transfer",size:18,stroke:"#FFF",weight:200,family:"ubuntu",left:15,top:20
                button=rect 5, 5,150,50,15
                button.style(left:800,top:15,fill:"#DBDCDF")
                title "Transfer",size:15,left:830,top:25,stroke:"#262626"
                button.click do
                  window width:550,height:440,title:"Başka Hesaba Transfer" do
                    background "#1B2136"
                    nesne2=rect 0,0,550,450,30
                    nesne2.style(left:200,fill:"#1F283E")

                    @db = SQLite3::Database.open 'user.db'
                    user = @db.execute "SELECT * FROM user WHERE kullanici_ad=\"#{kullanici_adi}\""
                    query=@db.execute "SELECT * FROM hesap WHERE tc=\"#{user[0][0]}\""
                    list=[]
                    for i in query
                      tutucu="#{i[0]} | #{i[5]} | #{i[1]}"
                      list.push(tutucu)
                    end

                    title "Hesap",top:50,left:20,size:14,stroke:"#FFF"
                    hesap=list_box items: list,top:50,left:260,width:250

                    title "Para miktarı",top:150,left:20,size:14,stroke:"#FFF"
                    para=edit_line width:190,top:150,left: 230,height:40

                    title "Alıcı hesap no",top:250,left:20,size:14,stroke:"#FFF"
                    transfer_hesabi=edit_line width:190,top:250,left: 230,height:40

                    transfer=rect 0,0,150,50,25
                    iptal=rect 0,0,150,50,25
                    iptal.style(top:335,left:210,fill:"#EB0F01")
                    transfer.style(top:335,left:380,fill:"#6BD406")
                    title "İptal",size:20,stroke:"#FFF",left:250,top:340
                    title "Transfer",size:20,stroke:"#FFF",left:425,top:340


                    iptal.click do
                      close
                    end

                    transfer.click do
                      karsi_hesap=@db.execute "SELECT * FROM hesap WHERE hesap_no=\"#{transfer_hesabi.text}\""
                      if karsi_hesap.length > 0
                        if query[0][5] == karsi_hesap[0][5]
                          alert("Bu panelden kendi hesabınıza para yollayamazsınız.")
                        else
                          for i in list
                            if i == hesap.text
                              hesap_no=query[list.index(i)][5]
                              hesap_parasi=query[list.index(i)][1].to_f
                              karsi_hesap_para=karsi_hesap[0][1].to_f
                              if hesap_parasi >0
                                if hesap_parasi-para.text.to_f >0
                                  @db.execute "UPDATE hesap SET para_miktari='#{hesap_parasi-para.text.to_f}' WHERE hesap_no='#{hesap_no}'"
                                  @db.execute "UPDATE hesap SET para_miktari='#{karsi_hesap_para+para.text.to_f}' WHERE hesap_no='#{karsi_hesap[0][5]}'"
                                  alert("Para transfer edildi.")
                                  close
                                else
                                  alert("Sadece #{hesap_parasi} kadar para transfer edebilirsiniz.")
                                end
                              else
                                alert("Bakiye Yetersiz.")
                              end
                              break
                            end
                          end
                        end
                      else
                        alert("Hesap no ile eşleşen bir hesap bulunamadı.")
                      end
                    end
                  end
                end
              end
            end
          end

          @eposta.click do
            @eposta.style(stroke:"#FFF")
            @anasayfa.style(stroke:"#253881")
            @hesaplarim.style(stroke:"#253881")
            @hesap_ac.style(stroke:"#253881")
            @islemler.style(stroke:"#253881")
            @db = SQLite3::Database.open 'user.db'
            user = @db.execute "SELECT * FROM user WHERE kullanici_ad=\"#{kullanici_adi}\""
            query=@db.execute "SELECT * FROM hesap WHERE tc=\"#{user[0][0]}\""
            mesaj=""
            for i in query
              mesaj+="Hesap türü: "+i[0].to_s+"\n"+"Hesap no: "+i[5].to_s+"\n"+"Hesap bakiyesi: "+i[1].to_s+"\n\n"
            end
            require_relative 'mail_api'
            mail=Mail_yolla.new
            mail.mail mesaj
          end

          @cikis.click do
            @cikis.style(stroke:"#FFF")
            close
          end
        end
      end

      def hesap_ac(category,kullanici_adi)
        @db = SQLite3::Database.open 'user.db'
        query = @db.execute "SELECT * FROM user WHERE kullanici_ad=\"#{kullanici_adi}\""
        hesap_no=rand(1000...9999)
        window title:category+" hesap aç",width:550,height:430 do
          background "#1B2136"
          nesne2=rect 0,0,600,430,30
          nesne2.style(left:180,fill:"#1F283E")

          title "Tc          \t\t" +query[0][0] ,size:20,left:20,weight:100,top:20,stroke:"#FFF"
          title "İsim        \t\t" +query[0][1] ,size:20,left:20,weight:100,top:70,stroke:"#FFF"
          title "Soyisim     \t " +query[0][2] ,size:20,left:20,weight:100,top:120,stroke:"#FFF"
          title "e-mail      \t " +query[0][3] ,size:20,left:20,weight:100,top:170,stroke:"#FFF"
          title "Kullanıcı adı\t " +query[0][4] ,size:20,left:20,weight:100,top:220,stroke:"#FFF"
          title "Hesap no    \t "+hesap_no.to_s,size:20,left:20,weight:100,top:270,stroke:"#FFF"
          olustur=rect 0,0,150,50,25
          iptal=rect 0,0,150,50,25
          iptal.style(top:350,left:190,fill:"#EB0F01")
          olustur.style(top:350,left:380,fill:"#6BD406")
          title "İptal",size:20,stroke:"#FFF",left:225,top:355
          title "Oluştur",size:20,stroke:"#FFF",left:410,top:355
          iptal.click do
            close
          end
          olustur.click do
            @db = SQLite3::Database.open 'user.db'
            @db.execute "CREATE TABLE IF NOT EXISTS hesap(hesap_tur TEXT,para_miktari REAL,tc TEXT,ad TEXT,soyad TEXT,hesap_no TEXT)"
            @db.execute "INSERT INTO hesap (hesap_tur,para_miktari,tc, ad , soyad,hesap_no) VALUES ('#{category}','#{0}','#{query[0][0]}','#{query[0][1]}','#{query[0][2]}','#{hesap_no}')"
            alert("Hesap oluşturuldu.")
            close
          end
        end
      end
      @home=stack width:1100, height:700, left:300 do
        page = Nokogiri::HTML(open("http://bigpara.hurriyet.com.tr/doviz/"))
        header= page.css("div[class='tBody']")
        ul=header.css("ul")
        list=ul[0...10]
        stack width:950,height:50,top:60,left:50 do
          background "#1F283E"
          para "Döviz Cinsi",left:20,stroke:"#FFF",top:10,weight:"300",size:15
          para "Alış",left:310,stroke:"#FFF",top:10,weight:"300",size:15
          para "Satış",left:530,stroke:"#FFF",top:10,weight:"300",size:15
          para "Değişim",left:820,stroke:"#FFF",top:10,weight:"300",size:15
        end
        top=110
        i=0
        for index in list
          if i%2==0
            stack width:950,height:50,top:top,left:50 do
              para "#{index.css("li")[0].text}",left:20,stroke:"#FFF",top:10,weight:200,size:12
              para "#{index.css("li")[2].text}",left:310,stroke:"#FFF",top:10,weight:200,size:12
              para "#{index.css("li")[3].text}",left:530,stroke:"#FFF",top:10,weight:200,size:12
              para "#{index.css("li")[4].text}",left:820,stroke:"#FFF",top:10,weight:200,size:12
            end
          else
            stack width:950,height:50,top:top,left:50 do
              background "#1F283E"
              para "#{index.css("li")[0].text}",left:20,stroke:"#FFF",top:10,weight:200,size:12
              para "#{index.css("li")[2].text}",left:310,stroke:"#FFF",top:10,weight:200,size:12
              para "#{index.css("li")[3].text}",left:530,stroke:"#FFF",top:10,weight:200,size:12
              para "#{index.css("li")[4].text}",left:820,stroke:"#FFF",top:10,weight:200,size:12
            end
          end
          top+=50
          i+=1
        end
      end
    end
  end
end
