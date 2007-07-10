Return-Path: <linux-kernel-owner+w=401wt.eu-S1763221AbXGJJ3B@vger.kernel.org>
Message-Id: <20070710093105.021241884@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/16] sclp: introduce some new interfaces.
Content-Disposition: inline; filename=003-sclp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Introduce some new interfaces so that random subsystems don't have to
mess around with sclp internal structures.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/early.c      |   44 ++++------------
 arch/s390/kernel/ipl.c        |   17 +++---
 drivers/s390/char/sclp.h      |    7 ++
 drivers/s390/char/sclp_info.c |  110 ++++++++++++++++++++++++++++++------------
 include/asm-s390/sclp.h       |   46 ++++++-----------
 5 files changed, 122 insertions(+), 102 deletions(-)

Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -171,37 +171,6 @@ static inline int memory_fast_detect(voi
 }
 #endif
 
-#define ADDR2G	(1UL << 31)
-
-static noinline __init unsigned long sclp_memory_detect(void)
-{
-	struct sclp_readinfo_sccb *sccb;
-	unsigned long long memsize;
-
-	sccb = &s390_readinfo_sccb;
-
-	if (sccb->header.response_code != 0x10)
-		return 0;
-
-	if (sccb->rnsize)
-		memsize = sccb->rnsize << 20;
-	else
-		memsize = sccb->rnsize2 << 20;
-	if (sccb->rnmax)
-		memsize *= sccb->rnmax;
-	else
-		memsize *= sccb->rnmax2;
-#ifndef CONFIG_64BIT
-	/*
-	 * Can't deal with more than 2G in 31 bit addressing mode, so
-	 * limit the value in order to avoid strange side effects.
-	 */
-	if (memsize > ADDR2G)
-		memsize = ADDR2G;
-#endif
-	return (unsigned long) memsize;
-}
-
 static inline __init unsigned long __tprot(unsigned long addr)
 {
 	int cc = -1;
@@ -218,6 +187,7 @@ static inline __init unsigned long __tpr
 
 /* Checking memory in 128KB increments. */
 #define CHUNK_INCR	(1UL << 17)
+#define ADDR2G		(1UL << 31)
 
 static noinline __init void find_memory_chunks(unsigned long memsize)
 {
@@ -293,7 +263,7 @@ static noinline __init void setup_lowcor
  */
 void __init startup_init(void)
 {
-	unsigned long memsize;
+	unsigned long long memsize;
 
 	ipl_save_parameters();
 	clear_bss_section();
@@ -306,7 +276,15 @@ void __init startup_init(void)
 	setup_lowcore_early();
 	sclp_readinfo_early();
 	memsize = sclp_memory_detect();
+#ifndef CONFIG_64BIT
+	/*
+	 * Can't deal with more than 2G in 31 bit addressing mode, so
+	 * limit the value in order to avoid strange side effects.
+	 */
+	if (memsize > ADDR2G)
+		memsize = ADDR2G;
+#endif
 	if (memory_fast_detect() < 0)
-		find_memory_chunks(memsize);
+		find_memory_chunks((unsigned long) memsize);
 	lockdep_on();
 }
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -25,10 +25,6 @@
 
 #define IPL_PARM_BLOCK_VERSION 0
 
-#define SCCB_VALID (s390_readinfo_sccb.header.response_code == 0x10)
-#define SCCB_LOADPARM (&s390_readinfo_sccb.loadparm)
-#define SCCB_FLAG (s390_readinfo_sccb.flags)
-
 #define IPL_UNKNOWN_STR		"unknown"
 #define IPL_CCW_STR		"ccw"
 #define IPL_FCP_STR		"fcp"
@@ -146,6 +142,8 @@ static struct ipl_parameter_block *dump_
 
 static enum shutdown_action on_panic_action = SHUTDOWN_STOP;
 
+static struct sclp_ipl_info sclp_ipl_info;
+
 int diag308(unsigned long subcode, void *addr)
 {
 	register unsigned long _addr asm("0") = (unsigned long) addr;
@@ -375,9 +373,9 @@ static ssize_t ipl_ccw_loadparm_show(str
 {
 	char loadparm[LOADPARM_LEN + 1] = {};
 
-	if (!SCCB_VALID)
+	if (!sclp_ipl_info.is_valid)
 		return sprintf(page, "#unknown#\n");
-	memcpy(loadparm, SCCB_LOADPARM, LOADPARM_LEN);
+	memcpy(loadparm, &sclp_ipl_info.loadparm, LOADPARM_LEN);
 	EBCASC(loadparm, LOADPARM_LEN);
 	strstrip(loadparm);
 	return sprintf(page, "%s\n", loadparm);
@@ -910,9 +908,9 @@ static int __init reipl_ccw_init(void)
 	reipl_block_ccw->hdr.blk0_len = IPL_PARM_BLK0_CCW_LEN;
 	reipl_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
 	/* check if read scp info worked and set loadparm */
-	if (SCCB_VALID)
+	if (sclp_ipl_info.is_valid)
 		memcpy(reipl_block_ccw->ipl_info.ccw.load_param,
-		       SCCB_LOADPARM, LOADPARM_LEN);
+		       &sclp_ipl_info.loadparm, LOADPARM_LEN);
 	else
 		/* read scp info failed: set empty loadparm (EBCDIC blanks) */
 		memset(reipl_block_ccw->ipl_info.ccw.load_param, 0x40,
@@ -1007,7 +1005,7 @@ static int __init dump_fcp_init(void)
 {
 	int rc;
 
-	if(!(SCCB_FLAG & 0x2) || !SCCB_VALID)
+	if (!sclp_ipl_info.has_dump)
 		return 0; /* LDIPL DUMP is not installed */
 	if (!diag308_set_works)
 		return 0;
@@ -1088,6 +1086,7 @@ static int __init s390_ipl_init(void)
 {
 	int rc;
 
+	sclp_get_ipl_info(&sclp_ipl_info);
 	reipl_probe();
 	rc = ipl_init();
 	if (rc)
Index: quilt-2.6/drivers/s390/char/sclp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.h
+++ quilt-2.6/drivers/s390/char/sclp.h
@@ -72,6 +72,13 @@ typedef unsigned int sclp_cmdw_t;
 
 typedef u32 sccb_mask_t;	/* ATTENTION: assumes 32bit mask !!! */
 
+struct sccb_header {
+	u16	length;
+	u8	function_code;
+	u8	control_mask[3];
+	u16	response_code;
+} __attribute__((packed));
+
 struct gds_subvector {
 	u8	length;
 	u8	key;
Index: quilt-2.6/drivers/s390/char/sclp_info.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_info.c
+++ quilt-2.6/drivers/s390/char/sclp_info.c
@@ -11,47 +11,97 @@
 #include <asm/sclp.h>
 #include "sclp.h"
 
-struct sclp_readinfo_sccb s390_readinfo_sccb;
+struct sclp_readinfo_sccb {
+	struct	sccb_header header;	/* 0-7 */
+	u16	rnmax;			/* 8-9 */
+	u8	rnsize;			/* 10 */
+	u8	_reserved0[24 - 11];	/* 11-23 */
+	u8	loadparm[8];		/* 24-31 */
+	u8	_reserved1[48 - 32];	/* 32-47 */
+	u64	facilities;		/* 48-55 */
+	u8	_reserved2[91 - 56];	/* 56-90 */
+	u8	flags;			/* 91 */
+	u8	_reserved3[100 - 92];	/* 92-99 */
+	u32	rnsize2;		/* 100-103 */
+	u64	rnmax2;			/* 104-111 */
+	u8	_reserved4[4096 - 112];	/* 112-4095 */
+} __attribute__((packed, aligned(4096)));
+
+static struct sclp_readinfo_sccb __initdata early_readinfo_sccb;
+static int __initdata early_readinfo_sccb_valid;
 
 void __init sclp_readinfo_early(void)
 {
-	sclp_cmdw_t command;
-	struct sccb_header *sccb;
 	int ret;
+	int i;
+	struct sclp_readinfo_sccb *sccb;
+	sclp_cmdw_t commands[] = {SCLP_CMDW_READ_SCP_INFO_FORCED,
+				  SCLP_CMDW_READ_SCP_INFO};
+
+	/* Enable service signal subclass mask. */
+	__ctl_set_bit(0, 9);
+	sccb = &early_readinfo_sccb;
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		do {
+			memset(sccb, 0, sizeof(*sccb));
+			sccb->header.length = sizeof(*sccb);
+			sccb->header.control_mask[2] = 0x80;
+			ret = sclp_service_call(commands[i], sccb);
+		} while (ret == -EBUSY);
 
-	__ctl_set_bit(0, 9); /* enable service signal subclass mask */
-
-	sccb = &s390_readinfo_sccb.header;
-	command = SCLP_CMDW_READ_SCP_INFO_FORCED;
-	while (1) {
-		u16 response;
-
-		memset(&s390_readinfo_sccb, 0, sizeof(s390_readinfo_sccb));
-		sccb->length = sizeof(s390_readinfo_sccb);
-		sccb->control_mask[2] = 0x80;
-
-		ret = sclp_service_call(command, &s390_readinfo_sccb);
-
-		if (ret == -EIO)
-			goto out;
-		if (ret == -EBUSY)
-			continue;
-
+		if (ret)
+			break;
 		__load_psw_mask(PSW_BASE_BITS | PSW_MASK_EXT |
 				PSW_MASK_WAIT | PSW_DEFAULT_KEY);
 		local_irq_disable();
+		/*
+		 * Contents of the sccb might have changed
+		 * therefore a barrier is needed.
+		 */
 		barrier();
+		if (sccb->header.response_code == 0x10) {
+			early_readinfo_sccb_valid = 1;
+			break;
+		}
+		if (sccb->header.response_code != 0x1f0)
+			break;
+	}
+	/* Disable service signal subclass mask again. */
+	__ctl_clear_bit(0, 9);
+}
 
-		response = sccb->response_code;
+unsigned long long __init sclp_memory_detect(void)
+{
+	unsigned long long memsize;
+	struct sclp_readinfo_sccb *sccb;
 
-		if (response == 0x10)
-			break;
+	if (!early_readinfo_sccb_valid)
+		return 0;
+	sccb = &early_readinfo_sccb;
+	if (sccb->rnsize)
+		memsize = sccb->rnsize << 20;
+	else
+		memsize = sccb->rnsize2 << 20;
+	if (sccb->rnmax)
+		memsize *= sccb->rnmax;
+	else
+		memsize *= sccb->rnmax2;
+	return memsize;
+}
 
-		if (response != 0x1f0 || command == SCLP_CMDW_READ_SCP_INFO)
-			break;
+/*
+ * This function will be called after sclp_memory_detect(), which gets called
+ * early from early.c code. Therefore the sccb should have valid contents.
+ */
+void __init sclp_get_ipl_info(struct sclp_ipl_info *info)
+{
+	struct sclp_readinfo_sccb *sccb;
 
-		command = SCLP_CMDW_READ_SCP_INFO;
-	}
-out:
-	__ctl_clear_bit(0, 9); /* disable service signal subclass mask */
+	if (!early_readinfo_sccb_valid)
+		return;
+	sccb = &early_readinfo_sccb;
+	info->is_valid = 1;
+	if (sccb->flags & 0x2)
+		info->has_dump = 1;
+	memcpy(&info->loadparm, &sccb->loadparm, LOADPARM_LEN);
 }
Index: quilt-2.6/include/asm-s390/sclp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/sclp.h
+++ quilt-2.6/include/asm-s390/sclp.h
@@ -11,29 +11,6 @@
 #include <linux/types.h>
 #include <asm/chpid.h>
 
-struct sccb_header {
-	u16	length;
-	u8	function_code;
-	u8	control_mask[3];
-	u16	response_code;
-} __attribute__((packed));
-
-#define LOADPARM_LEN 8
-
-struct sclp_readinfo_sccb {
-	struct	sccb_header header;	/* 0-7 */
-	u16	rnmax;			/* 8-9 */
-	u8	rnsize;			/* 10 */
-	u8	_reserved0[24 - 11];	/* 11-23 */
-	u8	loadparm[LOADPARM_LEN];	/* 24-31 */
-	u8	_reserved1[91 - 32];	/* 32-90 */
-	u8	flags;			/* 91 */
-	u8	_reserved2[100 - 92];	/* 92-99 */
-	u32	rnsize2;		/* 100-103 */
-	u64	rnmax2;			/* 104-111 */
-	u8	_reserved3[4096 - 112];	/* 112-4095 */
-} __attribute__((packed, aligned(4096)));
-
 #define SCLP_CHP_INFO_MASK_SIZE		32
 
 struct sclp_chp_info {
@@ -42,12 +19,21 @@ struct sclp_chp_info {
 	u8 configured[SCLP_CHP_INFO_MASK_SIZE];
 };
 
-extern struct sclp_readinfo_sccb s390_readinfo_sccb;
-extern void sclp_readinfo_early(void);
-extern int sclp_sdias_blk_count(void);
-extern int sclp_sdias_copy(void *dest, int blk_num, int nr_blks);
-extern int sclp_chp_configure(struct chp_id chpid);
-extern int sclp_chp_deconfigure(struct chp_id chpid);
-extern int sclp_chp_read_info(struct sclp_chp_info *info);
+#define LOADPARM_LEN 8
+
+struct sclp_ipl_info {
+	int is_valid;
+	int has_dump;
+	char loadparm[LOADPARM_LEN];
+};
+
+void sclp_readinfo_early(void);
+unsigned long long sclp_memory_detect(void);
+int sclp_sdias_blk_count(void);
+int sclp_sdias_copy(void *dest, int blk_num, int nr_blks);
+int sclp_chp_configure(struct chp_id chpid);
+int sclp_chp_deconfigure(struct chp_id chpid);
+int sclp_chp_read_info(struct sclp_chp_info *info);
+void sclp_get_ipl_info(struct sclp_ipl_info *info);
 
 #endif /* _ASM_S390_SCLP_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
