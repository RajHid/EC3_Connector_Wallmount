// * Discription what the *.scad is about ect.
// Wall mount for EC3 Plgs to make a put troug for connekting a Prusa printer PSU to a enclosed Printer

// The Connectors are very similar:
// The housing of Female connector has a plastic casing that fits in the male plastic casing
// The Female electric Connektor is the one that recives the male slotted one (banana) connector whith springs on the outside

// ==================================
// = Used Libraries =
// ==================================
// Used Librareis and usage
// == Threads ==

//use <threadlib/threadlib.scad>
// LINK:
//// https://github.com/adrianschlatter/threadlib
// USAGE:
//// bolt("M6", turns=10, higbee_arc=30);
//// tap , bolt, nut

//m6();  
/*
module m6(){
    union(){
        difference(){
            cylinder(h=5,d1=25,d2=25, $fn=4);
            bolt("M6", turns=6, higbee_arc=30); // tap , bolt, nut
            translate([12.5,0,5]){
            //cube([25,25,10],center=true);
            }
        }
    }
}
*/

// ==================================
// = Variables =
// ==================================

// == Direct Input Variables ==


//// EC3 Dimensions
EnclosurWallThicknes=3;

ElektricalConnectorDistance=8.4;
EC3_CaseWidth_x=16.60;
EC3_CaseWidth_y=8.00;
EC3_CaseHeight_z=17.50;
RoundBaseCutout_D=6.2;
CutDepth=1.5;
BrimHeight_z=0.5;
PlugChamfer_z=2;
PlugChamferAspRat=1.25;

EC3_Plug_Scale=1.025;
EC3_PlugPutThroughScale=1.2; // is applied in 2D_Base_Shape_EC3_Plug_Putthrough()

//// Case Dimensions

Case_CaseWidth_x=40.00;
Case_CaseWidth_y=20.00;
Case_CaseHeight_z=17.50;


// ==== Dimensions Female EC3 plug ==== 
FemCaseHeight_z=8.10;
FemCaseWidth_y=6.40;

// ==== Dimensions Male EC3 plug ==== 


EC3TubeHeight_z=8.10;
MalCaseHeight_z=8.10;
MalCaseWidth_y=8.00;

// === 1 ===
Insulation_D=5.00;
InsulationLength_z=10;

// === 2 ===
WallCasePlugSideHeight_z=EC3_CaseHeight_z; // ???

// === 3 ===

WallCaseHeight_z=EC3_CaseHeight_z+2;

// == Positioning Variables ==

// == Dependant Variables ==
BaseShapeHeight_z=EC3_CaseHeight_z-FemCaseHeight_z; // Height of the intersection of the Round and Half Round Part
BaseShapeWidth_y=7.50;   // Width of the intersection of the Round and Half Round Part, its taler than the brim at the base
Tube_Cut=BaseShapeWidth_y*0.5; // Cuts the Section between the Tubes

HalfCutterCubeSize=100;

//HalfCutterOffset=HalfCutterCubeSize/2+Case_CaseWidth_y;

// Positioning 

PlugCenterOffset_x=ElektricalConnectorDistance/2+Case_CaseWidth_x/2-EC3_CaseWidth_x/2; // ??? EC3_CaseWidth_y (Worked!) --> changed to ElektricalConnectorDistance becaus of Logik!><
PlugCenterOffset_y=Case_CaseWidth_y/2+EnclosurWallThicknes/2; //PlugCenterOffset_y=EC3_CaseWidth_y/2+Case_CaseWidth_y/2-EC3_CaseWidth_y/2

InsulationBendRadius=(EnclosurWallThicknes+PlugCenterOffset_y)/2;

WallCaseCableSideHeight_z=InsulationLength_z+InsulationBendRadius+EC3_CaseWidth_y+(((EC3_CaseWidth_y*EC3_PlugPutThroughScale)-EC3_CaseWidth_y))/2;

// === Facettes Numbers ===
// - $fn Values for Cylinders and Spheres

FN_HexNut=6;
FN_Performance=36;
FN_Rough=12;
FN_Medium=36;
FN_Fine=72;
FN_ExtraFine=144;

FN_M8=8.00;

// == Calculated Variables

// === 1 ===

// === 2 ===

// === 3 ===

// ==================================
// = Tuning Variables =
// ==================================
// Variables for finetuning (The Slegehammer if something has to be made fit)

