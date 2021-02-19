# moca

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## iBeaconのmajorとminorの使い道

### major
そのまま10進として扱って回答バージョンとする
手持ちの質問データのバージョン番号と照合して関係ないやつは捨てる？

### minor
2進数変換してビットを見ることで最大16個のフラグとする

２（DEX）　→　0000 0000 0000 0010（BIN）　→　質問２の回答だけＹＥＳ