# iOS-Repository-Template
이 레포지토리는 iOS 프로젝트에 사용하기 위한 템플릿 레포지토리입니다.

## 템플릿 사용 방법

아래의 세가지 방법 중 하나를 선택하여 사용하시면 됩니다.

### 방법 1. Fork해서 사용하기

1. 이 Repository를 Fork한다.
2. [New](https://github.com/new) 버튼을 눌러서 새 Repository를 생성한다.
3. Repository Template에서 이 Repository Template을 선택한다.

### 방법 2. Fork 없이 사용하기

1. [Use this template](https://github.com/taek0622/iOS-Repository-Template/generate) 버튼을 눌러서 새 Repository를 만든다.

### 방법 3. Github Template 없이 사용하기 (비추천)

1. 이 Repository를 클론한다.

   `git clone https://github.com/taek0622/iOS-Repository-Template.git`

2. 숨겨져있는 `.git` 디렉토리를 찾아 삭제한다.

   `rm -rf .git`

3. 새로운 깃 Repository를 생성한다.

   `git init`

4. 첫번째 commit을 생성한다.

   `git commit -a -m "Initial commit"`
   
## .gitmessage 사용 방법

- 프로젝트를 Clone 받은 후 터미널 상에서 프로젝트 경로로 들어가서 아래의 명령어를 사용하여 `.gitmessage` 사용
```shell
git config --global commit.template .github/.gitmessage
```
- 위의 명령어 실행 후 `git commit`을 할 때는 아래와 같이 사용할 수 있음
<img width="802" alt="스크린샷 2022-08-07 18 10 05" src="https://user-images.githubusercontent.com/81027256/183284158-9ef715a0-4045-487b-8441-c3b8b2cf7547.png">
<img width="922" alt="스크린샷 2022-08-07 18 10 14" src="https://user-images.githubusercontent.com/81027256/183284160-229ebf0e-d5f0-4353-8c58-7af44e0b0107.png">
<img width="922" alt="스크린샷 2022-08-07 18 11 12" src="https://user-images.githubusercontent.com/81027256/183284179-438d0f7b-cbd9-4816-90de-57b1f94f8b2e.png">
<img width="810" alt="스크린샷 2022-08-07 18 11 22" src="https://user-images.githubusercontent.com/81027256/183284284-d84b54ab-49f9-485d-9531-b1c5a3b5d92e.png">

## 사용 가능한 범위
- Repository Template을 사용했을 때, 복사되는 범위는 현재 프로젝트의 디렉토리 및 구조, 브랜치 등까지 입니다. Issue나 Pull request의 Labels, Wiki, Project, Actions 등은 복사되지 않습니다.
