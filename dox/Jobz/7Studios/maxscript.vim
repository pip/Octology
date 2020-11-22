" Vim syntax file
" Language:    MaxScript (Autodesk's 3DStudio MaxScript .ms && .mcr files)
" Maintainer:  PipStuart <Pip@CPAN.Org>,<PStuart@SevenStudios.Com>
" Created:     81FInk7   (Tue Jan 15 18:49:46:07 PST 2008)
" Last Change: 81LBFik   (Mon Jan 21 11:15:44:46 PST 2008)
" Version:     0         (derived from v6 of xmath.vim)
" URL:         N/A
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  sy clear
elseif exists("b:current_syntax")
  finish
en
"   MaxScript         Grammar - Item Types
" label button edittext combobox dropdownList listbox spinner slider pickbutton radiobuttons checkbox checkbutton colorPicker mapbutton materialbutton 
" progressbar timer bitmap
"   MaxScript Class Hierarchy - Each class typically inherits the properties, operators, and methods of its parent class.
" Value: AngleAxis Array ArrayParameter AtmosphericClass BigMatrix BigMatrixRowArray BipedExportInterface BitArray Bitmap BitmapControl BooleanClass
"   Box2 ButtonControl CTBitMap CTMotionTracker ChangeHandler CharStream CheckBoxControl CheckButtonControl Class Color ColorPickerControl
"   ComboBoxControl Control EdgeSelection EditTextControl EffectClass EmptyClass EulerAngles FaceSelection FileStream Float GeomObject GroupEndControl
"   GroupStartControl HashTable Integer Interval LabelControl ListBoxControl MAXClass MAXFilterClass MAXKey MAXKeyArray MAXMeshClass MAXModifierArray
"   MAXNoteKey MAXNoteKeyArray MAXObject MAXRootNode MAXScriptFunction MAXSuperClass MAXTVNode MSPluginClass MapButtonControl MapSupportClass
"   MaterialLibrary Matrix3 MeditMaterialsClass Menuitem ModifierClass MotionTracker MouseTool MtlButtonControl MultiMaterialClass
"   NURBSDisplay
"   --NURBSObject
"   ----NURBSControlVertex
"   ----NURBSCurve NURBSBlendCurve
"   ------NURBSCVCurve NURBSCurveOnSurface
"   ------NURBSChamferCurve
"   ------NURBSFilletCurve
"   ------NURBSIsoCurve
"   ------NURBSMirrorCurve
"   ------NURBSOffsetCurve
"   ------NURBSPointCurve NURBSPointCurveOnSurface
"   ------NURBSProjectNormalCurve
"   ------NURBSProjectVectorCurve
"   ------NURBSSurfSurfIntersectionCurve
"   ------NURBSSurfaceEdgeCurve
"   ------NURBSSurfaceNormalCurve
"   ------NURBSXFormCurve
"   ----NURBSPoint:NURBSCurveConstPoint NURBSCurveIntersectPoint NURBSCurveSurfaceIntersectPoint NURBSIndependentPoint NURBSPointConstPoint NURBSSurfConstPoint
"       NURBSSurface: NURBS1RailSweepSurface NURBS2RailSweepSurface NURBSBlendSurface NURBSCVSurface NURBSCapSurface NURBSExtrudeSurface NURBSFilletSurface
"       NURBSLatheSurface NURBSMirrorSurface NURBSMultiCurveTrimSurface NURBSNBlendSurface NURBSOffsetSurface NURBSPointSurface NURBSRuledSurface
"       NURBSULoftSurface NURBSUVLoftSurface NURBSXFormSurface
" ----NURBSTexturePoint
" --NURBSSelection
" --NURBSSet
" --NURBSSurfaceApproximation
" --NURBSTextureSurface
" --Name
" --NodeChildrenArray
" --NoteTrack
" --Number
" --OLEMethod
" --OLEObject
" --Object
" --OkClass
" --PathName
" --PhyBlendedRigidVertex
" --PhyContextExport
" --PhyRigidVertex
" --PickerControl
" --Point2
" --Point3
" --ProgressBar
" --Quat
" --RadioControl
" --Ray
" --RolloutControl
" --RolloutFloater
" --SelectionSet
" --SelectionSetArray
" --Set
" --SliderControl
" --SpinnerControl
" --StandardMaterialClass
" --String
" --StringStream
" --StructDef
" --SubAnim
" --Time
" --Timer
" --TriMesh
" --UndefinedClass
" --UnsuppliedClass
" --UserGeneric
" --VertexSelection
" --WindowStream
" --XRefScene
" --MAXWrapper
" ----atmospheric: Fire_Effect Fog Missing_Atmospheric RenderEnvironment Volume_Fog Volume_Light
" ----filter: Area Blackman Blendfilter Catmull_Rom Cook_Variable cubic Mitchell_Netravali Plate_Match_MAX_R2 Plate_Match_VIZ_R2 Quadratic Sharp_Quadratic
"       Soften Video
"     FloatController: AudioFloat bezier_float Block Float_Expression float_list Float_Motion_Capture Float_Reactor float_script linear_float LOD_Controller
"       Missing_Float_Control Noise_float On_Off SlaveFloat tcb_float Waveform_Float
" ----Layer_Manager
" ----MasterBlockController: Block_Control Free_Center MasterBlock
" ----material: Blend compositematerial DoubleSided doubleSidedMat Matte MatteShadow Missing_Mtl Morphermaterial Multimaterial multiSubMaterial NoMaterial
"       RaytraceMaterial Shellac standard Standardmaterial
" ------TexOutputClass: StandardTextureOutput
" ------textureMap: Adobe_Photoshop_Plug_In_Filter Adobe_Premiere_Video_Filter bitmapTex Bitmaptexture Bricks Cellular Checker compositeTexture
"         CompositeTexturemap Dent falloff fallofftextureMap FlatMirror Gradient Gradient_Ramp Marble Mask maskTex Missing_TextureMap Mix Noise NoTexture
"         output Paint Particle_Age Particle_MBlur Perlin_Marble Planet Raytrace Reflect_Refract RGB_Multiply RGB_Tint Smoke Speckle Splat Stucco Swirl
"         Thin_Wall_Refraction Vertex_Color Water Wood
" ------TopBottom
" ------topBottomMat
" ------UVGenClass: Missing_UVGen StandardUVGen
" ------XYZGenClass: Missing_XYZGen StandardXYZGen
" ----Matrix3Controller: IK_ControllerMatrix3Controller Link_Control Link_Transform lookat Missing_Matrix3_Control prs Slave_Control TVDummyControl
" ----modifier: Affect_Region Bend Bevel Bevel_Profile CameraMap Cap_Holes CrossSection DeleteMesh DeleteSplineModifier Displace Disp_Approx Edit_Mesh
"       Edit_Patch Edit_Spline Extrude Face_Extrude FFDBox FFDCyl FFD_2x2x2 FFD_3x3x3 FFD_4x4x4 FFD_Select Fillet_Chamfer Flex Lathe Lattice Linked_xform
"       MaterialByElement Materialmodifier Melt MeshSmooth Mesh_Select MIrror Missing_OSM Morpher NCurve_Sel Noisemodifier Normalize_Spline Normalmodifier
"       NSurf_Sel optimizeValue
" --ActionPredicate
" --ActiveXControl
" --AngleAxis
" --AngleControl
" --Array
" --ArrayParameter
" --AtmosphericClass
" --AttributeDef: Layer_Manager
" --BigMatrix
" --BigMatrixRowArray
" --BinStream
" --BitArray
" --bitmap
" --BitmapControl
" --BooleanClass
" --Box2
" --ButtonControl
" --ccCurve
" --ccPoint
" --CCRootClass
" --ChangeHandler
" --CharStream
" --CheckBoxControl
" --CheckButtonControl
" --class
" --color
" --ColorPickerControl
" --ComboBoxControl
" --Control
" --CTBitMap
" --CTMotionTracker
" --CurveCtlGeneric
" --CurvePointsArray
" --EdgeSelection
" --EditTextControl
" --EffectClass
" --EmptyClass
" --EulerAngles
" --FaceSelection
" --FileStream
" --float
" --Generic
" --GeomObject
" --GroupBoxControl
" --GroupEndControl
" --GroupStartControl
" --HashTable
" --ImgTag
" --integer
" --Interface
" --InterfaceFunction
" --Interval
" --IObject
" --LabelControl
" --LinkControl
" --ListBoxControl
" --MapButtonControl
" --MappedGeneric
" --MappedPrimitive
" --MapSupportClass
" --MaterialLibrary
" --Matrix3
" --MAXAKey
" --MAXClass
" --MAXCurveCtl
" --MAXFilterClass
" --MAXKey
" --MAXKeyArray
" --MAXMeshClass: mesh
" --MAXModifierArray
" --MAXNoteKey
" --MAXNoteKeyArray
" --MAXObject
" --MAXRefTarg
" --MAXRootNode
" --MAXScriptFunction
" --MAXSuperClass
" --MAXTVNode
" --MeditMaterialsClass
" --menuitem
" --MixinInterface
" --ModifierClass
" --MotionTracker
" --MouseTool
" --MPassCamEffectClass
" --MSComMethod
" --MSCustAttribDef
" --MSDispatch
" --MSPluginClass
" --MtlButtonControl
" --MultiListBoxControl
" --MultiMaterialClass
" --name
" --NodeChildrenArray
" --NodeGeneric
" --NoteTrack
" --Number
" --NURBSDisplay
" --NURBSObject
" ----NURBSControlVertex
" ----NURBSCurve
" ------NURBSBlendCurve
" ------NURBSChamferCurve
" ------NURBSCVCurve
" --------NURBSCurveOnSurface
" ------NURBSFilletCurve
" ------NURBSIsoCurve
" ------NURBSMirrorCurve
" ------NURBSOffsetCurve
" ------NURBSPointCurve
" --------NURBSPointCurveOnSurface
" ------NURBSProjectNormalCurve
" ------NURBSProjectVectorCurve
" ------NURBSSurfaceEdgeCurve
" ------NURBSSurfaceNormalCurve
" ------NURBSSurfSurfIntersectionCurve
" ------NURBSXFormCurve
" ----NURBSPoint: NURBSCurveConstPoint NURBSCurveIntersectPoint NURBSCurveSurfaceIntersectPoint NURBSIndependentPoint NURBSPointConstPoint NURBSSurfConstPoint
" ----NURBSSurface
" ------NURBS1RailSweepSurface
" ------NURBS2RailSweepSurface
" ------NURBSBlendSurface
" ------NURBSCapSurface
" ------NURBSCVSurface
" ------NURBSExtrudeSurface
" ------NURBSFilletSurface
" ------NURBSLatheSurface
" ------NURBSMirrorSurface
" ------NURBSMultiCurveTrimSurface
" ------NURBSNBlendSurface
" ------NURBSOffsetSurface
" ------NURBSPointSurface
" ------NURBSRuledSurface
" ------NURBSULoftSurface
" ------NURBSUVLoftSurface
" ------NURBSXFormSurface
" ----NURBSTexturePoint
" --NURBSSelection
" --NURBSSet
" --NURBSSurfaceApproximation
" --NURBSTextureSurface
" --object
" --OkClass
" --OLEMethod
" --OLEObject
" --PathName
" --PickerControl
" --Point2
" --point3
" --Primitive
" --progressBar
" --Quat
" --RadioControl
" --Ray
" --RCMenu
" --RolloutClass
" --RolloutControl
" --RolloutFloater
" --SelectionSet
" --SelectionSetArray
" --Set: ObjectSet
" --SliderControl
" --SpinnerControl
" --StandardMaterialClass
" --StaticMethodInterface
" --String
" --StringStream
" --StructDef
" --subAnim
" --TextureClass
" --time
" --Timer
" --TriMesh
" --UndefinedClass
" --UnsuppliedClass
" --UserGeneric
" --ValueRef
" --VertexSelection
" --WindowStream
" --XRefScene
" --MAXWrapper
" ----atmospheric
" ------Fire_Effect
" ------Fog
" ------Missing_Atmospheric
" ------RenderEnvironment
" ------Volume_Fog
" ------Volume_Light
" ----BitmapIO
" ------Autodesk_Animator_Flic
" ------AVI
" ------BMP
" ------bmpio
" ------CIN
" ------CMB
" ------EPS_Image
" ------GIF
" ------IFL
" ------JPEG
" ------jpegio
" ------pngio
" ------Portable_Network_Graphics
" ------PSD_I_O
" ------QTime
" ------rgb
" ------RLA
" ------RPF
" ------Targa
" ------tgaio
" ------TIF
" ------YUV
" ----CustAttrib
" ------Missing_Custom_Attribute_Plugin
" ----filter
" ------Area
" ------Blackman
" ------Blendfilter
" ------Catmull_Rom
" ------Cook_Variable
" ------cubic
" ------Filter_kernel_plug_in_not_found
" ------Mitchell_Netravali
" ------Plate_Match_MAX_R2
" ------Quadratic
" ------Sharp_Quadratic
" ------Soften
" ------Video
" ----FloatController
" ------AudioFloat
" ------bezier_float
" ------Block
" ------Float_Expression
" ------float_list
" ------Float_Motion_Capture
" ------Float_Reactor
" ------float_script
" ------Float_Wire
" ------FloatList
" ------FloatReactor
" ------linear_float
" ------LOD_Controller
" ------Missing_Float_Control
" ------Noise_float
" ------On_Off
" ------SlaveFloat
" ------tcb_float
" ------Waveform_Float
" ------WireFloat
" ----GlobalUtilityPlugin
" ------MaxRenderer_COM_Server
" ------Plugin_Manager
" ----IKSolver
" ------IKHISolver
" ------IKLimb
" ----MasterBlockController
" ------Block_Control
" ------Master_Controller_plugin_not_found
" ------MasterBlock
" ------MasterList
" ----material
" ------Blend
" ------compositematerial
" ------DoubleSided
" ------doubleSidedMat
" ------Matte
" ------MatteShadow
" ------Missing_Mtl
" ------Morphermaterial
" ------Multimaterial
" ------multiSubMaterial
" ------NoMaterial
" ------RaytraceMaterial
" ------Shellac
" ------standard
" ------Standardmaterial
" ------TexOutputClass
" --------StandardTextureOutput
" ------textureMap
" --------Adobe_Photoshop_Plug_In_Filter
" --------Adobe_Premiere_Video_Filter
" --------bitmapTex
" --------Bitmaptexture
" --------Bricks
" --------Cellular
" --------cellularTex
" --------Checker
" --------Combustion
" --------compositeTexture
" --------CompositeTexturemap
" --------Dent
" --------dents
" --------falloff
" --------fallofftextureMap
" --------Flat_Mirror
" --------flatMirror
" --------Gradient
" --------Gradient_Ramp
" --------Marble
" --------Mask
" --------maskTex
" --------Missing_TextureMap
" --------Mix
" --------mixTexture
" --------Noise
" --------NoTexture
" --------output
" --------Particle_Age
" --------Particle_MBlur
" --------particleBlur
" --------Perlin_Marble
" --------perlinMarble
" --------Planet
" --------Raytrace
" --------Reflect_Refract
" --------reflectRefract
" --------RGB_Multiply
" --------RGB_Tint
" --------rgbMult
" --------rgbTint
" --------Smoke
" --------Speckle
" --------Splat
" --------Stucco
" --------Swirl
" --------Thin_Wall_Refraction
" --------thinWallRefraction
" --------Vertex_Color
" --------Water
" --------Wood
" ------TopBottom
" ------topBottomMat
" ------UVGenClass
" --------Missing_UVGen
" --------StandardUVGen
" ------XYZGenClass
" --------Missing_XYZGen
" --------StandardXYZGen
" ----Matrix3Controller
" ------IK_ControllerMatrix3Controller
" ------IKChainControl
" ------IKControl
" ------Link
" ------Link_Constraint
" ------lookat
" ------Missing_Matrix3_Control
" ------prs
" ------Slave_Control
" ------transform_script
" ------TVDummyControl
" ----modifier
" ------Affect_Region
" ------Bend
" ------BendMod
" ------Bevel
" ------Bevel_Profile
" ------CameraMap
" ------Cap_Holes
" ------ConvertToPatch
" ------CrossSection
" ------DeleteMesh
" ------DeletePatch
" ------DeleteSplineModifier
" ------Disp_Approx
" ------Displace
" ------Edit_Mesh
" ------Edit_Patch
" ------Edit_Spline
" ------Extrude
" ------Face_Extrude
" ------FFD_2x2x2
" ------FFD_3x3x3
" ------FFD_4x4x4
" ------FFD_Select
" ------FFD2x2x2
" ------FFD3x3x3
" ------FFD4x4x4
" ------FFDBox
" ------FFDCyl
" ------Fillet_Chamfer
" ------Flex
" ------HSDS_Modifier
" ------HSDSObject
" ------Lathe
" ------Lattice
" ------Linked_XForm
" ------LinkedXForm
" ------MaterialByElement
" ------Materialmodifier
" ------Melt
" ------Mesh_Select
" ------MeshSelect
" ------meshsmooth
" ------MIrror
" ------Missing_OSM
" ------Morpher
" ------MultiRes
" ------NCurve_Sel
" ------Noisemodifier
" ------Normalize_Spl
" ------Normalize_Spline
" ------Normalmodifier
" ------NSurf_Sel
" ------optimize
" ------Patch_Select
" ------PatchDeform
" ------PathDeform
" ------Point_Cache
" ------PointCache
" ------Poly_Select
" ------Preserve
" ------Push
" ------Relax
" ------Ripple
" ------Skew
" ------Skin
" ------SliceModifier
" ------smooth
" ------SmoothModifier
" ------Spherify
" ------SplineSelect
" ------Squeeze
" ------STL_Check
" ------Stretch
" ------surface
" ------SurfDeform
" ------Taper
" ------tessellate
" ------Trim_Extend
" ------Turn_to_Mesh
" ------Turn_to_Patch
" ------Turn_to_Poly
" ------Twist
" ------Unwrap_UVW
" ------UVW_Xform
" ------Uvwmap
" ------UVWUnwrap
" ------Vertex_Colors
" ------VertexPaint
" ------Vol__Select
" ------VolumeSelect
" ------Wave
" ------XForm
" ----MorphController
" ------Barycentric_Morph_Controller
" ------Cubic_Morph_Controller
" ------Missing_Morph_Control
" ----MPassCamEffect
" ------Depth_of_FieldMPassCamEffect
" ------Motion_BlurMPassCamEffect
" ------multiPassDOF
" ------multiPassMotionBlur
" ------Standin_for_missing_MultiPass_Camera_Effect_Plugin
" ----node
" ------camera
" --------Freecamera
" --------Missing_Camera
" --------Targetcamera
" ------GeometryClass
" --------Apollo_Param_Container
" --------apolloParamContainer
" --------Blizzard
" --------BoneGeometry
" --------BoneObj
" --------Boolean2
" --------Box
" --------C_Ext
" --------Capsule
" --------ChamferBox
" --------ChamferCyl
" --------Cone
" --------Conform
" --------Connect
" --------ControlContainer
" --------CV_Surf
" --------Cylinder
" --------Damper
" --------Editable_mesh
" --------Editable_Patch
" --------Editable_Poly
" --------EditablePolyMesh
" --------Gengon
" --------GeoSphere
" --------Hedra
" --------Hose
" --------L_Ext
" --------Loft
" --------LoftObject
" --------Mesher
" --------meshGrid
" --------Missing_GeomObject
" --------Morph
" --------Nurbs
" --------NURBS_Imported_Objects
" --------NURBSSurf
" --------OilTank
" --------OldBoolean
" --------PArray
" --------particleMesher
" --------PCloud
" --------Plane
" --------Point_Surf
" --------Point_SurfGeometry
" --------PolyMeshObject
" --------Prism
" --------Pyramid
" --------Quadpatch
" --------RingWave
" --------RmModel
" --------RmModelGeometry
" --------Scatter
" --------ShapeMerge
" --------SlidingDoor
" --------SlidingWindow
" --------Snow
" --------Sphere
" --------Spindle
" --------Spray
" --------Spring
" --------SuperSpray
" --------Targetobject
" --------Teapot
" --------Terrain
" --------Torus
" --------Torus_Knot
" --------TriMeshGeometry
" --------Tripatch
" --------Tube
" ------helper: Anchor AudioClip Background Billboard Bone BoxGizmo CamPoint Compass Cone_Angle ConeAngleManip CylGizmo Dummy Falloff_Manipulator
"         FalloffManip FogHelper grid Hotspot_Manip HotspotManip IK_Chain_Object IK_Swivel_Manip IKSwivelManip Inline LOD Missing_Helper NavInfo
"         Plane_Angle PlaneAngleManip Point PointHelperObj Position_Manip PositionManip Protractor ProxSensor radiusManip Reactor_Angle_Manip
"         Reactor_Vector_Handle_Manip
ReactorAngleManip
ReactorVectorHandleManip
Rotation_--
Rotation_Valuehelper
RotationValueManip
Slider_Manip
SliderManip
sliderManipulator
Sound
SphereGizmo
Tape
TimeSensor
TouchSensor
uvwMappingHeightManip
uvwMappingLengthManip
uvwMappingUTileManip
uvwMappingVTileManip
uvwMappingWidthManip
" ------light
" --------Directionallight
" --------freeSpot
" --------Missing_Light
" --------Omnilight
" --------TargetDirectionallight
" --------targetSpot
" ------NodeObject
" ------shape
" --------Arc
" --------Circle
" --------CV_Curve
" --------CV_Curveshape
" --------Donut
" --------Ellipse
" --------Helix
" --------line
" --------LinearShape
" --------Lines
" --------Missing_Shape
" --------Ngon
" --------NURBSCurveShape
" --------Point_Curve
" --------Point_Curveshape
" --------Rectangle
" --------section
" --------Simple_Shape
" --------Simple_Spline
" --------SplineShape
" --------Star
" --------text
" ------SpacewarpObject
" --------BendModWSM
" --------Bomb
" --------CameraMapSpaceWarp
" --------ConformSpaceWarp
" --------Deflector
" --------Drag
" --------gravity
" --------MapScalerSpaceWarp
" --------Missing_WSM_Object
" --------Motor
" --------Path_Follow
" --------PathDeformSpaceWarp
" --------PBomb
" --------PDynaFlect
" --------PDynaflector
" --------POmniFlect
" --------PushSpaceWarp
" --------SDeflector
" --------SDynaFlect
" --------SDynaflector
" --------SOmniFlect
" --------SpaceBend
" --------Spacedisplace
" --------SpaceFFDBox
" --------SpaceFFDCyl
" --------SpaceNoise
" --------Spaceripple
" --------SpaceSkew
" --------SpaceStretch
" --------SpaceTaper
" --------SpaceTwist
" --------Spacewave
" --------UDeflector
" --------UDynaDeflector
" --------UDynaFlect
" --------UOmniFlect
" --------Vortex
" --------Wind
" ------System
" --------Bones
" --------Missing_System
" --------Ring_Array
" --------Sunlight
" --------XRefObject
" ----ParamBlock
" ------ParamBlockParamBlock
" ----ParamBlock2----
" ------ParamBlock2ParamBlock2
" ----Point3Controller
" ------AudioPoint3
" ------bezier_color
" ------bezier_point3
" ------Color_RGB
" ------Missing_Point3_Control
" ------Noise_point3
" ------Point3_Expression
" ------point3_list
" ------Point3_Motion_Capture
" ------Point3_Reactor
" ------point3_script
" ------Point3_Wire
" ------Point3_XYZ
" ------Point3List
" ------Point3Reactor
" ------Point3Spring
" ------Slave_Point3
" ------SlavePoint3
" ------SpringPoint3Controller
" ------tcb_point3
" ------WirePoint3
" ----PositionController
" ------Attachment
" ------AudioPosition
" ------bezier_position
" ------Dynamics_Position_Controller
" ------linear_position
" ------Missing_Position_Control
" ------Noise_position
" ------path
" ------Path_Constraint
" ------Position_Constraint
" ------Position_Expression
" ------position_list
" ------Position_Motion_Capture
" ------Position_Reactor
" ------position_script
" ------Position_Wire
" ------Position_XYZ
" ------PositionList
" ------PositionReactor
" ------PositionSpring
" ------SlavePos
" ------SpringPositionController
" ------Sunlight_Slave_Controller
" ------Surface_position
" ------tcb_position
" ------WirePosition
" ----QuatController
" ----RadiosityEffect
" ------Missing_Radiosity
" ----ReferenceMaker
" ------CurveControl
" ------CustAttribContainer
" ------Deform_Curve
" ------HSUtil
" ------Material_Editor
" ------MeshCollision
" ------Missing_RefMaker
" ------MtlBaseLib
" ------MtlLib
" ------NamedSelSetList
" ------NodeNamedSelSet
" ------PlanarCollision
" ------Scene
" ------SphericalCollision
" ------StdDualVS
" ------Texmaps
" ------TexmapsReferenceMaker
" ----ReferenceTarget
" ------Auto_Secondary_Element
" ------Bulge_Angle_Deformer
" ------gizmoBulge
" ------gizmoJoint
" ------gizmoJointMorph
" ------Glow_Element
" ------Gradient_GradCtlData
" ------IK_Controller
" ------JAngleData
" ------JBinaryData
" ------JBoolData
" ------JColor3Data
" ------JColorData
" ------JFlagCtlData
" ------JFlagSetData
" ------JFloat3Data
" ------JFloatData
" ------JGradCtlData
" ------Joint_Angle_Deformer
" ------Joystick_Input_Device
" ------JPercent3Data
" ------JPercentData
" ------JSubtex
" ------JWorld3Data
" ------JWorldData
" ------LZFlare_AutoSec_Base
" ------LZFlare_AutoSec_Data
" ------LZFlare_Aux_Data
" ------LZFlare_Data
" ------LZFlare_Glow_Data
" ------LZFlare_Inferno_Data
" ------LZFlare_ManSec_Base
" ------LZFlare_ManSec_Data
" ------LZFlare_Prefs_Data
" ------LZFlare_Rays_Data
" ------LZFlare_Rend_Data
" ------LZFlare_Ring_Data
" ------LZFlare_Star_Data
" ------LZFlare_Streak_Data
" ------LZFocus_Data
" ------LZGlow_Aux_Data
" ------LZGlow_Data
" ------LZGlow_Rend_Data
" ------LZHilight_Aux_Data
" ------LZHilight_Data
" ------LZHilight_Rend_Data
" ------Manual_Secondary_Element
" ------MIDI_Device
" ------Missing_RefTarget
" ------Morph_Angle_Deformer
" ------Mouse_Input_Device
" ------Ray_Element
" ------Ray_Engine
" ------Raytrace_Engine_Global_Parameters
" ------Raytrace_Texture_ParamBlock
" ------RenderElementMgr
" ------Ring_Element
" ------Star_Element
" ------Streak_Element
" ------This_Data
" ------TVNode
" ----renderEffect
" ------blur
" ------Brightness_and_Contrast
" ------briteCon
" ------Color_Balance
" ------colorBalance
" ------Depth_of_Field
" ------DOFEffect
" ------File_Output
" ------fileOut
" ------Film_Grain
" ------FilmGrain
" ------imageMotionBlur
" ------Lens_Effects
" ------Missing_Render_Effect
" ------Motion_Blur
" ----RenderElement
" ------Alpha
" ------alphaRenderElement
" ------Atmosphere
" ------atmosphereRenderElement
" ------BackgroundRenderElement
" ------Beauty
" ------beautyRenderElement
" ------bgndRenderElement
" ------BlendRenderElement
" ------clrShadowRenderElement
" ------Colored_Shadow
" ------Diffuse
" ------diffuseRenderElement
" ------emissionRenderElement
" ------Missing_Render_Element_Plug_in
" ------Reflection
" ------reflectionRenderElement
" ------Refraction
" ------refractionRenderElement
" ------Self_Illumination
" ------ShadowRenderElement
" ------Specular
" ------specularRenderElement
" ------Z_Depth
" ------ZRenderElement
" ----RendererClass
" ------Default_Scanline_Renderer
" ------DefaultScanlineRenderer
" ------Missing_Renderer
" ------VUE_File_Renderer
" ----RotationController
" ------AudioRotation
" ------bezier_rotation
" ------Dynamics_Rotation_Controller
" ------Euler_XYZ
" ------linear_rotation
" ------Local_Euler_XYZ
" ------LookAt_Constraint
" ------Missing_Rotation_Control
" ------Noise_rotation
" ------Orientation_Constraint
" ------rotation_list
" ------Rotation_Motion_Capture
" ------Rotation_Reactor
" ------rotation_script
" ------Rotation_Wire
" ------RotationList
" ------RotationReactor
" ------SlaveRotation
" ------tcb_rotation
" ------WireRotation
" ----ScaleController
" ------AudioScale
" ------bezier_scale
" ------linear_scale
" ------Missing_Scale_Control
" ------Noise_scale
" ------Scale_Expression
" ------scale_list
" ------Scale_Motion_Capture
" ------Scale_Reactor
" ------scale_script
" ------Scale_Wire
" ------ScaleList
" ------ScaleReactor
" ------ScaleXYZ
" ------SlaveScale
" ------tcb_scale
" ------WireScale
" ----Shader
" ------Anisotropic
" ------Blinn
" ------Blinn2
" ------BlinnShader
" ------Metal
" ------Metal2
" ------Missing_Shader_Plug_in
" ------Multi_Layer
" ------MultiLayer
" ------Oren_Nayar_Blinn
" ------OrenNayarBlinn
" ------Phong
" ------Phong2
" ------Strauss
" ----Shadow: raytraceShadow 
" ----SpacewarpModifier
" ------Bombbinding
" ------Deflectorbinding
" ------Displace_Mesh
" ------Displace_NURBS
" ------Displacebinding
" ------DragMod
" ------FFD_Binding
" ------Gravitybinding
" ------MapScaler
" ------Missing_WSM
" ------MotorMod
" ------Particle_Cache
" ------ParticleCache
" ------Path_FollowMod
" ------PBombMod
" ------PDynaFlectMod
" ------Point_CacheSpacewarpModifier
" ------PointCacheWSM
" ------POmniFlectMod
" ------PushMod
" ------Ripplebinding
" ------SDeflectMod
" ------SDynaFlectMod
" ------SimpleOSMToWSMMod
" ------SOmniFlectMod
" ------SpaceCameraMap
" ------SpaceConform
" ------SpacePatchDeform
" ------SpacePathDeform
" ------SpaceSurfDeform
" ------Surface_Mapper
" ------UDeflectorMod
" ------UDynaFlectMod
" ------UOmniFlectMod
" ------VortexMod
" ------Wavebinding
" ------Windbinding
" ----ToneOperator
" ------Automatic_Exposure_Control
" ------AutomaticAdaptiveExposureControl
" ------Missing_Exposure_Control
" ----UtilityPlugin
" ------ASCII_Object_Output
" ------Asset_Browser
" ------Assign_Vertex_Colors
" ------Camera_Match
" ------Camera_Tracker
" ------collapse
" ------Color_Clipboard
" ------COM_DCOM_Server_Control
" ------Dynamics
" ------Follow_Bank
" ------IFL_Manager
" ------Level_of_Detail
" ------Link_Inheritance__Selected
" ------MapPath_Editor
" ------MAX_File_Finder
" ------MAXScript
" ------Measure
" ------Motion_Capture
" ------Polygon_Counter
" ------Rescale_World_Units
" ------Reset_XForm
" ------Resource_Collector
" ------Shape_Check
" ------Strokes
" ------Surface_Approximation
" ------UVW_Remove
" ------Visual_MAXScript
" ------VisualMSUtil
"   Language Reserved Keywords
" about and animate as at by case catch collect continue coordsys do else exit fn for from function global if in local macroscript mapped max not of off on or
" parameters persistent plugin rcmenu return rollout set struct then throw to tool try undo utility when where while with
"   Punctuation && Symbols
" ( ) + * - / ^ += -= *= /= -- = ; <eol> , [ ] : ' & .  { } # == != < > >= <= ?  $ ...  ..  \ 
"   Predefined          Globals
" true false on off pi e red green blue white black orange yellow brown gray x_axis y_axis z_axis ok undefined unsupplied dontcollect
"   3DSMax       System Globals
" activeGrid ambientColor ambientColorController animationRange animButtonEnabled animButtonState autoBackup.enabled autoBackup.time backgroundColor
" 2do
" backgroundColorController
" Lets you get and set a Controller value that defines the global rendering environment (Rendering > Environment) background color controller. See Working with 3ds Max Atmospherics.
" backgroundImageFileName
" Lets you get and set a String value that defines the viewport background image bitmap file name. This variable contains the corresponding bitmap file name set in the Viewport Background dialog. See Viewport Background Images.
" C
" cui.commandPanelOpen
" Lets you get and set whether the command panel is displayed. A Boolean value - true if the command panel is displayed, false if not displayed. See Command Panels.
" currentMaterialLibrary
" Contains a virtual array of materials and root level maps corresponding to the currently opened material library. You can get library materials via array indexing and iterate over them in a for loop. The array can be indexed by number, or by name or string to select by material name. This variable is read-only. See MaterialLibrary Values.
" D
" displayGamma
" fileInGamma
" fileOutGamma
" Lets you get and set Float values that define the gamma preference settings. They contain the corresponding values set in the Gamma tab of the Preferences dialog. You could use these global variables to establish gamma for a MAXScript-created bitmap, 
" For Example:
" b = bitmap 320 240 gamma:displayGamma
" render camera:c to:b
" This would cause the rendered bitmap to display using the current displays gamma setting if used as a rollout bitmap or button image.
" displaySafeFrames
" Lets you get and set whether Show Safe Frames is on for the active viewport. A Boolean value - true if Show Safe Frames is on, false if off.
" E
" environmentMap
" Lets you get and set a TextureMap value that defines the global rendering environment (Rendering > Environment) environment map. See Working with 3ds Max Atmospherics.
" F
" flyOffTime
" Lets you get and set an Integer value that defines the time in milliseconds the user must hold down on a flyout before the flyout is activated. This variable contains the corresponding value set in the General tab of the Preferences dialog.
" frameRate
" Lets you get and set an Integer value that defines the current scene frame rate in frames-per-second. This variable contains the corresponding value set in the Time Configuration dialog. See Time Configuration Dialog.
" G
" globalTracks
" Contains a MAXTVNode value that defines the top-level Global Tracks node in Track View. This variable is read-only. See Track View Nodes.
" H
" hardwareLockID
" Contains an Integer value that defines the 3ds Max hardware lock ID. This variable is read-only.
" hotspotAngleSeparation
" Contains a Float value that defines the Hot Spot/FallOff Angle Separation value. This variable contains the corresponding value set in the Rendering tab of the Preferences dialog. This variable is read-only.
" K
" keyboard.shiftPressed
" keyboard.controlPressed
" keyboard.altPressed
" keyboard.escPressed
" These variables access the current state of the keyboard shift, control, alt and escape keys and return true or false depending on the pressed state of the key at the time the variable is read and are read-only variables.
" L
" lightTintColor
" Lets you get and set a Color value that defines the global rendering environment (Rendering > Environment) Global Lighting Tint color. See Working with 3ds Max Atmospherics.
" lightTintColorController
" Lets you get and set a Controller value that defines the global rendering environment (Rendering > Environment) Global Lighting Tint color controller. See Working with 3ds Max Atmospherics.
" lightLevel
" Lets you get and set a Float value that defines the global rendering environment (Rendering > Environment) Global Lighting Tint Level. See Working with 3ds Max Atmospherics.
" lightLevelController
" Lets you get and set a Controller value that defines the global rendering environment (Rendering > Environment) Global Lighting Tint Level controller. See Working with 3ds Max Atmospherics.
" listener 
" Read only system global - listener edit window <WindowStream> value
" localTime
" Contains a String value that defines the current local date and time. This variable is read-only. An example of the value stored in localtime is:
" s = localTime
" "4/14/97 10:24:57 AM"
" The format of this string is controlled by the date format selected in the
" main Windows Regional Settings control panel.
" logsystem.quietmode
" Lets you get and set whether error logging quiet mode is enabled. A Boolean
" value set to true when you do not want error messages from the renderer to
" bring up dialog boxes. If set to false, error messages from the renderer will
" bring up dialog boxes. 3ds Max sets the corresponding internal variable to
" true during network rendering to suppress error messages such as the "Missing
" Maps" and "Missing Map Coordinates" dialogs. If this variable is set to true
" and the renderer generates an error message, the renderer will exit. After
" setting quiet mode, do not forget to clear it when you are done, since the
" user will not see any error messages from the renderer while quiet mode is
" enabled.
" M
" macroRecorder
" Read only system global - macro recorder edit window <WindowStream> value
" manipulateMode
" Get/set the 3ds Max manipulate mode. When true, manipulate mode is active.
" maxFileName
" Contains a String value that defines the file name for the currently open
" scene. This variable is read-only.
" maxFilePath
" Contains a String value that defines the directory path for the currently
" open scene. This variable is read-only.
" maxOps.productAppID : enum : Read
" productAppID enums: {#none|#max|#viz|#gmax}
" The enum values returned are as follows:
" #none - no ID
" #max - 3ds Max 
" #viz - Autodesk VIZ
" #gmax - gmax
" meditMaterials
" Contains a virtual array of materials and root level maps corresponding to
" the slots in the material editor. You can access material editor materials
" and root level maps via array indexing and iterate over them in a for loop.
" The array can be indexed by number to specify slot number or name or string
" to select by material and root level map name. 
" Example:
" $foo.material = meditMaterials[1]
" meditMaterials["foo mat"].diffuse = red
" for m in meditMaterials do print m.diffuseMap
" meditMaterials[1]=standard()
" print meditMaterials.count -- number of slots
" This variable is read-only, but the elements (the materials in the slots) are
" assignable. See MaterialLibrary Values. See Material Editor for methods for
" assigning materials and maps to the material editor slots.
" N
" numEffects
" Contains an Integer value that defines the number of current render effects
" defined in the Rendering > Effects dialog list. This variable is read-only.
" See RenderEffect.
" numAtmospherics
" Contains an Integer value that defines the number of atmospheric events, as
" shown in Rendering > Environment. This variable is read-only. See Working
" with 3ds Max Atmospherics.
" numSubObjectLevels
" Lets you get the number of sub-object levels supported by the object or
" modifier currently selected in the modifier stack. If the Modify panel is not
" open or no objects are selected, the global contains the value undefined. See
" Modify Panel.
" Note: 
" The subObjectLevel and numSubObjectLevels system global variables return
" values other than 'undefined' if you are in the Motion panel. At the top of
" the Motion panel there is a Selection Level/Sub-Object drop-down list. This
" is for Trajectory mode, and switches you in and out of Keys SO mode. Because
" of this, the test (subobjectlevel != undefined) is not a valid test of
" whether you are in the Modify panel. Instead, use the test
" (getCommandPanelTaskMode() == #modify).
" O
" 
" P
" playActiveOnly
" Lets you get and set whether to playback the active viewport only. This
" variable contains the corresponding value set in the Time Configuration
" dialog. A Boolean value - true if Active Viewport Only is on, false if off.
" See Time Configuration Dialog.
" preferences.constantReferenceSystem
" Lets you get and set whether to use the same coordinate system for the Move,
" Rotate, and Scale tools in the 3ds Max toolbar. A Boolean value - true if
" Constant is on, false if off. This variable matches the Constant check box
" in the General page of Customize > Preferences.
" preferences.dontRepeatRefMsg
" A PRS animation controllers message notification system optimization was
" introduced in 3ds Max 6 and was enabled by default. It speeds up complex
" rigs using multiple animation controllers. When set to true, the
" optimization is enabled and no redundant notifications are sent by the
" controllers. When set to false, the animation system behaves as in 3ds Max 5
" and earlier.
" preferences.flyOffTime
" Lets you get and set an Integer value that defines the time in milliseconds
" the user must hold down on a flyout before the flyout is activated. This
" variable contains the corresponding value set in the General page of
" Customize > Preferences.
" preferences.InvalidateTMOpt
" An optimization was introduced in 3ds Max 7 that checks to see if a node has
" already been invalidated before sending out notifications to it's dependents
" that it has been changed. It speeds up complex rigs, especially those that
" involve the new expose transform helper. When set to true, the optimization
" is enabled and multiple notifications will not be sent out. When set to
" false, the animation system behaves as in 3ds Max 6 and earlier. It is true
" by default. 
" preferences.maximumGBufferLayers
" Lets you get and set an Integer value that specifies the maximum number of
" g-buffer layers generated during a render.
" preferences.spinnerWrap
" Lets you get and set a Boolean value that defines whether cursor wrapping is
" limited to an area close to the spinner when you drag to adjust spinner
" value. This variable contains the corresponding value set in the General
" page of Customize > Preferences.
" preferences.spinnerPrecision 
" This integer value defines the number of decimal digits displayed by
" spinners.Corresponds to the Precision value in the Spinners group in
" Customize > Preferences > General.
" preferences.spinnerSnap
" This float value defines the spinner snap value. Corresponds to the Snap
" value in the Spinners group in Customize > Preferences > General.
" preferences.useSpinnerSnap
" This Boolean value defines whether to use the spinner snap. Corresponds to
" the Use Snap checkbox in the Spinners group in Customize > Preferences >
" General.
" preferences.useLargeVertexDots
" Lets you get and set whether to use small or large dots when representing
" vertices as dots. A Boolean value set to true if you when using dots to
" represent vertices and a large size is desired. The value of this variable
" only has effect when UseVertexDots is set to true. This variable contains
" the corresponding value set in the Viewports page of Customize >
" Preferences.
" preferences.useTransformGizmos
" Lets you get and set whether to use the Transform Gizmos. A Boolean value -
" true if on, false if off. This variable contains the corresponding value set
" in the Viewports page of Customize > Preferences.
" preferences.useVertexDots
" Lets you get and set whether to represent vertices as dots. A Boolean value
" set to true when you want to use dots as the representation of the vertices
" in a mesh. If set to false, ticks will be used. This variable contains the
" corresponding value set in the Viewports page of Customize > Preferences.
" Q
" 
" R
" realTimePlayback
" Lets you get and set whether to playback in real time mode. This variable
" contains the corresponding value set in the Time Configuration dialog. A
" Boolean value - true if Real Time is on, false if off. See Time
" Configuration Dialog.
" renderer
" In versions prior 3ds Max 6, this global variable was used to get and set
" the renderer type (#production or #draft). The #draft renderer option has
" been removed from 3ds Max 6, making this variable obsolete. It only
" accepts and returns #production now and is kept for backwards
" compatibility of scripts from earlier versions that might be checking this
" value.
" renderDisplacements
" Lets you get and set whether to perform displacement mapping during a
" render. A Boolean value - true if displacement mapping is to be performed,
" false if not.
" renderEffects
" Lets you get and set whether to perform Render Effects after a scene
" render. A Boolean value - true if Render Effects are to be performed,
" false if not.
" renderHeight
" Lets you get and set an Integer value that defines the output size height
" for the active renderer. This variable contains the corresponding value
" set in the Render Scene dialog. See Render Scene Dialog.
" renderPixelAspect
" Lets you get and set an Integer value that defines the output pixel aspect
" for the active renderer. This variable contains the corresponding value
" set in the Render Scene dialog.
" renderWidth
" Lets you get and set an Integer value that defines the output size width
" for the active renderer. This variable contains the corresponding value
" set in the Render Scene dialog. See Render Scene Dialog.
" rendOutputFilename
" Lets you get and set a String value that defines the output file name for
" the active renderer. This variable contains the corresponding value set in
" the Render Scene dialog. If this global variable is set to "" the Save
" File check box in the Render Scene dialog is unchecked.
" rendSimplifyAreaLights
" When set to true, area lights will be examined and converted to point light sources when appropriate. 
" Note 
" There is also an equaly-named parameter to the render() command to achieve this behavior.
" rootNode
" Contains a Node value that defines the root node of the scene. The root node does not physically exist in the scene, rather it is a special node that is the parent node of all nodes that are not linked to another node. The scene can be enumerated by accessing the children property of the root node. A run-time error is generated if you try to perform other node operations on the root node.
" S
" sceneMaterials
" Contains a virtual array of materials and root level maps corresponding to the materials and root level maps present in the scene. You can get scene materials and root level maps via array indexing and iterate over them in a for loop. The array can be indexed by number, or by name or string to select by material or root level map name. This variable is read-only. See MaterialLibrary Values.
" scriptsPath
" Contains a String value that defines the full directory path to the current Scripts directory. This variable is read-only.
" selectionSets
" Contains a virtual array of all the current named node selection sets in the Named Selection Set drop-down list on the 3ds Max toolbar. You can get named selection sets via array indexing and iterate over them in a for loop. The array can be indexed by number, or by name or string to select by named selection sets. You can change, add and delete Named Selection Sets by using the standard array methods on the selectionSets array. See SelectionSetArray Values.
" showEndResult
" Lets you get and set the state of the Show End Result Toggle icon in the Modify panel. A Boolean Value - true if Show End Result is on, false if off. See Modify Panel.
" skipRenderedFrames
" Lets you get and set whether to skip rendered frames during a render. A Boolean Value - true if rendered frames are to be skipped, false if not.
" sliderTime
" Lets you get and set a Time value that defines the time associated with the 3ds Max time slider. See Time Control.
" snapMode.active
" Lets you get and set a Boolean value defining the Snap toggle state - on (true) or off (false). See Status Bar Buttons.
" snapMode.type
" Lets you get and set a Name value defining whether 2D (#2D), 2.5D (#2_5D), or 3D (#3D) is the current snap type. See Status Bar Buttons.
" subObjectLevel
" Lets you get and set the sub-object level in the Modify panel if it is open. An Integer value of zero or greater up to the number of sub-object levels supported by the currently open modifier, typically in the order shown in the Sub-Object drop-down list. A subObjectLevel of 0 means sub-object mode is off. If the Modify panel is not open or sub-object level setting not permitted in the current modifier, the global contains the value undefined. Use the numSubObjectLevels global variable to access the maximum valid subObjectlevel value. See Modify Panel. 
" Example:
" b=box() -- create a box
" em=edit_mesh() -- create an Edit Mesh modifier
" addModifier $box01 em -- add edit mesh mod
" max modify mode -- open mod panel
" select $box01 -- select object box01
" print subObjectLevel -- print the current subobject level
" subObjectLevel = 2 -- set sub-object level to Edge
" Note: 
" The subObjectLevel and numSubObjectLevels system global variables return values other than 'undefined' if you are in the Motion panel. At the top of the Motion panel, there is a Selection Level/Sub-Object drop-down. This is for Trajectory mode, and switches you in and out of Keys SO mode. 
" Because of this, the test (subobjectlevel != undefined) is not a valid test of whether you are in the Modify panel. Instead, use the test (getCommandPanelTaskMode() == #modify).
" sysInfo.DesktopSize
" A read only variable to get the desktop size in pixels as a <point2> value. See also System Information and getMAXWindowSize() under Miscellaneous Functions 
" sysInfo.DesktopBPP
" A read only variable to get the desktop color depth in bits per pixel as an <integer> value. See also System Information
" sysInfo.MAXPriority
" Get/set the 3ds Max process priority as a <name> value. Valid priority values are #high, #normal, and #low. See also System Information
" T
" ticksPerFrame
" Lets you get and set an Integer value defining the system time resolution. There are always 4800 ticks per second, this means that ticksPerFrame is dependent on the frames per second rate 
" (ticksPerFrame * frameRate == 4800)
" timeConfiguration.playActiveOnly
" Lets you get and set whether to playback the active viewport only. This variable contains the corresponding value set in the Time Configuration dialog. A Boolean value - true if Active Viewport Only is on, false if off. See Time Configuration Dialog.
" timeConfiguration.realTimePlayback
" Lets you get and set whether to playback in real time mode. This variable contains the corresponding value set in the Time Configuration dialog. A Boolean value - true if Real Time is on, false if off. See Time Configuration Dialog.
" timeConfiguration.PlaybackSpeed
" Lets you get and set the viewport playback speed mode. See Time Configuration Dialog.
" timeConfiguration.PlaybackLoop
" Get/set whether to loop the viewport playback. Only used when timeConfiguration.realTimePlayback is set to true. See Time Configuration Dialog. Available in 3ds Max 8 and higher.
" timeConfiguration.useTrackBar
" Lets you get and set the state of the Time Configuration dialog 'Key Steps / Use TrackBar' check box. A Boolean value - true if checked, false if not. See Time Configuration Dialog.
" toolMode.coordSysNode
" A read/write variable containing a node value or undefined. This variable reflects which node, if any, is the current reference coordinate system node. Assignment to this variable must be a node value.
" trackbar.filter
" Lets you get and set the filter specifying which types of keys to show in the Trackbar. A Name value - the valid values are: #all, #TMOnly, #currentTM, #object, and #mat.
" trackbar.visible
" Lets you get and set whether the trackbar is visible. A Boolean value - true if the trackbar is visible, false if invisible
" trackViewNodes
" Contains a MAXTVNode value that defines top-level World node in Track View. This variable is read-only. See Track View Nodes.
" U
" units.DisplayType
" Get/set the current unit display type as a <name>. Valid unit display types are:
" #Generic
" #Metric
" #US
" #custom
" units.MetricType
" Get/set the current metric unit display type as a <name>. Valid metric unit display types are:
" #Millimeters
" #Centimeters
" #Meters
" #Kilometers
" units.USType
" Get/set the current US standard unit display type as a <name>. Valid US standard unit display types are:
" #Frac_In
" #Dec_In
" #Frac_Ft
" #Dec_Ft
" #Ft_Frac_In
" #Ft_Dec_In
" units.USFrac
" Get/set the current US fraction display type as a <name>. Valid US fraction display types are:
" #Frac_1_1
" #Frac_1_2
" #Frac_1_4
" #Frac_1_8
" #Frac_1_10
" #Frac_1_16
" #Frac_1_32
" #Frac_1_64
" #Frac_1_100
" units.CustomName
" Get/set the current custom unit name as a <string>
" units.CustomValue
" Get/set the current custom unit value as a <float>
" units.CustomUnit
" Get/set the current custom unit type as a <name>. Valid custom unit display types are:
" #Inches
" #Feet
" #Miles
" #Millimeters
" #Centimeters
" #Meters
" #Kilometers
" units.SystemScale
" Get/set the current system unit scale value as a <float>. This is the value shown in Customize Units Setup... > System Units Setup > System Units Scale group.
" units.SystemType
" Get/set the current system unit scale type as a <name>. This is the unit shown in Customize > Units Setup... > System Units Setup > System Units Scale group. Valid system unit scale types are:
" #Inches
" #Feet
" #Miles
" #Millimeters
" #Centimeters
" #Meters
" #Kilometers
" useEnvironmentMap
" Lets you get and set the global rendering environment (Rendering > Environment) Use Map value. A Boolean value - true if Use Map is on, false if off. See Working with 3ds Max Atmospherics.
" V
" videoPostTracks
" Contains a MAXTVNode value that defines the top-level Video Post Track View node. This variable is read-only. See Track View Nodes. This variable contains the value undefined in Autodesk VIZ.
" viewport.activeViewport
" Lets you get and set the index of the active viewport. See Accessing Active Viewport Info, Type, and Transforms.
" viewport.numViews
" Contains the number of viewports in the current viewport layout. This variable is read-only. See Accessing Active Viewport Info, Type, and Transforms.
" Scanline Renderer Specific System Global Variables
" The following 3ds Max system global variables are specific to 3ds Max’s default scanline A-Buffer renderer. These variables return undefined if the current renderer is not 3ds Max’s default scanline A-Buffer renderer.
" scanlineRender.antiAliasFilter
" Lets you get and set the anti-aliasing filter. For a list of all of the anti-aliasing filters you can say:
" showClass "*:filter*"
" Example:
" scanlineRender.antiAliasFilter = quadratic()
" The anti-aliasing filters and their parameters are described in 3ds Max Scanline A-Buffer Renderer Anti-Aliasing Filters.
" scanlineRender.antiAliasFilterSize
" Contains a float value that defines the anti-aliasing filter size.
" scanlineRender.enablePixelSampler
" Lets you enables and disables global super sampling. A Boolean value - true if Disable all Samplers is off, false if on.
" "      MaxScript System Globals - These give access to the MaxScript system state. You can access and assign to them as noted.
" currentTime
" Contains a Time value that defines the current evaluation time in frames as set by the at time context expression currently in force. This is useful in functions that need to do time-relative computations that may be called from code that sets working animation time. If there is no at time context in force, currentTime contains the current user interface slider time, unless a render is in progress. If a render is being performed, currentTime contains the frame being rendered. This variable is read-only.
" editorFont
" Lets you get and set a String value that defines the font name for script Editor windows. Setting this variable effects all currently open and future script Editor and MAXScript Listener windows. This variable contains the corresponding value set in the MAXScript page of Customize > Preferences.
" editorFontSize
" Lets you get and set an Integer value defining the font point size for script Editor. Setting this variable effects all currently open and future script Editor and MAXScript Listener windows. This variable contains the corresponding value set in the MAXScript page of Customize > Preferences.
" editorShowPath
"  NEW in 3ds Max 9: This system global variable controls whether the MAXScript Editor will display the full path of the edited script (true, default in 3ds Max 9), or only the file name (false, the only mode prior to 3ds Max 9). 
"  editorTabWidth
"  Lets you get and set an Integer value defining the tab width (in characters) for script Editor windows. Setting this variable effects all currently open and future script Editor windows. This variable contains the corresponding value set in the MAXScript page of Customize > Preferences.
"  escapeEnable
"  Lets you get and set a Boolean value defining whether ESC key interrupt detection is on or off. Setting enableEscape to false turns ESC key interrupt detection off, setting it to true turns it on again. This variable is useful when used in conjunction with a Progress Bar. You can set enableEscape to false when you don't want the user to be able to interrupt a script running a long computation and you have set up a progress bar with its own Cancel button. See Progress Bar Display.
"   NEW in 3ds Max 9: The default value of this variable has been changed to false. It used to be true in previous versions of 3ds Max.
"   heapFree
"   Contains an Integer64 value defining the current amount of free memory in the MAXScript heap. This value will vary constantly depending on where MAXScript is in its collection regime. This variable is read-only.
"    NEW in 3ds Max 9: The value type of this variable has been changed from Integer to Integer64 to accommodate the increased memory space of 64 bit systems.
"    heapSize
"    Lets you get and set an Integer64 value defining the size of the heap currently allocated to MAXScript. MAXScript carves its own working memory (called a heap) out of the memory that 3ds Max has allocated. 
"    You can add to this heap at any time by assigning the new size to this system variable, 
"    as in:
"    heapSize += 1000000 -- another meg please
"    See also Memory Allocation and Garbage Collection.
"     NEW in 3ds Max 9: The value type of this variable has been changed from Integer to Integer64 to accommodate the increased memory space of 64 bit systems.
"     inputTextColor
"     Lets you get and set a Color value defining the color of typed input text in Listener.
"     messageTextColor
"     Lets you get and set a Color value defining the color of error message text in Listener.
"     outputTextColor
"     Lets you get and set a Color value defining the color of output text in Listener.
"     options.oldPrintStyles
"     The printed form of all basic data value types, except for BigArray, are directly readable by the readValue() and readExpr() functions, making it simpler to read back in values printed to a file by MAXScript. If the pre-3ds Max 4 print forms are required for compatibility with existing scripts, you can set this variable to true.
"     options.showGCStatus
"     When set to true, the message "MXS GC" will be displayed in the status bar during MAXScript Garbage Collection. When set to false, no message will be displayed. The setting is stored in the 3dsmax.ini file in the [MAXScript] section. Available in 3ds Max 8 and higher.
"     stackLimit
"     The stack is region of reserved memory in which MAXScript temporarily stores status data such as procedure and function call return addresses, passed parameters, and local variables. 
"     In versions prior to 3ds Max 9, this defaulted to 1024000 bytes. Certain scripts that contain recursive algorithms could exceed this limit and generate a runtime error. You could assign to the stackLimit variable to increase the stack size available.
"      NEW in 3ds Max 9: In 3ds Max 9, the stack limit has been increased to 2048000 bytes but you cannot effectively change the size anymore. Assigning to the stackLimit variable will not change the stack size. 
"      ?'
"      A special variable that is used only in the context of the MAXScript Listener. This variable contains the result of the last expression evaluated in the Listener. For more details, see Using the '?' Symbol.
" parenthesis sanity checker
sy region  maxscriptZone              matchgroup=Delimiter start="("  matchgroup=Delimiter end=")" transparent contains=ALLBUT,maxscriptError
sy region  maxscriptZone              matchgroup=Delimiter start="\[" matchgroup=Delimiter end="]" transparent contains=ALLBUT,maxscriptError
sy match   maxscriptError             "[)\]}]"
"sy match   maxscriptBraceError        "[)}]"   contained
"sy match   maxscriptCurlyError        "[)\]]"  contained
"sy match   maxscriptParenError        "[\]}]"  contained
sy match   maxscriptComma             "[,;:]"
sy match   maxscriptComma             "\.\.\.$"
" A bunch of useful maxscript keywords
sy case    ignore
sy keyword maxscriptFuncCmd           fn function utility
sy keyword maxscriptType              global local             value state items
"sy keyword maxscriptStatement         execute  exit  pause  return  undefine
sy keyword maxscriptConditional       if then else elseif
sy keyword maxscriptRepeat            while do for in
sy keyword maxscriptCmd               checkbox spinner on
sy keyword maxscriptFunc              range open close okToClose resized moved changed checked pressed pos center
sy case    match
" Labels (supports maxscript's goto)
sy match   maxscriptLabel             "^\s*<[a-zA-Z_][a-zA-Z0-9]*>"
" String and Character constants
" Highlight special characters (those which have a backslash) differently
sy match   maxscriptSpecial                                                contained "\\\d\d\d\|\\."
sy region  maxscriptString            start=+"+  skip=+\\\\\|\\"+  end=+"+ contains=maxscriptSpecial,@Spell
sy match   maxscriptOperator           "[*=+-]"
sy match   maxscriptCharacter         "'[^\\]'"
sy match   maxscriptSpecialChar         "'\\.'"
sy match   maxscriptNumber            "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
" Comments:
" MaxScript supports --...  (to EndOfLine) && /* ... */ comment blocks (like C/C++)
sy cluster maxscriptCommentGroup                          contains=maxscriptString,maxscriptTodo,@Spell
sy keyword maxscriptTodo                                  contained  COMBAK  DEBUG  FIXME  Todo  TODO  XXX
sy match   maxscriptComment                 "--.*$"       contains=@maxscriptCommentGroup
"sy region  maxscriptCommentBlock      start="/*" end="*/" contains=@maxscriptCommentGroup
" synchronizing
"sy sync    match maxscriptSyncComment grouphere  maxscriptCommentBlock "/*"
"sy sync    match maxscriptSyncComment groupthere NONE                  "*/"
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if   version >= 508 || !exists("did_maxscript_syntax_inits")
  if version <  508
    let                         did_maxscript_syntax_inits = 1
    com -nargs=+ HiLink hi     link <args>
  el
    com -nargs=+ HiLink hi def link <args>
  en
  HiLink maxscriptBraceError       maxscriptError
  HiLink maxscriptCmd              maxscriptStatement
  HiLink maxscriptCommentBlock     maxscriptComment
  HiLink maxscriptCurlyError       maxscriptError
  HiLink maxscriptFuncCmd          maxscriptStatement
  HiLink maxscriptParenError       maxscriptError
  " The default methods for highlighting.  Can be overridden later
  HiLink maxscriptCharacter        Character
  "HiLink maxscriptComma            Delimiter
  HiLink maxscriptComma            Type
  HiLink maxscriptComment          Comment
  HiLink maxscriptCommentBlock     Comment
  HiLink maxscriptConditional      Conditional
  HiLink maxscriptError            Error
  HiLink maxscriptFunc             Function
  HiLink maxscriptLabel            PreProc
  HiLink maxscriptNumber           Number
  HiLink maxscriptOperator         PreProc
  HiLink maxscriptRepeat           Repeat
  HiLink maxscriptSpecial          Type
  HiLink maxscriptSpecialChar      SpecialChar
  HiLink maxscriptStatement        Statement
  HiLink maxscriptString           String
  HiLink maxscriptTodo             Todo
  HiLink maxscriptType             Type
  delc HiLink
en
let b:current_syntax = "maxscript"
" vim: ts=17