// ==================================
// = Test Stage =
// ==================================
/*test_side_by_side_list(10){
    2D_Half_Round_Tube(MalCaseWidth_y);
    2D_Round_Tube(MalCaseWidth_y);
    2D_Half_Round_Tube(FemCaseWidth_y);
    2D_Round_Tube(FemCaseWidth_y);
    2D_2Qmm_Insulation(Insulation_D);
}

test_stack_list(10){
    Linear_Extruding(MalCaseHeight_z){      2D_Half_Round_Tube(MalCaseWidth_y); }
    Linear_Extruding(MalCaseHeight_z){      2D_Round_Tube(MalCaseWidth_y);      }
    Linear_Extruding(FemCaseHeight_z){      2D_Half_Round_Tube(FemCaseWidth_y); }
    Linear_Extruding(FemCaseHeight_z){      2D_Round_Tube(FemCaseWidth_y);      }
    Linear_Extruding(InsulationLength_z){   2D_2Qmm_Insulation(Insulation_D);               }
    Linear_Extruding(BaseShapeHeight_z){    2D_Base_Shape(BaseShapeWidth_y,RoundBaseCutout_D);   }
    Linear_Extruding(BrimHeight_z){    2D_Base_Shape(CaseWidth_y,RoundBaseCutout_D);   }
}
*/

// Test For Plug Case arrangement
//Test_Plug_Case_Arrangment();
module Test_Plug_Case_Arrangment(){
    MirrorMirrorOnTheWall(0){Wall_Case_Base_Shape();};
}
module MirrorMirrorOnTheWall(Offset){
    translate([0,Offset,0]){
        children();
        mirror([1,0,0]){
            children();
        }
    }
    translate([0,-Offset,0]){
        mirror([0,1,0]){
            //children();
            mirror([1,0,0]){
                //children();
            }
        }
    }
}
//Plug_Test();
module Plug_Test(){
    translate([PlugCenterOffset_x,PlugCenterOffset_y,0]){
        rotate([0,0,0]){
            Main_Axis_Plug_Arrangement();
        }
    }
}
//Wall_Case();
//Half_Cutter(HalfCutterOffset);
//Wall_Case_Base_Shape();
//Test_Plug_Case_Arrangment();
//Main_Axis_Plug_Arrangement();
//Enviroment_Enclosure_Wall();

// == See me ==
// For Testing and Development


see_me_half(){
BendedTubeOffset=InsulationBendRadius;
ScaleFactorHole=1;
//for (i=[0:10]){    
    //color(c=[0.025*i,0.055*i,0.025*i]){
        //Wall_Case(i);
        //Half_Cutter(HalfCutterOffset);
        translate([0,0,0]){
            Wall_Case_Base_Shape();
            //Half_Cutter(Case_CaseWidth_y/2+EnclosurWallThicknes/2-(100/2),100){Wall_Case_Base_Shape();};
            //Half_Cutter((100/2)+Case_CaseWidth_y/2+EnclosurWallThicknes/2,100){Wall_Case_Base_Shape();};
        }
        translate([0,0,0]){
            Wall_Case_Base_Shape_Backplate();
        }
        translate([0,0,(EC3_Plug_Scale*(-InsulationLength_z-BendedTubeOffset))+InsulationLength_z+BendedTubeOffset]){
            Wall_Case_Ring_Fitter_3(1,1,1,0.97);
        }
        //Wall_Case_Ring_Fitter_3(1,1,1,0.97);
        /*translate([0,-Case_CaseWidth_y/2-EnclosurWallThicknes/2,0]){            
            translate([ ElektricalConnectorDistance/2+PlugCenterOffset_x,
                        0,
                        -InsulationLength_z-BendedTubeOffset]){
                rotate([90,0,0]){
                    translate([0,0,-Case_CaseWidth_y/2]){
                        scale([ScaleFactorHole,ScaleFactorHole,ScaleFactorHole]){
                            //Wall_Case_Ring_Fitter();
                        }
                    }
                }
            }
        }*/
        union(){
            //Bolts_Arrangement_Cutter_WallSide(-EnclosurWallThicknes/2){RUTHEX_M3();};
            //Bolts_Arrangement_Cutter_WallSide(-EnclosurWallThicknes/2){Bolt(Case_CaseWidth_y/2);};
        }
        union(){
            //Bolts_Arrangement_Cutter_WallSide(Case_CaseWidth_y/2){Bolt_Head(3.1,5.5);};
            //Bolts_Arrangement_Cutter_WallSide(Case_CaseWidth_y/2){Bolt(18);};
            //// Inside the enclousure, Clamps the EC3-Plug
            //Bolts_Arrangement_Cutter_Inside(Case_CaseWidth_y/2){RUTHEX_M3();};
            //Bolts_Arrangement_Cutter_Inside(Case_CaseWidth_y){Bolt(18);};
            //Bolts_Arrangement_Cutter_Inside(Case_CaseWidth_y){Bolt_Head(3.1,5.5);};
        }
        //MirrorMirrorOnTheWall(0){Wall_Case_Base_Shape_Backplate();};
        //Test_Plug_Case_Arrangment();
        //Main_Axis_Plug_Arrangement();
        //Enviroment_Enclosure_Wall(); // center=true
    //}
    //}
}
module see_me_half(){
    //difference(){
        //union(){
          translate([0,0,0]){
            for(i=[0:1:$children-1]){
                a=255;
                b=50;
                k_farbabstand=((a-b)/$children);
                Farbe=((k_farbabstand*i)/255);
                SINUS_Foo=0.5+(sin(((360/(a-b))*k_farbabstand)*(i+1)))/2;
                COSIN_Foo=0.5+(cos(((360/(a-b))*k_farbabstand)*(i+1)))/2;
                color(c = [ SINUS_Foo,
                            1-(SINUS_Foo/2+COSIN_Foo/2),
                            COSIN_Foo],
                            alpha = 0.5){  
                    //MirrorMirrorOnTheWall(0){
                    difference(){
                        MirrorMirrorOnTheWall(0){
                            render(convexity=20){children(i);}
                            //children(i);
                        }
// Creates a Cutting to see a Sidesection cut of the objects
                            color(c = [ SINUS_Foo,
                                1-(SINUS_Foo/2+COSIN_Foo/2),
                                COSIN_Foo],
                                alpha = 0.2){
                                translate([35,-5,0]){
                                    //cube([30,30,150],center=true);
                                }
                                //cube([30,30,150],center=true);
                            }
                            }
                        }
                    }
                    //MAIN_AXIS_ARRANGEMENT();
                } // sin((2*PI*i)/$children)
            }

