@echo off
title Walsh Capstone — Setup and Launch

echo ============================================================
echo   Walsh CDC Capstone Project Setup
echo   E:\gl-walsh\walsh-capstone
echo ============================================================
echo.

:: ── Check if conda is available ─────────────────────────────────────────────
where conda >nul 2>&1
if errorlevel 1 (
    echo ERROR: conda not found.
    echo Please open this from Anaconda Prompt, not regular Command Prompt.
    echo.
    echo Steps:
    echo   1. Click Start
    echo   2. Search for "Anaconda Prompt"
    echo   3. Open it
    echo   4. Run this file again from Anaconda Prompt
    pause
    exit /b 1
)

:: ── Check if project folder exists ──────────────────────────────────────────
if not exist "E:\gl-walsh\walsh-capstone" (
    echo Creating project folder: E:\gl-walsh\walsh-capstone
    mkdir "E:\gl-walsh\walsh-capstone"
    mkdir "E:\gl-walsh\walsh-capstone\data"
    mkdir "E:\gl-walsh\walsh-capstone\outputs"
    mkdir "E:\gl-walsh\walsh-capstone\models"
    echo Folders created.
) else (
    echo Project folder found: E:\gl-walsh\walsh-capstone
)
echo.

:: ── Check if environment exists ─────────────────────────────────────────────
conda env list | findstr "cdc_capstone" >nul 2>&1
if errorlevel 1 (
    echo Environment "cdc_capstone" not found.
    echo Creating it now — this takes 3-5 minutes on first run...
    echo.

    :: Check if environment.yml exists next to this bat file
    if exist "%~dp0environment.yml" (
        echo Using environment.yml...
        conda env create -f "%~dp0environment.yml"
    ) else (
        echo Installing packages manually...
        conda create -n cdc_capstone python=3.11 -y
        call conda activate cdc_capstone
        conda install pandas numpy matplotlib seaborn scipy scikit-learn statsmodels jupyter notebook ipywidgets -y
        pip install joblib requests --quiet
    )

    if errorlevel 1 (
        echo.
        echo ERROR: Environment creation failed.
        echo Try running these commands manually in Anaconda Prompt:
        echo   conda create -n cdc_capstone python=3.11 -y
        echo   conda activate cdc_capstone
        echo   conda install pandas numpy matplotlib seaborn scipy scikit-learn statsmodels jupyter notebook ipywidgets -y
        pause
        exit /b 1
    )
    echo.
    echo Environment created successfully.
) else (
    echo Environment "cdc_capstone" found.
)
echo.

:: ── Activate environment ─────────────────────────────────────────────────────
echo Activating cdc_capstone environment...
call conda activate cdc_capstone
if errorlevel 1 (
    echo ERROR: Could not activate environment.
    echo Try: conda activate cdc_capstone
    pause
    exit /b 1
)
echo.

:: ── Launch Jupyter ───────────────────────────────────────────────────────────
echo ============================================================
echo   Launching Jupyter Notebook
echo   Your browser will open at: http://localhost:8888
echo.
echo   Navigate to: CDC_Capstone_Walsh.ipynb
echo   Then: Cell -> Run All Cells
echo ============================================================
echo.

cd /d "E:\gl-walsh\walsh-capstone"
jupyter notebook

pause
