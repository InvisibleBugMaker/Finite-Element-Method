# -*- coding: mbcs -*-
#
# Abaqus/CAE Release 2020 replay file
# Internal Version: 2019_09_13-10.49.31 163176
# Run by jiaoyi on Mon May 31 23:42:01 2021
#

# from driverUtils import executeOnCaeGraphicsStartup
# executeOnCaeGraphicsStartup()
#: Executing "onCaeGraphicsStartup()" in the site directory ...
from abaqus import *
from abaqusConstants import *
session.Viewport(name='Viewport: 1', origin=(0.0, 0.0), width=466.666625976563, 
    height=291.111114501953)
session.viewports['Viewport: 1'].makeCurrent()
session.viewports['Viewport: 1'].maximize()
from caeModules import *
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()
openMdb('Q1.cae')
#: The model database "U:\CESG504\HW5 Q1\4\Q1.cae" has been opened.
session.viewports['Viewport: 1'].setValues(displayedObject=None)
session.viewports['Viewport: 1'].partDisplay.geometryOptions.setValues(
    referenceRepresentation=ON)
p = mdb.models['Model-1'].parts['Part-1']
session.viewports['Viewport: 1'].setValues(displayedObject=p)
p1 = mdb.models['Model-1'].parts['Part-1']
session.viewports['Viewport: 1'].setValues(displayedObject=p1)
p1 = mdb.models['Model-1'].parts['Part-1']
session.viewports['Viewport: 1'].setValues(displayedObject=p1)
mdb.models['Model-1'].parts['Part-1'].setValues(space=THREE_D, 
    type=DEFORMABLE_BODY)
session.viewports['Viewport: 1'].view.setValues(nearPlane=142.166, 
    farPlane=225.074, width=86.0367, height=56.2179, viewOffsetX=1.97701, 
    viewOffsetY=-0.636047)
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=200.0)
g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=STANDALONE)
session.viewports['Viewport: 1'].view.setValues(nearPlane=176.079, 
    farPlane=201.045, width=155.289, height=101.468, cameraPosition=(3.54695, 
    -1.08098, 188.562), cameraTarget=(3.54695, -1.08098, 0))
s.unsetPrimaryObject()
del mdb.models['Model-1'].sketches['__profile__']
p1 = mdb.models['Model-1'].parts['Part-1']
session.viewports['Viewport: 1'].setValues(displayedObject=p1)
p = mdb.models['Model-1'].parts['Part-1']
p.deleteFeatures(('Partition edge-5', 'Partition edge-6', 'Partition edge-7', 
    'Partition edge-8', 'Partition cell-2', ))
p = mdb.models['Model-1'].parts['Part-1']
p.regenerate()
p = mdb.models['Model-1'].parts['Part-1']
p.regenerate()
session.viewports['Viewport: 1'].view.setValues(nearPlane=146.6, 
    farPlane=220.64, width=56.5099, height=29.2311, viewOffsetX=15.8312, 
    viewOffsetY=-9.58564)
p = mdb.models['Model-1'].parts['Part-1']
p.regenerate()
p = mdb.models['Model-1'].parts['Part-1']
e = p.edges
pickedEdges = e.getSequenceFromMask(mask=('[#0 #200000 ]', ), )
p.PartitionEdgeByParam(edges=pickedEdges, parameter=0.618899726867676)
p = mdb.models['Model-1'].parts['Part-1']
del p.features['Partition edge-5']
p = mdb.models['Model-1'].parts['Part-1']
e = p.edges
pickedEdges = e.getSequenceFromMask(mask=('[#0 #200000 ]', ), )
p.PartitionEdgeByParam(edges=pickedEdges, parameter=0.125)
p = mdb.models['Model-1'].parts['Part-1']
e = p.edges
pickedEdges = e.getSequenceFromMask(mask=('[#0 #2000000 ]', ), )
p.PartitionEdgeByParam(edges=pickedEdges, parameter=0.125)
p = mdb.models['Model-1'].parts['Part-1']
e = p.edges
pickedEdges = e.getSequenceFromMask(mask=('[#0 #80000 ]', ), )
p.PartitionEdgeByParam(edges=pickedEdges, parameter=0.125)
session.viewports['Viewport: 1'].view.setValues(nearPlane=148.466, 
    farPlane=218.774, width=22.6222, height=11.7019, viewOffsetX=17.6003, 
    viewOffsetY=-18.4605)
