## ManyaBeauty

This is a simple website of author's clothing and accessories built with
[Ruby on Rails](http://rubyonrails.org) and [Rspec](http://rspec.info).

[Twitter Bootstrap](http://getbootstrap.com) framework is used to give the
website a more or less presentable view.

[Bootstrap Image Gallery](https://blueimp.github.io/Bootstrap-Image-Gallery)
extension was used to display photos in modal dialog.

Of course [jQuery](https://jquery.com/) JavaScript library is used on the client
side.

In addition following jQuery plugins are used:

* [OWL Carousel](http://owlgraphic.com/owlcarousel) to make a carousel slider
on the main page of the website.

* [Justified Galley](http://miromannino.github.io/Justified-Gallery) to create
justified gallery of photos.

* [jQuery Mousewheel](https://plugins.jquery.com/mousewheel) by [Brandon Aaron]
(http://brandon.aaron.sh) to fix scrolling in photo modal dialog.

The website has an admin area and all matters related to authentication and
authorization are handled by [Devise](https://github.com/plataformatec/devise)
gem.

[CarrierWave](https://github.com/carrierwaveuploader/carrierwave) gem is used
for photo uploads. Uploaded photos are saved in [Amazon S3]
(http://aws.amazon.com/s3) cloud storage.

## Credits

Sample photos in `lib/assets/images` and `spec/fixtures/files` directories were
taken from [Pixabay](http://pixabay.com). They are licensed under a [CC0 1.0]
(http://creativecommons.org/publicdomain/zero/1.0/) license.

Icons `app/assets/images/flag_russia.png` and `app/assets/images/flag_usa.png`
are included in [Fatcow](http://www.fatcow.com/free-icons) icon set that is
licensed under a [CC BY 3.0](http://creativecommons.org/licenses/by/3.0/)
license.

Icon `app/assets/images/mail.png` is included in [Miu Flat Social]
(http://linhpham.me/social) icon set that is free for personal and commercial
use.

Logo `app/assets/images/tailor-logo.png` is a derivative of
[Vintage tailor symbols]
(http://www.freepik.com/free-vector/vintage-tailor-symbols-set_714459.htm) set
designed by [Freepik](http://www.freepik.com). This set is free for commercial
use.

Icons `app/assets/images/fallback/default.png` and
`app/assets/images/fallback/default-lg.png` are modified versions of original
icon that is included in [Technology and Hardware]
(https://www.iconfinder.com/iconsets/technology-and-hardware-2) icon set
designed by [Maxim Basinski](https://www.iconfinder.com/vasabii). This set is
free for commercial use.

Images in `app/assets/images/carousel` directory are resized versions of
original images from [StockSnap.io](https://stocksnap.io). All photos in that
photo stock are free from copyright restrictions.


## Acknowledgments

Thanks to the talented web designer and my friend [Egor Permyakov]
(https://ru.linkedin.com/in/%D0%B5%D0%B3%D0%BE%D1%80-%D0%BF%D0%B5%D1%80%D0%BC%D1%8F%D0%BA%D0%BE%D0%B2-362733b1)
for his advices on design of this website.
