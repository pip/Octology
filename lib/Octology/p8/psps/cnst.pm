# H83M3QqE: Octology::p8::psps::cnst.pm crE8d by PipStuart <Pip@CPAN.Org> as "Pip's Screeps Global Constants" module to export l8st copies of all Constants;
# 2du:ck if rang got RoomName argz that are same or can still compute btwn nearby rooms,git pull && valid8 deep cdif,write POD && tsts;
package     Octology::p8::psps::cnst; # originally was all exported from psps.pm but isol8d here for inclusion in any other sub-classes
use strict; use warnings;use utf8;use v5.10;#se JSON; # $hashref = decode_json($utf8_encoded_json_text); # needs 5.14 for PP, had to pmei JSON
require       Exporter  ;
use base qw(  Exporter );
use vars qw( @EXPORT   );
use         Octology::a8; # Compress && eXpand Base64 Room(Name|Position|Terrain) && SerializedPath
my  $VERSION='0.0';my $d8VS='H9AM0dGN'; # l8st packing fits all in less than 1 page (46 lines) with few blank areas,but preserves rel8ively consistent columns
our @EXPORT = qw(OK          cdif cbrn      CREEP_LIFE_TIME        FIND_EXIT_TOP  %gd8a clrz        MINERAL_REGEN_TIME   ROOM_WIDTH  RESOURCE_UTRIUM_HYDRIDE
      MOVE       ERR_NOT_OWNER    xbrn      CREEP_CLAIM_LIFE_TIME  FIND_EXIT_RIGHT      prtz        MINERAL_MIN_AMOUNT   ROOM_HEIGHT RESOURCE_UTRIUM_OXIDE
      WORK       ERR_NO_PATH      cbrp      CREEP_CORPSE_RATE      FIND_EXIT_BOTTOM     rolz        MINERAL_RANDOM_FACTOR            RESOURCE_KEANIUM_HYDRIDE
      CARRY      ERR_NAME_EXISTS  xbrp rang  RAMPART_DECAY_AMOUNT  FIND_EXIT_LEFT       stcz        MINERAL_DENSITY                  RESOURCE_KEANIUM_OXIDE
         ATTACK  ERR_BUSY         cbrt cbsp  RAMPART_DECAY_TIME    FIND_EXIT            lokz        MINERAL_DENSITY_PROBABILITY      RESOURCE_LEMERGIUM_HYDRIDE
  RANGED_ATTACK  ERR_NOT_FOUND    xbrt xbsp  RAMPART_HITS          FIND_CREEPS                      MINERAL_DENSITY_CHANGE           RESOURCE_LEMERGIUM_OXIDE
      TOUGH      ERR_NOT_ENOUGH_ENERGY       RAMPART_HITS_MAX      FIND_MY_CREEPS                  CONTAINER_HITS                    RESOURCE_ZYNTHIUM_HYDRIDE
      HEAL       ERR_NOT_ENOUGH_RESOURCES   SPAWN_HITS             FIND_HOSTILE_CREEPS             CONTAINER_CAPACITY                RESOURCE_ZYNTHIUM_OXIDE
      CLAIM      ERR_INVALID_TARGET         SPAWN_ENERGY_START     FIND_SOURCES_ACTIVE             CONTAINER_DECAY                   RESOURCE_GHODIUM_HYDRIDE
 BODYPART_COST   ERR_FULL                   SPAWN_ENERGY_CAPACITY  FIND_SOURCES                    CONTAINER_DECAY_TIME              RESOURCE_GHODIUM_OXIDE
   WORLD_WIDTH   ERR_NOT_IN_RANGE     CREEP_SPAWN_TIME             FIND_DROPPED_ENERGY             CONTAINER_DECAY_TIME_OWNED      RESOURCE_UTRIUM_ACID
   WORLD_HEIGHT  ERR_INVALID_ARGS           SPAWN_RENEW_RATIO      FIND_DROPPED_RESOURCES        EXTRACTOR_HITS                    RESOURCE_UTRIUM_ALKALIDE
     TOP         ERR_TIRED                OBSTACLE_OBJECT_TYPES    FIND_STRUCTURES               EXTRACTOR_COOLDOWN                RESOURCE_KEANIUM_ACID
     TOP_RIGHT   ERR_NO_BODYPART            STRUCTURE_SPAWN        FIND_MY_STRUCTURES                  LAB_HITS                    RESOURCE_KEANIUM_ALKALIDE
         RIGHT   ERR_NOT_ENOUGH_EXTENSIONS  STRUCTURE_EXTENSION    FIND_HOSTILE_STRUCTURES             LAB_MINERAL_CAPACITY        RESOURCE_LEMERGIUM_ACID
  BOTTOM_RIGHT   ERR_RCL_NOT_ENOUGH         STRUCTURE_ROAD         FIND_FLAGS                          LAB_ENERGY_CAPACITY         RESOURCE_LEMERGIUM_ALKALIDE
  BOTTOM         ERR_GCL_NOT_ENOUGH         STRUCTURE_WALL         FIND_CONSTRUCTION_SITES             LAB_BOOST_ENERGY            RESOURCE_ZYNTHIUM_ACID
  BOTTOM_LEFT     LOOK_CREEPS               STRUCTURE_RAMPART      FIND_MY_SPAWNS                      LAB_BOOST_MINERAL           RESOURCE_ZYNTHIUM_ALKALIDE
         LEFT     LOOK_ENERGY               STRUCTURE_KEEPER_LAIR  FIND_HOSTILE_SPAWNS                 LAB_COOLDOWN                RESOURCE_GHODIUM_ACID
     TOP_LEFT     LOOK_RESOURCES            STRUCTURE_PORTAL       FIND_MY_CONSTRUCTION_SITES          LAB_REACTION_AMOUNT         RESOURCE_GHODIUM_ALKALIDE
  COLOR_RED       LOOK_SOURCES              STRUCTURE_CONTROLLER   FIND_HOSTILE_CONSTRUCTION_SITES   TERMINAL_CAPACITY    TERRAIN_MASK_WALL   DENSITY_LOW
  COLOR_PURPLE    LOOK_MINERALS             STRUCTURE_LINK         FIND_MINERALS                     TERMINAL_HITS        TERRAIN_MASK_SWAMP  DENSITY_MODERATE
  COLOR_BLUE      LOOK_STRUCTURES           STRUCTURE_STORAGE      FIND_NUKES                        TERMINAL_SEND_COST   TERRAIN_MASK_LAVA   DENSITY_HIGH
  COLOR_CYAN      LOOK_FLAGS                STRUCTURE_TOWER         SOURCE_ENERGY_CAPACITY           TERMINAL_MIN_SEND  ROAD_HITS             DENSITY_ULTRA
  COLOR_GREEN     LOOK_CONSTRUCTION_SITES   STRUCTURE_OBSERVER      SOURCE_ENERGY_NEUTRAL_CAPACITY   TERMINAL_COOLDOWN  ROAD_WEAROUT
  COLOR_YELLOW    LOOK_NUKES                STRUCTURE_POWER_BANK    SOURCE_ENERGY_KEEPER_CAPACITY   SAFE_MODE_DURATION  ROAD_DECAY_AMOUNT   MODE_SIMULATION
  COLOR_ORANGE    LOOK_TERRAIN              STRUCTURE_POWER_SPAWN    POWER_SPAWN_HITS               SAFE_MODE_COOLDOWN  ROAD_DECAY_TIME     MODE_WORLD
  COLOR_BROWN        CARRY_CAPACITY         STRUCTURE_EXTRACTOR      POWER_SPAWN_ENERGY_CAPACITY    SAFE_MODE_COST       LINK_HITS
  COLOR_GREY                HARVEST_POWER   STRUCTURE_LAB            POWER_SPAWN_POWER_CAPACITY    ENERGY_REGEN_TIME     LINK_HITS_MAX     RESOURCE_HYDROGEN
  COLOR_WHITE       HARVEST_MINERAL_POWER   STRUCTURE_TERMINAL       POWER_SPAWN_ENERGY_RATIO      ENERGY_DECAY          LINK_CAPACITY     RESOURCE_OXYGEN
 WALL_HITS                   REPAIR_POWER   STRUCTURE_CONTAINER    CONTROLLER_LEVELS                STORAGE_CAPACITY     LINK_COOLDOWN     RESOURCE_UTRIUM
 WALL_HITS_MAX            DISMANTLE_POWER   STRUCTURE_NUKER        CONTROLLER_STRUCTURES            STORAGE_HITS         LINK_LOSS_RATIO   RESOURCE_LEMERGIUM
  GCL_POW                     BUILD_POWER     TOWER_HITS           CONTROLLER_DOWNGRADE            OBSERVER_HITS       SIGN_NOVICE_AREA    RESOURCE_KEANIUM
  GCL_MULTIPLY               ATTACK_POWER     TOWER_CAPACITY       CONTROLLER_CLAIM_DOWNGRADE      OBSERVER_RANGE      SIGN_RESPAWN_AREA   RESOURCE_ZYNTHIUM
  GCL_NOVICE     UPGRADE_CONTROLLER_POWER     TOWER_ENERGY_COST    CONTROLLER_RESERVE                 PORTAL_UNSTABLE     RESOURCE_ENERGY  RESOURCE_CATALYST
   FLAGS_LIMIT        RANGED_ATTACK_POWER     TOWER_POWER_ATTACK   CONTROLLER_RESERVE_MAX             PORTAL_MIN_TIMEOUT  RESOURCE_POWER   RESOURCE_GHODIUM
  PORTAL_DECAY                 HEAL_POWER     TOWER_POWER_HEAL     CONTROLLER_MAX_UPGRADE_PER_TICK    PORTAL_MAX_TIMEOUT  RESOURCE_CATALYZED_UTRIUM_ACID
   ORDER_SELL           RANGED_HEAL_POWER     TOWER_POWER_REPAIR   CONTROLLER_ATTACK_BLOCKED_UPGRADE    SYSTEM_USERNAME   RESOURCE_CATALYZED_UTRIUM_ALKALIDE
   ORDER_BUY                 REPAIR_COST      TOWER_OPTIMAL_RANGE  CONTROLLER_NUKE_BLOCKED_UPGRADE    SUBSCRIPTION_TOKEN  RESOURCE_CATALYZED_KEANIUM_ACID
  MARKET_FEE              DISMANTLE_COST      TOWER_FALLOFF_RANGE   CONSTRUCTION_COST               INVADERS_ENERGY_GOAL  RESOURCE_CATALYZED_KEANIUM_ALKALIDE
  RESOURCES_ALL  EXTENSION_HITS               TOWER_FALLOFF         CONSTRUCTION_COST_ROAD_SWAMP_RATIO                    RESOURCE_CATALYZED_LEMERGIUM_ACID
  BODYPARTS_ALL  EXTENSION_ENERGY_CAPACITY  NUKER_HITS             MAX_CONSTRUCTION_SITES     RESOURCE_HYDROXIDE          RESOURCE_CATALYZED_LEMERGIUM_ALKALIDE
     COLORS_ALL   POWER_BANK_HITS           NUKER_COOLDOWN         MAX_CREEP_SIZE             RESOURCE_ZYNTHIUM_KEANITE   RESOURCE_CATALYZED_ZYNTHIUM_ACID
   BOOSTS         POWER_BANK_CAPACITY_MAX   NUKER_ENERGY_CAPACITY    NUKE_LAND_TIME           RESOURCE_UTRIUM_LEMERGITE   RESOURCE_CATALYZED_ZYNTHIUM_ALKALIDE
  REACTIONS       POWER_BANK_CAPACITY_MIN   NUKER_GHODIUM_CAPACITY   NUKE_RANGE   NUKE_DAMAGE                             RESOURCE_CATALYZED_GHODIUM_ACID
                  POWER_BANK_CAPACITY_CRIT   POWER_BANK_DECAY   POWER_BANK_HIT_BACK   POWER_BANK_RESPAWN_TIME             RESOURCE_CATALYZED_GHODIUM_ALKALIDE);