p = mdb.models['Model-1'].parts['Part-1']
c = p.cells
pickedCells = c.getSequenceFromMask(mask=('[#2 ]', ), )
v1, e, d1 = p.vertices, p.edges, p.datums
p.PartitionCellByPlaneThreePoints(point1=v1[32], point2=v1[34], point3=v1[37], 
    cells=pickedCells)
session.viewports['Viewport: 1'].view.setValues(nearPlane=146.358, 
    farPlane=220.882, width=60.51, height=31.3002, viewOffsetX=17.527, 
    viewOffsetY=-13.1898)
a = mdb.models['Model-1'].rootAssembly
a.regenerate()
session.viewports['Viewport: 1'].setValues(displayedObject=a)
#: Warning: Mesh deleted in 2 regions of instance 'Part-1-1' due to geometry association failure.
session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
session.viewports['Viewport: 1'].assemblyDisplay.setValues(loads=ON, bcs=ON, 
    predefinedFields=ON, connectors=ON, optimizationTasks=OFF, 
    geometricRestrictions=OFF, stopConditions=OFF)
session.viewports['Viewport: 1'].view.setValues(nearPlane=143.023, 
    farPlane=224.217, width=111.937, height=59.9215, viewOffsetX=-1.14842, 
    viewOffsetY=2.3394)
session.viewports['Viewport: 1'].view.setValues(nearPlane=147.34, 
    farPlane=219.9, width=37.8608, height=20.2674, viewOffsetX=15.1885, 
    viewOffsetY=-14.9617)
del mdb.models['Model-1'].boundaryConditions['BC-1']
session.viewports['Viewport: 1'].view.setValues(nearPlane=142.53, 
    farPlane=224.71, width=119.645, height=64.0477, viewOffsetX=34.5833, 
    viewOffsetY=-5.08767)
session.viewports['Viewport: 1'].view.setValues(nearPlane=142.102, 
    farPlane=225.138, width=119.286, height=63.8554, viewOffsetX=-1.07184, 
    viewOffsetY=-2.45978)
session.viewports['Viewport: 1'].view.setValues(nearPlane=146.782, 
    farPlane=220.457, width=45.7835, height=24.5086, viewOffsetX=10.1459, 
    viewOffsetY=-16.4593)
session.viewports['Viewport: 1'].view.setValues(nearPlane=162.137, 
    farPlane=247.544, width=50.5728, height=27.0723, cameraPosition=(167.481, 
    11.7627, 21.7214), cameraUpVector=(-0.254293, 0.906574, -0.336835), 
    cameraTarget=(-14.9658, 21.2583, 3.30552), viewOffsetX=11.2072, 
    viewOffsetY=-18.1811)
session.viewports['Viewport: 1'].view.setValues(nearPlane=171.428, 
    farPlane=245.615, width=53.4708, height=28.6236, cameraPosition=(138.392, 
    2.35668, -114.07), cameraUpVector=(-0.0882147, 0.936565, 0.339211), 
    cameraTarget=(-7.47988, 13.7896, -3.13326), viewOffsetX=11.8494, 
    viewOffsetY=-19.2229)
session.viewports['Viewport: 1'].view.setValues(nearPlane=171.24, 
    farPlane=245.803, width=53.4122, height=28.5923, viewOffsetX=-2.21943, 
    viewOffsetY=-8.26038)
session.viewports['Viewport: 1'].view.setValues(nearPlane=182.359, 
    farPlane=206.153, width=56.8803, height=30.4488, cameraPosition=(-17.4565, 
    59.4078, -188.741), cameraUpVector=(0.286185, 0.799072, 0.528756), 
    cameraTarget=(-25.797, 20.3914, -9.50848), viewOffsetX=-2.36354, 
    viewOffsetY=-8.79673)
