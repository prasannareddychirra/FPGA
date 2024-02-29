#add debug for FSBL
XSCTH_BUILD_DEBUG = "1"
   
#Enable appropriate FSBL debug flags
YAML_COMPILER_FLAGS_append = " -DFSBL_DEBUG_INFO"