#ur @EXPORT2= qw(OK                         CREEP_LIFE_TIME        FIND_EXIT_TOP                    MINERAL_REGEN_TIME           RESOURCE_UTRIUM_HYDRIDE
# MOVE           ERR_NOT_OWNER              CREEP_CLAIM_LIFE_TIME  FIND_EXIT_RIGHT                  MINERAL_MIN_AMOUNT           RESOURCE_UTRIUM_OXIDE
# WORK           ERR_NO_PATH                CREEP_CORPSE_RATE      FIND_EXIT_BOTTOM                 MINERAL_RANDOM_FACTOR        RESOURCE_KEANIUM_HYDRIDE
# CARRY          ERR_NAME_EXISTS                                   FIND_EXIT_LEFT                   MINERAL_DENSITY              RESOURCE_KEANIUM_OXIDE
# ATTACK         ERR_BUSY                   RAMPART_DECAY_AMOUNT   FIND_EXIT                        MINERAL_DENSITY_PROBABILITY  RESOURCE_LEMERGIUM_HYDRIDE
# RANGED_ATTACK  ERR_NOT_FOUND              RAMPART_DECAY_TIME     FIND_CREEPS                      MINERAL_DENSITY_CHANGE       RESOURCE_LEMERGIUM_OXIDE
# TOUGH          ERR_NOT_ENOUGH_ENERGY      RAMPART_HITS           FIND_MY_CREEPS                                                RESOURCE_ZYNTHIUM_HYDRIDE
# HEAL           ERR_NOT_ENOUGH_RESOURCES   RAMPART_HITS_MAX       FIND_HOSTILE_CREEPS              CONTAINER_HITS               RESOURCE_ZYNTHIUM_OXIDE
# CLAIM          ERR_INVALID_TARGET                                FIND_SOURCES_ACTIVE              CONTAINER_CAPACITY           RESOURCE_GHODIUM_HYDRIDE
#                ERR_FULL                   SPAWN_HITS             FIND_SOURCES                     CONTAINER_DECAY              RESOURCE_GHODIUM_OXIDE
# BODYPART_COST  ERR_NOT_IN_RANGE           SPAWN_ENERGY_START     FIND_DROPPED_ENERGY              CONTAINER_DECAY_TIME
#                ERR_INVALID_ARGS           SPAWN_ENERGY_CAPACITY  FIND_DROPPED_RESOURCES           CONTAINER_DECAY_TIME_OWNED   RESOURCE_UTRIUM_ACID
# WORLD_WIDTH    ERR_TIRED                  CREEP_SPAWN_TIME       FIND_STRUCTURES                                               RESOURCE_UTRIUM_ALKALIDE
# WORLD_HEIGHT   ERR_NO_BODYPART            SPAWN_RENEW_RATIO      FIND_MY_STRUCTURES               EXTRACTOR_HITS               RESOURCE_KEANIUM_ACID
#                ERR_NOT_ENOUGH_EXTENSIONS                         FIND_HOSTILE_STRUCTURES          EXTRACTOR_COOLDOWN           RESOURCE_KEANIUM_ALKALIDE
# TOP            ERR_RCL_NOT_ENOUGH         OBSTACLE_OBJECT_TYPES  FIND_FLAGS                                                    RESOURCE_LEMERGIUM_ACID
# TOP_RIGHT      ERR_GCL_NOT_ENOUGH                                FIND_CONSTRUCTION_SITES          LAB_HITS                     RESOURCE_LEMERGIUM_ALKALIDE
# RIGHT                                     STRUCTURE_SPAWN        FIND_MY_SPAWNS                   LAB_MINERAL_CAPACITY         RESOURCE_ZYNTHIUM_ACID
# BOTTOM_RIGHT   LOOK_CREEPS                STRUCTURE_EXTENSION    FIND_HOSTILE_SPAWNS              LAB_ENERGY_CAPACITY          RESOURCE_ZYNTHIUM_ALKALIDE
# BOTTOM         LOOK_ENERGY                STRUCTURE_ROAD         FIND_MY_CONSTRUCTION_SITES       LAB_BOOST_ENERGY             RESOURCE_GHODIUM_ACID
# BOTTOM_LEFT    LOOK_RESOURCES             STRUCTURE_WALL         FIND_HOSTILE_CONSTRUCTION_SITES  LAB_BOOST_MINERAL            RESOURCE_GHODIUM_ALKALIDE
# LEFT           LOOK_SOURCES               STRUCTURE_RAMPART      FIND_MINERALS                    LAB_COOLDOWN
# TOP_LEFT       LOOK_MINERALS              STRUCTURE_KEEPER_LAIR  FIND_NUKES                       LAB_REACTION_AMOUNT   TERRAIN_MASK_WALL   DENSITY_LOW
#                LOOK_STRUCTURES            STRUCTURE_PORTAL                                                              TERRAIN_MASK_SWAMP  DENSITY_MODERATE
# COLOR_RED      LOOK_FLAGS                 STRUCTURE_CONTROLLER   SOURCE_ENERGY_CAPACITY           TERMINAL_CAPACITY     TERRAIN_MASK_LAVA   DENSITY_HIGH
# COLOR_PURPLE   LOOK_CONSTRUCTION_SITES    STRUCTURE_LINK         SOURCE_ENERGY_NEUTRAL_CAPACITY   TERMINAL_HITS                             DENSITY_ULTRA
# COLOR_BLUE     LOOK_NUKES                 STRUCTURE_STORAGE      SOURCE_ENERGY_KEEPER_CAPACITY    TERMINAL_SEND_COST  ROAD_HITS
# COLOR_CYAN     LOOK_TERRAIN               STRUCTURE_TOWER                                         TERMINAL_MIN_SEND   ROAD_WEAROUT       MODE_SIMULATION
# COLOR_GREEN                               STRUCTURE_OBSERVER     POWER_SPAWN_HITS                 TERMINAL_COOLDOWN   ROAD_DECAY_AMOUNT  MODE_SURVIVAL
# COLOR_YELLOW   CARRY_CAPACITY             STRUCTURE_POWER_BANK   POWER_SPAWN_ENERGY_CAPACITY                          ROAD_DECAY_TIME    MODE_WORLD
# COLOR_ORANGE   HARVEST_POWER              STRUCTURE_POWER_SPAWN  POWER_SPAWN_POWER_CAPACITY       SAFE_MODE_DURATION                     MODE_ARENA
# COLOR_BROWN    HARVEST_MINERAL_POWER      STRUCTURE_EXTRACTOR    POWER_SPAWN_ENERGY_RATIO         SAFE_MODE_COOLDOWN  LINK_HITS
# COLOR_GREY     REPAIR_POWER               STRUCTURE_LAB                                           SAFE_MODE_COST      LINK_HITS_MAX    RESOURCE_HYDROGEN
# COLOR_WHITE    DISMANTLE_POWER            STRUCTURE_TERMINAL     CONTROLLER_LEVELS                                    LINK_CAPACITY    RESOURCE_OXYGEN
#                BUILD_POWER                STRUCTURE_CONTAINER    CONTROLLER_STRUCTURES            ENERGY_REGEN_TIME   LINK_COOLDOWN    RESOURCE_UTRIUM
# WALL_HITS      ATTACK_POWER               STRUCTURE_NUKER        CONTROLLER_DOWNGRADE             ENERGY_DECAY        LINK_LOSS_RATIO  RESOURCE_LEMERGIUM
# WALL_HITS_MAX  UPGRADE_CONTROLLER_POWER                          CONTROLLER_CLAIM_DOWNGRADE                                            RESOURCE_KEANIUM
#                RANGED_ATTACK_POWER        TOWER_HITS             CONTROLLER_RESERVE               STORAGE_CAPACITY    RESOURCE_ENERGY  RESOURCE_ZYNTHIUM
# GCL_POW        HEAL_POWER                 TOWER_CAPACITY         CONTROLLER_RESERVE_MAX           STORAGE_HITS        RESOURCE_POWER   RESOURCE_CATALYST
# GCL_MULTIPLY   RANGED_HEAL_POWER          TOWER_ENERGY_COST      CONTROLLER_MAX_UPGRADE_PER_TICK                                       RESOURCE_GHODIUM
# GCL_NOVICE     REPAIR_COST                TOWER_POWER_ATTACK     CONTROLLER_ATTACK_BLOCKED_UPGRADE   OBSERVER_HITS
#                DISMANTLE_COST             TOWER_POWER_HEAL       CONTROLLER_NUKE_BLOCKED_UPGRADE     OBSERVER_RANGE   RESOURCE_CATALYZED_UTRIUM_ACID
# FLAGS_LIMIT                               TOWER_POWER_REPAIR                                                          RESOURCE_CATALYZED_UTRIUM_ALKALIDE
#                EXTENSION_HITS             TOWER_OPTIMAL_RANGE    CONSTRUCTION_COST                                    RESOURCE_CATALYZED_KEANIUM_ACID
# PORTAL_DECAY   EXTENSION_ENERGY_CAPACITY  TOWER_FALLOFF_RANGE    CONSTRUCTION_COST_ROAD_SWAMP_RATIO                   RESOURCE_CATALYZED_KEANIUM_ALKALIDE
#                                           TOWER_FALLOFF                                                               RESOURCE_CATALYZED_LEMERGIUM_ACID
# ORDER_SELL     POWER_BANK_HITS                                   MAX_CONSTRUCTION_SITES  RESOURCE_HYDROXIDE           RESOURCE_CATALYZED_LEMERGIUM_ALKALIDE
# ORDER_BUY      POWER_BANK_CAPACITY_MAX    NUKER_HITS             MAX_CREEP_SIZE          RESOURCE_ZYNTHIUM_KEANITE    RESOURCE_CATALYZED_ZYNTHIUM_ACID
#                POWER_BANK_CAPACITY_MIN    NUKER_COOLDOWN                                 RESOURCE_UTRIUM_LEMERGITE    RESOURCE_CATALYZED_ZYNTHIUM_ALKALIDE
# MARKET_FEE     POWER_BANK_CAPACITY_CRIT   NUKER_ENERGY_CAPACITY   SIGN_NOVICE_AREA                                    RESOURCE_CATALYZED_GHODIUM_ACID
#                POWER_BANK_DECAY           NUKER_GHODIUM_CAPACITY  SIGN_RESPAWN_AREA      PORTAL_UNSTABLE              RESOURCE_CATALYZED_GHODIUM_ALKALIDE
# RESOURCES_ALL  POWER_BANK_HIT_BACK        NUKE_LAND_TIME                                 PORTAL_MIN_TIMEOUT
# BODYPARTS_ALL                             NUKE_RANGE              SUBSCRIPTION_TOKEN     PORTAL_MAX_TIMEOUT   BOOSTS  REACTIONS  INVADERS_ENERGY_GOAL
#    COLORS_ALL  POWER_BANK_RESPAWN_TIME    NUKE_DAMAGE             SYSTEM_USERNAME  ); # dense layout needs 6 xtra vim lines past 1 page,preserving sepR8 blox
sub OK                              () {         0;}
sub ERR_NOT_OWNER                   () {        -1;}
sub ERR_NO_PATH                     () {        -2;}
sub ERR_NAME_EXISTS                 () {        -3;}
sub ERR_BUSY                        () {        -4;}
sub ERR_NOT_FOUND                   () {        -5;}
sub ERR_NOT_ENOUGH_ENERGY           () {        -6;}
sub ERR_NOT_ENOUGH_RESOURCES        () {        -6;}
sub ERR_INVALID_TARGET              () {        -7;}
sub ERR_FULL                        () {        -8;}
sub ERR_NOT_IN_RANGE                () {        -9;}
sub ERR_INVALID_ARGS                () {       -10;}
sub ERR_TIRED                       () {       -11;}
sub ERR_NO_BODYPART                 () {       -12;}
sub ERR_NOT_ENOUGH_EXTENSIONS       () {        -6;}
sub ERR_RCL_NOT_ENOUGH              () {       -14;}
sub ERR_GCL_NOT_ENOUGH              () {       -15;}