// == Testprints ==

//// == Cutes a slice of the Objekts
Intersection_Test_Cut("yz",1,0){
// Intersection_Test_Cut("Plaine xy yz xz", Slicethickness , Distance from coordinate origin in plaine )
    //Wall_Case();
    //Half_Cutter(HalfCutterOffset);
    //Wall_Case_Base_Shape();
    //Test_Plug_Case_Arrangment();
    //Main_Axis_Plug_Arrangement();
    //Enviroment_Enclosure_Wall();
}

// ==================================
// =
// ==================================

// ==================================
// = Stage =
// ==================================
// Final module for Produktion

// Checklist for Real Printing
//// Are the Scale parameter set for fitting the EC3-Plug? --> Should cut the hole sligthly bigger by 2% to 5% (1.02 to 1.05)
echo("",);
//// Are the Holes for put Trhough the EC3-Plug big enugh?



// ===============================================================================
// =--------------------------------- Enviroment Modules ------------------------=
// ===============================================================================
// Modules that resembles the Enviroment aka the helmet where to atach a camera mount
module Enviroment_Enclosure_Wall(){
    //color(c=[0.1,1,0.1],alpha=0.2){
        cube([70,EnclosurWallThicknes,70],center=true);
    //}
}
// ===============================================================================
// =--------------------------------- Modules -----------------------------------=
// ===============================================================================


// === Main Axes Arrangement

//// === Wall Case
module Wall_Case_Base_Shape_Backplate(){
BendedTubeOffset=InsulationBendRadius;
    echo("WallCaseBShpBpl_InsulationBendRadius",InsulationBendRadius);
ScaleFactorHole=EC3_Plug_Scale;
    difference(){
        union(){
            translate([0,-Case_CaseWidth_y/2-EnclosurWallThicknes/2,0]){
                //
                Linear_Extruding(WallCaseHeight_z,0){
                    square([Case_CaseWidth_x,Case_CaseWidth_y/2],center=false);
                }
                // 
                Linear_Extruding(WallCaseCableSideHeight_z,-1){
                    square([Case_CaseWidth_x,Case_CaseWidth_y/2],center=false);
                }                
            }    
            translate([0,0,(EC3_Plug_Scale*(-InsulationLength_z-BendedTubeOffset))+InsulationLength_z+BendedTubeOffset]){
                Wall_Case_Ring_Fitter_3(1,1,1,0.97);
            }
        }
        translate([ ElektricalConnectorDistance/2+PlugCenterOffset_x,
                    PlugCenterOffset_y,
                    (EC3_Plug_Scale*(-InsulationLength_z-BendedTubeOffset))]){
            rotate([90,0,0]){
                translate([0,0,0]){
                    scale([ScaleFactorHole,ScaleFactorHole,ScaleFactorHole]){
                        linear_extrude(height=Case_CaseWidth_x){
                            2D_Base_Shape_EC3_Plug_Putthrough();
                        }
                    }
                }
            }
        }

        translate([ ElektricalConnectorDistance/2+PlugCenterOffset_x,
                    Case_CaseWidth_x/2,
                    -InsulationLength_z-BendedTubeOffset]){
                    echo("WallCaseBackPlate",InsulationLength_z-BendedTubeOffset);
            rotate([90,0,0]){
                translate([0,0,0]){
                    //scale([EC3_Plug_Scale,EC3_Plug_Scale,EC3_Plug_Scale]){
                        linear_extrude(height=Case_CaseWidth_x){
                            2D_Base_Shape_EC3_Plug_Putthrough();
                        }
                    //}
                }
            }
        }
        union(){
            Bolts_Arrangement_Cutter_WallSide(-EnclosurWallThicknes/2){RUTHEX_M3();};
            Bolts_Arrangement_Cutter_WallSide(-EnclosurWallThicknes/2){Bolt(Case_CaseWidth_y/2);};
            
        }
    }
}


