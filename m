From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/52] s390: hypfs: Move diag implementation and data definitions
Date: Tue, 14 Jun 2016 20:56:38 +0200
Message-ID: <201606141857.u5EIs0jW121646@mx0a-001b2d01.pphosted.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

Diag 204 data and function definitions currently live in the hypfs
files. As KVM will be a consumer of this data, we need to make it
publicly available and move it to the appropriate diag.{c,h} files.

__attribute__ ((packed)) occurences were replaced with __packed for
all moved structs.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/hypfs/hypfs_diag.c | 361 +++++++++++++------------------------------
 arch/s390/include/asm/diag.h | 127 +++++++++++++++
 arch/s390/kernel/diag.c      |  22 +++
 3 files changed, 256 insertions(+), 254 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 0450357..1e28414 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -19,29 +19,10 @@
 #include <asm/ebcdic.h>
 #include "hypfs.h"
 
-#define LPAR_NAME_LEN 8		/* lpar name len in diag 204 data */
-#define CPU_NAME_LEN 16		/* type name len of cpus in diag224 name table */
 #define TMP_SIZE 64		/* size of temporary buffers */
 
 #define DBFS_D204_HDR_VERSION	0
 
-/* diag 204 subcodes */
-enum diag204_sc {
-	SUBC_STIB4 = 4,
-	SUBC_RSI = 5,
-	SUBC_STIB6 = 6,
-	SUBC_STIB7 = 7
-};
-
-/* The two available diag 204 data formats */
-enum diag204_format {
-	INFO_SIMPLE = 0,
-	INFO_EXT = 0x00010000
-};
-
-/* bit is set in flags, when physical cpu info is included in diag 204 data */
-#define LPAR_PHYS_FLG  0x80
-
 static char *diag224_cpu_names;			/* diag 224 name table */
 static enum diag204_sc diag204_store_sc;	/* used subcode for store */
 static enum diag204_format diag204_info_type;	/* used diag 204 data format */
@@ -53,7 +34,7 @@ static int diag204_buf_pages;		/* number of pages for diag204 data */
 static struct dentry *dbfs_d204_file;
 
 /*
- * DIAG 204 data structures and member access functions.
+ * DIAG 204 member access functions.
  *
  * Since we have two different diag 204 data formats for old and new s390
  * machines, we do not access the structs directly, but use getter functions for
@@ -62,302 +43,173 @@ static struct dentry *dbfs_d204_file;
 
 /* Time information block */
 
-struct info_blk_hdr {
-	__u8  npar;
-	__u8  flags;
-	__u16 tslice;
-	__u16 phys_cpus;
-	__u16 this_part;
-	__u64 curtod;
-} __attribute__ ((packed));
-
-struct x_info_blk_hdr {
-	__u8  npar;
-	__u8  flags;
-	__u16 tslice;
-	__u16 phys_cpus;
-	__u16 this_part;
-	__u64 curtod1;
-	__u64 curtod2;
-	char reserved[40];
-} __attribute__ ((packed));
-
 static inline int info_blk_hdr__size(enum diag204_format type)
 {
-	if (type == INFO_SIMPLE)
-		return sizeof(struct info_blk_hdr);
-	else /* INFO_EXT */
-		return sizeof(struct x_info_blk_hdr);
+	if (type == DIAG204_INFO_SIMPLE)
+		return sizeof(struct diag204_info_blk_hdr);
+	else /* DIAG204_INFO_EXT */
+		return sizeof(struct diag204_x_info_blk_hdr);
 }
 
 static inline __u8 info_blk_hdr__npar(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct info_blk_hdr *)hdr)->npar;
-	else /* INFO_EXT */
-		return ((struct x_info_blk_hdr *)hdr)->npar;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_info_blk_hdr *)hdr)->npar;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_info_blk_hdr *)hdr)->npar;
 }
 
 static inline __u8 info_blk_hdr__flags(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct info_blk_hdr *)hdr)->flags;
-	else /* INFO_EXT */
-		return ((struct x_info_blk_hdr *)hdr)->flags;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_info_blk_hdr *)hdr)->flags;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_info_blk_hdr *)hdr)->flags;
 }
 
 static inline __u16 info_blk_hdr__pcpus(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct info_blk_hdr *)hdr)->phys_cpus;