sub FIND_EXIT_TOP                   () {         1;}
sub FIND_EXIT_RIGHT                 () {         3;}
sub FIND_EXIT_BOTTOM                () {         5;}
sub FIND_EXIT_LEFT                  () {         7;}
sub FIND_EXIT                       () {        10;}
sub FIND_CREEPS                     () {       101;}
sub FIND_MY_CREEPS                  () {       102;}
sub FIND_HOSTILE_CREEPS             () {       103;}
sub FIND_SOURCES_ACTIVE             () {       104;}
sub FIND_SOURCES                    () {       105;}
sub FIND_DROPPED_ENERGY             () {      -106;}
sub FIND_DROPPED_RESOURCES          () {       106;}
sub FIND_STRUCTURES                 () {       107;}
sub FIND_MY_STRUCTURES              () {       108;}
sub FIND_HOSTILE_STRUCTURES         () {       109;}
sub FIND_FLAGS                      () {       110;}
sub FIND_CONSTRUCTION_SITES         () {       111;}
sub FIND_MY_SPAWNS                  () {       112;}
sub FIND_HOSTILE_SPAWNS             () {       113;}
sub FIND_MY_CONSTRUCTION_SITES      () {       114;}
sub FIND_HOSTILE_CONSTRUCTION_SITES () {       115;}
sub FIND_MINERALS                   () {       116;}
sub FIND_NUKES                      () {       117;}

sub TOP                             () {         1;}
sub TOP_RIGHT                       () {         2;}
sub RIGHT                           () {         3;}
sub BOTTOM_RIGHT                    () {         4;}
sub BOTTOM                          () {         5;}
sub BOTTOM_LEFT                     () {         6;}
sub LEFT                            () {         7;}
sub TOP_LEFT                        () {         8;}

sub COLOR_RED                       () {         1;}
sub COLOR_PURPLE                    () {         2;}
sub COLOR_BLUE                      () {         3;}
sub COLOR_CYAN                      () {         4;}
sub COLOR_GREEN                     () {         5;}
sub COLOR_YELLOW                    () {         6;}
sub COLOR_ORANGE                    () {         7;}
sub COLOR_BROWN                     () {         8;}
sub COLOR_GREY                      () {         9;}
sub COLOR_WHITE                     () {        10;}

sub LOOK_CREEPS                     () { "creep"           ;}
sub LOOK_ENERGY                     () { "energy"          ;}
sub LOOK_RESOURCES                  () { "resource"        ;}
sub LOOK_SOURCES                    () { "source"          ;}
sub LOOK_MINERALS                   () { "mineral"         ;}
sub LOOK_STRUCTURES                 () { "structure"       ;}
sub LOOK_FLAGS                      () { "flag"            ;}
sub LOOK_CONSTRUCTION_SITES         () { "constructionSite";}
sub LOOK_NUKES                      () { "nuke"            ;}
sub LOOK_TERRAIN                    () { "terrain"         ;}

sub OBSTACLE_OBJECT_TYPES           () { ["spawn", "creep", "wall", "source", "constructedWall", "extension", "link", "storage", "tower", "observer",
                                     "powerSpawn", "powerBank", "lab", "terminal", "nuker"];} # this could be qw() instead

sub MOVE                            () { "move"            ;} # my order is WMCA RHLT instead of MWCA RTHL here
sub WORK                            () { "work"            ;}
sub CARRY                           () { "carry"           ;}
sub ATTACK                          () { "attack"          ;}
sub RANGED_ATTACK                   () { "ranged_attack"   ;}
sub TOUGH                           () { "tough"           ;}
sub HEAL                            () { "heal"            ;}
sub CLAIM                           () { "claim"           ;}

sub BODYPART_COST                   () { {
        "move"                      =>          50,
        "work"                      =>         100,
        "attack"                    =>          80,
        "carry"                     =>          50,
        "heal"                      =>         250,
        "ranged_attack"             =>         150,
        "tough"                     =>          10,
        "claim"                     =>         600 };}

sub  ROOM_WIDTH                     () {        50;} # these are not actual constants from JavaScript code but have been added here to standardize code d8a
sub  ROOM_HEIGHT                    () {        50;}

sub WORLD_WIDTH                     () {       202;} # these were always upd8ing, but are now deprec8d in favor of Game.map.getWorldSize() for sepR8 shardz
sub WORLD_HEIGHT                    () {       202;}

sub CREEP_LIFE_TIME                 () {      1500;}
sub CREEP_CLAIM_LIFE_TIME           () {       500;}
sub CREEP_CORPSE_RATE               () {       0.2;}

sub CARRY_CAPACITY                  () {        50;}
sub HARVEST_POWER                   () {         2;}
sub HARVEST_MINERAL_POWER           () {         1;}
sub REPAIR_POWER                    () {       100;}
sub DISMANTLE_POWER                 () {        50;}
sub BUILD_POWER                     () {         5;}
sub ATTACK_POWER                    () {        30;}
sub UPGRADE_CONTROLLER_POWER        () {         1;}
sub RANGED_ATTACK_POWER             () {        10;}
sub HEAL_POWER                      () {        12;}
sub RANGED_HEAL_POWER               () {         4;}
sub REPAIR_COST                     () {     0.01 ;}
sub DISMANTLE_COST                  () {     0.005;}

sub RAMPART_DECAY_AMOUNT            () {       300;}
sub RAMPART_DECAY_TIME              () {       100;}
sub RAMPART_HITS                    () {         1;}
sub RAMPART_HITS_MAX                () { {2=> 300000, 3=> 1000000, 4=> 3000000, 5=> 10000000, 6=> 30000000, 7=> 100000000, 8=> 300000000};}

sub ENERGY_REGEN_TIME               () {       300;}
sub ENERGY_DECAY                    () {      1000;}

sub SPAWN_HITS                      () {      5000;}
sub SPAWN_ENERGY_START              () {       300;}
sub SPAWN_ENERGY_CAPACITY           () {       300;}
sub CREEP_SPAWN_TIME                () {         3;}
sub SPAWN_RENEW_RATIO               () {       1.2;}

