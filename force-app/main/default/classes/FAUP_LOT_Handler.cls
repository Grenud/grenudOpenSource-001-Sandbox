public class FAUP_LOT_Handler {

public static void checkLotResults(List<FAUP_LOT__c> Lotrecordlist) {
    integer totalCondition = 269;
    integer count = 0;
    for (FAUP_LOT__c lot : Lotrecordlist) {
        boolean passCriteriaMet = true; // Initialize a boolean to track if the criteria are met
        boolean allFieldsBlank = true; // Initialize a boolean to track if all fields are blank
system.debug(passCriteriaMet);
        if (lot.Imidacloprid__c != null && lot.Imidacloprid__c > 0.01) {
            passCriteriaMet = false;
            
        }if(lot.Imidacloprid__c == null){
            count = count+1;
        }else{
           allFieldsBlank = false; 
        }

        if (lot.Tebuconazole__c != null && lot.Tebuconazole__c > 1.5) {
            passCriteriaMet = false;
        }if(lot.Tebuconazole__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }

        if (lot.Thiamethoxam__c != null && lot.Thiamethoxam__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.Thiamethoxam__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }

        if (lot.Trifloxystrobin__c != null && lot.Trifloxystrobin__c > 5.0) {
            passCriteriaMet = false;
        }if(lot.Trifloxystrobin__c == null){
            count = count+1;
               }else{
           allFieldsBlank = false; 
        }

        if (lot.Isoprothiolane__c != null && lot.Isoprothiolane__c > 6.0) {
            passCriteriaMet = false;
        }if(lot.Isoprothiolane__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
 /////     / /// //////////////////////////////////////////////////////////////////////////////////////////////////////
        if (lot.X2_4_D__c != null && lot.X2_4_D__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X2_4_D__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
               if (lot.X2_3_Hydroxycarbofuran_0_005__c != null && lot.X2_3_Hydroxycarbofuran_0_005__c > 0.005) {
            passCriteriaMet = false;
        }if(lot.X2_3_Hydroxycarbofuran_0_005__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
               if (lot.X3_Acebenzolar_s_methyl_0_01__c != null && lot.X3_Acebenzolar_s_methyl_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X3_Acebenzolar_s_methyl_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
               if (lot.X4_Acephate_0_005__c != null && lot.X4_Acephate_0_005__c > 0.005) {
            passCriteriaMet = false;
        }if(lot.X4_Acephate_0_005__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
               if (lot.X5_Acetamiprid_0_01__c != null && lot.X5_Acetamiprid_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X5_Acetamiprid_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
               if (lot.X6_Acetochlor_0_01__c != null && lot.X6_Acetochlor_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X6_Acetochlor_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
               if (lot.X7_Alachlor_0_01__c != null && lot.X7_Alachlor_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X7_Alachlor_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                 if (lot.X8_Aldicarb_0_01__c != null && lot.X8_Aldicarb_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X8_Aldicarb_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                 if (lot.X9_Aldicarb_sulfone_0_01__c != null && lot.X9_Aldicarb_sulfone_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X9_Aldicarb_sulfone_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
        
               if (lot.X10_Aldicarb_sulfoxide_0_01__c != null && lot.X10_Aldicarb_sulfoxide_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X10_Aldicarb_sulfoxide_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
               if (lot.X11_Ametoctradin_0_01__c != null && lot.X11_Ametoctradin_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X11_Ametoctradin_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
               if (lot.X12_Aminopyralid_0_01__c != null && lot.X12_Aminopyralid_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X12_Aminopyralid_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                if (lot.X13_Anilophos_0_01__c != null && lot.X13_Anilophos_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X13_Anilophos_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                if (lot.X14_Atrazine_0_01__c != null && lot.X14_Atrazine_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X14_Atrazine_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                if (lot.X15_Azimsulfuron_0_01__c != null && lot.X15_Azimsulfuron_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X15_Azimsulfuron_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                if (lot.X16_Azinphos_ethyl_0_01__c != null && lot.X16_Azinphos_ethyl_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X16_Azinphos_ethyl_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                if (lot.X17_Azinphos_methyl_0_01__c != null && lot.X17_Azinphos_methyl_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X17_Azinphos_methyl_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                if (lot.X18_Azoxystrobin_0_01__c != null && lot.X18_Azoxystrobin_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X18_Azoxystrobin_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                 if (lot.X19_Beflubutamid_0_01__c != null && lot.X19_Beflubutamid_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X19_Beflubutamid_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                 if (lot.X20_Benalaxyl__c != null && lot.X20_Benalaxyl__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X20_Benalaxyl__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X21_Bendiocarb_0_01__c != null && lot.X21_Bendiocarb_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X21_Bendiocarb_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X22_Benfuracarb_0_01__c != null && lot.X22_Benfuracarb_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X22_Benfuracarb_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X23_Bensulfuron_methyl_0_01__c != null && lot.X23_Bensulfuron_methyl_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X23_Bensulfuron_methyl_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X24_Bentazone_0_01__c != null && lot.X24_Bentazone_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X24_Bentazone_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X25_Bifenazate_0_01__c != null && lot.X25_Bifenazate_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X25_Bifenazate_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X26_Bifenazatesum__c != null && lot.X26_Bifenazatesum__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X26_Bifenazatesum__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X27_Bifenazate_diazene_0_01__c != null && lot.X27_Bifenazate_diazene_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X27_Bifenazate_diazene_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X28_Bifenox_0_01__c != null && lot.X28_Bifenox_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X28_Bifenox_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X29_Bifenthrin_0_01__c != null && lot.X29_Bifenthrin_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X29_Bifenthrin_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X30_Binapacryl_0_01__c != null && lot.X30_Binapacryl_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X30_Binapacryl_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X31_Bispyribac_0_01__c != null && lot.X31_Bispyribac_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X31_Bispyribac_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
                   if (lot.X32_Boscalid_0_01__c != null && lot.X32_Boscalid_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X32_Boscalid_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
        if (lot.X33_Bromophos_Bromophosmethyl_0_01__c != null && lot.X33_Bromophos_Bromophosmethyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X33_Bromophos_Bromophosmethyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X34_Bromophos_ethyl_0_01__c != null && lot.X34_Bromophos_ethyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X34_Bromophos_ethyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X35_Bromoxynil_0_01__c != null && lot.X35_Bromoxynil_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X35_Bromoxynil_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X36_Bromuconazole_0_01__c != null && lot.X36_Bromuconazole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X36_Bromuconazole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X37_Buprofezin_buprofexin_0_005__c != null && lot.X37_Buprofezin_buprofexin_0_005__c > 0.005) {
    passCriteriaMet = false;
} else if (lot.X37_Buprofezin_buprofexin_0_005__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X38_Butachlor_0_01__c != null && lot.X38_Butachlor_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X38_Butachlor_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X39_Butylate_0_01__c != null && lot.X39_Butylate_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X39_Butylate_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X40_Carbaryl_0_01__c != null && lot.X40_Carbaryl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X40_Carbaryl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X41_Carbendazim_sumofbenmyl_carbe_0_005__c != null && lot.X41_Carbendazim_sumofbenmyl_carbe_0_005__c > 0.005) {
    passCriteriaMet = false;
} else if (lot.X41_Carbendazim_sumofbenmyl_carbe_0_005__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X42_Carbofuran_0_005__c != null && lot.X42_Carbofuran_0_005__c > 0.005) {
    passCriteriaMet = false;
} else if (lot.X42_Carbofuran_0_005__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X43_Carbofuran_3_OH_0_01__c != null && lot.X43_Carbofuran_3_OH_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X43_Carbofuran_3_OH_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X44_Carboxin_0_01__c != null && lot.X44_Carboxin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X44_Carboxin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X45_Carfentrazone_ethyl_0_01__c != null && lot.X45_Carfentrazone_ethyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X45_Carfentrazone_ethyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X46_Carpropamid_0_01__c != null && lot.X46_Carpropamid_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X46_Carpropamid_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X47_Chlorantraniliprole_0_01__c != null && lot.X47_Chlorantraniliprole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X47_Chlorantraniliprole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X48_Chlorbufam_0_01__c != null && lot.X48_Chlorbufam_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X48_Chlorbufam_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X49_Chloridazon_0_01__c != null && lot.X49_Chloridazon_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X49_Chloridazon_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X50_Chlorimuron_ethyl_0_01__c != null && lot.X50_Chlorimuron_ethyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X50_Chlorimuron_ethyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X51_Chloropicrin_0_01__c != null && lot.X51_Chloropicrin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X51_Chloropicrin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X52_Chlorotoluron_0_01__c != null && lot.X52_Chlorotoluron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X52_Chlorotoluron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X53_Chloroxuron_0_01__c != null && lot.X53_Chloroxuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X53_Chloroxuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X54_Chlorpyrifos_Chlorpyrifosethyl_0_005__c != null && lot.X54_Chlorpyrifos_Chlorpyrifosethyl_0_005__c > 0.005) {
    passCriteriaMet = false;
} else if (lot.X54_Chlorpyrifos_Chlorpyrifosethyl_0_005__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X55_Chlorpyrifos_methyl_0_01__c != null && lot.X55_Chlorpyrifos_methyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X55_Chlorpyrifos_methyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X56_Chlorsulfuron_0_01__c != null && lot.X56_Chlorsulfuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X56_Chlorsulfuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X57_Chlorthiamid_0_01__c != null && lot.X57_Chlorthiamid_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X57_Chlorthiamid_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X58_Cinmethylene_0_01__c != null && lot.X58_Cinmethylene_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X58_Cinmethylene_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X59_Clodinafop_0_01__c != null && lot.X59_Clodinafop_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X59_Clodinafop_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X60_Clofentezine_0_01__c != null && lot.X60_Clofentezine_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X60_Clofentezine_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X61_Clothianidin_0_01__c != null && lot.X61_Clothianidin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X61_Clothianidin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X62_Cyantraniliprole_0_01__c != null && lot.X62_Cyantraniliprole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X62_Cyantraniliprole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X63_Cyazofamid_0_01__c != null && lot.X63_Cyazofamid_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X63_Cyazofamid_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X64_Cycloxydim_0_01__c != null && lot.X64_Cycloxydim_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X64_Cycloxydim_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X65_Cyflumetofen_0_01__c != null && lot.X65_Cyflumetofen_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X65_Cyflumetofen_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X66_Cyfluthrin_0_01__c != null && lot.X66_Cyfluthrin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X66_Cyfluthrin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X67_Cyhalofop_butyl_0_01__c != null && lot.X67_Cyhalofop_butyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X67_Cyhalofop_butyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X68_Cyhalothrin_lamda_0_01__c != null && lot.X68_Cyhalothrin_lamda_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X68_Cyhalothrin_lamda_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X69_Cymoxanil_0_01__c != null && lot.X69_Cymoxanil_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X69_Cymoxanil_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X70_Cypermethrin_0_01__c != null && lot.X70_Cypermethrin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X70_Cypermethrin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X71_Cyprodinil_0_01__c != null && lot.X71_Cyprodinil_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X71_Cyprodinil_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X72_Cyromazine_0_01__c != null && lot.X72_Cyromazine_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X72_Cyromazine_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X73_Dalapon_0_01__c != null && lot.X73_Dalapon_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X73_Dalapon_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X74_Dazomet_0_01__c != null && lot.X74_Dazomet_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X74_Dazomet_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X75_Deltamethrin_0_01__c != null && lot.X75_Deltamethrin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X75_Deltamethrin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X76_Demeton_s_methyl_sulfone_0_01__c != null && lot.X76_Demeton_s_methyl_sulfone_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X76_Demeton_s_methyl_sulfone_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X77_Diafenthiuron_0_01__c != null && lot.X77_Diafenthiuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X77_Diafenthiuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X78_Diazinon_0_01__c != null && lot.X78_Diazinon_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X78_Diazinon_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X79_Dichlorvos_DDVP_0_01__c != null && lot.X79_Dichlorvos_DDVP_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X79_Dichlorvos_DDVP_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X80_Difenoconazole_0_01__c != null && lot.X80_Difenoconazole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X80_Difenoconazole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X81_Diflubenzuron_0_01__c != null && lot.X81_Diflubenzuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X81_Diflubenzuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X82_Dimethenamid_0_01__c != null && lot.X82_Dimethenamid_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X82_Dimethenamid_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X83_Dimethoate_0_01__c != null && lot.X83_Dimethoate_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X83_Dimethoate_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X84_Dimethomorph_0_01__c != null && lot.X84_Dimethomorph_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X84_Dimethomorph_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X85_Dimoxystrobin_0_01__c != null && lot.X85_Dimoxystrobin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X85_Dimoxystrobin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X86_Diniconazole_0_01__c != null && lot.X86_Diniconazole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X86_Diniconazole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X87_Dinoseb_0_01__c != null && lot.X87_Dinoseb_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X87_Dinoseb_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X88_Dinotefuran_0_01__c != null && lot.X88_Dinotefuran_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X88_Dinotefuran_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X89_Dinoterb_0_01__c != null && lot.X89_Dinoterb_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X89_Dinoterb_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X90_Dioxathion_0_01__c != null && lot.X90_Dioxathion_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X90_Dioxathion_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X91_Disulfoton_0_01__c != null && lot.X91_Disulfoton_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X91_Disulfoton_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X92_Diuron_0_01__c != null && lot.X92_Diuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X92_Diuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X93_Dodemorph_0_01__c != null && lot.X93_Dodemorph_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X93_Dodemorph_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X94_Dodine_0_01__c != null && lot.X94_Dodine_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X94_Dodine_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X95_Edifenphos_0_01__c != null && lot.X95_Edifenphos_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X95_Edifenphos_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X96_Emamectin_Emamectin_benzoate_0_01__c != null && lot.X96_Emamectin_Emamectin_benzoate_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X96_Emamectin_Emamectin_benzoate_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X97_Epoxyconazole_0_01__c != null && lot.X97_Epoxyconazole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X97_Epoxyconazole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X98_Ethion_0_01__c != null && lot.X98_Ethion_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X98_Ethion_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X99_Ethiprole_0_01__c != null && lot.X99_Ethiprole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X99_Ethiprole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X100_Ethofenprox_0_01__c != null && lot.X100_Ethofenprox_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X100_Ethofenprox_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X101_Ethofumesate_0_01__c != null && lot.X101_Ethofumesate_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X101_Ethofumesate_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X102_Ethoxysulfuron_0_01__c != null && lot.X102_Ethoxysulfuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X102_Ethoxysulfuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X103_Famoxadone_0_01__c != null && lot.X103_Famoxadone_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X103_Famoxadone_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X104_Fenamidone_0_01__c != null && lot.X104_Fenamidone_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X104_Fenamidone_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X105_Fenazaquin_0_01__c != null && lot.X105_Fenazaquin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X105_Fenazaquin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X106_Fenbutatin_oxide_0_01__c != null && lot.X106_Fenbutatin_oxide_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X106_Fenbutatin_oxide_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X107_Fenhexamid_0_01__c != null && lot.X107_Fenhexamid_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X107_Fenhexamid_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X108_Fenitrothion_0_01__c != null && lot.X108_Fenitrothion_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X108_Fenitrothion_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X109_Fenobucarb_0_01__c != null && lot.X109_Fenobucarb_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X109_Fenobucarb_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X110_Fenoxaprop_ethyl_0_01__c != null && lot.X110_Fenoxaprop_ethyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X110_Fenoxaprop_ethyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X111_Fenoxycarb_0_01__c != null && lot.X111_Fenoxycarb_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X111_Fenoxycarb_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X112_Fenpropathrin_0_01__c != null && lot.X112_Fenpropathrin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X112_Fenpropathrin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X113_Fenpyroximate_0_01__c != null && lot.X113_Fenpyroximate_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X113_Fenpyroximate_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X114_Fenthion_0_01__c != null && lot.X114_Fenthion_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X114_Fenthion_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X115_Fenthion__c != null && lot.X115_Fenthion__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X115_Fenthion__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X116_Fenthion_sulfone_0_01__c != null && lot.X116_Fenthion_sulfone_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X116_Fenthion_sulfone_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X117_Fenthion_sulfoxide_0_01__c != null && lot.X117_Fenthion_sulfoxide_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X117_Fenthion_sulfoxide_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X118_Fipronil_0_002__c != null && lot.X118_Fipronil_0_002__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X118_Fipronil_0_002__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X119_Fipronil_Fip_sulfone_0_005__c != null && lot.X119_Fipronil_Fip_sulfone_0_005__c > 0.005) {
    passCriteriaMet = false;
} else if (lot.X119_Fipronil_Fip_sulfone_0_005__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X120_Fipronil_sulfone_0_002__c != null && lot.X120_Fipronil_sulfone_0_002__c > 0.002) {
    passCriteriaMet = false;
} else if (lot.X120_Fipronil_sulfone_0_002__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X121_Flonicamid_0_01__c != null && lot.X121_Flonicamid_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X121_Flonicamid_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X122_Flonicamid_TFNA_TFNG_0_01__c != null && lot.X122_Flonicamid_TFNA_TFNG_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X122_Flonicamid_TFNA_TFNG_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X123_Fluazifop_0_01__c != null && lot.X123_Fluazifop_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X123_Fluazifop_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X124_Flubendiamide_0_01__c != null && lot.X124_Flubendiamide_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X124_Flubendiamide_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X125_Flucetosulfuron_0_01__c != null && lot.X125_Flucetosulfuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X125_Flucetosulfuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X126_Fluchloralin_0_01__c != null && lot.X126_Fluchloralin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X126_Fluchloralin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X127_Fludioxonil_0_01__c != null && lot.X127_Fludioxonil_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X127_Fludioxonil_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X128_Flufenacet_0_01__c != null && lot.X128_Flufenacet_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X128_Flufenacet_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X129_Flufenoxuron_0_01__c != null && lot.X129_Flufenoxuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X129_Flufenoxuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X130_Flufenzine_0_01__c != null && lot.X130_Flufenzine_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X130_Flufenzine_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X131_Flumetralin_0_01__c != null && lot.X131_Flumetralin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X131_Flumetralin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X132_Fluometuron_0_01__c != null && lot.X132_Fluometuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X132_Fluometuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X133_Fluopicolide_0_01__c != null && lot.X133_Fluopicolide_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X133_Fluopicolide_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X134_Fluopyram_0_01__c != null && lot.X134_Fluopyram_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X134_Fluopyram_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X135_Flupyradifurone_0_01__c != null && lot.X135_Flupyradifurone_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X135_Flupyradifurone_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X136_Flusilazole_0_01__c != null && lot.X136_Flusilazole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X136_Flusilazole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X137_Flutolanil_0_01__c != null && lot.X137_Flutolanil_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X137_Flutolanil_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X138_Flutriafol_0_01__c != null && lot.X138_Flutriafol_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X138_Flutriafol_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X139_Fluxapyroxad_0_01__c != null && lot.X139_Fluxapyroxad_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X139_Fluxapyroxad_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X140_Halosulfuron_Methyl_0_01__c != null && lot.X140_Halosulfuron_Methyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X140_Halosulfuron_Methyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X141_Hexaconazole_0_01__c != null && lot.X141_Hexaconazole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X141_Hexaconazole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X142_Hexythiazox_0_01__c != null && lot.X142_Hexythiazox_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X142_Hexythiazox_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X143_Imazamox_0_01__c != null && lot.X143_Imazamox_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X143_Imazamox_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X144_Imazapic_0_01__c != null && lot.X144_Imazapic_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X144_Imazapic_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X145_Imazethapyr_0_01__c != null && lot.X145_Imazethapyr_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X145_Imazethapyr_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X146_Imazosulfuron_0_01__c != null && lot.X146_Imazosulfuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X146_Imazosulfuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X147_Imidacloprid_0_005__c != null && lot.X147_Imidacloprid_0_005__c > 0.005) {
    passCriteriaMet = false;
} else if (lot.X147_Imidacloprid_0_005__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X148_Indoxacarb_0_01__c != null && lot.X148_Indoxacarb_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X148_Indoxacarb_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X149_Iodosulfuron_methyl_0_01__c != null && lot.X149_Iodosulfuron_methyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X149_Iodosulfuron_methyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X150_Iprodione_0_01__c != null && lot.X150_Iprodione_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X150_Iprodione_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X151_Iprovalicarb_0_01__c != null && lot.X151_Iprovalicarb_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X151_Iprovalicarb_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X152_Isoprothiolane_0_01__c != null && lot.X152_Isoprothiolane_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X152_Isoprothiolane_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X153_Isoproturon_0_01__c != null && lot.X153_Isoproturon_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X153_Isoproturon_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X154_Isoxaben_0_01__c != null && lot.X154_Isoxaben_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X154_Isoxaben_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X155_Kresoxim_methyl_0_01__c != null && lot.X155_Kresoxim_methyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X155_Kresoxim_methyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X156_Linuron_0_01__c != null && lot.X156_Linuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X156_Linuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X157_Lufenuron_0_01__c != null && lot.X157_Lufenuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X157_Lufenuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X158_Malaoxon_Malathion_0_01__c != null && lot.X158_Malaoxon_Malathion_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X158_Malaoxon_Malathion_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X159_Malathion_0_01__c != null && lot.X159_Malathion_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X159_Malathion_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X160_Malathion_malaoxon_0_01__c != null && lot.X160_Malathion_malaoxon_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X160_Malathion_malaoxon_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X161_Mandipropamid_0_01__c != null && lot.X161_Mandipropamid_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X161_Mandipropamid_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X162_Mefenacet_0_01__c != null && lot.X162_Mefenacet_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X162_Mefenacet_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X163_Mesotrione_0_01__c != null && lot.X163_Mesotrione_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X163_Mesotrione_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X164_Metalaxyl_Metamifop_0_01__c != null && lot.X164_Metalaxyl_Metamifop_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X164_Metalaxyl_Metamifop_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X165_Metamifop_0_01__c != null && lot.X165_Metamifop_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X165_Metamifop_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X166_Metconazole_sum_of_isomers_0_01__c != null && lot.X166_Metconazole_sum_of_isomers_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X166_Metconazole_sum_of_isomers_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X167_Methamidophos_0_005__c != null && lot.X167_Methamidophos_0_005__c > 0.005) {
    passCriteriaMet = false;
} else if (lot.X167_Methamidophos_0_005__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X168_Methomyl_0_01__c != null && lot.X168_Methomyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X168_Methomyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X169_Methoxyfenozide_0_01__c != null && lot.X169_Methoxyfenozide_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X169_Methoxyfenozide_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X170_Methyl_Parathion_0_01__c != null && lot.X170_Methyl_Parathion_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X170_Methyl_Parathion_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X171_Metolachlor_0_01__c != null && lot.X171_Metolachlor_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X171_Metolachlor_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X172_Metribuzin_0_01__c != null && lot.X172_Metribuzin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X172_Metribuzin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X173_Metsulfuron_methyl_0_01__c != null && lot.X173_Metsulfuron_methyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X173_Metsulfuron_methyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X174_Monocrotophos_0_01__c != null && lot.X174_Monocrotophos_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X174_Monocrotophos_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X175_Monuron_0_01__c != null && lot.X175_Monuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X175_Monuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X176_Myclobutanil_0_01__c != null && lot.X176_Myclobutanil_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X176_Myclobutanil_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X177_Novaluron_0_01__c != null && lot.X177_Novaluron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X177_Novaluron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X178_Omethoate_Dimethoate_0_01__c != null && lot.X178_Omethoate_Dimethoate_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X178_Omethoate_Dimethoate_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X179_Oxadiargyl_0_01__c != null && lot.X179_Oxadiargyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X179_Oxadiargyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X180_Oxadiazon_0_01__c != null && lot.X180_Oxadiazon_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X180_Oxadiazon_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X181_Oxamyl_0_01__c != null && lot.X181_Oxamyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X181_Oxamyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X182_Oxycarboxin_Carboxin_sulfone_0_01__c != null && lot.X182_Oxycarboxin_Carboxin_sulfone_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X182_Oxycarboxin_Carboxin_sulfone_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X183_Oxydemeton_methyl_0_01__c != null && lot.X183_Oxydemeton_methyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X183_Oxydemeton_methyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X184_Oxydemeton_methyl_0_01__c != null && lot.X184_Oxydemeton_methyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X184_Oxydemeton_methyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X185_Oxyfluorfen_0_01__c != null && lot.X185_Oxyfluorfen_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X185_Oxyfluorfen_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X186_Paclobutrazol_0_01__c != null && lot.X186_Paclobutrazol_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X186_Paclobutrazol_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X187_Paraoxon_Paraoxon_ethyl_0_01__c != null && lot.X187_Paraoxon_Paraoxon_ethyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X187_Paraoxon_Paraoxon_ethyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X188_Paraoxon_methyl_0_01__c != null && lot.X188_Paraoxon_methyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X188_Paraoxon_methyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X189_Parathion_Ethyl_0_01__c != null && lot.X189_Parathion_Ethyl_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X189_Parathion_Ethyl_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X190_Penconazole_0_01__c != null && lot.X190_Penconazole_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X190_Penconazole_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X191_Pencycuron_0_01__c != null && lot.X191_Pencycuron_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X191_Pencycuron_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X192_Pendimethaline_0_01__c != null && lot.X192_Pendimethaline_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X192_Pendimethaline_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X193_Permethrin_0_01__c != null && lot.X193_Permethrin_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X193_Permethrin_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X194_Phenthoate_0_01__c != null && lot.X194_Phenthoate_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X194_Phenthoate_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X195_Phorate_0_01__c != null && lot.X195_Phorate_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X195_Phorate_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X196_Phorate_0_01__c != null && lot.X196_Phorate_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X196_Phorate_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X197_Phorate_sulfone_0_01__c != null && lot.X197_Phorate_sulfone_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X197_Phorate_sulfone_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X198_Phorate_sulfoxide_0_01__c != null && lot.X198_Phorate_sulfoxide_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X198_Phorate_sulfoxide_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X199_Phosalone_0_01__c != null && lot.X199_Phosalone_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X199_Phosalone_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}

if (lot.X200_Phosphamidon_0_01__c != null && lot.X200_Phosphamidon_0_01__c > 0.01) {
    passCriteriaMet = false;
} else if (lot.X200_Phosphamidon_0_01__c == null) {
    count = count + 1;
} else {
    allFieldsBlank = false;
}
if (lot.X201_Phoxim_0_01__c != null && lot.X201_Phoxim_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X201_Phoxim_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X202_Picloram_0_01__c != null && lot.X202_Picloram_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X202_Picloram_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X203_Picoxystrobin_0_01__c != null && lot.X203_Picoxystrobin_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X203_Picoxystrobin_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X204_Piperonyl_Butoxide_0_01__c!= null && lot.X204_Piperonyl_Butoxide_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X204_Piperonyl_Butoxide_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X205_Pirimicarb_0_01__c != null && lot.X205_Pirimicarb_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X205_Pirimicarb_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X206_Pirimiphos_ethyl_0_01__c != null && lot.X206_Pirimiphos_ethyl_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X206_Pirimiphos_ethyl_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X207_Pirimiphos_methyl_0_01__c != null && lot.X207_Pirimiphos_methyl_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X207_Pirimiphos_methyl_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X208_Pretilachlor_0_01__c != null && lot.X208_Pretilachlor_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X208_Pretilachlor_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X209_Procymidone_0_01__c != null && lot.X209_Procymidone_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X209_Procymidone_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X210_Profenofos_0_005__c != null && lot.X210_Profenofos_0_005__c> 0.005) {
            passCriteriaMet = false;
        }if(lot.X210_Profenofos_0_005__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X211_Propamocarb_0_01__c != null && lot.X211_Propamocarb_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X211_Propamocarb_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X213_Propiconazole_0_005__c != null && lot.X213_Propiconazole_0_005__c> 0.005) {
            passCriteriaMet = false;
        }if(lot.X213_Propiconazole_0_005__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X214_Propoxur_0_01__c != null && lot.X214_Propoxur_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X214_Propoxur_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X215_Prothioconazole_0_005__c != null && lot.X215_Prothioconazole_0_005__c> 0.005) {
            passCriteriaMet = false;
        }if(lot.X215_Prothioconazole_0_005__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X216_Pymetrozine_0_01__c != null && lot.X216_Pymetrozine_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X216_Pymetrozine_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X217_Pyraclostrobin_0_01__c != null && lot.X217_Pyraclostrobin_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X217_Pyraclostrobin_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X218_Pyrazophos_0_01__c != null && lot.X218_Pyrazophos_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X218_Pyrazophos_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X219_Pyrazosulfuron_ethyl_0_01__c != null && lot.X219_Pyrazosulfuron_ethyl_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X219_Pyrazosulfuron_ethyl_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X220_Pyriproxyfen_0_01__c != null && lot.X220_Pyriproxyfen_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X220_Pyriproxyfen_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X221_Quinclorac_0_01__c != null && lot.X221_Quinclorac_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X221_Quinclorac_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X222_Quinmerac_0_01__c != null && lot.X222_Quinmerac_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X222_Quinmerac_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X223_Quinolphos_0_01__c != null && lot.X223_Quinolphos_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X223_Quinolphos_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X224_Quizalfop_P_0_01__c != null && lot.X224_Quizalfop_P_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X224_Quizalfop_P_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X225_Quizalofop_ethyl_0_01__c != null && lot.X225_Quizalofop_ethyl_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X225_Quizalofop_ethyl_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X226_Rimsulfuron_0_01__c != null && lot.X226_Rimsulfuron_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X226_Rimsulfuron_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X227_Simazine_0_01__c != null && lot.X227_Simazine_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X227_Simazine_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X228_Spinetoram_0_01__c != null && lot.X228_Spinetoram_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X228_Spinetoram_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X229_Spinosad_Spin_A__c != null && lot.X229_Spinosad_Spin_A__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X229_Spinosad_Spin_A__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X230_Spirotetramat_0_01__c != null && lot.X230_Spirotetramat_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X230_Spirotetramat_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X231_Spirotetramat_0_01__c != null && lot.X231_Spirotetramat_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X231_Spirotetramat_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X232_S_m_BYI08330_enol_0_01__c != null && lot.X232_S_m_BYI08330_enol_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X232_S_m_BYI08330_enol_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X233_Spirotetramat_mono_hydroxy_0_01__c!= null && lot.X233_Spirotetramat_mono_hydroxy_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X233_Spirotetramat_mono_hydroxy_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X234_Spiroxamine_0_01__c != null && lot.X234_Spiroxamine_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X234_Spiroxamine_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X235_Sulfosulfuron_0_01__c != null && lot.X235_Sulfosulfuron_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X235_Sulfosulfuron_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X236_Sulfoxaflor_sum_of_isomers_0_01__c != null && lot.X236_Sulfoxaflor_sum_of_isomers_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X236_Sulfoxaflor_sum_of_isomers_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X237_Tebuconazole_0_01__c != null && lot.X237_Tebuconazole_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X237_Tebuconazole_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X238_Tebufenozide_0_01__c != null && lot.X238_Tebufenozide_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X238_Tebufenozide_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X239_Teflubenzuron_0_01__c != null && lot.X239_Teflubenzuron_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X239_Teflubenzuron_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X240_Temephos_0_01__c != null && lot.X240_Temephos_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X240_Temephos_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X241_Tetraconazole_0_01__c != null && lot.X241_Tetraconazole_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X241_Tetraconazole_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X242_TFNA_0_01__c != null && lot.X242_TFNA_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X242_TFNA_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X243_TFNG_0_01__c != null && lot.X243_TFNG_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X243_TFNG_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X244_Thiabendazole_0_01__c != null && lot.X244_Thiabendazole_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X244_Thiabendazole_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X245_Thiacloprid_0_01__c != null && lot.X245_Thiacloprid_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X245_Thiacloprid_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X246_Thiamethoxam_0_005__c != null && lot.X246_Thiamethoxam_0_005__c > 0.005) {
            passCriteriaMet = false;
        }if(lot.X246_Thiamethoxam_0_005__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X247_Thifensulfuron_Methyl_0_01__c != null && lot.X247_Thifensulfuron_Methyl_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X247_Thifensulfuron_Methyl_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X248_Thifluzamide_0_01__c != null && lot.X248_Thifluzamide_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X248_Thifluzamide_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X249_Thiobencarb_0_01__c != null && lot.X249_Thiobencarb_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X249_Thiobencarb_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X250_Thiodicarb_0_01__c != null && lot.X250_Thiodicarb_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X250_Thiodicarb_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X251_Thiometon_0_01__c != null && lot.X251_Thiometon_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X251_Thiometon_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X252_Thiophanate_methyl_0_005__c != null && lot.X252_Thiophanate_methyl_0_005__c > 0.005) {
            passCriteriaMet = false;
        }if(lot.X252_Thiophanate_methyl_0_005__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X253_Tolfenpyrad_0_01__c != null && lot.X253_Tolfenpyrad_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X253_Tolfenpyrad_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X254_Triazophos_0_01__c != null && lot.X254_Triazophos_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X254_Triazophos_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X255_Tribenuron_Methyl_0_01__c != null && lot.X255_Tribenuron_Methyl_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X255_Tribenuron_Methyl_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }     
if (lot.X256_Trichlorfon_Dylox_0_01__c!= null && lot.X256_Trichlorfon_Dylox_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X256_Trichlorfon_Dylox_0_01__c== null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X257_Triclopyr_0_01__c != null && lot.X257_Triclopyr_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X257_Triclopyr_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X258_Tricyclazole_0_005__c!= null && lot.X258_Tricyclazole_0_005__c > 0.005) {
            passCriteriaMet = false;
        }if(lot.X258_Tricyclazole_0_005__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }

if (lot.X259_Tridemorph_0_01__c != null && lot.X259_Tridemorph_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X259_Tridemorph_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X260_Trifloxystrobin_0_01__c != null && lot.X260_Trifloxystrobin_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X260_Trifloxystrobin_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X261_Triflumuron_0_01__c != null && lot.X261_Triflumuron_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X261_Triflumuron_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
if (lot.X262_Trinexapac_ethyl_0_01__c!= null && lot.X262_Trinexapac_ethyl_0_01__c> 0.01) {
            passCriteriaMet = false;
        }if(lot.X262_Trinexapac_ethyl_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }

if (lot.X263_Triticonazole_0_01__c != null && lot.X263_Triticonazole_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X263_Triticonazole_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }

     if (lot.X264_Zoxamide_0_01__c != null && lot.X264_Zoxamide_0_01__c > 0.01) {
            passCriteriaMet = false;
        }if(lot.X264_Zoxamide_0_01__c == null){
            count = count+1;
                }else{
           allFieldsBlank = false; 
        }
        
        
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (allFieldsBlank == false && passCriteriaMet == false) {
            system.debug('allFieldsBl/nk'+allFieldsBlank);
            lot.UP_Status__c = 'Fail';
        }  
        if (passCriteriaMet == true && allFieldsBlank == false) {
            system.debug('passCriteriaMet'+passCriteriaMet);

            lot.UP_Status__c = 'Pass';
        } 
         if(totalCondition == count){
                    system.debug('FAil');
            lot.UP_Status__c = 'None';
        }
    }
}


    
   /* public static void checkLotResults(List<FAUP_LOT__c> Lotrecordlist) { 
        
        For(FAUP_LOT__c lot:  Lotrecordlist){            
            if ((lot.Imidacloprid__c != null && lot.Imidacloprid__c <= 0.01) &&   
                (lot.Tebuconazole__c != null && lot.Tebuconazole__c <= 1.5) &&
                (lot.Thiamethoxam__c != null && lot.Thiamethoxam__c <= 0.01) &&
                (lot.Trifloxystrobin__c != null && lot.Trifloxystrobin__c <= 5.0) &&
                (lot.Isoprothiolane__c != null && lot.Isoprothiolane__c <= 6.0))
            {
system.debug('IF CHALA PASS');
                lot.UP_Status__c = 'Pass';
            }else if(lot.Imidacloprid__c == null && lot.Tebuconazole__c == null && lot.Thiamethoxam__c == null 
						&& lot.Trifloxystrobin__c == null && lot.Isoprothiolane__c == null)
                     {
                         system.debug('IF ELES CHALA NULL');
                          lot.UP_Status__c =null;    
                      } 
                 else {
                     system.debug('ELSE CHALA FAIL');
                          lot.UP_Status__c = 'Fail';
                      }            
        } 
        
    }*/
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   
 public static void updateSuspect(List<FAUP_LOT__c> Lotrecordlist) { 
        
//VARIABLES & COLLECTIONS
        string statusLot = '';   //variable to store Lot current status
        string VarlotName='';       //variable to store Lot Name
        Set<Id> SetlotId = new Set<Id>();   //Set to store lot id to get related samples of a lot.
        Set<Id> SetclientFarmerId = new Set<Id>();  //Set to store client farmer id from samples to get client farmers whose sample is created.
        Set<Id> SetSampleId = new Set<Id>();  //Set to store sample Id from samples to get realted farms of a sample.
        List<FAUP_Sample__c> updatedSamplesList = new List<FAUP_Sample__c>();  //List to store updated sample records.
        List<Account> updatedClientFarmerList = new List<Account>();  //List to store updated clientfarmer records.
        List<Farm__c> updatedtFarmList = new List<Farm__c>();    //List to store updated farm records.
        
        //Get current lot record details on the basis of value status Pass or Fail and store in set and variables.
        For(FAUP_LOT__c lot:  Lotrecordlist){ 
            
            if(lot.UP_Status__c == 'Fail'){
                statusLot = lot.UP_Status__c; //store Lot status in variable statusLot.
                VarlotName = lot.Name;      //store Lot Name in variable lotName.
                SetlotId.add(lot.id);   //store Id of lot in SetlotId.
            }else if(lot.UP_Status__c == 'Pass'){
                statusLot = lot.UP_Status__c;
                VarlotName = lot.Name;
                SetlotId.add(lot.id);   
            } 
        }
        
        if(SetlotId.size()>0){
            
            //UPdate samples suspected = true           
            List<FAUP_Sample__c> SampleList = [SELECT Id, Name, UP_Suspect__c,UP_LOT__c,Client_Farmer__c FROM FAUP_Sample__c WHERE UP_LOT__c In: SetlotId];
            
            if(SampleList.Size()>0){
                for(FAUP_Sample__c sample: SampleList){
                    
                    if(statusLot == 'Fail'){
                        sample.UP_Suspect__c = true;     //update each sample record status = true.
                        updatedSamplesList.add(sample);  // store sample records to be updated
                        SetSampleId.add(sample.Id);     //store Id of sample in SetSampleId.
                        if(sample.Client_Farmer__c != null){
                            SetclientFarmerId.add(sample.Client_Farmer__c); //store client farmerId  in SetclientFarmerId.
                        }
                    }else if(statusLot == 'Pass'){
                      //  sample.UP_Suspect__c = false;
                     //   updatedSamplesList.add(sample);
                        SetSampleId.add(sample.Id);
                        if(sample.Client_Farmer__c != null){
                            SetclientFarmerId.add(sample.Client_Farmer__c);
                        }
                    }
                }
            }
        }  
        if(SetclientFarmerId.Size() >0){
            
//UPdate Client Farmers suspected = true           
            List<Account> ClientFarmerList = [SELECT Id, Name, Suspect__c,LOT_1_Name__c,LOT_1_Status__c,LOT_2_Name__c,LOT_2_Status__c,LOT_3_Name__c,LOT_3_Status__c 
                                              FROM Account 
                                              WHERE Id In: SetclientFarmerId];
            for(Account cltfrm: ClientFarmerList){
                
                if(statusLot == 'Fail'){
                    if(cltfrm.LOT_1_Name__c == null  && cltfrm.LOT_1_Status__c == null){                   
                        cltfrm.Suspect__c =true; 
                        cltfrm.LOT_1_Status__c = 'Doubt';   //update each clientfarmer record LOT1 status = Doubt.
                        cltfrm.LOT_1_Name__c = VarlotName;  //update each clientfarmer record LOT1 Name =  variable VarlotName.  
                    }
                    else if(cltfrm.LOT_2_Name__c == null && cltfrm.LOT_2_Status__c == null){
                        cltfrm.Suspect__c =true; 
                        cltfrm.LOT_2_Status__c = 'Doubt';  //update each clientfarmer record LOT2 status = Doubt.
                        cltfrm.LOT_2_Name__c = VarlotName; //update each clientfarmer record LOT2 Name =  variable VarlotName.
                    }
                    else if(cltfrm.LOT_3_Name__c == null && cltfrm.LOT_3_Status__c == null){
                        cltfrm.Suspect__c =true;
                        cltfrm.LOT_3_Status__c = 'Doubt';  //update each clientfarmer record LOT3 status = Doubt.
                        cltfrm.LOT_3_Name__c = VarlotName; //update each clientfarmer record LOT3 Name =  variable VarlotName.
                    }
                    updatedClientFarmerList.add(cltfrm);
                    
                } else if(statusLot == 'Pass'){
                    
                    if(cltfrm.LOT_1_Name__c == null && cltfrm.LOT_1_Status__c == null){
                        system.debug(cltfrm.Name);
                        system.debug(cltfrm.LOT_1_Name__c);
                        cltfrm.LOT_1_Status__c = ' No Doubt';
                        cltfrm.LOT_1_Name__c = VarlotName;
                    }
                    else if(cltfrm.LOT_2_Name__c == null && cltfrm.LOT_2_Status__c == null){
                        cltfrm.LOT_2_Status__c = ' No Doubt';
                        cltfrm.LOT_2_Name__c = VarlotName;
                    }
                    else if(cltfrm.LOT_3_Name__c == null && cltfrm.LOT_3_Status__c == null){
                        cltfrm.LOT_3_Status__c = 'No Doubt';
                        cltfrm.LOT_3_Name__c = VarlotName;
                    }
                    
                    updatedClientFarmerList.add(cltfrm);
                }
            }
        }
        
        if(SetSampleId.Size() > 0){
            
//UPdate Farms suspected = true           
            List<Farm__c> FarmsList = [SELECT Id, Name, UP_Suspect__c,UP_Sample__c
                                       FROM Farm__c 
                                       WHERE UP_Sample__c In:SetSampleId];
            
            for(Farm__c frm: FarmsList){
                if(statusLot == 'Fail'){
                    frm.UP_Suspect__c =true;
                    updatedtFarmList.add(frm);
                }
				/* else if(statusLot == 'Pass'){
                    frm.UP_Suspect__c =false;
                    updatedtFarmList.add(frm); 
                }*/
                
            }
        }
        
        if(updatedSamplesList.Size()>0){
            update updatedSamplesList;
        }
        
        if(updatedClientFarmerList.Size()>0){
            update updatedClientFarmerList;
        }
        if(updatedtFarmList.Size()>0){
            update updatedtFarmList;
        }
        
    }    
}