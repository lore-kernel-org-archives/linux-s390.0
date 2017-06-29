From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 19:24:33 +0000
Subject: [CRIU][PATCH v2 05/17] s390:criu: Enable s390 in criu
Message-Id: <20170629192445.55580-6-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add s390 parts to common code files.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 criu/pie/Makefile         |  7 +++++++
 criu/pie/Makefile.library |  7 +++++++
 criu/pie/util-vdso.c      | 25 +++++++++++++++++++------
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/criu/pie/Makefile b/criu/pie/Makefile
index 73d95d5..76c3535 100644
--- a/criu/pie/Makefile
+++ b/criu/pie/Makefile
@@ -16,6 +16,13 @@ ifeq ($(SRCARCH),arm)
 	ccflags-y	+= -marm
 endif
 
+# We assume that compel code does not change floating point registers.
+# On s390 gcc uses fprs to cache gprs. Therefore disable floating point
+# with -msoft-float.
+ifeq ($(SRCARCH),s390)
+	ccflags-y	+= -msoft-float
+endif
+
 asflags-y	+= -D__ASSEMBLY__
 
 LDS		:= compel/arch/$(SRCARCH)/scripts/compel-pack.lds.S
diff --git a/criu/pie/Makefile.library b/criu/pie/Makefile.library
index f589333..eb1f45e 100644
--- a/criu/pie/Makefile.library
+++ b/criu/pie/Makefile.library
@@ -41,3 +41,10 @@ ccflags-y		+= $(COMPEL_UAPI_INCLUDES)
 ifeq ($(SRCARCH),arm)
 	ccflags-y	+= -marm
 endif
+# We assume that compel code does not change floating point registers.
+# On s390 gcc uses fprs to cache gprs. Therefore disable floating point
+# with -msoft-float.
+ifeq ($(SRCARCH),s390)
+	ccflags-y	+= -msoft-float
+endif
+
diff --git a/criu/pie/util-vdso.c b/criu/pie/util-vdso.c
index 51fea56..4a6138e 100644
--- a/criu/pie/util-vdso.c
+++ b/criu/pie/util-vdso.c
@@ -68,6 +68,12 @@ static unsigned long elf_hash(const unsigned char *name)
 	return h;
 }
 
+#ifdef __ORDER_BIG_ENDIAN__
+#define BORD ELFDATA2MSB /* 0x02 */
+#else
+#define BORD ELFDATA2LSB /* 0x01 */
+#endif
+
 static int has_elf_identity(Ehdr_t *ehdr)
 {
 	/*
@@ -75,12 +81,12 @@ static int has_elf_identity(Ehdr_t *ehdr)
 	 */
 #if defined(CONFIG_VDSO_32)
 	static const char elf_ident[] = {
-		0x7f, 0x45, 0x4c, 0x46, 0x01, 0x01, 0x01, 0x00,
+		0x7f, 0x45, 0x4c, 0x46, 0x01, BORD, 0x01, 0x00,
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	};
 #else
 	static const char elf_ident[] = {
-		0x7f, 0x45, 0x4c, 0x46, 0x02, 0x01, 0x01, 0x00,
+		0x7f, 0x45, 0x4c, 0x46, 0x02, BORD, 0x01, 0x00,
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	};
 #endif
@@ -202,17 +208,24 @@ err_oob:
 	return -EFAULT;
 }
 
+/* On s390x Hash_t is 64 bit */
+#ifdef __s390x__
+typedef unsigned long Hash_t;
+#else
+typedef Word_t Hash_t;
+#endif
+
 static void parse_elf_symbols(uintptr_t mem, size_t size, Phdr_t *load,
 		struct vdso_symtable *t, uintptr_t dynsymbol_names,
-		Word_t *hash, Dyn_t *dyn_symtab)
+		Hash_t *hash, Dyn_t *dyn_symtab)
 {
 	const char *vdso_symbols[VDSO_SYMBOL_MAX] = {
 		ARCH_VDSO_SYMBOLS
 	};
 	const size_t vdso_symbol_length = sizeof(t->symbols[0].name);
 
-	Word_t nbucket, nchain;
-	Word_t *bucket, *chain;
+	Hash_t nbucket, nchain;
+	Hash_t *bucket, *chain;
 
 	unsigned int i, j, k;
 	uintptr_t addr;
@@ -264,7 +277,7 @@ int vdso_fill_symtable(uintptr_t mem, size_t size, struct vdso_symtable *t)
 	Dyn_t *dyn_strtab = NULL;
 	Dyn_t *dyn_symtab = NULL;
 	Dyn_t *dyn_hash = NULL;
-	Word_t *hash = NULL;
+	Hash_t *hash = NULL;
 
 	uintptr_t dynsymbol_names;
 	uintptr_t addr;
-- 
2.7.4