sub SOURCE_ENERGY_CAPACITY          () {      3000;}
sub SOURCE_ENERGY_NEUTRAL_CAPACITY  () {      1500;}
sub SOURCE_ENERGY_KEEPER_CAPACITY   () {      4000;}

sub WALL_HITS                       () {         1;}
sub WALL_HITS_MAX                   () { 300000000;}

sub EXTENSION_HITS                  () {      1000;}
sub EXTENSION_ENERGY_CAPACITY       () { {0=> 50, 1=> 50, 2=> 50, 3=> 50, 4=> 50, 5=> 50, 6=> 50, 7=> 100, 8=> 200};}

sub ROAD_HITS                       () {      5000;}
sub ROAD_WEAROUT                    () {         1;}
sub ROAD_DECAY_AMOUNT               () {       100;}
sub ROAD_DECAY_TIME                 () {      1000;}

sub LINK_HITS                       () {      1000;}
sub LINK_HITS_MAX                   () {      1000;}
sub LINK_CAPACITY                   () {       800;}
sub LINK_COOLDOWN                   () {         1;}
sub LINK_LOSS_RATIO                 () {      0.03;}

sub STORAGE_CAPACITY                () {   1000000;}
sub STORAGE_HITS                    () {     10000;}

sub STRUCTURE_SPAWN                 () { "spawn"          ;}
sub STRUCTURE_EXTENSION             () { "extension"      ;}
sub STRUCTURE_ROAD                  () { "road"           ;}
sub STRUCTURE_WALL                  () { "constructedWall";}
sub STRUCTURE_RAMPART               () { "rampart"        ;}
sub STRUCTURE_KEEPER_LAIR           () { "keeperLair"     ;}
sub STRUCTURE_PORTAL                () { "portal"         ;}
sub STRUCTURE_CONTROLLER            () { "controller"     ;}
sub STRUCTURE_LINK                  () { "link"           ;}
sub STRUCTURE_STORAGE               () { "storage"        ;}
sub STRUCTURE_TOWER                 () { "tower"          ;}
sub STRUCTURE_OBSERVER              () { "observer"       ;}
sub STRUCTURE_POWER_BANK            () { "powerBank"      ;}
sub STRUCTURE_POWER_SPAWN           () { "powerSpawn"     ;}
sub STRUCTURE_EXTRACTOR             () { "extractor"      ;}
sub STRUCTURE_LAB                   () { "lab"            ;}
sub STRUCTURE_TERMINAL              () { "terminal"       ;}
sub STRUCTURE_CONTAINER             () { "container"      ;}
sub STRUCTURE_NUKER                 () { "nuker"          ;}

sub CONSTRUCTION_COST               () { {
        "spawn"                     =>       15000,
        "extension"                 =>        3000,
        "road"                      =>         300,
        "constructedWall"           =>           1,
        "rampart"                   =>           1,
        "link"                      =>        5000,
        "storage"                   =>       30000,
        "tower"                     =>        5000,
        "observer"                  =>        8000,
        "powerSpawn"                =>      100000,
        "extractor"                 =>        5000,
        "lab"                       =>       50000,
        "terminal"                  =>      100000,
        "container"                 =>        5000,
        "nuker"                     =>      100000 };}
sub CONSTRUCTION_COST_ROAD_SWAMP_RATIO () {     5;}
sub CONTROLLER_LEVELS    (){{         1=>   200, 2=> 45000, 3=> 135000, 4=> 405000, 5=> 1215000, 6=> 3645000, 7=> 10935000            };}
sub CONTROLLER_STRUCTURES(){{
      "spawn"            =>{ 0=>    0,1=>     1, 2=>     1, 3=>      1, 4=>      1, 5=>       1, 6=>       1, 7=>        2, 8=>      3},
      "extension"        =>{ 0=>    0,1=>     0, 2=>     5, 3=>     10, 4=>     20, 5=>      30, 6=>      40, 7=>       50, 8=>     60},
      "link"             =>{          1=>     0, 2=>     0, 3=>      0, 4=>      0, 5=>       2, 6=>       3, 7=>        4, 8=>      6},
      "road"             =>{ 0=> 2500,1=>  2500, 2=>  2500, 3=>   2500, 4=>   2500, 5=>    2500, 6=>    2500, 7=>     2500, 8=>   2500},
      "constructedWall"  =>{          1=>     0, 2=>  2500, 3=>   2500, 4=>   2500, 5=>    2500, 6=>    2500, 7=>     2500, 8=>   2500},
      "rampart"          =>{          1=>     0, 2=>  2500, 3=>   2500, 4=>   2500, 5=>    2500, 6=>    2500, 7=>     2500, 8=>   2500},
      "storage"          =>{          1=>     0, 2=>     0, 3=>      0, 4=>      1, 5=>       1, 6=>       1, 7=>        1, 8=>      1},
      "tower"            =>{          1=>     0, 2=>     0, 3=>      1, 4=>      1, 5=>       2, 6=>       2, 7=>        3, 8=>      6},
      "observer"         =>{          1=>     0, 2=>     0, 3=>      0, 4=>      0, 5=>       0, 6=>       0, 7=>        0, 8=>      1},
      "powerSpawn"       =>{          1=>     0, 2=>     0, 3=>      0, 4=>      0, 5=>       0, 6=>       0, 7=>        0, 8=>      1},
      "extractor"        =>{          1=>     0, 2=>     0, 3=>      0, 4=>      0, 5=>       0, 6=>       1, 7=>        1, 8=>      1},
      "terminal"         =>{          1=>     0, 2=>     0, 3=>      0, 4=>      0, 5=>       0, 6=>       1, 7=>        1, 8=>      1},
      "lab"              =>{          1=>     0, 2=>     0, 3=>      0, 4=>      0, 5=>       0, 6=>       3, 7=>        6, 8=>     10},
      "container"        =>{ 0=>    5,1=>     5, 2=>     5, 3=>      5, 4=>      5, 5=>       5, 6=>       5, 7=>        5, 8=>      5},
      "nuker"            =>{          1=>     0, 2=>     0, 3=>      0, 4=>      0, 5=>       0, 6=>       0, 7=>        0, 8=>      1} };}
sub CONTROLLER_DOWNGRADE (){{         1=> 20000, 2=>  5000, 3=>  10000, 4=>  20000, 5=>   40000, 6=>   60000, 7=>   100000, 8=> 150000};}
sub CONTROLLER_CLAIM_DOWNGRADE             () {      0.2;}
sub CONTROLLER_RESERVE                     () {        1;}
sub CONTROLLER_RESERVE_MAX                 () {     5000;}
sub CONTROLLER_MAX_UPGRADE_PER_TICK        () {       15;}
sub CONTROLLER_ATTACK_BLOCKED_UPGRADE      () {     1000;}
sub CONTROLLER_NUKE_BLOCKED_UPGRADE        () {      200;}

sub SAFE_MODE_DURATION                     () {    20000;}
sub SAFE_MODE_COOLDOWN                     () {    50000;}
sub SAFE_MODE_COST                         () {     1000;}

sub TOWER_HITS                             () {     3000;}
sub TOWER_CAPACITY                         () {     1000;}
sub TOWER_ENERGY_COST                      () {       10;}
sub TOWER_POWER_ATTACK                     () {      600;}
sub TOWER_POWER_HEAL                       () {      400;}
sub TOWER_POWER_REPAIR                     () {      800;}
sub TOWER_OPTIMAL_RANGE                    () {        5;}
sub TOWER_FALLOFF_RANGE                    () {       20;}
sub TOWER_FALLOFF                          () {     0.75;}

sub OBSERVER_HITS                          () {      500;}
sub OBSERVER_RANGE                         () {       10;}

sub POWER_BANK_HITS                        () {  2000000;}
sub POWER_BANK_CAPACITY_MAX                () {     5000;}
sub POWER_BANK_CAPACITY_MIN                () {      500;}
sub POWER_BANK_CAPACITY_CRIT               () {      0.3;}
sub POWER_BANK_DECAY                       () {     5000;}
sub POWER_BANK_HIT_BACK                    () {      0.5;}

sub POWER_SPAWN_HITS                       () {     5000;}
sub POWER_SPAWN_ENERGY_CAPACITY            () {     5000;}
sub POWER_SPAWN_POWER_CAPACITY             () {      100;}
sub POWER_SPAWN_ENERGY_RATIO               () {       50;}

sub EXTRACTOR_HITS                         () {      500;}
sub EXTRACTOR_COOLDOWN                     () {        5;}

sub LAB_HITS                               () {      500;}
sub LAB_MINERAL_CAPACITY                   () {     3000;}
sub LAB_ENERGY_CAPACITY                    () {     2000;}
sub LAB_BOOST_ENERGY                       () {       20;}
sub LAB_BOOST_MINERAL                      () {       30;}
sub LAB_COOLDOWN                           () {       10;}
sub LAB_REACTION_AMOUNT                    () {        5;}

sub GCL_POW                                () {      2.4;}
sub GCL_MULTIPLY                           () {  1000000;}
sub GCL_NOVICE                             () {        3;}

sub MODE_SIMULATION                        () {  undef     ;} # was "simulation", but is now 'null' in JavaScript
#ub MODE_SURVIVAL                          () { "survival" ;} # was               removed         from JavaScript
sub MODE_WORLD                             () {  undef     ;} # was "world"     , but is now 'null' in JavaScript
#ub MODE_ARENA                             () { "arena"    ;} # was               removed         from JavaScript

sub TERRAIN_MASK_WALL                      () {        1;}
sub TERRAIN_MASK_SWAMP                     () {        2;}
sub TERRAIN_MASK_LAVA                      () {        4;}

sub MAX_CONSTRUCTION_SITES                 () {      100;}
sub MAX_CREEP_SIZE                         () {       50;}

sub MINERAL_REGEN_TIME                     () {    50000;}
sub MINERAL_MIN_AMOUNT                     () { {
                                       "H" =>      35000,
                                       "O" =>      35000,
                                       "L" =>      35000,
                                       "K" =>      35000,
                                       "Z" =>      35000,
                                       "U" =>      35000,
                                       "X" =>      35000 };}
