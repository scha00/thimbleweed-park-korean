# Thimbleweed Park 한글패치

**v0.2 alpha** — Thimbleweed Park을 한국어로 즐길 수 있게 해주는 팬 번역
패치입니다. 텍스트 번역은 100% 끝났지만 아직 정식 검수(QA) 전인 초기
버전입니다.

이 저장소에는 게임 리소스가 전혀 포함되어 있지 않습니다. 배포하는 건
번역된 텍스트/폰트/이미지만 담은 `ThimbleweedPark.ggpack4` 파일 하나뿐이고,
이 파일을 정품 게임 폴더에 복사해 넣기만 하면 됩니다.

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

`ggpack1`/`ggpack2`는 전혀 건드리지 않습니다. 게임 엔진이 원래
`ggpack3`, `ggpack4`처럼 번호가 이어지는 추가 패키지 파일을 자동으로
얹어서 읽는 기능을 지원해서(공식 "Ransome Uncensored" DLC도 `ggpack3`으로
같은 방식을 씁니다), 그 위에 번역 파일이 담긴 패키지 하나를 얹는 것뿐입니다.

## 제거 방법

게임 폴더에 복사해 넣은 `ThimbleweedPark.ggpack4` 파일을 삭제하면 원래
상태로 완전히 돌아갑니다.

## 개발 히스토리

- 텍스트 12,900여 줄(대사, UI, 노트/일지 등 스탠드얼론 파일 포함) 전체 번역.
- 게임의 언어 슬롯 중 실제로 선택 가능한 "de"(독일어) 슬롯에 번역을 넣는
  방식을 채택. 화면에 그림으로 박혀 있는 텍스트(간판, 신문, 힌트 전단 등)는
  기본적으로 "de" 참조를 "en"(영어) 프레임으로 리다이렉트해서 원래 영어
  그대로 두되, 진행에 중요한 이미지 3종(캐주얼/하드 모드 선택 화면, 엔딩
  신문 헤드라인, 힌트트론 전단지)은 실제로 이미지 안에 한글을 새로 그려
  넣었음.
- 엔진이 동사+목적어 문장을 항상 "동사 목적어" 순서(영어 어순)로 이어붙이는
  구조라 한국어 어순(목적어+동사)으로 자연스럽게 만들 수 없었음. 그래서
  `[줍기] 사과`, `[주기] 사과 > 윌`처럼 동사를 대괄호로 감싸고 "with/on/in/to"
  연결어를 `>`로 통일하는 표기법으로 절충.
- 비트맵 폰트 34종 전체(대사/UI뿐 아니라 이전엔 손 안 댔던 폰트까지 전부)에
  한글 글리프를 새로 추가. 처음엔 글자별 베이스라인 계산이 틀려서
  삐뚤빼뚤하게 나오는 문제가 있었는데, 폰트의 공통 ascent 기준으로 다시
  계산해서 해결. 일부 폰트는 채우기 색상을 잘못 감지해 검은색으로 나오던
  버그와, 그림자 효과가 빠졌던 문제도 확인 후 수정.
- `Autosave`, 날짜/시간 포맷, `(casual)`/`(hard)` 같은 난이도 표기 등 일부
  시스템 문자열은 번역하면 엔진이 내부적으로 값을 못 찾아 빈칸으로
  나오는 걸 확인하고 원문 영어로 되돌림.
- `ThimbleweedText_*.tsv` 체계 밖에 있는 별도 텍스트 파일(노트, 수첩, 척의
  일지, 크레딧 등)이 뒤늦게 발견되어 추가로 번역.
- 실제 플레이하면서 발견된 버그들(Save/Load 라벨 뒤바뀜, 존댓말/반말 오류,
  "beep→삐-" 치환만 되고 나머지 문장은 번역이 안 남아있던 랜섬 대사 다수 등)을
  계속 찾아서 수정.
- **[v0.2] 설치 방식을 전면 개편.** 기존에는 500MB 넘는 `ggpack1`을 직접
  압축 해제 → 패치 → 재압축해서 원본 자리에 덮어씌우는 방식이었는데, 파일
  하나라도 원본과 바이트 크기가 달라지면 맵 이동 시 게임이 튕기는 문제를
  오래 추적한 끝에 발견. 대신 게임이 원래 지원하는 "추가 패키지 파일"
  기능을 이용해 `ThimbleweedPark.ggpack4`라는 작은 별도 파일만 게임 폴더에
  얹는 방식으로 바꿈 — `ggpack1`은 아예 손대지 않으므로 이 문제가 원천적으로
  사라짐. 설치 스크립트(Mac/Windows)와 `ngpack-tool` 번들도 전부 필요
  없어져서 제거.
