@echo off
echo ========================================
echo  Ministerio Digital - Build Script
echo ========================================
echo.

echo [1/4] Rodando flutter analyze...
call flutter analyze
if %ERRORLEVEL% neq 0 (
    echo ERRO: Analyze encontrou erros!
    exit /b 1
)
echo.

echo [2/4] Rodando testes...
call flutter test
if %ERRORLEVEL% neq 0 (
    echo ERRO: Testes falharam!
    exit /b 1
)
echo.

echo [3/4] Build APK (Release)...
call flutter build apk --release
if %ERRORLEVEL% neq 0 (
    echo ERRO: Build APK falhou!
    exit /b 1
)
echo APK gerado em: build\app\outputs\flutter-apk\app-release.apk
echo.

echo [4/4] Build Web...
call flutter build web --release
if %ERRORLEVEL% neq 0 (
    echo ERRO: Build Web falhou!
    exit /b 1
)
echo Web gerado em: build\web\
echo.

echo ========================================
echo  BUILD COMPLETO COM SUCESSO!
echo ========================================
echo.
echo Proximos passos:
echo 1. Para testar APK: adb install build\app\outputs\flutter-apk\app-release.apk
echo 2. Para web: abra build\web\index.html no navegador
echo 3. Para iOS: flutter build ipa
echo.
pause
