Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] kbuild: add endianness flag to CHEKCFLAGS
Date: Mon, 28 May 2018 19:00:48 +0200
Message-Id: <20180528170048.16595-1-luc.vanoostenryck@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

The kernel depends on macros like __BYTE_ORDER__,
__BIG_ENDIAN__ or __LITTLE_ENDIAN__.

OTOH, sparse doesn't know about the endianness of the kernel and
by default uses the same as the machine on which sparse was built.

Ensure that sparse can predefine the macros corresponding to
how the kernel was configured by adding -m{big,little}-endian
to CHECKFLAGS in the main Makefile (and so for all archs).
Also, remove the equivalent done in arch specific Makefiles.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile               | 3 +++
 arch/openrisc/Makefile | 1 -
 arch/parisc/Makefile   | 2 +-
 arch/s390/Makefile     | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 56ba070df..057a278d2 100644
--- a/Makefile
+++ b/Makefile
@@ -878,6 +878,9 @@ ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
 LDFLAGS_vmlinux	+= $(call ld-option, -X,)
 endif
 
+# insure the checker run with the right endianness
+CHECKFLAGS += $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig,-mlittle)
+
 # Default kernel image to build when no specific target is given.
 # KBUILD_IMAGE may be overruled on the command line or
 # set in the environment
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index cf8802962..89076a66e 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -25,7 +25,6 @@ LDFLAGS_vmlinux :=
 LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 KBUILD_CFLAGS	+= -pipe -ffixed-r10 -D__linux__
-CHECKFLAGS	+= -mbig-endian
 
 ifeq ($(CONFIG_OPENRISC_HAVE_INST_MUL),y)
 	KBUILD_CFLAGS += $(call cc-option,-mhard-mul)
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 34ac503e2..348ae4779 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -22,7 +22,7 @@ KBUILD_IMAGE := vmlinuz
 KBUILD_DEFCONFIG := default_defconfig
 
 NM		= sh $(srctree)/arch/parisc/nm
-CHECKFLAGS	+= -D__hppa__=1 -mbig-endian
+CHECKFLAGS	+= -D__hppa__=1
 LIBGCC		= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 export LIBGCC
 
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index c79936d02..68a690442 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -18,7 +18,7 @@ KBUILD_CFLAGS	+= -m64
 KBUILD_AFLAGS	+= -m64
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= 16384
-CHECKFLAGS	+= -D__s390__ -D__s390x__ -mbig-endian
+CHECKFLAGS	+= -D__s390__ -D__s390x__
 
 export LD_BFD
 
-- 
2.17.0