// A Brim around the hole on the Backplate, goes throug the Wall and Snaps in the frontplate
module Wall_Case_Ring_Fitter_3(SCALE_x,SCALE_y,SCALE_z,EXTRU_Scle){
    
BendedTubeOffset=InsulationBendRadius;
    translate([PlugCenterOffset_x,PlugCenterOffset_y,0]){
        translate([ ElektricalConnectorDistance/2,
                    0,
                    -InsulationLength_z-BendedTubeOffset]){
        echo("Fitter_3",InsulationLength_z-BendedTubeOffset);
            rotate([90,0,0]){
                translate([0,0,Case_CaseWidth_y/2]){
                    scale([SCALE_x,SCALE_y,SCALE_z]){
                        translate([0,0,EnclosurWallThicknes]){
                            Linear_Extruding(EnclosurWallThicknes,-1){
                                2D_OFFSETT_SHAPER(2,0){2D_Base_Shape_EC3_Plug_Putthrough();};
                            }
                            translate([0,0,-EnclosurWallThicknes]){
                                scale([1,1,1]){
                                    mirror([0,0,1]){
                                        linear_extrude(height=EnclosurWallThicknes,scale=EXTRU_Scle){
                                        2D_OFFSETT_SHAPER(2,0){2D_Base_Shape_EC3_Plug_Putthrough();};
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
module Wall_Case_Base_Shape(){
    difference(){
        translate([0,EnclosurWallThicknes/2,0]){
            union(){
                // Extrudes where the EC3-Plug nestes in the wallmount
                Linear_Extruding(WallCaseHeight_z,0){
                    2D_Base_Shape_Wall_Case();
                }
                // Extrudes the side where the cabel goes in the EC3-Plug
                Linear_Extruding(WallCaseCableSideHeight_z,-1){
                    2D_Base_Shape_Wall_Case();
                }
            }
        }
        translate([0,0,0]){
            rotate([0,0,0]){
                // Shape in form of the EC3-Plug to cut from the Wall Case
                Main_Axis_Plug_Arrangement(); 
            }   
        }
        union(){
            #Bolts_Arrangement_Cutter_WallSide(Case_CaseWidth_y/2){Bolt_Head(3.3,5.7);};
            Bolts_Arrangement_Cutter_WallSide(Case_CaseWidth_y/2){Bolt(18);};
            // Inside enclousure Clamps the EC3-Plug
            Bolts_Arrangement_Cutter_Inside(Case_CaseWidth_y/2+EnclosurWallThicknes/2){RUTHEX_M3();};
            Bolts_Arrangement_Cutter_Inside(Case_CaseWidth_y){Bolt(18);};
            Bolts_Arrangement_Cutter_Inside(Case_CaseWidth_y){Bolt_Head(3.3,5.7);};
        }
        translate([0,Case_CaseWidth_y/4+Case_CaseWidth_y/2+EnclosurWallThicknes/2,0]){
            //cube([100,Case_CaseWidth_y/2,100],center=true);
            translate([0,1,0]){
                //cube([100,Case_CaseWidth_y/2,100],center=true); // Eliminates Thin Wall, just for practical usage in the development, uncomment on the real thing
            }
        }
    }
}
//// === EC3 Plug ===

module Main_Axis_Plug_Arrangement(){
BendedTubeOffset=InsulationBendRadius;
    echo("MainAxisArr_InsulationBendRadius",InsulationBendRadius);
ScaleFactorHole=1; // Scaling factor 1.2 basesd on the EC3-Plug to be able to fidle the Plug trough the Wallmount
    translate([PlugCenterOffset_x,PlugCenterOffset_y,0]){
        scale([EC3_Plug_Scale,EC3_Plug_Scale,EC3_Plug_Scale]){
            union(){
        //// Base Shape
                //// Brim
                Linear_Extruding(BaseShapeHeight_z,0){    
                    2D_Base_Shape(BaseShapeWidth_y,RoundBaseCutout_D);
                }
                //// Brim
                Linear_Extruding(BrimHeight_z,0){ // Brim
                    2D_Base_Shape(EC3_CaseWidth_y,RoundBaseCutout_D);
                }
        //// Tubes        
                translate([0,0,BaseShapeHeight_z]){
                    //// Half Round Tube of EC3-Plug Tube
                    Tube_Generator(){2D_Half_Round_Tube(BaseShapeWidth_y);}
                    translate([ElektricalConnectorDistance/2,0,0]){
                        //// Midsection
                        Tube_Generator(){2D_Base_Shape_Tube_Cut(Tube_Cut,ElektricalConnectorDistance);;}
                    }
                    translate([ElektricalConnectorDistance,0,0]){
                        //// Round Tube of EC3-Plug
                        Tube_Generator(){2D_Round_Tube(BaseShapeWidth_y);;}
                    }
                    //// Cuts off a small pice of the midsection to make enugh space to plug the plugs together
                    union(){
                        translate([0,0,EC3TubeHeight_z-0.5]){
                            linear_extrude(height=PlugChamfer_z+0.5,center=false,scale=PlugChamferAspRat){
                                hull(){
                                    2D_Half_Round_Tube(BaseShapeWidth_y);
                                    translate([ElektricalConnectorDistance/2,0,0]){
                                        //// Mid
                                        2D_Base_Shape_Tube_Cut(Tube_Cut,ElektricalConnectorDistance);
                                    }
                                    translate([ElektricalConnectorDistance,0,0]){
                                        //// Round Tube of EC3-Plug
                                        2D_Round_Tube(BaseShapeWidth_y);
                                    }
                                }
                            }
                        }
                    }
                }
                //// Cabel
                translate([ 0,
                            0,
                            -InsulationLength_z]){
                    Linear_Extruding(InsulationLength_z,0){
                        2D_2Qmm_Insulation(Insulation_D);
                    }
                    translate([ ElektricalConnectorDistance,
                                0,
                                0]){
                        Linear_Extruding(InsulationLength_z,0){
                            2D_2Qmm_Insulation(Insulation_D);
                        }
                    }
                }
                //// Bendet part of the cable way 
                rotate([0,0,0]){
                    translate([0,-BendedTubeOffset,-InsulationLength_z+BendedTubeOffset*0.2]){
                        rotate([-90,0,90]){
                            union(){
                            rotate_extrude(angle=90,convexity=2){
                                translate([BendedTubeOffset,0,0]){
                                    rotate([0,0,0]){
                                        circle(d=Insulation_D,$fn=FN_Performance);
                                        //2D_2Qmm_Insulation(Insulation_D);
                                    }
                                }
                            }
                        }
                        }
                    }
                }
                //// Other bendet cable way
                rotate([0,0,0]){
                    translate([ ElektricalConnectorDistance,
                                -BendedTubeOffset,
                                -InsulationLength_z+BendedTubeOffset*0.2]){
                        rotate([-90,0,90]){
                            union(){
                            rotate_extrude(angle=90,convexity=2){
                                translate([BendedTubeOffset,0,0]){
                                    rotate([0,0,0]){
                                        circle(d=Insulation_D,$fn=FN_Performance);
                                        //2D_2Qmm_Insulation(Insulation_D);
                                    }
                                }
                            }
                        }
                        }
                    }
                }
                // Wall put Trough, 
                translate([ ElektricalConnectorDistance/2,
                            0,
                            -InsulationLength_z-BendedTubeOffset]){
                    rotate([90,0,0]){
                        translate([0,0,0]){
                            scale([ScaleFactorHole,ScaleFactorHole,ScaleFactorHole]){
                                linear_extrude(height=Case_CaseWidth_x){
                                    2D_Base_Shape_EC3_Plug_Putthrough();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    //// A Rim around the hole
    translate([0,0,(EC3_Plug_Scale*(-InsulationLength_z-BendedTubeOffset))+InsulationLength_z+BendedTubeOffset]){ // correcetes the Sligthly dimension increas du to EC3_Plug_Scale
        scale([1,1,1]){
            Wall_Case_Ring_Fitter_3(1.0,1.0,1.025,0.97);        // SCALE_x,SCALE_y,SCALE_z,EXTRU_Scle inner Hole stayes the same size, dont grow with the Scalefactor
            Wall_Case_Ring_Fitter_3(1.025,1.025,1.025,0.97);    // SCALE_x,SCALE_y,SCALE_z,EXTRU_Scle Outer cut in opposing pice gets sligthly bigger to fit
        }
    }
}
module Tube_Body(){    
    Linear_Extruding(EC3TubeHeight_z,0){  // Plug Casing
        2D_Half_Round_Tube(BaseShapeWidth_y);
    }
    translate([ElektricalConnectorDistance,0,0]){
        Linear_Extruding(EC3TubeHeight_z,0){  // Plug casing
            2D_Round_Tube(BaseShapeWidth_y);
        }
    }
    translate([ElektricalConnectorDistance/2,-BaseShapeWidth_y*0.05,0]){
        Linear_Extruding(EC3TubeHeight_z,0){  // Cut between Tubes
            2D_Base_Shape_Tube_Cut(Tube_Cut,ElektricalConnectorDistance);
        }
    }
}
module Tube_Generator(){
    linear_extrude(height=EC3TubeHeight_z){  // Plug Casing
            children();
    }
    translate([0,0,EC3TubeHeight_z]){
        linear_extrude(height=PlugChamfer_z,center=false,scale=PlugChamferAspRat){
            children();
        }
    }
    translate([0,0,EC3TubeHeight_z+PlugChamfer_z]){
        linear_extrude(height=PlugChamfer_z,center=false){
            scale(PlugChamferAspRat){
                children();
            }
        }
    }
}

// ===============================================================================
// ---------------------------------- Cutting Modules ----------------------------
// ===============================================================================
// === Half Cutter
// Cuts the Pice in a upper and lower half to be able to put the EC3-Plug in between

module Half_Cutter(HalfCutterOffset,HalfCutterCubeSize){
    difference(){
        children();
        translate([0,HalfCutterOffset,0]){
            cube([HalfCutterCubeSize,HalfCutterCubeSize,HalfCutterCubeSize],center=true);
        }
    }
}
module Bolts_Arrangement_Cutter_WallSide(Position_y){
BendedTubeOffset=InsulationBendRadius;
    rotate([0,0,0]){
        translate([0,Position_y,0]){
            translate([ Case_CaseWidth_x-(Case_CaseWidth_x-(EC3_CaseWidth_x+(((EC3_CaseWidth_x*EC3_PlugPutThroughScale)-EC3_CaseWidth_x))))/4,
                        0,
                        -InsulationLength_z-BendedTubeOffset-(EC3_CaseWidth_y+(((EC3_CaseWidth_y*EC3_PlugPutThroughScale)-EC3_CaseWidth_y))/2)/2]){
                rotate([90,0,0]){
                    children();
                }
            }
            translate([0,0,WallCaseHeight_z/1.5]){
                rotate([90,0,0]){
                    children();
                }
            }
        }
    }
}

module Bolts_Arrangement_Cutter_Inside(Position_y){
BendedTubeOffset=InsulationBendRadius;
    rotate([0,0,0]){
        translate([0,Position_y,0]){
            translate([Case_CaseWidth_x-(Case_CaseWidth_x-EC3_CaseWidth_x)/4,0,WallCaseHeight_z/1.5]){
                rotate([90,0,0]){
                    children();
                }
            }
            translate([0,0,-InsulationLength_z-BendedTubeOffset-EC3_CaseWidth_y/2]){
                rotate([90,0,0]){
                    children();
                }
            }
        }
    }
}
/*
module FFOO(){
    //translate([(PlugCenterOffset_x+ElektricalConnectorDistance/2)*2,WallCaseHeight_z/2,0]){
        mirror([1,0,0]){
            translate([Case_CaseWidth_x-(Case_CaseWidth_x-EC3_CaseWidth_x)/4,-InsulationLength_z-BendedTubeOffset-EC3_CaseWidth_y/2,0]){
                translate([0,0,0]){
                    //Bolt();
                }
                translate([0,0,-EnclosurWallThicknes/2-Case_CaseWidth_y/2+2]){
                    //Bolt_Head();
                }
            }
        }
        translate([Case_CaseWidth_x-(Case_CaseWidth_x-EC3_CaseWidth_x)/4,0,0]){
            translate([0,0,EnclosurWallThicknes/2]){
                    //RUTHEX_M3();
                }
            //#Bolt(Case_CaseWidth_y/2);
        }
    }*/

module Bolt(BoltLength){
    translate([0,0,0]){
        rotate([0,0,0]){
            translate([0,0,0]){
                cylinder(h=BoltLength,d1=3.2,d2=3.2,center=false,$fn=FN_Performance);
            }
        }
    }
}
module Bolt_Head(HEADHEIGHT,HEADDIAMETER){
    BoltHeadHeight=HEADHEIGHT;
    BoltHeadDiameter=HEADDIAMETER;
    translate([0,0,0]){
        rotate([0,0,0]){
            translate([0,0,0]){
                cylinder(h=BoltHeadHeight,d1=BoltHeadDiameter,d2=BoltHeadDiameter,center=true,$fn=FN_Performance);
            }
        }
    }
}


module Projection_Cutter(Offset_z){    
    projection(cut = true){
        translate([0,0,Offset_z]){
            children();
        }
    }
}
// ===============================================================================
// ---------------------------------- Intersection Modules -----------------------
// ===============================================================================

module Intersection_Test_Cut(PLAIN,THICKNESS,OFFSET){
// ==== EXAMPLE ====
//    !Intersection_Test_Cut("xy",1,7/2){sphere(7);};
// ==== EXAMPLE ====
    if (PLAIN=="xz"){
        intersection(){
            children();
            translate([0,OFFSET,0]){
                cube([100,THICKNESS,100],center=true);
            }
        }
    }
    else if (PLAIN=="xy") {
        intersection(){
            children();
            translate([0,0,OFFSET]){
                cube([100,100,THICKNESS],center=true);
            }
        }
    }
    else if (PLAIN=="yz") {
        intersection(){
            children();
            translate([OFFSET,0,0]){
                cube([THICKNESS,100,100],center=true);
            }
        }   
    }
}
// ===============================================================================
// ---------------------------------- Linear Extrude Modules ---------------------
// ===============================================================================

module Linear_Extruding(ExtrudeLength,ExrtudingDirektionInverter){
    Length=ExtrudeLength;
    translate([0,0,Length*ExrtudingDirektionInverter]){
        linear_extrude(height=ExtrudeLength){
            children();
        }
    }
}

// ===============================================================================
// ---------------------------------- Rotate Extrude Modules ---------------------
// ===============================================================================

// ===============================================================================
// =--------------------------------- 2D-Shapes ---------------------------------=
// ===============================================================================

/// === Wall Case Back Plate
//!2D_OFFSETT_SHAPER(1,1){2D_Base_Shape_EC3_Plug_Putthrough();};
module 2D_OFFSETT_SHAPER(OFFSET_Out,OFFSET_Inn){
// OFFSET_Out: outward Offset of Shape based on 2D Shape
// OFFSET_Inn: Inward Offset of Shape based on 2D Shape
// OFFSET_Out+OFFSET_Inn=WHIDHT of the rim
    translate([0,0,-1]){
        //color(c=[0.1,0.8,0.1],alpha=0.35){children();} // For testing the Shape
    }
    union(){
        difference(){        
            offset(delta=OFFSET_Out){
                children();
            }
            offset(delta=-OFFSET_Inn){
                children();
            }
        }
    }
}

//// === Wall Case

module 2D_Base_Shape_Wall_Case(){
    square([Case_CaseWidth_x,Case_CaseWidth_y],center=false);
}

/// === E3D Plug
// Multiusage to cut the Hole to put the EC3-Plug troug the pice
//2D_Base_Shape_EC3_Plug_Putthrough();
module 2D_Base_Shape_EC3_Plug_Putthrough(){
scale([EC3_PlugPutThroughScale,EC3_PlugPutThroughScale,EC3_PlugPutThroughScale]){
        union(){
            square([(   EC3_CaseWidth_y+ElektricalConnectorDistance)/2,
                        EC3_CaseWidth_y],
                        center=true);
            translate([-(EC3_CaseWidth_y+ElektricalConnectorDistance)/4,0,0]){
                circle(d=EC3_CaseWidth_y,$fn=FN_Performance);
            }
            translate([(EC3_CaseWidth_y+ElektricalConnectorDistance)/4,0,0]){
                circle(d=EC3_CaseWidth_y,$fn=FN_Performance);
            }
        }
    }
}

module 2D_Half_Round_Tube(Diameter){
    union(){
        translate([-Diameter/2,-Diameter/2,0]){
            square([Diameter/2,Diameter],center=false);
        }
        translate([0,0,0]){
            circle(d=Diameter,$fn=FN_Performance);
            }
    }
}
module 2D_Round_Tube(Diameter){
    translate([0,0,0]){
        circle(d=Diameter,$fn=FN_Performance);
    }
}
module 2D_2Qmm_Insulation(Diameter){
    translate([0,0,0]){
        circle(d=Diameter,$fn=FN_Performance);
    }
}
module 2D_Base_Shape(BaseShapeWidth_y,BaseShapeCutout_D){
    CutoutPosition_x=ElektricalConnectorDistance/2;
    CutoutPosition_y=(BaseShapeWidth_y+BaseShapeCutout_D)/2-CutDepth;
    difference(){
        union(){
            2D_Half_Round_Tube(BaseShapeWidth_y);
            translate([ElektricalConnectorDistance/2,BaseShapeWidth_y/6,0]){
                2D_Base_Shape_Midsection(BaseShapeWidth_y,ElektricalConnectorDistance);
            }
            translate([ElektricalConnectorDistance/2,-BaseShapeWidth_y/4,0]){
                2D_Base_Shape_Midsection(BaseShapeWidth_y,ElektricalConnectorDistance);
            }
            translate([ElektricalConnectorDistance,0,0]){
                2D_Round_Tube(BaseShapeWidth_y);
            }
        }
        translate([CutoutPosition_x,CutoutPosition_y,0]){
            2D_Base_Shape_Cutout_Shape(BaseShapeCutout_D);
        }
        
    }
}
module 2D_Base_Shape_Midsection(BaseShapeWidth_y,ElektricalConnectorDistance){
    square([ElektricalConnectorDistance,BaseShapeWidth_y/2],center=true);
}
module 2D_Base_Shape_Tube_Cut(BaseShapeWidth_y,ElektricalConnectorDistance){ // Cuts the area between the Tubes
    square([ElektricalConnectorDistance,BaseShapeWidth_y],center=true);
}
//2D_Base_Shape_Cutout_Shape(BaseShapeCutout_D);
module 2D_Base_Shape_Cutout_Shape(BaseShapeCutout_D){
    circle(d=BaseShapeCutout_D,$fn=FN_Performance);
    square([BaseShapeCutout_D,BaseShapeCutout_D]);
}


module 2D_Base_Shape_Tube_Chamfer(){
    Projection_Cutter(){
        //Main_Axis_Plug_Arrangement();
        Tube_Body();
    }
}
// ===============================================================================
// =--------------------------------- Smoothing ---------------------------------=
// ===============================================================================

2D_Smooth_r=1;
// Radius of a outer Tip Rounding 
2D_Fillet_r=1;
// Radius of a inner corner Ronding
2D_Chamfer_DELTA_INN=1;
2D_Chamfer_DELTA_OUT=2;

// a straigt line on edges and corners
2D_Chamfer_BOOLEAN=false;

    
module Smooth(r=3){
    //$fn=30;
    offset(r=r,$fn=30){
        offset(r=-r,$fn=30){
        children();
        }
    }
}
module Fillet(r=3){
    //$fn=30;
    offset(r=-r,$fn=30){
        offset(r=r,$fn=30){
            children();
        }
    }
}
module Chamfer_OUTWARD(DELTA_OUT=3){
    //$fn=30;
    offset(delta=DELTA_OUT,chamfer=true,$fn=30){
        offset(delta=-DELTA_OUT,chamfer=true, $fn=30){
            children();
        }
    }
}
module Chamfer_INWARD(DELTA_INN=3){
    //$fn=30;
    offset(delta=-DELTA_INN,chamfer=true,$fn=30){
        offset(delta=DELTA_INN,chamfer=true, $fn=30){
            children();
        }
    }
}

// ===============================================================================
// =--------------------------------- Ruthex --------------------------------=
// ===============================================================================
// Dimensions for Ruthex Tread inseerts

//RUTHEX_M3();
module RUTHEX_M3(){    
L=5.7+5.7*0.25; // Length + Margin
echo("RUTHEX",L);
D1=4.0;    
    translate([0,0,0]){
        rotate([0,0,0]){
            translate([0,0,0]){
                cylinder(h=L,d1=D1,d2=D1,$fn=FN_Performance);
            }
        }
    }
}

// ===============================================================================
// =--------------------------------- Import STL --------------------------------=
// ===============================================================================

module NAME_OF_IMPORT(){
    rotate([0,0,-90]){
        translate([-515,-100,-45]){
            import("PATH/TO/FILE.stl",convexity=3);
        }
    }
}