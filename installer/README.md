# Thimbleweed Park 한글패치 설치 도구

**현재 버전: v0.1 alpha** — 텍스트 100% 번역은 끝났지만 아직 정식 검수(QA)가
끝나지 않은 초기 버전입니다. 플레이 중 어색한 번역이나 버그를 보시면
이슈로 남겨주세요.

이 패치는 게임 자체를 배포하지 않습니다. `patch/` 폴더에는 번역한 텍스트/폰트/이미지
파일 141개만 들어있고, 나머지 게임 리소스(그래픽/사운드/코드)는 전혀 포함하지
않습니다. 설치 스크립트가 하는 일은:

1. 사용자가 정품으로 갖고 있는 게임의 `ThimbleweedPark.ggpack1`을 백업
2. 그 파일을 로컬에서 압축 해제
3. `patch/` 폴더의 파일로 덮어쓰기 (독일어 슬롯에 한글 텍스트, 폰트에 한글 글리프 추가 등)
4. 다시 압축해서 원래 파일 자리에 교체

정품 게임 파일을 이미 갖고 있는 사람만 패치를 적용할 수 있고, 게임 리소스가
따로 유출/배포되지 않습니다.

설치 후 게임 안에서 **옵션 > 언어(Language) 목록에서 "Korean Text"를
선택하면** 한글로 표시됩니다. (목록에서 원래 "German Text"였던 자리가
"Korean Text"로 바뀌어 있습니다 — 엔진 내부적으로는 독일어 슬롯 데이터를
그대로 쓰기 때문입니다. 이미지 에셋은 그대로 영어를 참조하도록 되어 있어서
그림은 안 바뀌고 텍스트만 한글로 나옵니다.)

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

`installer/windows/ngpack.exe`가 이미 포함되어 있습니다. GitHub Actions의
windows-latest 러너에서 [scemino/ngpack](https://github.com/scemino/ngpack)
(BSD-3-Clause) 소스를 그대로 컴파일한 것입니다 — 빌드 워크플로는
[`.github/workflows/build-ngpack.yml`](../.github/workflows/build-ngpack.yml)에
있습니다. 다만 개발 환경이 Mac이라 이 실행 파일 자체를 실제 Windows에서
직접 실행 테스트는 못 해봤습니다. 문제가 있으면 이슈로 알려주세요.

```
cd installer\windows
install.bat "C:\Program Files (x86)\Steam\steamapps\common\Thimbleweed Park"
```
경로를 안 주면 실행 중에 물어봅니다.

제거:
```
uninstall.bat "C:\Program Files (x86)\Steam\steamapps\common\Thimbleweed Park"
```

`ngpack.exe`를 직접 다시 빌드하고 싶다면 GitHub 저장소의 Actions 탭에서
"Build ngpack binaries" 워크플로를 수동 실행(workflow_dispatch)하면
Windows/Linux 바이너리를 새로 뽑아낼 수 있습니다.

## 참고

- 설치 스크립트는 항상 `ThimbleweedPark.ggpack1.orig`이라는 이름으로 원본을
  백업해둡니다. 이 파일이 있으면 언제든 제거(uninstall) 스크립트로 원상복구할
  수 있습니다.
- 재설치할 때는 기존 백업을 그대로 사용하므로, 이미 패치된 파일 위에 다시
  패치를 씌우는 일은 없습니다.
- `ggpack2`는 이 패치가 건드리지 않습니다.
