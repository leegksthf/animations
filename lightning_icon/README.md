# Lightning Icon (Rounded Thunder Shape)

Flutter의 CustomClipper와 Path의 `quadraticBezierTo`함수를 활용해  
둥근 느낌의 번개 모양을 그리는 예제 프로젝트입니다.

![demo](https://firebasestorage.googleapis.com/v0/b/instagram-resume.firebasestorage.app/o/post%2Flinghtning.png?alt=media&token=9c16be2d-196b-4ddd-b8e7-f1f11381f3ff)

## ✨ 주요 특징

- **CustomClipper 활용**  
  ClipPath와 CustomClipper를 사용해 원하는 번개 모양을 직접 정의할 수 있습니다.
- **부드러운 곡선**  
  Path의 `quadraticBezierTo` 함수를 이용해 각 꼭짓점마다 곡선을 적용하여 각진 번개가 아닌 부드러운 라운드 번개 아이콘을 만들었습니다.
- **재사용 가능한 구조**  
  번개 모양의 포인트와 곡률(radius)만 조정하면 다양한 스타일의 아이콘 제작이 가능합니다.
