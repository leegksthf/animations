# Card Gradient Animation

Flutter로 구현한 입체 그라데이션 카드 애니메이션 예제입니다.  
Radial Gradient와 3D 변환, 애니메이션을 활용해 광원 효과와 입체감을 표현했습니다.

![demo](https://firebasestorage.googleapis.com/v0/b/instagram-resume.firebasestorage.app/o/post%2Fcard.gif?alt=media&token=c903c961-09e4-4846-b12f-e3365d92405f)

## ✨ 주요 특징

- **입체감 있는 카드**  
  x, y, z 좌표 Matrix4 변환을 활용해 카드에 3D 회전 효과를 줬습니다.
- **광원 효과**  
  Radial Gradient의 중심 좌표를 애니메이션으로 변화시켜, 빛이 움직이는 듯한 광원 효과를 구현했습니다.
- **애니메이션**  
  AnimationController와 Tween을 활용해 카드의 회전과 그라데이션 이동이 자연스럽게 반복됩니다.
