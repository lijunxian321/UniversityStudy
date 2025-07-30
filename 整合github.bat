@echo off
setlocal enabledelayedexpansion

:: Git 用户信息（修改为你自己的）
git config --global user.name "lijunxian321"
git config --global user.email "youremail@example.com"

:: 克隆主仓库
echo === Cloning UniversityStudy ===
git clone https://github.com/lijunxian321/UniversityStudy.git
cd UniversityStudy

:: 合并 class2022.2
echo === Merging class2022.2 ===
git remote add class2022_2 https://github.com/lijunxian321/class2022.2.git
git fetch class2022_2
git merge --allow-unrelated-histories class2022_2/main -m "Merge class2022.2 into UniversityStudy"
git remote remove class2022_2

:: 合并 2022algo
echo === Merging 2022algo ===
git remote add algo2022 https://github.com/lijunxian321/2022algo.git
git fetch algo2022
git merge --allow-unrelated-histories algo2022/main -m "Merge 2022algo into UniversityStudy"
git remote remove algo2022

:: 合并 -ocaml
echo === Merging -ocaml ===
git remote add ocaml https://github.com/lijunxian321/-ocaml.git
git fetch ocaml
git merge --allow-unrelated-histories ocaml/main -m "Merge -ocaml into UniversityStudy"
git remote remove ocaml

:: 合并 class2022Fall
echo === Merging class2022Fall ===
git remote add class2022fall https://github.com/lijunxian321/class2022Fall.git
git fetch class2022fall
git merge --allow-unrelated-histories class2022fall/main -m "Merge class2022Fall into UniversityStudy"
git remote remove class2022fall

:: 推送到 GitHub
echo === Pushing merged result to GitHub ===
git push origin main

echo.
echo ✅ 所有仓库已成功合并进 UniversityStudy
pause
