/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2011-2015 OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

Application
    interFoam

Description
    Solver for 2 incompressible, isothermal immiscible fluids using a VOF
    (volume of fluid) phase-fraction based interface capturing approach.

    The momentum and other fluid properties are of the "mixture" and a single
    momentum equation is solved.

    Turbulence modelling is generic, i.e. laminar, RAS or LES may be selected.

    For a two-fluid approach see twoPhaseEulerFoam.

\*---------------------------------------------------------------------------*/

#include "fvCFD.H"    //有限体积法离散相关文件
#include "CMULES.H"  //采用MULES方法求解，OpenFOAM开发的一种半隐离散格式
#include "EulerDdtScheme.H"  //欧拉时间离散格式
#include "localEulerDdtScheme.H"
#include "CrankNicolsonDdtScheme.H"
#include "subCycle.H"  //调用子时间步
#include "immiscibleIncompressibleTwoPhaseMixture.H"  //不可压缩双相传输模型（alpha方程）
#include "turbulentTransportModel.H"  //湍流模型
#include "pimpleControl.H"
#include "fvIOoptionList.H"   //源项
#include "CorrectPhi.H"  //通量修正
#include "fixedFluxPressureFvPatchScalarField.H"  //设置边界压力条件
#include "localEulerDdtScheme.H"
#include "fvcSmooth.H"  //光顺求解

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include "setRootCase.H"  //设置case目录
    #include "createTime.H"  //创建时间对象
    #include "createMesh.H"  //创建网格对象

    pimpleControl pimple(mesh);  //采用pimple算法

    #include "createTimeControls.H"  //创建时间控制
    #include "createRDeltaT.H"  //创建时间步（LTS）
    #include "initContinuityErrs.H"  //初始连续性误差
    #include "createFields.H"  //创建场对象
    #include "createMRF.H"  //更新边界速度
    #include "createFvOptions.H"  //创建源项
    #include "correctPhi.H"  //修正界面流率  保证连续性

    if (!LTS)  //如果是非局部时间步  （LTS的deltaT为非均一的场）,初始检验一次
    {
        #include "readTimeControls.H"  //读取时间控制
        #include "CourantNo.H"  //计算库朗数
        #include "setInitialDeltaT.H"  //初始时间步
    }

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nStarting time loop\n" << endl;  //输出提示信息   开始时间循环

    while (runTime.run())
    {
        #include "readTimeControls.H"  //读取时间控制

        if (LTS)
        {
            #include "setRDeltaT.H"  //创建LTS的时间步
        }
        else  //进行每一run时间的检测后的时间步长的设置
        {
            #include "CourantNo.H"  //计算库朗数
            #include "alphaCourantNo.H"  //计算alpha库朗数
            #include "setDeltaT.H"  //设置时间步
        }

        runTime++;  //时间递增

        Info<< "Time = " << runTime.timeName() << nl << endl;  //输出当前运行时间点

        // --- Pressure-velocity PIMPLE corrector loop
        while (pimple.loop())    //进入速度压力pimple外循环
        {
            #include "alphaControls.H"  //读取alpha控制  （MULES方法控制、子循环次数、界面压缩因子等）
            #include "alphaEqnSubCycle.H"  //alpha方程求解

            mixture.correct();  //1、曲率修正  2、平均运动粘度修正

            #include "UEqn.H"  //求解速度方程，若开启动量预测，则得到一个预测的U

            // --- Pressure corrector loop
            while (pimple.correct())  //内循环
            {
                #include "pEqn.H"  //求解压力方程，迭带计算一个时间步长内的P，p_rgh
            }

            if (pimple.turbCorr()) //如果控制湍流的开关不为零
            {
                turbulence->correct();  //修正湍动黏性
            }
        }

        runTime.write();  //写入数据

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************************************************************* //
