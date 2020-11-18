#!/usr/bin/env python
# -*- coding: utf-8 -*-

import vtk

case = "./"
filename = "{}/system/controlDict".format(case)

#reader
reader = vtk.vtkOpenFOAMReader()
reader.SetFileName(filename)
reader.Update()

latest_time = reader.GetTimeValues().GetRange()[1]
reader.UpdateTimeStep(latest_time)
reader.Update()

block = reader.GetOutput()
grid = block.GetBlock(0)

field = "mag(U)"
data_type = "cell"

magU = grid.GetCellData().GetArray("mag(U)")

array_name = "mag(U)"
array = magU

# filter 
geom_filter = vtk.vtkGeometryFilter()
geom_filter.SetInputData(reader.GetOutput())

# lookup table
lut = vtk.vtkLookupTable()
lut.SetHueRange(0.667,0)
lut.Build()

# mapper
mapper = vtk.vtkCompositePolyDataMapper()
mapper.SetInputConnection(geom_filter.GetOutputPort())
mapper.SetScalarModeToUseCellFieldData()
mapper.SelectColorArray(array_name)
mapper.SetScalarRange(array.GetRange())
mapper.SetLookupTable(lut)

# actor
actor = vtk.vtkActor()
actor.SetMapper(mapper)
actor.SetOrientation(0,0,0)

# renderer
ren = vtk.vtkRenderer()
ren.AddActor(actor)
ren.SetBackground(1,1,1)

ren_win = vtk.vtkRenderWindow()
ren_win.AddRenderer(ren)
ren_win.SetSize(640,480)

# interactor
inter = vtk.vtkRenderWindowInteractor()
inter.SetRenderWindow(ren_win)



ren_win.Render()
inter.Initialize()
inter.Start()
