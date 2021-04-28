Pod::Spec.new do |s|

  s.name         = "WMZPageController"
  s.version      = "1.3.7"
  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.license      = "Copyright (c) 2019年 WMZ. All rights reserved."
  s.summary      = "高性能分页控制器,支持ios13暗黑模式"
  s.description  = <<-DESC 
                    替换UIPageController方案,具备完整的生命周期,多种指示器样式,多种标题样式,可悬浮,支持ios13暗黑模式(仿优酷,爱奇艺,今日头条,简书,京东等多种标题菜单)
                   DESC
  s.homepage     = "https://github.com/wwmz/WMZPageController"
  s.license      = {:type => "MIT", :file => "LICENSE" }
  s.author       = { "wmz" => "925457662@qq.com" }
  s.source       = { :git => "https://github.com/wwmz/WMZPageController.git",:tag => s.version.to_s}
  s.source_files = "WMZPageController/WMZPageController/**/*.{h,m}"
  s.resources     = "WMZPageController/WMZPageController/DataSource/PageController.bundle"
end