-	else /* INFO_EXT */
-		return ((struct x_info_blk_hdr *)hdr)->phys_cpus;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_info_blk_hdr *)hdr)->phys_cpus;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_info_blk_hdr *)hdr)->phys_cpus;
 }
 
 /* Partition header */
 
-struct part_hdr {
-	__u8 pn;
-	__u8 cpus;
-	char reserved[6];
-	char part_name[LPAR_NAME_LEN];
-} __attribute__ ((packed));
-
-struct x_part_hdr {
-	__u8  pn;
-	__u8  cpus;
-	__u8  rcpus;
-	__u8  pflag;
-	__u32 mlu;
-	char  part_name[LPAR_NAME_LEN];
-	char  lpc_name[8];
-	char  os_name[8];
-	__u64 online_cs;
-	__u64 online_es;
-	__u8  upid;
-	char  reserved1[3];
-	__u32 group_mlu;
-	char  group_name[8];
-	char  reserved2[32];
-} __attribute__ ((packed));
-
 static inline int part_hdr__size(enum diag204_format type)
 {
-	if (type == INFO_SIMPLE)
-		return sizeof(struct part_hdr);
-	else /* INFO_EXT */
-		return sizeof(struct x_part_hdr);
+	if (type == DIAG204_INFO_SIMPLE)
+		return sizeof(struct diag204_part_hdr);
+	else /* DIAG204_INFO_EXT */
+		return sizeof(struct diag204_x_part_hdr);
 }
 
 static inline __u8 part_hdr__rcpus(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct part_hdr *)hdr)->cpus;
-	else /* INFO_EXT */
-		return ((struct x_part_hdr *)hdr)->rcpus;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_part_hdr *)hdr)->cpus;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_part_hdr *)hdr)->rcpus;
 }
 
 static inline void part_hdr__part_name(enum diag204_format type, void *hdr,
 				       char *name)
 {
-	if (type == INFO_SIMPLE)
-		memcpy(name, ((struct part_hdr *)hdr)->part_name,
-		       LPAR_NAME_LEN);
-	else /* INFO_EXT */
-		memcpy(name, ((struct x_part_hdr *)hdr)->part_name,
-		       LPAR_NAME_LEN);
-	EBCASC(name, LPAR_NAME_LEN);
-	name[LPAR_NAME_LEN] = 0;
+	if (type == DIAG204_INFO_SIMPLE)
+		memcpy(name, ((struct diag204_part_hdr *)hdr)->part_name,
+		       DIAG204_LPAR_NAME_LEN);
+	else /* DIAG204_INFO_EXT */
+		memcpy(name, ((struct diag204_x_part_hdr *)hdr)->part_name,
+		       DIAG204_LPAR_NAME_LEN);
+	EBCASC(name, DIAG204_LPAR_NAME_LEN);
+	name[DIAG204_LPAR_NAME_LEN] = 0;
 	strim(name);
 }
 
-struct cpu_info {
-	__u16 cpu_addr;
-	char  reserved1[2];
-	__u8  ctidx;
-	__u8  cflag;
-	__u16 weight;
-	__u64 acc_time;
-	__u64 lp_time;
-} __attribute__ ((packed));
-
-struct x_cpu_info {
-	__u16 cpu_addr;
-	char  reserved1[2];
-	__u8  ctidx;
-	__u8  cflag;
-	__u16 weight;
-	__u64 acc_time;
-	__u64 lp_time;
-	__u16 min_weight;
-	__u16 cur_weight;
-	__u16 max_weight;
-	char  reseved2[2];
-	__u64 online_time;
-	__u64 wait_time;
-	__u32 pma_weight;
-	__u32 polar_weight;
-	char  reserved3[40];
-} __attribute__ ((packed));
-
 /* CPU info block */
 
 static inline int cpu_info__size(enum diag204_format type)
 {
-	if (type == INFO_SIMPLE)
-		return sizeof(struct cpu_info);
-	else /* INFO_EXT */
-		return sizeof(struct x_cpu_info);
+	if (type == DIAG204_INFO_SIMPLE)
+		return sizeof(struct diag204_cpu_info);
+	else /* DIAG204_INFO_EXT */
+		return sizeof(struct diag204_x_cpu_info);
 }
 
 static inline __u8 cpu_info__ctidx(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct cpu_info *)hdr)->ctidx;