sub MINERAL_RANDOM_FACTOR                  () {        2;}
sub MINERAL_DENSITY                        () { {
                                        1  =>      15000,
                                        2  =>      35000,
                                        3  =>      70000,
                                        4  =>     100000 };}
sub MINERAL_DENSITY_PROBABILITY            () { {
                                        1  =>        0.1,
                                        2  =>        0.5,
                                        3  =>        0.9,
                                        4  =>        1.0 };}
sub MINERAL_DENSITY_CHANGE                 () {     0.05;}

sub DENSITY_LOW                            () {        1;}
sub DENSITY_MODERATE                       () {        2;}
sub DENSITY_HIGH                           () {        3;}
sub DENSITY_ULTRA                          () {        4;}

sub TERMINAL_CAPACITY                      () {   300000;}
sub TERMINAL_HITS                          () {     3000;}
sub TERMINAL_SEND_COST                     () {      0.1;}
sub TERMINAL_MIN_SEND                      () {      100;}
sub TERMINAL_COOLDOWN                      () {       10;}

sub CONTAINER_HITS                         () {   250000;}
sub CONTAINER_CAPACITY                     () {     2000;}
sub CONTAINER_DECAY                        () {     5000;}
sub CONTAINER_DECAY_TIME                   () {      100;}
sub CONTAINER_DECAY_TIME_OWNED             () {      500;}

sub NUKER_HITS                             () {     1000;}
sub NUKER_COOLDOWN                         () {   100000;}
sub NUKER_ENERGY_CAPACITY                  () {   300000;}
sub NUKER_GHODIUM_CAPACITY                 () {     5000;}
sub NUKE_LAND_TIME                         () {    50000;}
sub NUKE_RANGE                             () {       10;}
sub NUKE_DAMAGE                            () { {
                                        0  =>   10000000,
                                        2  =>    5000000 };}

sub PORTAL_DECAY                           () {    30000;}

sub ORDER_SELL                             () {   "sell";}
sub ORDER_BUY                              () {    "buy";}

sub MARKET_FEE                             () {     0.05;}

sub FLAGS_LIMIT                            () {    10000;}

sub SUBSCRIPTION_TOKEN                     () {  "token";}

sub RESOURCE_ENERGY                        () { "energy";}
sub RESOURCE_POWER                         () {  "power";}

sub RESOURCE_HYDROGEN                      () {      "H";}
sub RESOURCE_OXYGEN                        () {      "O";}
sub RESOURCE_UTRIUM                        () {      "U";}
sub RESOURCE_LEMERGIUM                     () {      "L";}
sub RESOURCE_KEANIUM                       () {      "K";}
sub RESOURCE_ZYNTHIUM                      () {      "Z";}
sub RESOURCE_CATALYST                      () {      "X";}
sub RESOURCE_GHODIUM                       () {      "G";}

sub RESOURCE_HYDROXIDE                     () {     "OH";}
sub RESOURCE_ZYNTHIUM_KEANITE              () {     "ZK";}
sub RESOURCE_UTRIUM_LEMERGITE              () {     "UL";}

sub RESOURCE_UTRIUM_HYDRIDE                () {     "UH";}
sub RESOURCE_UTRIUM_OXIDE                  () {     "UO";}
sub RESOURCE_KEANIUM_HYDRIDE               () {     "KH";}
sub RESOURCE_KEANIUM_OXIDE                 () {     "KO";}
sub RESOURCE_LEMERGIUM_HYDRIDE             () {     "LH";}
sub RESOURCE_LEMERGIUM_OXIDE               () {     "LO";}
sub RESOURCE_ZYNTHIUM_HYDRIDE              () {     "ZH";}
sub RESOURCE_ZYNTHIUM_OXIDE                () {     "ZO";}
sub RESOURCE_GHODIUM_HYDRIDE               () {     "GH";}
sub RESOURCE_GHODIUM_OXIDE                 () {     "GO";}

sub RESOURCE_UTRIUM_ACID                   () {   "UH2O";}
sub RESOURCE_UTRIUM_ALKALIDE               () {   "UHO2";}
sub RESOURCE_KEANIUM_ACID                  () {   "KH2O";}
sub RESOURCE_KEANIUM_ALKALIDE              () {   "KHO2";}
sub RESOURCE_LEMERGIUM_ACID                () {   "LH2O";}
sub RESOURCE_LEMERGIUM_ALKALIDE            () {   "LHO2";}
sub RESOURCE_ZYNTHIUM_ACID                 () {   "ZH2O";}
sub RESOURCE_ZYNTHIUM_ALKALIDE             () {   "ZHO2";}
sub RESOURCE_GHODIUM_ACID                  () {   "GH2O";}
sub RESOURCE_GHODIUM_ALKALIDE              () {   "GHO2";}

sub RESOURCE_CATALYZED_UTRIUM_ACID         () {  "XUH2O";}
sub RESOURCE_CATALYZED_UTRIUM_ALKALIDE     () {  "XUHO2";}
sub RESOURCE_CATALYZED_KEANIUM_ACID        () {  "XKH2O";}
sub RESOURCE_CATALYZED_KEANIUM_ALKALIDE    () {  "XKHO2";}
sub RESOURCE_CATALYZED_LEMERGIUM_ACID      () {  "XLH2O";}
sub RESOURCE_CATALYZED_LEMERGIUM_ALKALIDE  () {  "XLHO2";}
sub RESOURCE_CATALYZED_ZYNTHIUM_ACID       () {  "XZH2O";}
sub RESOURCE_CATALYZED_ZYNTHIUM_ALKALIDE   () {  "XZHO2";}
sub RESOURCE_CATALYZED_GHODIUM_ACID        () {  "XGH2O";}
sub RESOURCE_CATALYZED_GHODIUM_ALKALIDE    () {  "XGHO2";}

sub REACTIONS () { { H    => {    O =>    "OH",
                                  L =>    "LH",
                                  K =>    "KH",
                                  U =>    "UH",
                                  Z =>    "ZH",
                                  G =>    "GH" },
                     O    => {    H =>    "OH",
                                  L =>    "LO",
                                  K =>    "KO",
                                  U =>    "UO",
                                  Z =>    "ZO",
                                  G =>    "GO" },
                     Z    => {    K =>    "ZK",
                                  H =>    "ZH",
                                  O =>    "ZO" },
                     L    => {    U =>    "UL",
                                  H =>    "LH",
                                  O =>    "LO" },
                     K    => {    Z =>    "ZK",
                                  H =>    "KH",
                                  O =>    "KO" },
                     G    => {    H =>    "GH",
                                  O =>    "GO" },
                     U    => {    L =>    "UL",
                                  H =>    "UH",
                                  O =>    "UO" },
                     OH   => {   UH =>  "UH2O",
                                 UO =>  "UHO2",
                                 ZH =>  "ZH2O",
                                 ZO =>  "ZHO2",
                                 KH =>  "KH2O",
                                 KO =>  "KHO2",
                                 LH =>  "LH2O",
                                 LO =>  "LHO2",
                                 GH =>  "GH2O",
                                 GO =>  "GHO2" },
                     X    => { UH2O => "XUH2O",
                               UHO2 => "XUHO2",
                               LH2O => "XLH2O",
                               LHO2 => "XLHO2",
                               KH2O => "XKH2O",
                               KHO2 => "XKHO2",
                               ZH2O => "XZH2O",
                               ZHO2 => "XZHO2",
                               GH2O => "XGH2O",
                               GHO2 => "XGHO2" },
                     ZK   => {   UL =>     "G" },
                     UL   => {   ZK =>     "G" },
                     LH   => {   OH =>  "LH2O" },
                     ZH   => {   OH =>  "ZH2O" },
                     GH   => {   OH =>  "GH2O" },
                     KH   => {   OH =>  "KH2O" },
                     UH   => {   OH =>  "UH2O" },
                     LO   => {   OH =>  "LHO2" },
                     ZO   => {   OH =>  "ZHO2" },
                     KO   => {   OH =>  "KHO2" },
                     UO   => {   OH =>  "UHO2" },
                     GO   => {   OH =>  "GHO2" },
                     LH2O => {    X => "XLH2O" },
                     KH2O => {    X => "XKH2O" },
                     ZH2O => {    X => "XZH2O" },
                     UH2O => {    X => "XUH2O" },
                     GH2O => {    X => "XGH2O" },
                     LHO2 => {    X => "XLHO2" },
                     UHO2 => {    X => "XUHO2" },
                     KHO2 => {    X => "XKHO2" },
                     ZHO2 => {    X => "XZHO2" },
                     GHO2 => {    X => "XGHO2" } };}

sub BOOSTS () { { work          => {    UO => {           harvest =>   3 },
                                      UHO2 => {           harvest =>   5 },
                                     XUHO2 => {           harvest =>   7 },
                                        LH => {             build => 1.5,
                                                           repair => 1.5 },
                                      LH2O => {             build => 1.8,
                                                           repair => 1.8 },
                                     XLH2O => {             build =>   2,
                                                           repair =>   2 },
                                        ZH => {         dismantle =>   2 },
                                      ZH2O => {         dismantle =>   3 },
                                     XZH2O => {         dismantle =>   4 },
                                        GH => { upgradeController => 1.5 },
                                      GH2O => { upgradeController => 1.8 },
                                     XGH2O => { upgradeController =>   2 } },
                         attack => {    UH => {            attack =>   2 },
                                      UH2O => {            attack =>   3 },
                                     XUH2O => {            attack =>   4 } },
                  ranged_attack => {    KO => {      rangedAttack =>   2,
                                                 rangedMassAttack =>   2 },
                                      KHO2 => {      rangedAttack =>   3,
                                                 rangedMassAttack =>   3 },
                                     XKHO2 => {      rangedAttack =>   4,
                                                 rangedMassAttack =>   4 } },
                  heal          => {    LO => {              heal =>   2,
                                                       rangedHeal =>   2 },
                                      LHO2 => {              heal =>   3,
                                                       rangedHeal =>   3 },
                                     XLHO2 => {              heal =>   4,
                                                       rangedHeal =>   4 } },
                  carry         => {    KH => {          capacity =>   2 },
                                      KH2O => {          capacity =>   3 },
                                     XKH2O => {          capacity =>   4 } },
                  move          => {    ZO => {           fatigue =>   2 },
                                      ZHO2 => {           fatigue =>   3 },
                                     XZHO2 => {           fatigue =>   4 } },
                  tough         => {    GO => {            damage => 0.7 },
                                      GHO2 => {            damage => 0.5 },
                                     XGHO2 => {            damage => 0.3 } } };}

