# ImageViewerProject
sk 채용과제 이미지 load 프로젝트

## 1. 📋 Project Summary
### Goal
1. iOS14 / Xcode 13 or Xcode 14
2. Grid Image or Image + Info List 등 자유 디자인
3. pull to refresh or infinite scroll
4. Author 기반 검색(이미 받아온 List내에서 검색)
5. 자동완성 기능
6. Memory Cache or Disk Cache
7. Image + model Info 기반 UI

### 제한사항
1. Open Source 사용 불가 (RxSwift만 사용 가능)
2. RxSwift or Combine 사용 필수
3. UIKit Native(RxCocoa사용불가) or SwiftUI 자유선택 (SwiftUI 가점)
4. MVVM (Test Code 가점)


### Requirements
- Xcode 14.0~
- iOS 16.0~

------------

## 2. 🗓 Planning
<img width="940" alt="SK_Schedule" src="https://github.com/YerinaOh/DunamuSubject/assets/25735293/586f716f-7a9c-4912-96f5-315d249487ba">
------------

## 3. 🖇 Data Architecture 구성도
<img width="899" alt="SK_Architecture" src="https://github.com/YerinaOh/DunamuSubject/assets/25735293/115c7afe-f173-42b3-89dd-a918ac51b6a2">

### 아키텍처 구조
- Repository: API 통신, Network를 담당하는 레이어
- Domain: View에 필요한 Data Model, Repository impl
- Presenter: 뷰에 나타날 인터렉션 (input-output)과 바인딩처리를 담당하는 레이어
- Application: 기타 앱에 필요한 life cycle, base 코드와 유틸성 업무를 담당하는 레이어
------------

## 4. 🪜 UI 구성도

### [project 폴더 디렉토리구조 설명]
### 화면의 view 구성
- MainView - image list, searchbar 포함

- DetailView - image 전체화면, author info

### [test 폴더 디렉토리구조 설명]
- ImageAPITestRepository: server api repositoryimpl 을 차용한 test 전용 data repo
- ImageViewerProjectTests: cache request data 가 정상적으로 parsing 되었는지 확인, viewmodel의 function 테스트

------------

## 5. 📏 Design Guideline
- Human Interface Guidelines 규격에 따름
- App Logo icon Guide
- <img width="761" alt="HIG_Logo" src="https://user-images.githubusercontent.com/25735293/156391465-165ee423-5e60-4e04-9e41-374cf732dd8b.png">
- App ToolBar Icon 
- app icon 규격에 따름
- url - https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/system-icons/

------------

## 6. 🕹 환경 대응
|DarkMode|IphoneSE|
|------|------|
|<img width="300" alt="iPhone 14 Pro" src="https://github.com/YerinaOh/DunamuSubject/assets/25735293/98738858-6440-4ef7-a84a-39e0b13314cd">|<img width="300" alt="iPhone SE" src="https://github.com/YerinaOh/DunamuSubject/assets/25735293/c43427fa-7207-43cd-b74f-5dc48947e5a7">|

- 각각 Darkmode 일 경우와 phoneSE와 같은 작은 해상도의 경우 UI이슈 없게끔 수정하였다.

----

## 7. ✏️ GIT COMMIT TAG RULE

> 
>> 'init' : 신규 project 생성 <br>
>> 'add' : 파일 add, class 로직 add <br>
>> 'update' : 파일 수정 <br>
>> 'fix' : 이슈 해결 <br>

