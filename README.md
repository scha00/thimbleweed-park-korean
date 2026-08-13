# Thimbleweed Park 한글패치

**v0.9 beta** — Thimbleweed Park을 한국어로 즐길 수 있게 해주는 팬 번역
패치입니다. 텍스트 번역은 100% 끝났고, 캐릭터 간 대화 존댓말/반말
일관성 등 대사 검수도 상당 부분 마친 베타 버전입니다. 어색한 번역이나
버그를 발견하시면
[Issues](https://github.com/scha00/thimbleweed-park-korean/issues)에
남겨주세요.

이 저장소에는 게임 리소스가 전혀 포함되어 있지 않습니다. 배포하는 건
번역된 텍스트/폰트/이미지 파일 155개뿐이고, 이 파일들만 담은
`ThimbleweedPark.ggpack4` 하나를 정품 게임 폴더에 복사해 넣으면 됩니다.
번역/에셋 파일 원본은 [`patch/`](patch) 폴더에 개별 파일로 그대로
들어있어서, 특정 줄이 왜 그렇게 번역됐는지 diff로 확인하거나 오역을
고쳐서 PR을 보낼 수 있습니다 — `ThimbleweedPark.ggpack4`는 이 폴더를
그대로 압축한 것뿐입니다.

## 한글화 범위

대사·자막(12,900여 줄), 게임 UI, 노트/수첩/일지 같은 스탠드얼론 텍스트,
폰트 34종은 전부 한글화되어 있습니다. 배경에 그림으로 그려진 텍스트(간판,
낙서, 신문·전단지 등)는 진행에 중요한 화면들과 마을 곳곳의 간판 일부를
번역했고 나머지는 계속 진행 중입니다. Save/Load 화면의
`(casual)`/`(hard)` 표기 등 극소수 시스템 문자열은 게임 엔진 자체 버그로
한글 표시가 안 되어 영어로 남아있습니다.

## 설치 방법

1. [Releases](https://github.com/scha00/thimbleweed-park-korean/releases/latest)에서
   `thimbleweed-park-korean.zip`을 받아 압축을 풉니다.
2. 게임 폴더에서 `ThimbleweedPark.ggpack1`이 있는 위치를 찾습니다.
   - **Windows (Steam)**: `C:\Program Files (x86)\Steam\steamapps\common\Thimbleweed Park\`
   - **Mac (Steam)**: `~/Library/Application Support/Steam/steamapps/common/Thimbleweed Park/Thimbleweed Park.app`를
     Finder에서 우클릭 → "패키지 내용 보기" → `Contents/Resources/`
   - GOG 등 다른 버전도 폴더 구조는 비슷합니다. `ThimbleweedPark.ggpack1`
     파일을 직접 찾으면 됩니다.
3. 압축 푼 `ThimbleweedPark.ggpack4` 파일을 위에서 찾은 `ThimbleweedPark.ggpack1`이
   있는 바로 그 폴더에 복사합니다.
4. 게임을 실행하고 **옵션 > 언어(Language) 목록에서 "Korean Text"를 선택**하면
   한글로 표시됩니다 (원래 "German Text"였던 자리를 대체한 것으로, 내부적으로
   독일어 슬롯을 그대로 사용합니다).

> **항상 최신 버전을 원한다면** Releases까지 안 기다리셔도 됩니다.
> 저장소의 [`install/ThimbleweedPark.ggpack4`](install/ThimbleweedPark.ggpack4)가
> `patch/`가 바뀔 때마다 GitHub Actions로 자동 재빌드되는 파일이라 항상
> 최신 상태예요. 이 파일만 받아서 위 3번처럼 게임 폴더에 복사해도 됩니다.
> Releases는 어느 정도 모여서 나오는 "정식" 버전 스냅샷이고, `install/`
> 쪽이 매 순간의 최신입니다.

`ggpack1`/`ggpack2`는 전혀 건드리지 않습니다. 게임 엔진이 원래
`ggpack3`, `ggpack4`처럼 번호가 이어지는 추가 패키지 파일을 자동으로
얹어서 읽는 기능을 지원해서(공식 "Ransome Uncensored" DLC도 `ggpack3`으로
같은 방식을 씁니다), 그 위에 번역 파일이 담긴 패키지 하나를 얹는 것뿐입니다.

## 제거 방법

게임 폴더에 복사해 넣은 `ThimbleweedPark.ggpack4` 파일을 삭제하면 원래
상태로 완전히 돌아갑니다.

## 직접 빌드하기

[`install/ThimbleweedPark.ggpack4`](install)는 [`patch/`](patch) 폴더를
그대로 압축한 것으로, `patch/`가 바뀌어 `main`에 푸시될 때마다 GitHub
Actions가 자동으로 다시 빌드해서 항상 최신 상태로 유지합니다
([`.github/workflows/build-pack.yml`](.github/workflows/build-pack.yml)).

로컬에서 직접 빌드하고 싶다면 [Dart SDK](https://dart.dev/get-dart)만
있으면 됩니다.

```bash
cd tools
dart pub get
dart run bin/build_pack.dart ../patch ../install/ThimbleweedPark.ggpack4
```

`patch/`를 고쳐서 오역을 수정하거나 새 파일을 추가한 뒤 바로 이 명령으로
다시 빌드해서 테스트해볼 수 있습니다.

## 개발 히스토리

### v0.9 beta (2026-08-12)

- 캐릭터 간 대화(레이/레예스/랜섬/프랭클린/딜로리스/윌리 및 조연진 전원)
  존댓말·반말 일관성을 전수 검수하고 발견된 오류 수정.
- 엔딩 신문에서 "기자, 퓰리처상 수상!" 문구가 엉뚱한 사진 위에 겹쳐
  보이던 걸 리포터 사진 위로 재배치.
- 엔딩 크레딧 번역자 목록에 추가.

### v0.4 alpha (2026-08-11)

- 파트 4까지 실제 플레이하며 검수한 번역 내용을 수정(주로 존댓말/반말
  일관성, 호칭 오류 등 캐릭터별 말투 정리).

### v0.3 alpha (2026-08-07)

- 마을 곳곳의 배경 간판 이미지 다수를 새로 한글화(하수관 청소업체 간판,
  울타리·공장 경고판, 필로트로닉스 공장 명판·직원 전용 표지, MMucasFlem
  채용 광고 등).
- 실제 플레이 중 발견된 대사 존댓말/반말 오류 다수 수정(레노어, 조지,
  레이↔모레나·보안관 등 캐릭터별 말투 일관성 정리).
- 상점 이름을 바꿔 부르는 대사가 새로 번역한 간판 이미지와 다른 표현을
  쓰고 있던 것을 통일.

### v0.2 alpha (2026-07-31)

- **설치 방식 전면 개편**: `ggpack1`을 직접 수정하던 방식이 맵 이동 시
  게임이 튕기는 원인이었던 걸 발견하고, `ggpack1`은 전혀 건드리지 않는
  별도 오버레이 패키지(`ThimbleweedPark.ggpack4`) 방식으로 전환.
- 비트맵 폰트 34종 전체에 한글 글리프 추가, 발견된 폰트 렌더링 버그 수정.
- 진행에 중요한 이미지 3종(모드 선택 화면, 엔딩 신문, 힌트트론 전단지)에
  실제로 한글 텍스트를 그려 넣음.
- Save/Load 화면 `(casual)`/`(hard)` 표기는 게임 엔진 자체 버그로 한글
  표시가 안 되는 걸 확인, 영어로 유지.

### v0.1 alpha (2026-07-29 ~ 2026-07-31)

- 텍스트 12,900여 줄(대사, UI, 노트/일지 등 스탠드얼론 파일 포함) 전체 번역.
- 실제 선택 가능한 "de"(독일어) 언어 슬롯에 번역을 넣는 방식 채택.
- 동사+목적어 어순이 영어식으로 고정된 엔진 제약 때문에 `[주기] 사과 > 윌`
  처럼 동사를 대괄호로 감싸는 표기법으로 절충.
- 비트맵 폰트에 한글 글리프 추가, 정품 파일을 직접 배포하지 않는 "패치"
  형태로 설치 방식 구성.