sub PORTAL_UNSTABLE          () { 10*24*3600*1000;}
sub PORTAL_MIN_TIMEOUT       () { 12*24*3600*1000;}
sub PORTAL_MAX_TIMEOUT       () { 22*24*3600*1000;}

sub POWER_BANK_RESPAWN_TIME  () {           50000;}

sub INVADERS_ENERGY_GOAL     () {          100000;}

sub SYSTEM_USERNAME          () {       'Screeps';}

sub SIGN_NOVICE_AREA         () {  'A new Novice Area is being planned somewhere in this sector. Please make sure all important rooms are reserved.';}
sub SIGN_RESPAWN_AREA        () { 'A new Respawn Area is being planned somewhere in this sector. Please make sure all important rooms are reserved.';}

sub BODYPARTS_ALL () { [
    MOVE         ,
    WORK         ,
    CARRY        ,
    ATTACK       ,
    RANGED_ATTACK,
    TOUGH        ,
    HEAL         ,
    CLAIM            ];}

sub RESOURCES_ALL () { [
    RESOURCE_ENERGY                      ,
    RESOURCE_POWER                       ,

    RESOURCE_HYDROGEN                    ,
    RESOURCE_OXYGEN                      ,
    RESOURCE_UTRIUM                      ,
    RESOURCE_KEANIUM                     ,
    RESOURCE_LEMERGIUM                   ,
    RESOURCE_ZYNTHIUM                    ,
    RESOURCE_CATALYST                    ,
    RESOURCE_GHODIUM                     ,

    RESOURCE_HYDROXIDE                   ,
    RESOURCE_ZYNTHIUM_KEANITE            ,
    RESOURCE_UTRIUM_LEMERGITE            ,

    RESOURCE_UTRIUM_HYDRIDE              ,
    RESOURCE_UTRIUM_OXIDE                ,
    RESOURCE_KEANIUM_HYDRIDE             ,
    RESOURCE_KEANIUM_OXIDE               ,
    RESOURCE_LEMERGIUM_HYDRIDE           ,
    RESOURCE_LEMERGIUM_OXIDE             ,
    RESOURCE_ZYNTHIUM_HYDRIDE            ,
    RESOURCE_ZYNTHIUM_OXIDE              ,
    RESOURCE_GHODIUM_HYDRIDE             ,
    RESOURCE_GHODIUM_OXIDE               ,

    RESOURCE_UTRIUM_ACID                 ,
    RESOURCE_UTRIUM_ALKALIDE             ,
    RESOURCE_KEANIUM_ACID                ,
    RESOURCE_KEANIUM_ALKALIDE            ,
    RESOURCE_LEMERGIUM_ACID              ,
    RESOURCE_LEMERGIUM_ALKALIDE          ,
    RESOURCE_ZYNTHIUM_ACID               ,
    RESOURCE_ZYNTHIUM_ALKALIDE           ,
    RESOURCE_GHODIUM_ACID                ,
    RESOURCE_GHODIUM_ALKALIDE            ,

    RESOURCE_CATALYZED_UTRIUM_ACID       ,
    RESOURCE_CATALYZED_UTRIUM_ALKALIDE   ,
    RESOURCE_CATALYZED_KEANIUM_ACID      ,
    RESOURCE_CATALYZED_KEANIUM_ALKALIDE  ,
    RESOURCE_CATALYZED_LEMERGIUM_ACID    ,
    RESOURCE_CATALYZED_LEMERGIUM_ALKALIDE,
    RESOURCE_CATALYZED_ZYNTHIUM_ACID     ,
    RESOURCE_CATALYZED_ZYNTHIUM_ALKALIDE ,
    RESOURCE_CATALYZED_GHODIUM_ACID      ,
    RESOURCE_CATALYZED_GHODIUM_ALKALIDE   ];}

sub COLORS_ALL () { [
    COLOR_RED    ,
    COLOR_PURPLE ,
    COLOR_BLUE   ,
    COLOR_CYAN   ,
    COLOR_GREEN  ,
    COLOR_YELLOW ,
    COLOR_ORANGE ,
    COLOR_BROWN  ,
    COLOR_GREY   ,
    COLOR_WHITE   ];}

our %gd8a=('clrz' => {'R'  =>  COLOR_RED   ,  'B'  =>  COLOR_BLUE  ,
                      'O'  =>  COLOR_ORANGE,  'P'  =>  COLOR_PURPLE,
                      'Y'  =>  COLOR_YELLOW,  'N'  =>  COLOR_BROWN ,
                      'G'  =>  COLOR_GREEN ,  'E'  =>  COLOR_GREY  ,
                      'C'  =>  COLOR_CYAN  ,  'W'  =>  COLOR_WHITE ,},
           'prtz' => {'W'  =>        WORK  ,  'A'  =>        ATTACK,
                      'M'  =>        MOVE  ,  'R'  => RANGED_ATTACK,
                      'C'  =>        CARRY ,  'H'  =>        HEAL  ,
                      'L'  =>        CLAIM ,  'T'  =>        TOUGH ,},
           'rolz' => {'h'  =>   'harvester',  'A'  =>    'Attacker', # lowercase left workers, UpperCase Right Attackers
                      'b'  =>     'builder',  'R'  =>      'Ranger',
                      'u'  =>    'upgrader',  'H'  =>      'Healer',
                      'c'  =>     'carrier',  'P'  =>     'Paladin',
                      'm'  =>       'miner',  'T'  =>      'Tanker',
                      's'  =>     'scouter',  'S'  =>     'Soldier',
                      'r'  =>    'reserver',  'F'  =>     'Fighter',
                      'e'  =>   'extracter',  'W'  =>     'Warrior',
                      't'  =>     'trucker',
                      'w'  =>      'waller',
                      'l'  =>     'claimer',
                      'f'  =>       'fixer',},
           'stcz' => {'S'  =>  STRUCTURE_SPAWN       , # ABCDE G I KLMNOP RSTU WX  
                      'X'  =>  STRUCTURE_EXTENSION   , #   NO:F H J      Q       YZ
                      'D'  =>  STRUCTURE_ROAD        , # this is the only D so think of creeps Driving faster on roaDs
                      'W'  =>  STRUCTURE_WALL        , # UpperCase constructed Wall structures match the loWercase natural terrain Walls
                      'R'  =>  STRUCTURE_RAMPART     , # nice that Rampart, Keeper_lair, Portal, Controller all have their first letter
                      'K'  =>  STRUCTURE_KEEPER_LAIR ,
                      'P'  =>  STRUCTURE_PORTAL      ,
                      'C'  =>  STRUCTURE_CONTROLLER  ,
                      'I'  =>  STRUCTURE_LINK        , # lInk and storaGe at least have Good contaIned letters
                      'G'  =>  STRUCTURE_STORAGE     ,
                      'T'  =>  STRUCTURE_TOWER       , # Tower, Observer, Extractor, Lab aLsO gOOd sTarTing wiTh firsT LETTErs
                      'O'  =>  STRUCTURE_OBSERVER    , # V? nO Others start with O thOugh sO prObably best tO just ignOre V
                      'B'  =>  STRUCTURE_POWER_BANK  ,
                      'A'  =>  STRUCTURE_POWER_SPAWN ,
                      'E'  =>  STRUCTURE_EXTRACTOR   ,
                      'L'  =>  STRUCTURE_LAB         , # Y for laboratorY so L can go to Link then I can go to?
                      'M'  =>  STRUCTURE_TERMINAL    , # M to reMeMber Market Money MoveMent aMong Merchants
                      'N'  =>  STRUCTURE_CONTAINER   , # Nice that coNtaiNer matches lowercase eNergy which is usually what they store
                      'U'  =>  STRUCTURE_NUKER       ,},
           'lokz' => {'c'  => LOOK_CREEPS            , # lowercase pws already for plain, wall, swamp terrain types
                      'n'  => LOOK_ENERGY            ,
                      'u'  => LOOK_SOURCES           ,
                      'r'  => LOOK_RESOURCES         ,
                      'm'  => LOOK_MINERALS          , # Minerals Match Miner rolz and are Made to Move on the Market through the terMinal
                      'e'  => LOOK_STRUCTURES        , # using last lEttEr to lEavE t for tErrain bElow
                      'f'  => LOOK_FLAGS             , # could use UpperCase Free Flag From  stcz above to signiFy some Fresh Fancy Flag Feature
                      'o'  => LOOK_CONSTRUCTION_SITES, # cOnstructiOn_sites graphics already lOOk like a little green O sO this is prObably a gOOd chOice
                      'u'  => LOOK_NUKES             , # matching  UpperCase nUker strUctUre      above
                      't'  => LOOK_TERRAIN           ,},
           'obsz' =>  'cuwWSXIGTOABLMU',); # just joined string of abbreV8ionz for OBSTACLE_OBJECT_TYPES reordered a bit (should be useful for path-finding)
