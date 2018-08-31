From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 31 Aug 2018 16:51:17 +0000
Subject: [PATCH 1/3] s390/setup: set control program code via diag 318
Message-Id: <1535734279-10204-2-git-send-email-walling@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The s390x diagnose 318 instruction sets the control program name code (CPNC)
and control program version code (CPVC) to provide usefu information regarding
the OS during debugging. The CPNC is explicitly set to 4 to indicate a Linux/KVM
environment.

The CPVC is a 7-byte value containing:

 - 3-byte Linux version code
 - 3-byte distribution identifier set in the config file
 - 1-byte null

The distro ID is set by the Kconfig option "Distribution Identifier" under the
"Processors Type and Features" section.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Kconfig              |  8 ++++++++
 arch/s390/include/asm/diag.h   | 12 ++++++++++++
 arch/s390/include/asm/sclp.h   |  1 +
 arch/s390/kernel/diag.c        |  1 +
 arch/s390/kernel/setup.c       | 23 +++++++++++++++++++++++
 drivers/s390/char/sclp_early.c |  6 +++++-
 6 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9a9c7a6..ca7fbd0fc 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -595,6 +595,14 @@ config EXPOLINE_FULL
 
 endchoice
 
+config DISTRO_ID
+	string "Distribution Identifier"
+	help
+	  This option sets a unique distribution identifier for this kernel build
+	  that will assist with internal problem diagnosis for IBM Z.
+
+	  Only the first three characters of this string will be utilized.
+
 endmenu
 
 menu "Memory setup"
diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index cdbaad5..19562be 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -32,6 +32,7 @@ enum diag_stat_enum {
 	DIAG_STAT_X2FC,
 	DIAG_STAT_X304,
 	DIAG_STAT_X308,
+	DIAG_STAT_X318,
 	DIAG_STAT_X500,
 	NR_DIAG_STAT
 };
@@ -293,6 +294,17 @@ struct diag26c_mac_resp {
 	u8	res[2];
 } __aligned(8);
 
+#define CPNC_LINUX		0x4
+union diag318_info {
+	unsigned long val;
+	struct {
+		unsigned int cpnc : 8;
+		unsigned int cpvc_linux : 24;
+		unsigned char cpvc_distro[3];
+		unsigned char zero;
+	};
+};
+
 int diag204(unsigned long subcode, unsigned long size, void *addr);
 int diag224(void *ptr);
 int diag26c(void *req, void *resp, enum diag26c_sc subcode);
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 3cae916..a1f413a 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -78,6 +78,7 @@ struct sclp_info {
 	unsigned char has_skey : 1;
 	unsigned char has_kss : 1;
 	unsigned char has_gisaf : 1;
+	unsigned char has_diag318 : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index 53a5316..06a063d 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -45,6 +45,7 @@ static const struct diag_desc diag_map[NR_DIAG_STAT] = {
 	[DIAG_STAT_X2FC] = { .code = 0x2fc, .name = "Guest Performance Data" },
 	[DIAG_STAT_X304] = { .code = 0x304, .name = "Partition-Resource Service" },
 	[DIAG_STAT_X308] = { .code = 0x308, .name = "List-Directed IPL" },
+	[DIAG_STAT_X318] = { .code = 0x318, .name = "Set CP Name and Version Codes" },
 	[DIAG_STAT_X500] = { .code = 0x500, .name = "Virtio Service" },
 };
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index c637c12..2535175 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -49,6 +49,7 @@
 #include <linux/crash_dump.h>
 #include <linux/memory.h>
 #include <linux/compat.h>
+#include <linux/version.h>
 
 #include <asm/ipl.h>
 #include <asm/facility.h>
@@ -866,6 +867,27 @@ static void __init setup_task_size(void)
 }
 
 /*
+ * Issue diagnose 318 to set the control program name and
+ * version codes.
+ */
+static void __init setup_control_program_code(void)
+{
+	union diag318_info diag318_info = {
+		.cpnc = CPNC_LINUX,
+		.cpvc_linux = LINUX_VERSION_CODE,
+		.cpvc_distro = CONFIG_DISTRO_ID,
+	};
+
+	BUILD_BUG_ON(sizeof(CONFIG_DISTRO_ID) - 1 > sizeof(diag318_info.cpvc_distro));
+
+	if (!sclp.has_diag318)
+		return;
+
+	diag_stat_inc(DIAG_STAT_X318);
+	asm volatile("diag %0,0,0x318\n" : : "d" (diag318_info.val));
+}
+
+/*
  * Setup function called from init/main.c just after the banner
  * was printed.
  */
@@ -907,6 +929,7 @@ void __init setup_arch(char **cmdline_p)
 	os_info_init();
 	setup_ipl();
 	setup_task_size();
+	setup_control_program_code();
 
 	/* Do some memory reservations *before* memory is added to memblock */
 	reserve_memory_end();
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 9a74abb..6e657e6 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -54,7 +54,9 @@ struct read_info_sccb {
 	u16	hcpua;			/* 120-121 */
 	u8	_pad_122[124 - 122];	/* 122-123 */
 	u32	hmfai;			/* 124-127 */
-	u8	_pad_128[4096 - 128];	/* 128-4095 */
+	u8	_pad_128[134 - 128];	/* 128-133 */
+	u8	fac134;			/* 134 */
+	u8	_pad_135[4096 - 135];	/* 135-4095 */
 } __packed __aligned(PAGE_SIZE);
 
 static struct sclp_ipl_info sclp_ipl_info;
@@ -107,6 +109,8 @@ static void __init sclp_early_facilities_detect(struct read_info_sccb *sccb)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
 	if (sccb->fac91 & 0x40)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_TLB_GUEST;
+	if (sccb->cpuoff > 134)
+		sclp.has_diag318 = !!(sccb->fac134 & 0x80);
 	sclp.rnmax = sccb->rnmax ? sccb->rnmax : sccb->rnmax2;
 	sclp.rzm = sccb->rnsize ? sccb->rnsize : sccb->rnsize2;
 	sclp.rzm <<= 20;
-- 
2.7.4
