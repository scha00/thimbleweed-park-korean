# Thimbleweed Park 한글패치 설치 도구

이 패치는 게임 자체를 배포하지 않습니다. `patch/` 폴더에는 번역한 텍스트/폰트/이미지
파일 141개만 들어있고, 나머지 게임 리소스(그래픽/사운드/코드)는 전혀 포함하지
않습니다. 설치 스크립트가 하는 일은:

1. 사용자가 정품으로 갖고 있는 게임의 `ThimbleweedPark.ggpack1`을 백업
2. 그 파일을 로컬에서 압축 해제
3. `patch/` 폴더의 파일로 덮어쓰기 (독일어 슬롯에 한글 텍스트, 폰트에 한글 글리프 추가 등)
4. 다시 압축해서 원래 파일 자리에 교체

정품 게임 파일을 이미 갖고 있는 사람만 패치를 적용할 수 있고, 게임 리소스가
따로 유출/배포되지 않습니다.

설치 후 게임 안에서 **옵션 > 언어를 German으로 바꾸면** 한글로 표시됩니다.
(엔진 내부 사정으로 "German" 슬롯에 번역을 넣었습니다 — 이미지 에셋은 그대로
영어를 참조하도록 되어 있어서 그림은 안 바뀌고 텍스트만 한글로 나옵니다.)

## 게임 폴더(ggpack1 위치) 찾는 법

**Windows (Steam 기준)**
보통 다음 위치에 있습니다:
`C:\Program Files (x86)\Steam\steamapps\common\Thimbleweed Park\`
그 폴더 안에서 `ThimbleweedPark.ggpack1` 파일을 직접 찾아보세요.

**Mac (Steam 기준)**
`~/Library/Application Support/Steam/steamapps/common/Thimbleweed Park/Thimbleweed Park.app`
이 앱을 Finder에서 우클릭 > "패키지 내용 보기"로 열면
`Contents/Resources/` 안에 `ThimbleweedPark.ggpack1`이 있습니다.

GOG판이나 다른 스토어 버전도 폴더 구조는 비슷하니 `ThimbleweedPark.ggpack1`
파일을 직접 찾으면 됩니다.

## Mac에서 설치

```bash
cd installer/mac
chmod +x install.sh uninstall.sh ngpack-tool
./install.sh "/path/to/Thimbleweed Park.app/Contents/Resources"
```

경로를 인자로 안 주면 실행 중에 물어봅니다.

macOS Gatekeeper가 "확인되지 않은 개발자" 경고를 띄우면, 스크립트를
더블클릭하지 말고 **터미널에서 직접 실행**하세요. `ngpack-tool` 바이너리에
대해서만 경고가 뜨면 `xattr -d com.apple.quarantine ngpack-tool`로
격리 속성을 지우면 됩니다.

제거:
```bash
./uninstall.sh "/path/to/Thimbleweed Park.app/Contents/Resources"
```

## Windows에서 설치

Windows용 `ngpack.exe`는 아직 이 저장소에 포함돼 있지 않습니다 (이 프로젝트가
Mac에서 개발되고 있어서, 지금 당장은 Windows용 바이너리를 직접 빌드할 수
없습니다). 아래 둘 중 하나로 준비하세요.

**방법 A: 직접 빌드 (Windows PC + Dart SDK 필요)**
```
1. https://dart.dev/get-dart 에서 Dart SDK 설치
2. git clone https://github.com/scemino/ngpack
3. cd ngpack
4. dart pub get
5. dart compile exe bin/ngpack.dart -o ngpack.exe
6. 만들어진 ngpack.exe를 installer/windows/ 폴더에 복사
```
(원본 `pubspec.yaml`의 `sdk: '>=2.12.0 <3.0.0'` 제약 때문에 최신 Dart에서
`pub get`이 거부되면, 그 줄을 `sdk: '>=2.12.0 <4.0.0'` 정도로 한 줄만 고치면
됩니다. scemino/ngpack은 BSD-3-Clause 라이선스라 이렇게 빌드해서 같이
배포해도 문제 없습니다.)

**방법 B: 나중에 GitHub Actions로 자동 빌드**
저장소를 만들고 CI를 붙이면, windows-latest 러너에서 위 빌드를 자동으로
해서 릴리스에 올릴 수 있습니다. 지금은 로컬 작업 단계라 보류.

`ngpack.exe`가 준비되면:
```
cd installer\windows
install.bat "C:\Program Files (x86)\Steam\steamapps\common\Thimbleweed Park"
```
경로를 안 주면 실행 중에 물어봅니다.

제거:
```
uninstall.bat "C:\Program Files (x86)\Steam\steamapps\common\Thimbleweed Park"
```

## 참고

- 설치 스크립트는 항상 `ThimbleweedPark.ggpack1.orig`이라는 이름으로 원본을
  백업해둡니다. 이 파일이 있으면 언제든 제거(uninstall) 스크립트로 원상복구할
  수 있습니다.
- 재설치할 때는 기존 백업을 그대로 사용하므로, 이미 패치된 파일 위에 다시
  패치를 씌우는 일은 없습니다.
- `ggpack2`는 이 패치가 건드리지 않습니다.