-	else /* INFO_EXT */
-		return ((struct x_cpu_info *)hdr)->ctidx;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_cpu_info *)hdr)->ctidx;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_cpu_info *)hdr)->ctidx;
 }
 
 static inline __u16 cpu_info__cpu_addr(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct cpu_info *)hdr)->cpu_addr;
-	else /* INFO_EXT */
-		return ((struct x_cpu_info *)hdr)->cpu_addr;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_cpu_info *)hdr)->cpu_addr;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_cpu_info *)hdr)->cpu_addr;
 }
 
 static inline __u64 cpu_info__acc_time(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct cpu_info *)hdr)->acc_time;
-	else /* INFO_EXT */
-		return ((struct x_cpu_info *)hdr)->acc_time;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_cpu_info *)hdr)->acc_time;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_cpu_info *)hdr)->acc_time;
 }
 
 static inline __u64 cpu_info__lp_time(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct cpu_info *)hdr)->lp_time;
-	else /* INFO_EXT */
-		return ((struct x_cpu_info *)hdr)->lp_time;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_cpu_info *)hdr)->lp_time;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_cpu_info *)hdr)->lp_time;
 }
 
 static inline __u64 cpu_info__online_time(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
+	if (type == DIAG204_INFO_SIMPLE)
 		return 0;	/* online_time not available in simple info */
-	else /* INFO_EXT */
-		return ((struct x_cpu_info *)hdr)->online_time;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_cpu_info *)hdr)->online_time;
 }
 
 /* Physical header */
 
-struct phys_hdr {
-	char reserved1[1];
-	__u8 cpus;
-	char reserved2[6];
-	char mgm_name[8];
-} __attribute__ ((packed));
-
-struct x_phys_hdr {
-	char reserved1[1];
-	__u8 cpus;
-	char reserved2[6];
-	char mgm_name[8];
-	char reserved3[80];
-} __attribute__ ((packed));
-
 static inline int phys_hdr__size(enum diag204_format type)
 {
-	if (type == INFO_SIMPLE)
-		return sizeof(struct phys_hdr);
-	else /* INFO_EXT */
-		return sizeof(struct x_phys_hdr);
+	if (type == DIAG204_INFO_SIMPLE)
+		return sizeof(struct diag204_phys_hdr);
+	else /* DIAG204_INFO_EXT */
+		return sizeof(struct diag204_x_phys_hdr);
 }
 
 static inline __u8 phys_hdr__cpus(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct phys_hdr *)hdr)->cpus;
-	else /* INFO_EXT */
-		return ((struct x_phys_hdr *)hdr)->cpus;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_phys_hdr *)hdr)->cpus;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_phys_hdr *)hdr)->cpus;
 }
 
 /* Physical CPU info block */
 
-struct phys_cpu {
-	__u16 cpu_addr;
-	char  reserved1[2];
-	__u8  ctidx;
-	char  reserved2[3];
-	__u64 mgm_time;
-	char  reserved3[8];
-} __attribute__ ((packed));
-
-struct x_phys_cpu {
-	__u16 cpu_addr;
-	char  reserved1[2];
-	__u8  ctidx;
-	char  reserved2[3];
-	__u64 mgm_time;
-	char  reserved3[80];
-} __attribute__ ((packed));
-
 static inline int phys_cpu__size(enum diag204_format type)
 {
-	if (type == INFO_SIMPLE)
-		return sizeof(struct phys_cpu);
-	else /* INFO_EXT */
-		return sizeof(struct x_phys_cpu);
+	if (type == DIAG204_INFO_SIMPLE)
+		return sizeof(struct diag204_phys_cpu);
+	else /* DIAG204_INFO_EXT */
+		return sizeof(struct diag204_x_phys_cpu);
 }
 
 static inline __u16 phys_cpu__cpu_addr(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct phys_cpu *)hdr)->cpu_addr;
-	else /* INFO_EXT */
-		return ((struct x_phys_cpu *)hdr)->cpu_addr;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_phys_cpu *)hdr)->cpu_addr;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_phys_cpu *)hdr)->cpu_addr;
 }
 
 static inline __u64 phys_cpu__mgm_time(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct phys_cpu *)hdr)->mgm_time;