# then make these few basic %gd8a accessor helper functions to expose each of my primary Screeps abbreV8ion contexts for single letters mapped to constants
sub clrz{my $ckey=shift(@_) || '';my $cval='';$cval=$gd8a{'clrz'}{$ckey} if(length($ckey) && exists($gd8a{'clrz'}{$ckey}));return($cval);} # maybe these should
sub prtz{my $pkey=shift(@_) || '';my $pval='';$pval=$gd8a{'prtz'}{$pkey} if(length($pkey) && exists($gd8a{'prtz'}{$pkey}));return($pval);} #   return something
sub rolz{my $rkey=shift(@_) || '';my $rval='';$rval=$gd8a{'rolz'}{$rkey} if(length($rkey) && exists($gd8a{'rolz'}{$rkey}));return($rval);} #   like:
sub stcz{my $skey=shift(@_) || '';my $sval='';$sval=$gd8a{'stcz'}{$skey} if(length($skey) && exists($gd8a{'stcz'}{$skey}));return($sval);} # ERR_INVALID_ARGS
sub lokz{my $lkey=shift(@_) || '';my $lval='';$lval=$gd8a{'lokz'}{$lkey} if(length($lkey) && exists($gd8a{'lokz'}{$lkey}));return($lval);} #   nstd of empty?
sub cdif{ # load constants.js && compare l8st names && values with above && print differences to upd8
  my $cfil=$ENV{'HOME'} . '/dvl/p8/psps/srvr/common/lib/constants.js';my $cjfd;my $cjhr;my %fndc;my %fndx;
  for(qw(cdif cbrn xbrn cbrp xbrp cbrt xbrt cbsp xbsp rang ROOM_WIDTH ROOM_HEIGHT
        %gd8a clrz prtz rolz stcz lokz)){$fndc{$_}=1;} # init FouND Constants 2mtch @Xport for added utlz not from JS
  $cfil= shift(@_) if(@_ && -r "$_[0]"); # try to load parameter constants file over default if readable
  open my $cjfh,'<' ,$cfil  or die "Can't open:$cfil: $!";                 binmode $cjfh,':encoding(UTF-8)';
  open my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local duplic8 of global
  while( <$cjfh>){ # try to manually parse the JavaScript since it's not in JSON
    if(/^\s+([A-Z_]+)\s*:\s*([^\n]+)\n$/){my $cnam=$1;my $cval=$2;my $cevl= eval($cnam);$fndc{$cnam}=1; # flag found names
      $cval=~ s/,\s*$//;$cval=~ s/^(['"])(.*)\1/$2/; # strip trailing comma && any surrounding single or double quotes
      if( $cval=~ /\*/){$cval= eval($cval);} # if value contains multiplic8ion, evalU8 it before comparing
      if(!defined($cevl) &&  $cval eq 'null'){$cevl='null';} # pretend Perl undef is same as JavaScript null
      if(($cnam=~ /^((BODYPART|CONSTRUCTION)_COST|CONTROLLER_STRUCTURES|MINERAL_(MIN_AMOUNT|DENSITY(_PROBABILITY)?)|NUKE_DAMAGE|REACTIONS|BOOSTS)$/ &&
          $cval eq '{' ) || ($cval=~ /^\{[^}]+\}$/ && # for nested sub-hashes, traverse them && construct the constant value && evalU8d value
          $cnam=~ /^(CONTROLLER_(LEVELS|DOWNGRADE)|EXTENSION_ENERGY_CAPACITY|RAMPART_HITS_MAX)$/) || ($cval=~ /^\[[^\]]+\]$/ &&
          $cnam=~ /^(OBSTACLE_OBJECT_TYPES)$/)){my $shln=$cval;my $href=$cevl;
        $cval=$cevl='{';
        while(defined($shln)){
          if   ($cnam=~ /^(CONTROLLER_(LEVELS|DOWNGRADE)|EXTENSION_ENERGY_CAPACITY|RAMPART_HITS_MAX)$/ ){$shln=~ s/(^\{|\}$)//g;
            while($shln=~ s/^\s*  (\d+)  \s*:\s+  (\d+) ,?   //x){my $shky=$1;my $shvl=$2; # traverse into    SubHash
              $cval  .=$shky . '=>' .         $shvl         . ',';
              $cevl  .=$shky . '=>' . $href->{$shky}        . ',';}
            $cval=~ s/,$/},\n/;
            $cevl=~ s/,$/},\n/;
            last;}
          elsif($cnam=~ /^(OBSTACLE_OBJECT_TYPES                                                   )$/x){$shln=~ s/(^\[|\]$)//g;
            $cval=$cevl='[';my $andx=0;
            while($shln=~ s/^\s*(['"])(.+?)\1           ,?\s*//x){my $savl=$2;             # traverse into    SubArray (so shln is not actually SubHash here)
              $cval  .=                       $savl         . ',';
              $cevl  .=               $href->[$andx++]      . ',';}                        #   && href is actually an ArrayRef for this case
            $cval=~ s/,$/],\n/;
            $cevl=~ s/,$/],\n/;
            last;}
          $shln= <$cjfh>;
          last if(!defined($shln) || $shln=~ /^\s{4}\},?\n$/);
          if   ($shln=~ /^\s+(['"])(.+)\1\s*:\s+ ([^,]+),? \n$/x){my $shky=$2;my $shvl=$3;
            $cval    .=$shky . '=>' .         $shvl         . ',';
            $cevl    .=$shky . '=>' . $href->{$shky}        . ',';}
          elsif($shln=~ /^\s+     (\d+)  \s*:\s+ ([^,]+),? \n$/x){my $shky=$1;my $shvl=$2; #     MINERAL_DENSITY(_PROBABILITY)? 1: 15000  no quotes
            $cval    .=$shky . '=>' .         $shvl         . ',';$href->{$shky}='1.0' if($cnam eq 'MINERAL_DENSITY_PROBABILITY' && $shvl eq'1.0');
            $cevl    .=$shky . '=>' . $href->{$shky}        . ',';} # above makes special 1.0 which became just int 1 back to matching string with extra '.0'
          elsif($shln=~ /^\s+(['"])(.+)\1\s*:\s+\{(.+)\},? \n$/x){my $shky=$2;my $shvl=$3; #     CONTROLLER_STRUCTURES "spawn": {0: 0, 1: 1, 2: 1, .. 8: 3},
            $cval    .=$shky . '=>{';
            $cevl    .=$shky . '=>{';
            while($shvl=~ s/^\s*  (\d+)  \s*:\s+  (\d+) ,?   //x){my $ssky=$1;my $ssvl=$2; # traverse into SubSubHash
              $cval  .=$ssky . '=>' .                $ssvl  . ',';
              $cevl  .=$ssky . '=>' . $href->{$shky}{$ssky} . ',';}
            $cval=~ s/,$/},\n/;
            $cevl=~ s/,$/},\n/;}
          elsif($shln=~ /^\s+      (.+)  \s*:\s+\{         \n$/x){my $shky=$1;my $sshl; #     REACTIONS with mineral keys with other mineral keys to react with
            $cval    .=$shky . '=>{';
            $cevl    .=$shky . '=>{';
            while($sshl= <$cjfh>){
              last if($sshl=~ /^\s{8}\},?\n$/);
              if   ($sshl=~ /^\s+(\w+)\s*:\s+(['"])(\w+)\2,?\n/ ){my $ssky=$1;my $ssvl=$3; # traverse into SubSub   Hash
                $cval.=$ssky . '=>' .                $ssvl  . ',';
                $cevl.=$ssky . '=>' . $href->{$shky}{$ssky} . ',';}
              elsif($sshl=~ /^\s+(\w+)\s*:\s+       \{      \n/x){my $ssky=$1;my $sssl;    # traverse into SubSubSubHash for BOOSTS only
                $cval.=$ssky . '=>{';
                $cevl.=$ssky . '=>{';
                while($sssl= <$cjfh>){
                  last if($sssl=~ /^\s{12}\},?\n$/);
                  if($sssl=~/^\s+(\w+)\s*:\s+    ([^,]+)  ,?\n/x){my $sssk=$1;my $sssv=$2;$sssv="0$sssv" if($sssv=~ /^\.\d/);
                    $cval.=$sssk . '=>' .                       $sssv  . ',';
                    $cevl.=$sssk . '=>' . $href->{$shky}{$ssky}{$sssk} . ',';}}
                $cval=~ s/,$/},/  ;$cevl=~ s/,$/},/  ;}}
            $cval    =~ s/,$/},\n/;$cevl=~ s/,$/},\n/;}}
        $cval        =~ s/,$/}/   ;$cevl=~ s/,$/}/   ; } # stupid silly vim % curly matching is finding in these regexes && concaten8d strings above =(
      if($cval ne $cevl){
        printf   $out8 "%-64s => %32s,",$cnam,$cval;
        printf   $out8    " !ne! %32s,\n",    $cevl;}}
    elsif(/^module\.exports\.([A-Z_]+)\s+=\s+\[\n$/){my $cnam=$1;my $cval='';my $cevl= eval($cnam);$fndc{$cnam}=1; # flag found names
      if($cnam=~ /^(BODYPARTS|RESOURCES|COLORS)_ALL$/){ # traverse arrayrefs of earlier constants
        my $saln;my $aref=$cevl;my $andx=0; # for nested sub-arrays, traverse them && construct the constant value && evalU8d value
        $cval=$cevl='[';
        while($saln= <$cjfh>){
          last if($saln=~ /^\];\n$/);
          if($saln=~ /^\s{4}module\.exports\.([A-Z_]+),?\n$/){
            $cval.=   eval($1)      . ','; # also evalU8ing this to get underlying values to match
            $cevl.=$aref->[$andx++] . ',';}}
        $cval=~ s/,$/];/;$cevl=~ s/,$/];/; }
      if($cval ne $cevl){
        printf   $out8 "%-64s => %32s",$cnam,$cval;
        printf   $out8    " !ne! %32s\n",    $cevl;}}} # figure out why curlies here can't % match with scope pair from above (like in comments or regexes?)
  close   $cjfh             or die "Can't close constants file handle: $!";
  for(sort(    @EXPORT)){$fndx{$_}=1;unless(exists($fndc{$_})){ # make sure all constants match in both directions between exported Perl && found JavaScript
      printf     $out8 "%-64s in EXPORT not found in constants.js!\n",$_;}}
  for(sort(keys(%fndc))){            unless(exists($fndx{$_})){
      printf     $out8 "%-64s in constants.js not found in EXPORT!\n",$_;}}
  close   $out8             or die "Can't close duplic8 STDOUT handle: $!";}
