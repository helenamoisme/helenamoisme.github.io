# Helena Personal Website

一个无需构建步骤的静态个人学术主页。

## 本地预览

```bash
python3 -m http.server 4173
```

随后打开 `http://localhost:4173`。

## 发布到 GitHub Pages

1. 创建一个名为 `<你的 GitHub 用户名>.github.io` 的公开仓库。
2. 将 `index.html` 和 `styles.css` 上传到仓库根目录并推送。
3. 在仓库的 **Settings → Pages** 中，选择从 `main` 分支部署。

## 修改内容

在 `index.html` 中替换姓名、简介、学校、项目与论文；将照片链接替换成自己的图片路径（推荐放到 `assets/avatar.jpg`）。同时将 GitHub、LinkedIn、Twitter/X、邮箱及论文链接替换成真实地址。