session.viewports['Viewport: 1'].view.setValues(nearPlane=182.133, 
    farPlane=206.378, width=56.8099, height=30.4112, viewOffsetX=-20.4087, 
    viewOffsetY=-3.51605)
session.viewports['Viewport: 1'].view.setValues(nearPlane=152.029, 
    farPlane=222.701, width=47.4201, height=25.3847, cameraPosition=(-106.67, 
    -143.354, -74.3735), cameraUpVector=(-0.62449, 0.776384, 0.0850812), 
    cameraTarget=(-21.9576, -5.9758, 13.1892), viewOffsetX=-17.0354, 
    viewOffsetY=-2.9349)
a = mdb.models['Model-1'].rootAssembly
c1 = a.instances['Part-1-1'].cells
cells1 = c1.getSequenceFromMask(mask=('[#1 ]', ), )
f1 = a.instances['Part-1-1'].faces
faces1 = f1.getSequenceFromMask(mask=('[#1c00002a #2 ]', ), )
region = a.Set(faces=faces1, cells=cells1, name='Set-9')
mdb.models['Model-1'].DisplacementBC(name='BC-1', createStepName='Step-1', 
    region=region, u1=0.0, u2=0.0, u3=0.0, ur1=0.0, ur2=0.0, ur3=0.0, 
    amplitude=UNSET, fixed=OFF, distributionType=UNIFORM, fieldName='', 
    localCsys=None)
session.viewports['Viewport: 1'].view.setValues(nearPlane=123.288, 
    farPlane=213.807, width=38.4554, height=20.5857, cameraPosition=(-184.237, 
    -69.5803, 10.2174), cameraUpVector=(-0.0268701, 0.946143, 0.322633), 
    cameraTarget=(-13.4343, -2.60018, 17.7271), viewOffsetX=-13.8149, 
    viewOffsetY=-2.38006)
session.viewports['Viewport: 1'].view.setValues(nearPlane=120.491, 
    farPlane=203.535, width=37.5831, height=20.1187, cameraPosition=(-180.229, 
    -18.5488, 71.5489), cameraUpVector=(0.257904, 0.96613, -0.00878948), 
    cameraTarget=(-7.56393, -1.83681, 11.352), viewOffsetX=-13.5015, 
    viewOffsetY=-2.32607)
session.viewports['Viewport: 1'].view.setValues(nearPlane=119.232, 
    farPlane=204.794, width=61.0109, height=32.66, viewOffsetX=-14.6217, 
    viewOffsetY=0.345205)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(loads=OFF, bcs=OFF, 
    predefinedFields=OFF, connectors=OFF)
mdb.Job(name='Job-2', model='Model-1', description='', type=ANALYSIS, 
    atTime=None, waitMinutes=0, waitHours=0, queue=None, memory=90, 
    memoryUnits=PERCENTAGE, getMemoryFromAnalysis=True, 
    explicitPrecision=SINGLE, nodalOutputPrecision=SINGLE, echoPrint=OFF, 
    modelPrint=OFF, contactPrint=OFF, historyPrint=OFF, userSubroutine='', 
    scratch='', resultsFormat=ODB, multiprocessingMode=DEFAULT, numCpus=1, 
    numGPUs=0)
del mdb.jobs['Job-2']
session.viewports['Viewport: 1'].assemblyDisplay.setValues(mesh=ON)
session.viewports['Viewport: 1'].assemblyDisplay.meshOptions.setValues(
    meshTechnique=ON)
a = mdb.models['Model-1'].rootAssembly
partInstances =(a.instances['Part-1-1'], )
a.deleteMesh(regions=partInstances)
a = mdb.models['Model-1'].rootAssembly
partInstances =(a.instances['Part-1-1'], )
a.seedPartInstance(regions=partInstances, size=1.0, deviationFactor=0.1, 
    minSizeFactor=0.1)