sub cbrn{my $xrns=shift(@_);my $crns=''; # Compress Base64 Room Name: eXpanded   Room Name String, Compressed Room Name String
  if($xrns=~ /^([WE])(\d+)([SN])(\d+)$/i){my $xdir=$1;my $xnum=$2;my $ydir=$3;my $ynum=$4;my $bpak=0;
    $bpak += 1 if(uc($xdir) eq 'E');$bpak += 4 if(  $xnum > 63);
    $bpak += 2 if(uc($ydir) eq 'N');$bpak += 8 if(  $ynum > 63); # pack first 4 bits into first b64 char, then num remainders
    $crns= $sb64[$bpak] . $sb64[$xnum % 64] . $sb64[$ynum % 64];}
  return(   $crns); }
sub xbrn{my $crns=shift(@_);my $xrns=''; # eXpand   Base64 Room Name: Compressed Room Name String, eXpanded   Room Name String
  if($crns=~ /^([0-9A-F])([0-9A-Za-z._])([0-9A-Za-z._])$/){my $bpak=$sb10{$1};my $xdir='W';my $xnum=$sb10{$2};my $ydir='S';my $ynum=$sb10{$3};
    $xdir='E' if($bpak & 1);$xnum+=64 if($bpak & 4);
    $ydir='N' if($bpak & 2);$ynum+=64 if($bpak & 8);
    $xrns="$xdir$xnum$ydir$ynum";}
  return(   $xrns); } # nstd of [nesw] rewrote to bit pack dirz wi 1 in positive axis,then xy > 63 (leavng 2high bits),then xy nums % 64 for always 3 b64 chrz
sub cbrp{my @xrps=      @_ ; my $crps=''; # Compress Base64 Room Position: eXpanded   Room Pos  String, Compressed Room Pos  String
  if(       @xrps  >= 1 && 0 <= $xrps[0] && $xrps[0] < ROOM_WIDTH ){$crps.= $sb64[$xrps[0]];}
  if(       @xrps  >= 2 && 0 <= $xrps[1] && $xrps[1] < ROOM_HEIGHT){$crps.= $sb64[$xrps[1]];}
  if(       @xrps  >= 3 &&      $xrps[2]=~ /^[WE]\d+[SN]\d+$/i){$crps.=  cbrn($xrps[2]);}
  return(   $crps); } # probably l8r eXpanded Pos objects should be anon hash of x, y, roomName like JS objects instead of just array here
sub xbrp{my $crps=shift(@_); my @xrps=(); # eXpand   Base64 Room Position: Compressed Room Pos  String, eXpanded   Room Pos  String
  if(length($crps) >= 1){  push(@xrps,$sb10{substr($crps,0,1)});}
  if(length($crps) >= 2){  push(@xrps,$sb10{substr($crps,1,1)});}
  if(length($crps) >= 5){  push(@xrps, xbrn(substr($crps,2,3)));}
  return(   @xrps); }
sub rang{my $frxy= shift(@_);my $toxy= shift(@_);                     my($fr_x,$fr_y,$to_x,$to_y); # either cmprSd b64 xy rposz or x,y, x,y to compute RANGe
  if(@_ >= 2 && $frxy=~ /^\d\d?$/ && 0 <= $frxy && $frxy < ROOM_WIDTH &&
                $toxy=~ /^\d\d?$/ && 0 <= $toxy && $toxy < ROOM_HEIGHT){($fr_x,$fr_y,$to_x,$to_y)=($frxy,$toxy,shift(@_),shift(@_));}
  elsif(defined($frxy) && $frxy=~ /^[0-9A-Za-n][0-9A-Za-n]/           && # shud accept cbrp strings also containing roomnames here (l8r ck if rmnmz match too)
        defined($toxy) && $toxy=~ /^[0-9A-Za-n][0-9A-Za-n]/           ){($fr_x,$fr_y)=xbrp($frxy);($to_x,$to_y)=xbrp($toxy);}
  if   (defined($fr_x) && defined($fr_y) &&
        defined($to_x) && defined($to_y)){my($xoff,$yoff)=(abs($fr_x-$to_x),abs($fr_y-$to_y));return( ($xoff >= $yoff) ? $xoff : $yoff );}
                                                                                              return(ERR_INVALID_ARGS);} # some pos dimension undef so invalid
sub cbrt{my $xtis=shift(@_);my $rwid=shift(@_) || ROOM_WIDTH;my $rhit=shift(@_) || ROOM_HEIGHT;my $crtd=''; # XpndedTerainInptStrng,RoomWIDth&&HeIghT,CmprsdRTD
  my $tsiz=int($rwid*$rhit/3); # Terrain SIZe; Compressed Room Terrain D8a should eventually hold a third of 2,500 totl expanded game squarez ($tsiz) plus one
  for(0..$tsiz){ # might want to sanity check that length($xtis) is $rwid*$rhit
    if  ($xtis=~ s/^([0-3])       //x){my $topc=$1;my $midc=0;my $botc=0; # TOPmost, MIDdle, && BOTtom Characterz
      if($xtis=~ s/^([0-3])([0-3])// ){   $midc=$1;   $botc=$2;}   # join triplet of squares bit-pairs for each compressed b64 char below
      $crtd .= $sb64[$topc*16  +  $midc*4  +  $botc]  ; }} # note if Room WIDth or HeIghT change from 50, this end test will need2chng for size % modulo 3
  return($crtd); } # above just append b64 charz instead of pre-padding && substr
sub xbrt{my $ctis=shift(@_);my $rwid=shift(@_) || ROOM_WIDTH;my $rhit=shift(@_) || ROOM_HEIGHT;my $xrtd=''; # CmprsdTerainInptStrng,RoomWIDth&&HeIghT,XpndedRTD
  my $tsiz=int($rwid*$rhit/3);$xrtd= '0' x ($rwid*$rhit); # Terrain SIZe; eXpanded Room Terrain D8a holds rwid*rhit 2,500 totl expanded game squarez
  for(0..$tsiz){ # might want to sanity check that length($ctis) is $tsiz+1
    if  ($ctis=~ s/^([0-9A-Za-z._])//){my $topc=$sb10{$1};my $lndx=$_*3; # TOPmost Character, Linear iNDeX
      substr($xrtd,$lndx+2,1,$topc&3) if($_ < $tsiz);$topc=int($topc/4); # sepR8 triplet of bit-pairs for each square
      substr($xrtd,$lndx+1,1,$topc&3) if($_ < $tsiz);$topc=int($topc/4); # note if Room WIDth or HeIghT change from 50, these tests for the end will need2chng
      substr($xrtd,$lndx  ,1,$topc  )               ;}}
  return($xrtd); } # eXpand Base64 Room Terrain here above && Compress Base64 Room Terrain below
sub cbsp{my $xsps=shift(@_);my $csps=''; # Compress Base64 Serialized Path: eXpanded   Serialized Path String, Compressed Serialized Path String
  if    ($xsps=~ s/^  0    ([0-9])//x){$csps.= $sb64[$1];} # skip over zero padding
  elsif ($xsps=~ s/^([1-4]  [0-9])//x){$csps.= $sb64[$1];}
  if    ($xsps=~ s/^  0    ([0-9])//x){$csps.= $sb64[$1];}
  elsif ($xsps=~ s/^([1-4]  [0-9])//x){$csps.= $sb64[$1];} # load %02d x && y
  while ($xsps=~ s/^([1-8])([1-8])// ){$csps.= $sb64[($1 - 1) * 8 +  ($2 - 1)     ];} # loop pairs of path    directions
  if    ($xsps=~ s/^([1-8])      $//x){$csps.= $sb64[($1 - 1) * 8 + (($1 + 3) % 8)];} # maybe encode last odd direction with fake final reverse
  return($csps); }
sub xbsp{my $csps=shift(@_);my $xsps=''; # eXpand   Base64 Serialized Path: Compressed Serialized Path String, eXpanded   Serialized Path String
  if    ($csps=~ s/^([0-9A-Za-n]  )([0-9A-Za-n])// ){                                                         $xsps.= sprintf("%02d%02d",$sb10{$1},$sb10{$2});}
  while ($csps=~ s/^([0-9A-Za-z._])             //x){my $dirs=$sb10{$1};my $dir1=$dirs% 8;$dirs= int($dirs/8);$xsps.= $dirs + 1;
    if(length($csps) || (($dirs + 12) % 8) != $dir1){                                                         $xsps.= $dir1 + 1;}}
  return($xsps); } # above test for final char not encoding reverse directions to include both (nstd of old colon)
8;

=encoding utf8

=head1 NAME

Octology::p8::psps::cnst - PiP'S ScreePS Perl Simul8or global CoNSTants

=head1 VERSION

This document8ion refers to version 0.0 of Octology::p8::psps::cnst, which was released on
.

=head1 SYNOPSIS

  use Octology::p8::psps::cnst;use v5.10;
  my  $ct = TOP   ; # Constant TOP
  say "ct is: $ct";
  my  $cr = RIGHT ; # Constant RIGHT
  say "cr is: $cr";

=head1 DESCRIPTION

=head1 USAGE

use Octology::p8::psps::cnst to import all the l8st Global Constants into your local namespace.

=head1 2DU

=over 2

=item - add function to parse l8st JSON && describe differences

=back

=head1 CHANGES

Revision history for Perl extension Octology::p8::psps::cnst:

=over 2

=item - pAKGvERS  d8VSD8vs

* original version of module sepR8d from main psps.pm, so that all these constants can be used commonly by any l8r sub-classes

=back

=head1 INSTALL

Please run:

  `perl -MCPAN -e "install Octology::p8::psps::cnst"`

or uncompress the package && run the standard:

  `perl Makefile.PL; make; make test; make install`

=head1 LICENSE

Most source code should be Free! Code I have lawful authority over is and shall be!
Copyright: (c) 2017, Pip Stuart.
Copyleft :  This software is licensed under the GNU General Public License
  (version 3 or later). Please consult L<HTTP://GNU.Org/licenses/gpl-3.0.txt>
  for important information about your freedom. This is Free Software: you
  are free to change and redistribute it. There is NO WARRANTY, to the
  extent permitted by law. See L<HTTP://FSF.Org> for further information.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
