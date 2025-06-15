# Wave Animation

Flutter의 CustomClipper와 sin, cos 등 삼각함수를 활용해  
물결 모양을 그리고, 애니메이션으로 자연스럽게 흐르는 효과를 구현한 예제입니다.

![demo](https://firebasestorage.googleapis.com/v0/b/instagram-resume.firebasestorage.app/o/post%2Fwave.gif?alt=media&token=2492c83d-0695-4f17-9c73-23bba5f1f3d4)

## ✨ 주요 특징

- **CustomClipper 활용**  
  ClipPath와 CustomClipper를 사용해 원하는 형태의 물결을 직접 그릴 수 있습니다.
- **삼각함수 기반 곡선**  
  sin, cos 함수를 이용해 물결의 굴곡, 높이, 길이 등을 자유롭게 조절할 수 있습니다.
- **애니메이션 효과**  
  삼각함수의 위상에 AnimationController를 더해  
  물결이 흘러가는 듯한 애니메이션을 구현했습니다.
- **다중 레이어**  
  서로 다른 색상과 파형의 물결을 겹쳐서 더욱 풍부한 시각 효과를 연출했습니다.
