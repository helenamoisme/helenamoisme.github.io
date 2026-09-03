# 把这个网站上传到 GitHub：最小 Git 教程

这份教程只讲完成这件事所需的 Git：保存版本、上传到 GitHub，以及在 VS Code 中操作。

## 先理解四个位置

可以把 Git 想成给代码拍“可回到过去的存档”。文件会依次经过：

```text
工作区（正在编辑的文件）
        ↓ git add
暂存区（准备写进下一次存档的文件清单）
        ↓ git commit
本地仓库（电脑里的正式存档）
        ↓ git push
GitHub 远程仓库（网上的备份与展示）
```

- **工作区**：VS Code 里正在修改的 `index.html`、`styles.css` 等文件。
- **暂存区**：可以理解为“这次要保存哪些改动”的购物篮。`git add` 只是放进篮子，不会真正产生版本。
- **提交（commit）**：把暂存区内容做成一个带说明的版本快照，保存在电脑里。
- **推送（push）**：把电脑里的提交上传到 GitHub。

> `git status` 是最常用的检查命令；不知道现在该做什么时，先运行它。

## 第一次上传本网站

### 1. 在 GitHub 创建仓库

登录 GitHub，点击右上角 **+ → New repository**。

- Repository name 填 `<你的用户名>.github.io`。例如用户名是 `helena-he`，就填 `helena-he.github.io`。
- 选择 **Public**。
- 不要勾选 “Add a README file”，因为本地已经有文件。
- 点击 **Create repository**。

这个特别命名的仓库会自动成为个人主页，地址是 `https://<你的用户名>.github.io`。

### 2. 在 VS Code 打开本项目

在 VS Code 选择 **File → Open Folder…**，打开这个文件夹：

```text
/Users/mohe/Documents/ChatGPT/helena personal website
```

左侧第三个图标是 **Source Control（源代码管理）**；它会列出所有尚未保存为版本的文件。

### 3. add：把这次要上传的文件放进暂存区

在 VS Code 的 Source Control 面板中，点击文件右侧的 **+**；全部都要加入时点击 Changes 一行右侧的 **+**。

命令行对应写法：

```bash
git add index.html styles.css README.md GIT_入门.md
```

想把当前文件夹的全部改动加入暂存区，可以用：

```bash
git add .
```

然后执行 `git status`。看到 `Changes to be committed` 就代表文件已经在暂存区。

### 4. commit：在电脑里创建一个版本

在 VS Code 的 Source Control 面板上方输入说明，例如 `发布个人主页初版`，然后点击 **Commit**。

命令行对应写法：

```bash
git commit -m "发布个人主页初版"
```

提交说明写“做了什么”即可，例如 `更新个人简介和项目`。不要写过于笼统的 `update`。

### 5. 连接 GitHub 并 push：上传

首次使用 VS Code 时，点击左下角 Accounts 图标，选择 **Sign in with GitHub**，在浏览器确认授权后回到 VS Code。

然后回到 GitHub 新仓库页面，复制它提供的 HTTPS 地址，形如：

```text
https://github.com/<你的用户名>/<你的用户名>.github.io.git
```

在 VS Code 的终端（Terminal → New Terminal）执行以下两行。把尖括号部分替换成真实用户名：

```bash
git remote add origin https://github.com/<你的用户名>/<你的用户名>.github.io.git
git push -u origin main
```

也可以在 Source Control 面板点击 **Publish Branch / 发布分支**，按提示选择 GitHub；它会自动完成连接和第一次推送。

推送完成后，等待一两分钟，打开 `https://<你的用户名>.github.io` 查看网站。

## 以后改完网站的固定流程

每次修改照片、简介或项目后，只需重复：

```bash
git status
git add .
git commit -m "更新个人简介"
git push
```

`git status` 没有列出文件时，说明没有尚未提交的改动。

## 最简单的分支概念

**分支**就是一条独立的修改路线。`main` 是已经发布、相对稳定的网站；想尝试大改版时，在新分支修改，就不会影响 `main`。

```bash
git switch -c redesign      # 创建并切换到名为 redesign 的分支
# 修改并照常 add、commit
git switch main             # 回到稳定版本
```

刚开始时只需要在 `main` 上维护这个网站。等你想尝试新版布局时，再创建分支即可。

## 两个容易混淆的点

- `commit` **不会**上传网页，它只把版本保存到本机；只有 `push` 才会传到 GitHub。
- 如果不小心 `git add` 了某个文件，可以撤出暂存区，文件本身不会被删除：

```bash
git restore --staged 文件名
```