-	else /* INFO_EXT */
-		return ((struct x_phys_cpu *)hdr)->mgm_time;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_phys_cpu *)hdr)->mgm_time;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_phys_cpu *)hdr)->mgm_time;
 }
 
 static inline __u64 phys_cpu__ctidx(enum diag204_format type, void *hdr)
 {
-	if (type == INFO_SIMPLE)
-		return ((struct phys_cpu *)hdr)->ctidx;
-	else /* INFO_EXT */
-		return ((struct x_phys_cpu *)hdr)->ctidx;
+	if (type == DIAG204_INFO_SIMPLE)
+		return ((struct diag204_phys_cpu *)hdr)->ctidx;
+	else /* DIAG204_INFO_EXT */
+		return ((struct diag204_x_phys_cpu *)hdr)->ctidx;
 }
 
 /* Diagnose 204 functions */
-
-static inline int __diag204(unsigned long subcode, unsigned long size, void *addr)
-{
-	register unsigned long _subcode asm("0") = subcode;
-	register unsigned long _size asm("1") = size;
-
-	asm volatile(
-		"	diag	%2,%0,0x204\n"
-		"0:\n"
-		EX_TABLE(0b,0b)
-		: "+d" (_subcode), "+d" (_size) : "d" (addr) : "memory");
-	if (_subcode)
-		return -1;
-	return _size;
-}
-
-static int diag204(unsigned long subcode, unsigned long size, void *addr)
-{
-	diag_stat_inc(DIAG_STAT_X204);
-	return __diag204(subcode, size, addr);
-}
-
 /*
  * For the old diag subcode 4 with simple data format we have to use real
  * memory. If we use subcode 6 or 7 with extended data format, we can (and
@@ -409,12 +261,12 @@ static void *diag204_get_buffer(enum diag204_format fmt, int *pages)
 		*pages = diag204_buf_pages;
 		return diag204_buf;
 	}
-	if (fmt == INFO_SIMPLE) {
+	if (fmt == DIAG204_INFO_SIMPLE) {
 		*pages = 1;
 		return diag204_alloc_rbuf();
-	} else {/* INFO_EXT */
-		*pages = diag204((unsigned long)SUBC_RSI |
-				 (unsigned long)INFO_EXT, 0, NULL);
+	} else {/* DIAG204_INFO_EXT */
+		*pages = diag204((unsigned long)DIAG204_SUBC_RSI |
+				 (unsigned long)DIAG204_INFO_EXT, 0, NULL);
 		if (*pages <= 0)
 			return ERR_PTR(-ENOSYS);
 		else
@@ -441,18 +293,18 @@ static int diag204_probe(void)
 	void *buf;
 	int pages, rc;
 
-	buf = diag204_get_buffer(INFO_EXT, &pages);
+	buf = diag204_get_buffer(DIAG204_INFO_EXT, &pages);
 	if (!IS_ERR(buf)) {
-		if (diag204((unsigned long)SUBC_STIB7 |
-			    (unsigned long)INFO_EXT, pages, buf) >= 0) {
-			diag204_store_sc = SUBC_STIB7;
-			diag204_info_type = INFO_EXT;
+		if (diag204((unsigned long)DIAG204_SUBC_STIB7 |
+			    (unsigned long)DIAG204_INFO_EXT, pages, buf) >= 0) {
+			diag204_store_sc = DIAG204_SUBC_STIB7;
+			diag204_info_type = DIAG204_INFO_EXT;
 			goto out;
 		}
-		if (diag204((unsigned long)SUBC_STIB6 |
-			    (unsigned long)INFO_EXT, pages, buf) >= 0) {
-			diag204_store_sc = SUBC_STIB6;
-			diag204_info_type = INFO_EXT;
+		if (diag204((unsigned long)DIAG204_SUBC_STIB6 |
+			    (unsigned long)DIAG204_INFO_EXT, pages, buf) >= 0) {
+			diag204_store_sc = DIAG204_SUBC_STIB6;
+			diag204_info_type = DIAG204_INFO_EXT;
 			goto out;
 		}
 		diag204_free_buffer();
@@ -460,15 +312,15 @@ static int diag204_probe(void)
 
 	/* subcodes 6 and 7 failed, now try subcode 4 */
 
-	buf = diag204_get_buffer(INFO_SIMPLE, &pages);
+	buf = diag204_get_buffer(DIAG204_INFO_SIMPLE, &pages);
 	if (IS_ERR(buf)) {
 		rc = PTR_ERR(buf);
 		goto fail_alloc;
 	}
-	if (diag204((unsigned long)SUBC_STIB4 |
-		    (unsigned long)INFO_SIMPLE, pages, buf) >= 0) {
-		diag204_store_sc = SUBC_STIB4;
-		diag204_info_type = INFO_SIMPLE;
+	if (diag204((unsigned long)DIAG204_SUBC_STIB4 |
+		    (unsigned long)DIAG204_INFO_SIMPLE, pages, buf) >= 0) {
+		diag204_store_sc = DIAG204_SUBC_STIB4;
+		diag204_info_type = DIAG204_INFO_SIMPLE;
 		goto out;
 	} else {
 		rc = -ENOSYS;
@@ -543,9 +395,9 @@ static void diag224_delete_name_table(void)
 
 static int diag224_idx2name(int index, char *name)
 {
-	memcpy(name, diag224_cpu_names + ((index + 1) * CPU_NAME_LEN),
-		CPU_NAME_LEN);
-	name[CPU_NAME_LEN] = 0;
+	memcpy(name, diag224_cpu_names + ((index + 1) * DIAG204_CPU_NAME_LEN),
+	       DIAG204_CPU_NAME_LEN);
+	name[DIAG204_CPU_NAME_LEN] = 0;
 	strim(name);
 	return 0;
 }
@@ -601,7 +453,7 @@ __init int hypfs_diag_init(void)
 		pr_err("The hardware system does not support hypfs\n");
 		return -ENODATA;
 	}
-	if (diag204_info_type == INFO_EXT) {
+	if (diag204_info_type == DIAG204_INFO_EXT) {
 		rc = hypfs_dbfs_create_file(&dbfs_file_d204);
 		if (rc)
 			return rc;
@@ -649,7 +501,7 @@ static int hypfs_create_cpu_files(struct dentry *cpus_dir, void *cpu_info)
 			      cpu_info__lp_time(diag204_info_type, cpu_info));
 	if (IS_ERR(rc))
 		return PTR_ERR(rc);
-	if (diag204_info_type == INFO_EXT) {
+	if (diag204_info_type == DIAG204_INFO_EXT) {
 		rc = hypfs_create_u64(cpu_dir, "onlinetime",
 				      cpu_info__online_time(diag204_info_type,
 							    cpu_info));
@@ -665,12 +517,12 @@ static void *hypfs_create_lpar_files(struct dentry *systems_dir, void *part_hdr)
 {
 	struct dentry *cpus_dir;
 	struct dentry *lpar_dir;
-	char lpar_name[LPAR_NAME_LEN + 1];
+	char lpar_name[DIAG204_LPAR_NAME_LEN + 1];
 	void *cpu_info;
 	int i;
 
 	part_hdr__part_name(diag204_info_type, part_hdr, lpar_name);
-	lpar_name[LPAR_NAME_LEN] = 0;
+	lpar_name[DIAG204_LPAR_NAME_LEN] = 0;
 	lpar_dir = hypfs_mkdir(systems_dir, lpar_name);
 	if (IS_ERR(lpar_dir))
 		return lpar_dir;
@@ -753,7 +605,8 @@ int hypfs_diag_create_files(struct dentry *root)
 			goto err_out;
 		}
 	}
-	if (info_blk_hdr__flags(diag204_info_type, time_hdr) & LPAR_PHYS_FLG) {
+	if (info_blk_hdr__flags(diag204_info_type, time_hdr) &
+	    DIAG204_LPAR_PHYS_FLG) {
 		ptr = hypfs_create_phys_files(root, part_hdr);
 		if (IS_ERR(ptr)) {
 			rc = PTR_ERR(ptr);
diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 5fac921..f72744f 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -78,4 +78,131 @@ struct diag210 {
 
 extern int diag210(struct diag210 *addr);
 
+/* bit is set in flags, when physical cpu info is included in diag 204 data */
+#define DIAG204_LPAR_PHYS_FLG 0x80
+#define DIAG204_LPAR_NAME_LEN 8		/* lpar name len in diag 204 data */
+#define DIAG204_CPU_NAME_LEN 16		/* type name len of cpus in diag224 name table */
+
+/* diag 204 subcodes */
+enum diag204_sc {
+	DIAG204_SUBC_STIB4 = 4,
+	DIAG204_SUBC_RSI = 5,
+	DIAG204_SUBC_STIB6 = 6,
+	DIAG204_SUBC_STIB7 = 7
+};
+
+/* The two available diag 204 data formats */
+enum diag204_format {
+	DIAG204_INFO_SIMPLE = 0,
+	DIAG204_INFO_EXT = 0x00010000
+};
+
+struct diag204_info_blk_hdr {
+	__u8  npar;
+	__u8  flags;
+	__u16 tslice;
+	__u16 phys_cpus;
+	__u16 this_part;
+	__u64 curtod;
+} __packed;
+
+struct diag204_x_info_blk_hdr {
+	__u8  npar;
+	__u8  flags;
+	__u16 tslice;
+	__u16 phys_cpus;
+	__u16 this_part;
+	__u64 curtod1;
+	__u64 curtod2;
+	char reserved[40];
+} __packed;
+
+struct diag204_part_hdr {
+	__u8 pn;
+	__u8 cpus;
+	char reserved[6];
+	char part_name[DIAG204_LPAR_NAME_LEN];
+} __packed;
+
+struct diag204_x_part_hdr {
+	__u8  pn;
+	__u8  cpus;
+	__u8  rcpus;
+	__u8  pflag;
+	__u32 mlu;
+	char  part_name[DIAG204_LPAR_NAME_LEN];
+	char  lpc_name[8];
+	char  os_name[8];
+	__u64 online_cs;
+	__u64 online_es;
+	__u8  upid;
+	char  reserved1[3];
+	__u32 group_mlu;
+	char  group_name[8];
+	char  reserved2[32];
+} __packed;
+
+struct diag204_cpu_info {
+	__u16 cpu_addr;
+	char  reserved1[2];
+	__u8  ctidx;
+	__u8  cflag;
+	__u16 weight;
+	__u64 acc_time;
+	__u64 lp_time;
+} __packed;
+
+struct diag204_x_cpu_info {
+	__u16 cpu_addr;
+	char  reserved1[2];
+	__u8  ctidx;
+	__u8  cflag;
+	__u16 weight;
+	__u64 acc_time;
+	__u64 lp_time;
+	__u16 min_weight;
+	__u16 cur_weight;
+	__u16 max_weight;
+	char  reseved2[2];
+	__u64 online_time;
+	__u64 wait_time;
+	__u32 pma_weight;
+	__u32 polar_weight;
+	char  reserved3[40];
+} __packed;
+
+struct diag204_phys_hdr {
+	char reserved1[1];
+	__u8 cpus;
+	char reserved2[6];
+	char mgm_name[8];
+} __packed;
+
+struct diag204_x_phys_hdr {
+	char reserved1[1];
+	__u8 cpus;
+	char reserved2[6];
+	char mgm_name[8];
+	char reserved3[80];
+} __packed;
+
+struct diag204_phys_cpu {
+	__u16 cpu_addr;
+	char  reserved1[2];
+	__u8  ctidx;
+	char  reserved2[3];
+	__u64 mgm_time;
+	char  reserved3[8];
+} __packed;
+
+struct diag204_x_phys_cpu {
+	__u16 cpu_addr;
+	char  reserved1[2];
+	__u8  ctidx;
+	char  reserved2[3];
+	__u64 mgm_time;
+	char  reserved3[80];
+} __packed;
+
+int diag204(unsigned long subcode, unsigned long size, void *addr);
 #endif /* _ASM_S390_DIAG_H */
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index 48b37b8..f4ce4a2 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -162,6 +162,28 @@ int diag14(unsigned long rx, unsigned long ry1, unsigned long subcode)
 }
 EXPORT_SYMBOL(diag14);
 
+static inline int __diag204(unsigned long subcode, unsigned long size, void *addr)
+{
+	register unsigned long _subcode asm("0") = subcode;
+	register unsigned long _size asm("1") = size;
+
+	asm volatile(
+		"	diag	%2,%0,0x204\n"
+		"0:\n"
+		EX_TABLE(0b,0b)
+		: "+d" (_subcode), "+d" (_size) : "d" (addr) : "memory");
+	if (_subcode)
+		return -1;
+	return _size;
+}
+
+int diag204(unsigned long subcode, unsigned long size, void *addr)
+{
+	diag_stat_inc(DIAG_STAT_X204);
+	return __diag204(subcode, size, addr);
+}
+EXPORT_SYMBOL(diag204);
+
 /*
  * Diagnose 210: Get information about a virtual device
  */
-- 
2.5.5
