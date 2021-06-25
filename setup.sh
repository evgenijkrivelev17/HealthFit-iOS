#!/bin/bash

CARTHAGE_VERSION=0.33.0
SWIFTLINT_VERSION=0.33.0
SWIFTFORMAT_VERSION=0.40.10
SOURCERY_VERSION=0.16.2
SWIFTGEN_VERSION="SwiftGen v6.1.0 (Stencil v0.13.1, StencilSwiftKit v2.7.2, SwiftGenKit v6.1.0)"

echo "🕛 Проверяем наличие установленного Homebrew..."

if which brew >/dev/null; then
  brew update
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "🕐 Проверяем наличие установленного SwiftLint версии ${SWIFTLINT_VERSION}..."

if which swiftlint >/dev/null; then
	CURRENT_SWIFTLINT_VERSION=$(swiftlint version)
	if [ $CURRENT_SWIFTLINT_VERSION != $SWIFTLINT_VERSION ]; then
		arch -x86_64 brew upgrade swiftlint
		echo "✅ Обновление до версии $(SWIFTLINT_VERSION)"
	else
        arch -x86_64 brew switch swiftlint $SWIFTLINT_VERSION
		echo "✅ Установлена актуальная версия SwiftLint"	
	fi
else
	echo "Установка SwiftLint"
    arch -x86_64 brew install swiftlint
fi


echo "🕑 Проверяем наличие установленного SwiftFormat версии ${SWIFTFORMAT_VERSION}..."

if which swiftformat >/dev/null; then
	CURRENT_SWIFTFORMAT_VERSION=$(swiftformat --version)
	if [ $CURRENT_SWIFTFORMAT_VERSION != $SWIFTFORMAT_VERSION ]; then
        arch -x86_64 brew upgrade swiftformat
		echo "✅ Обновление до версии $(SWIFTFORMAT_VERSION)"
	else
        arch -x86_64 brew switch swiftformat $SWIFTFORMAT_VERSION
		echo "✅ Установлена актуальная версия SwiftFormat"	
	fi
else
	echo "Установка SwiftFormat"
    arch -x86_64 brew install swiftformat
fi
