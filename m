Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 4/4] kbuild: remove unnecessary in-subshell execution
Date: Thu, 17 Jan 2019 19:02:44 +0900
Message-Id: <1547719364-18849-4-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The commands surrounded by ( ) are executed in a subshell, but in
most cases, we do not need to spawn an extra subshell.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/Makefile.build |  4 ++--
 scripts/Makefile.lib   | 21 ++++++++++-----------
 scripts/mkcompile_h    |  4 ++--
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9800178..f8e2794 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -312,11 +312,11 @@ $(real-obj-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 #
 # These mirror gensymtypes_c and co above, keep them in synch.
 cmd_gensymtypes_S =                                                         \
-    (echo "\#include <linux/kernel.h>" ;                                    \
+   { echo "\#include <linux/kernel.h>" ;                                    \
      echo "\#include <asm/asm-prototypes.h>" ;                              \
     $(CPP) $(a_flags) $< |                                                  \
      grep "\<___EXPORT_SYMBOL\>" |                                          \
-     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ) | \
+     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
      $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index c6fc295..c0abd9a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -271,7 +271,7 @@ DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtb= DTB     $@
 cmd_dt_S_dtb=						\
-(							\
+{							\
 	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
 	echo '.section .dtb.init.rodata,"a"';		\
 	echo '.balign STRUCT_ALIGNMENT';		\
@@ -281,7 +281,7 @@ cmd_dt_S_dtb=						\
 	echo '__dtb_$(subst -,_,$(*F))_end:';		\
 	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
 	echo '.balign STRUCT_ALIGNMENT'; 		\
-) > $@
+} > $@
 
 $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 	$(call if_changed,dt_S_dtb)
@@ -335,20 +335,20 @@ printf "%08x\n" $$dec_size |						\
 )
 
 quiet_cmd_bzip2 = BZIP2   $@
-      cmd_bzip2 = (cat $(real-prereqs) | bzip2 -9 && $(size_append)) > $@
+      cmd_bzip2 = { cat $(real-prereqs) | bzip2 -9 && $(size_append); } > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-      cmd_lzma = (cat $(real-prereqs) | lzma -9 && $(size_append)) > $@
+      cmd_lzma = { cat $(real-prereqs) | lzma -9 && $(size_append); } > $@
 
 quiet_cmd_lzo = LZO     $@
-      cmd_lzo = (cat $(real-prereqs) | lzop -9 && $(size_append)) > $@
+      cmd_lzo = { cat $(real-prereqs) | lzop -9 && $(size_append); } > $@
 
 quiet_cmd_lz4 = LZ4     $@
-      cmd_lz4 = (cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
-                  $(size_append)) > $@
+      cmd_lz4 = { cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
+                  $(size_append); } > $@
 
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
@@ -390,12 +390,11 @@ quiet_cmd_uimage = UIMAGE  $@
 # big dictionary would increase the memory usage too much in the multi-call
 # decompression mode. A BCJ filter isn't used either.
 quiet_cmd_xzkern = XZKERN  $@
-      cmd_xzkern = (cat $(real-prereqs) | \
-	sh $(srctree)/scripts/xz_wrap.sh && $(size_append)) > $@
+      cmd_xzkern = { cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh && \
+                     $(size_append); } > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
-      cmd_xzmisc = (cat $(real-prereqs) | \
-	xz --check=crc32 --lzma2=dict=1MiB) > $@
+      cmd_xzmisc = cat $(real-prereqs) | xz --check=crc32 --lzma2=dict=1MiB > $@
 
 # ASM offsets
 # ---------------------------------------------------------------------------
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index 87f1fc9..2339f86 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -62,7 +62,7 @@ UTS_TRUNCATE="cut -b -$UTS_LEN"
 
 # Generate a temporary compile.h
 
-( echo /\* This file is auto generated, version $VERSION \*/
+{ echo /\* This file is auto generated, version $VERSION \*/
   if [ -n "$CONFIG_FLAGS" ] ; then echo "/* $CONFIG_FLAGS */"; fi
 
   echo \#define UTS_MACHINE \"$ARCH\"
@@ -73,7 +73,7 @@ UTS_TRUNCATE="cut -b -$UTS_LEN"
   echo \#define LINUX_COMPILE_HOST \"`echo $LINUX_COMPILE_HOST | $UTS_TRUNCATE`\"
 
   echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | grep ' version ' | sed 's/[[:space:]]*$//'`\"
-) > .tmpcompile
+} > .tmpcompile
 
 # Only replace the real compile.h if the new one is different,
 # in order to preserve the timestamp and avoid unnecessary
-- 
2.7.4