a = mdb.models['Model-1'].rootAssembly
partInstances =(a.instances['Part-1-1'], )
a.generateMesh(regions=partInstances)
session.viewports['Viewport: 1'].view.setValues(nearPlane=119.653, 
    farPlane=204.372, width=54.321, height=29.1527, viewOffsetX=-10.3966, 
    viewOffsetY=10.2884)
session.viewports['Viewport: 1'].view.setValues(nearPlane=137.221, 
    farPlane=199.043, width=62.2966, height=33.433, cameraPosition=(-96.7301, 
    -75.7676, 129.487), cameraUpVector=(0.259923, 0.933249, 0.247966), 
    cameraTarget=(-12.7054, 4.23019, -12.8376), viewOffsetX=-11.923, 
    viewOffsetY=11.799)
session.viewports['Viewport: 1'].view.setValues(nearPlane=149.579, 
    farPlane=187.526, width=67.9071, height=36.444, cameraPosition=(-74.3382, 
    3.70829, 165.469), cameraUpVector=(0.604303, 0.766966, -0.215825), 
    cameraTarget=(-22.9542, -6.49796, -10.5187), viewOffsetX=-12.9968, 
    viewOffsetY=12.8616)
session.viewports['Viewport: 1'].view.setValues(nearPlane=145.542, 
    farPlane=191.564, width=130.505, height=70.0387, viewOffsetX=-9.2066, 
    viewOffsetY=14.9268)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(mesh=OFF)
session.viewports['Viewport: 1'].assemblyDisplay.meshOptions.setValues(
    meshTechnique=OFF)
mdb.jobs['Job-1'].submit(consistencyChecking=OFF)
#: The job input file "Job-1.inp" has been submitted for analysis.
#: Job Job-1: Analysis Input File Processor completed successfully.
#: Job Job-1: Abaqus/Standard completed successfully.
#: Job Job-1 completed successfully. 
o3 = session.openOdb(name='U:/CESG504/HW5 Q1/4/Job-1.odb')
#: Model: U:/CESG504/HW5 Q1/4/Job-1.odb
#: Number of Assemblies:         1
#: Number of Assembly instances: 0
#: Number of Part instances:     1
#: Number of Meshes:             1
#: Number of Element Sets:       7
#: Number of Node Sets:          8
#: Number of Steps:              1
session.viewports['Viewport: 1'].setValues(displayedObject=o3)
session.viewports['Viewport: 1'].makeCurrent()
session.viewports['Viewport: 1'].odbDisplay.display.setValues(plotState=(
    CONTOURS_ON_DEF, ))
session.viewports['Viewport: 1'].view.setValues(nearPlane=147.457, 
    farPlane=224.426, width=35.6176, height=19.0666, viewOffsetX=13.3939, 
    viewOffsetY=-13.6426)
session.viewports['Viewport: 1'].view.setValues(nearPlane=154.397, 
    farPlane=207.218, width=37.2938, height=19.9639, cameraPosition=(15.1897, 
    94.4425, 150.811), cameraUpVector=(-0.38644, 0.680021, -0.623085), 
    cameraTarget=(-35.4953, 12.4486, -5.47146), viewOffsetX=14.0242, 
    viewOffsetY=-14.2846)
session.viewports['Viewport: 1'].view.setValues(nearPlane=147.94, 
    farPlane=213.674, width=141.121, height=75.544, viewOffsetX=11.6382, 
    viewOffsetY=-10.7056)
mdb.save()
#: The model database has been saved to "U:\CESG504\HW5 Q1\4\Q1.cae".
mdb.save()
#: The model database has been saved to "U:\CESG504\HW5 Q1\4\Q1.cae".
mdb.save()
#: The model database has been saved to "U:\CESG504\HW5 Q1\4\Q1.cae".
mdb.save()
#: The model database has been saved to "U:\CESG504\HW5 Q1\4\Q1.cae".
mdb.save()
#: The model database has been saved to "U:\CESG504\HW5 Q1\4\Q1.cae".
mdb.save()
#: The model database has been saved to "U:\CESG504\HW5 Q1\4\Q1.cae".
