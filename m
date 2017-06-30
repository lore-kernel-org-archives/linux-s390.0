From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 18:31:40 +0000
Subject: [CRIU][PATCH v3 05/15] s390:criu: Enable s390 in criu
Message-Id: <20170630183150.76021-6-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add s390 parts to common code files.

Patch history
-------------
v2->v3:

 * Add: Fix big endian byte order checks

Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reviewed-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 criu/pie/Makefile         |  7 +++++++
 criu/pie/Makefile.library |  6 ++++++
 criu/pie/util-vdso.c      | 25 +++++++++++++++++++------
 criu/sk-netlink.c         | 16 ++++++++++++++++
 4 files changed, 48 insertions(+), 6 deletions(-)

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
index f589333..ceadc1d 100644
--- a/criu/pie/Makefile.library
+++ b/criu/pie/Makefile.library
@@ -41,3 +41,9 @@ ccflags-y		+= $(COMPEL_UAPI_INCLUDES)
 ifeq ($(SRCARCH),arm)
 	ccflags-y	+= -marm
 endif
+# We assume that compel code does not change floating point registers.
+# On s390 gcc uses fprs to cache gprs. Therefore disable floating point
+# with -msoft-float.
+ifeq ($(SRCARCH),s390)
+	ccflags-y	+= -msoft-float
+endif
diff --git a/criu/pie/util-vdso.c b/criu/pie/util-vdso.c
index 51fea56..6213df9 100644
--- a/criu/pie/util-vdso.c
+++ b/criu/pie/util-vdso.c
@@ -68,6 +68,12 @@ static unsigned long elf_hash(const unsigned char *name)
 	return h;
 }
 
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
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
diff --git a/criu/sk-netlink.c b/criu/sk-netlink.c
index 44982a1..a9d73c5 100644
--- a/criu/sk-netlink.c
+++ b/criu/sk-netlink.c
@@ -107,6 +107,22 @@ static int dump_one_netlink_fd(int lfd, u32 id, const struct fd_parms *p)
 		 * On 64-bit sk->gsize is multiple to 8 bytes (sizeof(long)),
 		 * so remove the last 4 bytes if they are empty.
 		 */
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		/*
+		 * Big endian swap: Ugly hack for zdtm/static/sk-netlink
+		 *
+		 * For big endian systems:
+		 *
+		 * - sk->groups[0] are bits 32-64
+		 * - sk->groups[1] are bits 0-32
+		 */
+		if (ne.n_groups == 2) {
+			uint32_t tmp = sk->groups[1];
+
+			sk->groups[1] = sk->groups[0];
+			sk->groups[0] = tmp;
+		}
+#endif
 		if (ne.n_groups && sk->groups[ne.n_groups - 1] == 0)
 			ne.n_groups -= 1;
 
-- 
2.7.4
