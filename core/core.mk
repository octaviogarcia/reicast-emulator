#LOCAL_PATH:= 

#MFLAGS	:= -marm -march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=softfp
#ASFLAGS	:= -march=armv7-a -mfpu=vfp-d16 -mfloat-abi=softfp
#LDFLAGS	:= -Wl,-Map,$(notdir $@).map,--gc-sections -Wl,-O3 -Wl,--sort-common 

RZDCY_SRC_DIR ?= $(call my-dir)

RZDCY_MODULES	:=	cfg/ hw/arm7/ hw/aica/ hw/holly/ hw/ hw/gdrom/ hw/maple/ \
 hw/mem/ hw/pvr/ hw/sh4/ hw/sh4/interpr/ hw/sh4/modules/ plugins/ profiler/ oslib/ \
 hw/extdev/ hw/arm/ hw/naomi/ imgread/ linux/ ./ deps/coreio/ deps/zlib/ deps/crypto/ \
 deps/libelf/ deps/chdpsr/ arm_emitter/ rend/ reios/ deps/libpng/ 


ifdef WEBUI
	RZDCY_MODULES += webui/
	RZDCY_MODULES += deps/libwebsocket/

	ifdef FOR_ANDROID
		RZDCY_MODULES += deps/ifaddrs/
	endif
endif

ifndef NO_REC
	RZDCY_MODULES += hw/sh4/dyna/
endif

ifndef NOT_ARM
    RZDCY_MODULES += rec-ARM/
endif

ifdef X86_REC
    RZDCY_MODULES += rec-x86/ emitter/
endif

ifdef X64_REC
    RZDCY_MODULES += rec-x64/
endif

ifdef CPP_REC
    RZDCY_MODULES += rec-cpp/
endif

ifndef NO_REND
    RZDCY_MODULES += rend/gles/
else
    RZDCY_MODULES += rend/norend/
endif

ifdef HAS_SOFTREND
	RZDCY_MODULES += rend/soft/
endif

ifndef NO_NIXPROF
    RZDCY_MODULES += linux/nixprof/
endif

ifdef FOR_ANDROID
    RZDCY_MODULES += android/ deps/libandroid/ deps/libzip/
endif

ifdef USE_SDL
    RZDCY_MODULES += sdl/
endif

ifdef FOR_LINUX
    RZDCY_MODULES += linux-dist/
endif

RZDCY_FILES := $(foreach dir,$(addprefix $(RZDCY_SRC_DIR)/,$(RZDCY_MODULES)),$(wildcard $(dir)*.cpp))
RZDCY_FILES += $(foreach dir,$(addprefix $(RZDCY_SRC_DIR)/,$(RZDCY_MODULES)),$(wildcard $(dir)*.c))
RZDCY_FILES += $(foreach dir,$(addprefix $(RZDCY_SRC_DIR)/,$(RZDCY_MODULES)),$(wildcard $(dir)*.S))

# add libchdr

# crypto
RZDCY_FILES += \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/crypto/md5.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/crypto/sha1.c

# flac
RZDCY_FILES += \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/bitmath.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/bitreader.c	 \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/cpu.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/crc.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/fixed.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/fixed_intrin_sse2.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/fixed_intrin_ssse3.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/float.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/format.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/lpc.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/lpc_intrin_avx2.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/lpc_intrin_sse2.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/lpc_intrin_sse41.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/lpc_intrin_sse.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/md5.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/memory.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/metadata_iterators.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/metadata_object.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/stream_decoder.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/flac-1.3.2/src/libFLAC/window.c

# lzma
RZDCY_FILES += \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/Alloc.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/Bra86.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/Bra.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/BraIA64.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/CpuArch.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/Delta.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/LzFind.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/Lzma86Dec.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/Lzma86Enc.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/LzmaDec.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/LzmaEnc.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/LzmaLib.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/deps/lzma-16.04/C/Sort.c 

# libchdr
RZDCY_FILES += \
	$(RZDCY_SRC_DIR)/deps/libchdr/src/bitstream.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/src/cdrom.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/src/chd.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/src/flac.c \
	$(RZDCY_SRC_DIR)/deps/libchdr/src/huffman.c


$(info Files: $(RZDCY_FILES))

ifdef FOR_PANDORA
RZDCY_CFLAGS	:= \
	$(CFLAGS) -c -O3 -I$(RZDCY_SRC_DIR) -I$(RZDCY_SRC_DIR)/deps \
	-DRELEASE -DPANDORA\
	-march=armv7-a -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp \
	-frename-registers -fsingle-precision-constant -ffast-math \
	-ftree-vectorize -fomit-frame-pointer
	RZDCY_CFLAGS += -march=armv7-a -mtune=cortex-a8 -mfpu=neon
	RZDCY_CFLAGS += -DTARGET_LINUX_ARMELv7
else
RZDCY_CFLAGS	:= \
	$(CFLAGS) -c -O3 -I$(RZDCY_SRC_DIR) -I$(RZDCY_SRC_DIR)/deps \
	-D_ANDROID -DRELEASE\
	-frename-registers -fsingle-precision-constant -ffast-math \
	-ftree-vectorize -fomit-frame-pointer
	
	ifndef NOT_ARM
		RZDCY_CFLAGS += -march=armv7-a -mtune=cortex-a9 -mfpu=vfpv3-d16
		RZDCY_CFLAGS += -DTARGET_LINUX_ARMELv7
	else
	  ifndef ISMIPS
      RZDCY_CFLAGS += -DTARGET_LINUX_x86
		else
      RZDCY_CFLAGS += -DTARGET_LINUX_MIPS
		endif
	endif
endif

RZDCY_CFLAGS += -Ideps/libchdr/flac-1.3.2/src/libFLAC/include -Ideps/libchdr/eps/crypto -DHAVE_SYS_PARAM_H -DFLAC__NO_DLL -D_7ZIP_ST

ifdef NO_REC
  RZDCY_CFLAGS += -DTARGET_NO_REC
endif

ifdef USE_GLES
  RZDCY_CFLAGS += -DGLES -fPIC
endif

ifdef HAS_SOFTREND
	RZDCY_CFLAGS += -DTARGET_SOFTREND
endif

RZDCY_CXXFLAGS := $(RZDCY_CFLAGS) -fno-exceptions -fno-rtti -std=gnu++11
