# Insta Check Animation

Flutter의 CustomPainter와 Animation을 활용해 인스타그램 스타일의 체크 애니메이션을 구현한 예제입니다.  
체크 아이콘이 원과 함께 그려지며, 선의 두께와 그려지는 타이밍이 애니메이션으로 자연스럽게 표현됩니다.

![demo](https://firebasestorage.googleapis.com/v0/b/instagram-resume.firebasestorage.app/o/post%2Fcheck.gif?alt=media&token=ef4924d5-d3b9-4b98-b72d-acf25a623431)

## ✨ 주요 특징

- **CustomPainter 활용**  
  CustomPainter를 활용하여 원하는 스타일의 원과 체크 모양을 그려 커스텀했습니다.
- **애니메이션 효과**  
  AnimationController와 Interval을 사용해 원, 체크의 각 구간별로 그려지는 타이밍을 세밀하게 조절했습니다.
- **선 두께 애니메이션**  
  원이 그려질 때 선의 두께가 점점 얇아지며, 자연스러운 효과를 연출합니다.
- **그라데이션 컬러**  
  체크와 원에 LinearGradient를 적용해 인스타그램 느낌의 컬러감을 더했습니다.
