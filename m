From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 19:24:30 +0000
Subject: [CRIU][PATCH v2 02/17] s390:compel: Enable s390 in compel/
Message-Id: <20170629192445.55580-3-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add s390 parts to common code files.

Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 compel/.gitignore           |  1 +
 compel/Makefile             |  8 ++++++++
 compel/plugins/Makefile     |  7 +++++++
 compel/src/lib/handle-elf.c | 25 +++++++++++++++++++++++++
 compel/src/main.c           |  3 +++
 5 files changed, 44 insertions(+)

diff --git a/compel/.gitignore b/compel/.gitignore
index 5b68863..e959dc5 100644
--- a/compel/.gitignore
+++ b/compel/.gitignore
@@ -1,6 +1,7 @@
 arch/x86/plugins/std/sys-exec-tbl-64.c
 arch/x86/plugins/std/syscalls-64.S
 arch/arm/plugins/std/syscalls/syscalls.S
+arch/s390/plugins/std/syscalls/syscalls.S
 include/version.h
 plugins/include/uapi/std/asm/syscall-types.h
 plugins/include/uapi/std/syscall-64.h
diff --git a/compel/Makefile b/compel/Makefile
index 43d27f5..ebe006d 100644
--- a/compel/Makefile
+++ b/compel/Makefile
@@ -34,6 +34,14 @@ CFLAGS			+= -DNO_RELOCS
 HOSTCFLAGS		+= -DNO_RELOCS
 endif
 
+# We assume that compel code does not change floating point registers.
+# On s390 gcc uses fprs to cache gprs. Therefore disable floating point
+# with -msoft-float.
+ifeq ($(filter s390x,$(ARCH)),)
+CFLAGS += -msoft-float
+HOSTCFLAGS += -msoft-float
+endif
+
 obj-y			+= src/main.o
 obj-y			+= arch/$(ARCH)/src/lib/handle-elf.o
 obj-y			+= src/lib/handle-elf.o
diff --git a/compel/plugins/Makefile b/compel/plugins/Makefile
index 7127425..aa09e20 100644
--- a/compel/plugins/Makefile
+++ b/compel/plugins/Makefile
@@ -7,6 +7,13 @@ PLUGIN_ARCH_DIR		:= compel/arch/$(ARCH)/plugins
 #
 # CFLAGS, ASFLAGS, LDFLAGS
 
+# We assume that compel code does not change floating point registers.
+# On s390 gcc uses fprs to cache gprs. Therefore disable floating point
+# with -msoft-float.
+ifeq ($(filter s390x,$(ARCH)),)
+CFLAGS += -msoft-float
+endif
+
 #
 # UAPI inclusion, referred as <compel/...>
 ccflags-y		+= -I compel/include/uapi
diff --git a/compel/src/lib/handle-elf.c b/compel/src/lib/handle-elf.c
index 41633e9..bf94d93 100644
--- a/compel/src/lib/handle-elf.c
+++ b/compel/src/lib/handle-elf.c
@@ -542,6 +542,31 @@ int __handle_elf(void *mem, size_t size)
 				break;
 #endif
 
+#ifdef ELF_S390
+			/*
+			 * See also arch/s390/kernel/module.c/apply_rela():
+			 * A PLT reads the GOT (global offest table). We can handle it like
+			 * R_390_PC32DBL because we have linked statically.
+			 */
+			case R_390_PLT32DBL: /* PC relative on a PLT (predure link table) */
+				pr_debug("\t\t\t\tR_390_PLT32DBL   at 0x%-4lx val 0x%x\n", place, value32 + addend32);
+				*((int32_t *)where) = (value64 + addend64 - place) >> 1;
+				break;
+			case R_390_PC32DBL: /* PC relative on a symbol */
+				pr_debug("\t\t\t\tR_390_PC32DBL    at 0x%-4lx val 0x%x\n", place, value32 + addend32);
+				*((int32_t *)where) = (value64 + addend64 - place) >> 1;
+				break;
+			case R_390_64: /* 64 bit absolute address */
+				pr_debug("\t\t\t\tR_390_64         at 0x%-4lx val 0x%lx\n", place, (long)value64);
+				pr_out("	{ .offset = 0x%-8x, .type = COMPEL_TYPE_LONG, "
+				       ".addend = %-8ld, .value = 0x%-16lx, }, /* R_390_64 */\n",
+				       (unsigned int)place, (long)addend64, (long)value64);
+				break;
+			case R_390_PC64: /* 64 bit relative address */
+				*((int64_t *)where) = value64 + addend64 - place;
+				pr_debug("\t\t\t\tR_390_PC64       at 0x%-4lx val 0x%lx\n", place, (long)value64);
+				break;
+#endif
 			default:
 				pr_err("Unsupported relocation of type %lu\n",
 					(unsigned long)ELF_R_TYPE(r->rel.r_info));
diff --git a/compel/src/main.c b/compel/src/main.c
index 1171478..86d22ab 100644
--- a/compel/src/main.c
+++ b/compel/src/main.c
@@ -52,6 +52,9 @@ static const flags_t flags = {
 #elif defined CONFIG_PPC64
 	.arch		= "ppc64",
 	.cflags		= COMPEL_CFLAGS_PIE,
+#elif defined CONFIG_S390
+	.arch		= "s390",
+	.cflags		= COMPEL_CFLAGS_PIE,
 #else
 #error "CONFIG_<ARCH> not defined, or unsupported ARCH"
 #endif
-- 
2.7.4
