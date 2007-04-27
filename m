Return-Path: <linux-kernel-owner+w=401wt.eu-S1755946AbXD0OLZ@vger.kernel.org>
Message-Id: <20070427140517.942703832@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 26/38] zfcpdump support.
Content-Disposition: inline; filename=129-zfcp-dump.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

s390 machines provide hardware support for creating Linux dumps on SCSI
disks. For creating a dump a special purpose dump Linux is used. The first
32 MB of memory are saved by the hardware before the dump Linux is
booted. Via an SCLP interface, the saved memory can be accessed from
Linux. This patch exports memory and registers of the crashed Linux to
userspace via a debugfs file. For more information refer to
Documentation/s390/zfcpdump.txt, which is included in this patch.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 Documentation/s390/zfcpdump.txt |   87 +++++
 arch/s390/Kconfig               |    8 
 arch/s390/Makefile              |    3 
 arch/s390/defconfig             |    1 
 arch/s390/kernel/head64.S       |   72 ++++
 arch/s390/kernel/ipl.c          |  232 +++++++++-----
 arch/s390/kernel/setup.c        |   38 ++
 arch/s390/kernel/smp.c          |   62 +++
 drivers/s390/char/Makefile      |    3 
 drivers/s390/char/sclp.h        |    2 
 drivers/s390/char/sclp_sdias.c  |  255 +++++++++++++++
 drivers/s390/char/zcore.c       |  651 ++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/ipl.h          |   32 +
 include/asm-s390/lowcore.h      |   46 ++
 include/asm-s390/sclp.h         |    2 
 include/asm-s390/setup.h        |    2 
 include/asm-s390/smp.h          |    1 
 17 files changed, 1411 insertions(+), 86 deletions(-)

Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig	2007-04-27 16:04:56.000000000 +0200
+++ quilt-2.6/arch/s390/defconfig	2007-04-27 16:04:59.000000000 +0200
@@ -167,6 +167,7 @@
 CONFIG_NO_IDLE_HZ_INIT=y
 CONFIG_S390_HYPFS_FS=y
 CONFIG_KEXEC=y
+# CONFIG_ZFCPDUMP is not set
 
 #
 # Networking
Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig	2007-04-27 16:04:56.000000000 +0200
+++ quilt-2.6/arch/s390/Kconfig	2007-04-27 16:04:59.000000000 +0200
@@ -519,6 +519,14 @@
 	  current kernel, and to start another kernel.  It is like a reboot
 	  but is independent of hardware/microcode support.
 
+config ZFCPDUMP
+	tristate "zfcpdump support"
+	select SMP
+	default n
+	help
+	  Select this option if you want to build an zfcpdump enabled kernel.
+	  Refer to "Documentation/s390/zfcpdump.txt" for more details on this.
+
 endmenu
 
 source "net/Kconfig"
Index: quilt-2.6/arch/s390/kernel/head64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head64.S	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/head64.S	2007-04-27 16:04:59.000000000 +0200
@@ -39,7 +39,69 @@
 	basr	%r13,0			# get base
 .LPG1:	sll	%r13,1			# remove high order bit
 	srl	%r13,1
-	lhi	%r1,1			# mode 1 = esame
+
+#ifdef CONFIG_ZFCPDUMP
+
+	# check if we have been ipled using zfcp dump:
+
+	tm	0xb9,0x01		# test if subchannel is enabled
+	jno	.nodump			# subchannel disabled
+	l	%r1,0xb8
+	la	%r5,.Lipl_schib-.LPG1(%r13)
+	stsch	0(%r5)			# get schib of subchannel
+	jne	.nodump			# schib not available
+	tm	5(%r5),0x01		# devno valid?
+	jno	.nodump
+	tm	4(%r5),0x80		# qdio capable device?
+	jno	.nodump
+	l	%r2,20(%r0)		# address of ipl parameter block
+	lhi	%r3,0
+	ic	%r3,0x148(%r2)		# get opt field
+	chi	%r3,0x20		# load with dump?
+	jne	.nodump
+
+	# store all prefix registers in case of load with dump:
+
+	la	%r7,0			# base register for 0 page
+	la	%r8,0			# first cpu
+	l	%r11,.Lpref_arr_ptr-.LPG1(%r13)	# address of prefix array
+	ahi	%r11,4			# skip boot cpu
+	lr	%r12,%r11
+	ahi	%r12,(CONFIG_NR_CPUS*4)	# end of prefix array
+	stap	.Lcurrent_cpu+2-.LPG1(%r13)	# store current cpu addr
+1:
+	cl	%r8,.Lcurrent_cpu-.LPG1(%r13)	# is ipl cpu ?
+	je	4f				# if yes get next cpu
+2:
+	lr	%r9,%r7
+	sigp	%r9,%r8,0x9		# stop & store status of cpu
+	brc	8,3f			# accepted
+	brc	4,4f			# status stored: next cpu
+	brc	2,2b			# busy: 	 try again
+	brc	1,4f			# not op:	 next cpu
+3:
+	mvc	0(4,%r11),264(%r7)	# copy prefix register to prefix array
+	ahi	%r11,4			# next element in prefix array
+	clr	%r11,%r12
+	je	5f			# no more space in prefix array
+4:
+	ahi	%r8,1				# next cpu (r8 += 1)
+	cl	%r8,.Llast_cpu-.LPG1(%r13)	# is last possible cpu ?
+	jl	1b				# jump if not last cpu
+5:
+	lhi	%r1,2			# mode 2 = esame (dump)
+	j	6f
+	.align 4
+.Lipl_schib:
+	.rept 13
+	.long 0
+	.endr
+.nodump:
+	lhi	%r1,1			# mode 1 = esame (normal ipl)
+6:
+#else
+	lhi	%r1,1			# mode 1 = esame (normal ipl)
+#endif /* CONFIG_ZFCPDUMP */
 	mvi	__LC_AR_MODE_ID,1	# set esame flag
 	slr	%r0,%r0 		# set cpuid to zero
 	sigp	%r1,%r0,0x12		# switch to esame mode
@@ -149,6 +211,14 @@
 .L4malign:.quad 0xffffffffffc00000
 .Lscan2g:.quad	0x80000000 + 0x20000 - 8	# 2GB + 128K - 8
 .Lnop:	.long	0x07000700
+#ifdef CONFIG_ZFCPDUMP
+.Lcurrent_cpu:
+	.long 0x0
+.Llast_cpu:
+	.long 0x0000ffff
+.Lpref_arr_ptr:
+	.long zfcpdump_prefix_array
+#endif /* CONFIG_ZFCPDUMP */
 .Lparmaddr:
 	.quad	PARMAREA
 	.align	64
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c	2007-04-27 16:04:52.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/ipl.c	2007-04-27 16:04:59.000000000 +0200
@@ -29,36 +29,21 @@
 #define SCCB_LOADPARM (&s390_readinfo_sccb.loadparm)
 #define SCCB_FLAG (s390_readinfo_sccb.flags)
 
-enum ipl_type {
-	IPL_TYPE_NONE	 = 1,
-	IPL_TYPE_UNKNOWN = 2,
-	IPL_TYPE_CCW	 = 4,
-	IPL_TYPE_FCP	 = 8,
-	IPL_TYPE_NSS	 = 16,
-};
-
-#define IPL_NONE_STR	 "none"
-#define IPL_UNKNOWN_STR  "unknown"
-#define IPL_CCW_STR	 "ccw"
-#define IPL_FCP_STR	 "fcp"
-#define IPL_NSS_STR	 "nss"
-
-/*
- * Must be in data section since the bss section
- * is not cleared when these are accessed.
- */
-static u16 ipl_devno __attribute__((__section__(".data"))) = 0;
-u32 ipl_flags __attribute__((__section__(".data"))) = 0;
+#define IPL_UNKNOWN_STR		"unknown"
+#define IPL_CCW_STR		"ccw"
+#define IPL_FCP_STR		"fcp"
+#define IPL_FCP_DUMP_STR	"fcp_dump"
+#define IPL_NSS_STR		"nss"
 
 static char *ipl_type_str(enum ipl_type type)
 {
 	switch (type) {
-	case IPL_TYPE_NONE:
-		return IPL_NONE_STR;
 	case IPL_TYPE_CCW:
 		return IPL_CCW_STR;
 	case IPL_TYPE_FCP:
 		return IPL_FCP_STR;
+	case IPL_TYPE_FCP_DUMP:
+		return IPL_FCP_DUMP_STR;
 	case IPL_TYPE_NSS:
 		return IPL_NSS_STR;
 	case IPL_TYPE_UNKNOWN:
@@ -67,15 +52,55 @@
 	}
 }
 
+enum dump_type {
+	DUMP_TYPE_NONE	= 1,
+	DUMP_TYPE_CCW	= 2,
+	DUMP_TYPE_FCP	= 4,
+};
+
+#define DUMP_NONE_STR	 "none"
+#define DUMP_CCW_STR	 "ccw"
+#define DUMP_FCP_STR	 "fcp"
+
+static char *dump_type_str(enum dump_type type)
+{
+	switch (type) {
+	case DUMP_TYPE_NONE:
+		return DUMP_NONE_STR;
+	case DUMP_TYPE_CCW:
+		return DUMP_CCW_STR;
+	case DUMP_TYPE_FCP:
+		return DUMP_FCP_STR;
+	default:
+		return NULL;
+	}
+}
+
+/*
+ * Must be in data section since the bss section
+ * is not cleared when these are accessed.
+ */
+static u16 ipl_devno __attribute__((__section__(".data"))) = 0;
+u32 ipl_flags __attribute__((__section__(".data"))) = 0;
+
 enum ipl_method {
-	IPL_METHOD_NONE,
-	IPL_METHOD_CCW_CIO,
-	IPL_METHOD_CCW_DIAG,
-	IPL_METHOD_CCW_VM,
-	IPL_METHOD_FCP_RO_DIAG,
-	IPL_METHOD_FCP_RW_DIAG,
-	IPL_METHOD_FCP_RO_VM,
-	IPL_METHOD_NSS,
+	REIPL_METHOD_CCW_CIO,
+	REIPL_METHOD_CCW_DIAG,
+	REIPL_METHOD_CCW_VM,
+	REIPL_METHOD_FCP_RO_DIAG,
+	REIPL_METHOD_FCP_RW_DIAG,
+	REIPL_METHOD_FCP_RO_VM,
+	REIPL_METHOD_FCP_DUMP,
+	REIPL_METHOD_NSS,
+	REIPL_METHOD_DEFAULT,
+};
+
+enum dump_method {
+	DUMP_METHOD_NONE,
+	DUMP_METHOD_CCW_CIO,
+	DUMP_METHOD_CCW_DIAG,
+	DUMP_METHOD_CCW_VM,
+	DUMP_METHOD_FCP_DIAG,
 };
 
 enum shutdown_action {
@@ -107,15 +132,15 @@
 static int reipl_capabilities = IPL_TYPE_UNKNOWN;
 
 static enum ipl_type reipl_type = IPL_TYPE_UNKNOWN;
-static enum ipl_method reipl_method = IPL_METHOD_NONE;
+static enum ipl_method reipl_method = REIPL_METHOD_DEFAULT;
 static struct ipl_parameter_block *reipl_block_fcp;
 static struct ipl_parameter_block *reipl_block_ccw;
 
 static char reipl_nss_name[NSS_NAME_SIZE + 1];
 
-static int dump_capabilities = IPL_TYPE_NONE;
-static enum ipl_type dump_type = IPL_TYPE_NONE;
-static enum ipl_method dump_method = IPL_METHOD_NONE;
+static int dump_capabilities = DUMP_TYPE_NONE;
+static enum dump_type dump_type = DUMP_TYPE_NONE;
+static enum dump_method dump_method = DUMP_METHOD_NONE;
 static struct ipl_parameter_block *dump_block_fcp;
 static struct ipl_parameter_block *dump_block_ccw;
 
@@ -134,6 +159,7 @@
 		: "d" (subcode) : "cc", "memory");
 	return _rc;
 }
+EXPORT_SYMBOL_GPL(diag308);
 
 /* SYSFS */
 
@@ -197,7 +223,7 @@
  * ipl section
  */
 
-static enum ipl_type ipl_get_type(void)
+static __init enum ipl_type get_ipl_type(void)
 {
 	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
 
@@ -211,12 +237,44 @@
 		return IPL_TYPE_UNKNOWN;
 	if (ipl->hdr.pbt != DIAG308_IPL_TYPE_FCP)
 		return IPL_TYPE_UNKNOWN;
+	if (ipl->ipl_info.fcp.opt == DIAG308_IPL_OPT_DUMP)
+		return IPL_TYPE_FCP_DUMP;
 	return IPL_TYPE_FCP;
 }
 
+void __init setup_ipl_info(void)
+{
+	ipl_info.type = get_ipl_type();
+	switch (ipl_info.type) {
+	case IPL_TYPE_CCW:
+		ipl_info.data.ccw.dev_id.devno = ipl_devno;
+		ipl_info.data.ccw.dev_id.ssid = 0;
+		break;
+	case IPL_TYPE_FCP:
+	case IPL_TYPE_FCP_DUMP:
+		ipl_info.data.fcp.dev_id.devno =
+			IPL_PARMBLOCK_START->ipl_info.fcp.devno;
+		ipl_info.data.fcp.dev_id.ssid = 0;
+		ipl_info.data.fcp.wwpn = IPL_PARMBLOCK_START->ipl_info.fcp.wwpn;
+		ipl_info.data.fcp.lun = IPL_PARMBLOCK_START->ipl_info.fcp.lun;
+		break;
+	case IPL_TYPE_NSS:
+		strncpy(ipl_info.data.nss.name, kernel_nss_name,
+			sizeof(ipl_info.data.nss.name));
+		break;
+	case IPL_TYPE_UNKNOWN:
+	default:
+		/* We have no info to copy */
+		break;
+	}
+}
+
+struct ipl_info ipl_info;
+EXPORT_SYMBOL_GPL(ipl_info);
+
 static ssize_t ipl_type_show(struct subsystem *subsys, char *page)
 {
-	return sprintf(page, "%s\n", ipl_type_str(ipl_get_type()));
+	return sprintf(page, "%s\n", ipl_type_str(ipl_info.type));
 }
 
 static struct subsys_attribute sys_ipl_type_attr = __ATTR_RO(ipl_type);
@@ -225,10 +283,11 @@
 {
 	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
 
-	switch (ipl_get_type()) {
+	switch (ipl_info.type) {
 	case IPL_TYPE_CCW:
 		return sprintf(page, "0.0.%04x\n", ipl_devno);
 	case IPL_TYPE_FCP:
+	case IPL_TYPE_FCP_DUMP:
 		return sprintf(page, "0.0.%04x\n", ipl->ipl_info.fcp.devno);
 	default:
 		return 0;
@@ -485,23 +544,29 @@
 	switch(type) {
 	case IPL_TYPE_CCW:
 		if (MACHINE_IS_VM)
-			reipl_method = IPL_METHOD_CCW_VM;
+			reipl_method = REIPL_METHOD_CCW_VM;
 		else
-			reipl_method = IPL_METHOD_CCW_CIO;
+			reipl_method = REIPL_METHOD_CCW_CIO;
 		break;
 	case IPL_TYPE_FCP:
 		if (diag308_set_works)
-			reipl_method = IPL_METHOD_FCP_RW_DIAG;
+			reipl_method = REIPL_METHOD_FCP_RW_DIAG;
 		else if (MACHINE_IS_VM)
-			reipl_method = IPL_METHOD_FCP_RO_VM;
+			reipl_method = REIPL_METHOD_FCP_RO_VM;
 		else
-			reipl_method = IPL_METHOD_FCP_RO_DIAG;
+			reipl_method = REIPL_METHOD_FCP_RO_DIAG;
+		break;
+	case IPL_TYPE_FCP_DUMP:
+		reipl_method = REIPL_METHOD_FCP_DUMP;
 		break;
 	case IPL_TYPE_NSS:
-		reipl_method = IPL_METHOD_NSS;
+		reipl_method = REIPL_METHOD_NSS;
+		break;
+	case IPL_TYPE_UNKNOWN:
+		reipl_method = REIPL_METHOD_DEFAULT;
 		break;
 	default:
-		reipl_method = IPL_METHOD_NONE;
+		BUG();
 	}
 	reipl_type = type;
 	return 0;
@@ -579,22 +644,22 @@
 
 /* dump type */
 
-static int dump_set_type(enum ipl_type type)
+static int dump_set_type(enum dump_type type)
 {
 	if (!(dump_capabilities & type))
 		return -EINVAL;
 	switch(type) {
-	case IPL_TYPE_CCW:
+	case DUMP_TYPE_CCW:
 		if (MACHINE_IS_VM)
-			dump_method = IPL_METHOD_CCW_VM;
+			dump_method = DUMP_METHOD_CCW_VM;
 		else
-			dump_method = IPL_METHOD_CCW_CIO;
+			dump_method = DUMP_METHOD_CCW_CIO;
 		break;
-	case IPL_TYPE_FCP:
-		dump_method = IPL_METHOD_FCP_RW_DIAG;
+	case DUMP_TYPE_FCP:
+		dump_method = DUMP_METHOD_FCP_DIAG;
 		break;
 	default:
-		dump_method = IPL_METHOD_NONE;
+		dump_method = DUMP_METHOD_NONE;
 	}
 	dump_type = type;
 	return 0;
@@ -602,7 +667,7 @@
 
 static ssize_t dump_type_show(struct subsystem *subsys, char *page)
 {
-	return sprintf(page, "%s\n", ipl_type_str(dump_type));
+	return sprintf(page, "%s\n", dump_type_str(dump_type));
 }
 
 static ssize_t dump_type_store(struct subsystem *subsys, const char *buf,
@@ -610,12 +675,12 @@
 {
 	int rc = -EINVAL;
 
-	if (strncmp(buf, IPL_NONE_STR, strlen(IPL_NONE_STR)) == 0)
-		rc = dump_set_type(IPL_TYPE_NONE);
-	else if (strncmp(buf, IPL_CCW_STR, strlen(IPL_CCW_STR)) == 0)
-		rc = dump_set_type(IPL_TYPE_CCW);
-	else if (strncmp(buf, IPL_FCP_STR, strlen(IPL_FCP_STR)) == 0)
-		rc = dump_set_type(IPL_TYPE_FCP);
+	if (strncmp(buf, DUMP_NONE_STR, strlen(DUMP_NONE_STR)) == 0)
+		rc = dump_set_type(DUMP_TYPE_NONE);
+	else if (strncmp(buf, DUMP_CCW_STR, strlen(DUMP_CCW_STR)) == 0)
+		rc = dump_set_type(DUMP_TYPE_CCW);
+	else if (strncmp(buf, DUMP_FCP_STR, strlen(DUMP_FCP_STR)) == 0)
+		rc = dump_set_type(DUMP_TYPE_FCP);
 	return (rc != 0) ? rc : len;
 }
 
@@ -664,14 +729,14 @@
 	char loadparm[LOADPARM_LEN + 1];
 
 	switch (reipl_method) {
-	case IPL_METHOD_CCW_CIO:
+	case REIPL_METHOD_CCW_CIO:
 		devid.devno = reipl_block_ccw->ipl_info.ccw.devno;
-		if (ipl_get_type() == IPL_TYPE_CCW && devid.devno == ipl_devno)
+		if (ipl_info.type == IPL_TYPE_CCW && devid.devno == ipl_devno)
 			diag308(DIAG308_IPL, NULL);
 		devid.ssid  = 0;
 		reipl_ccw_dev(&devid);
 		break;
-	case IPL_METHOD_CCW_VM:
+	case REIPL_METHOD_CCW_VM:
 		reipl_get_ascii_loadparm(loadparm);
 		if (strlen(loadparm) == 0)
 			sprintf(buf, "IPL %X",
@@ -681,30 +746,32 @@
 				reipl_block_ccw->ipl_info.ccw.devno, loadparm);
 		__cpcmd(buf, NULL, 0, NULL);
 		break;
-	case IPL_METHOD_CCW_DIAG:
+	case REIPL_METHOD_CCW_DIAG:
 		diag308(DIAG308_SET, reipl_block_ccw);
 		diag308(DIAG308_IPL, NULL);
 		break;
-	case IPL_METHOD_FCP_RW_DIAG:
+	case REIPL_METHOD_FCP_RW_DIAG:
 		diag308(DIAG308_SET, reipl_block_fcp);
 		diag308(DIAG308_IPL, NULL);
 		break;
-	case IPL_METHOD_FCP_RO_DIAG:
+	case REIPL_METHOD_FCP_RO_DIAG:
 		diag308(DIAG308_IPL, NULL);
 		break;
-	case IPL_METHOD_FCP_RO_VM:
+	case REIPL_METHOD_FCP_RO_VM:
 		__cpcmd("IPL", NULL, 0, NULL);
 		break;
-	case IPL_METHOD_NSS:
+	case REIPL_METHOD_NSS:
 		sprintf(buf, "IPL %s", reipl_nss_name);
 		__cpcmd(buf, NULL, 0, NULL);
 		break;
-	case IPL_METHOD_NONE:
-	default:
+	case REIPL_METHOD_DEFAULT:
 		if (MACHINE_IS_VM)
 			__cpcmd("IPL", NULL, 0, NULL);
 		diag308(DIAG308_IPL, NULL);
 		break;
+	case REIPL_METHOD_FCP_DUMP:
+	default:
+		break;
 	}
 	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
 }
@@ -715,28 +782,28 @@
 	static char buf[100];
 
 	switch (dump_method) {
-	case IPL_METHOD_CCW_CIO:
+	case DUMP_METHOD_CCW_CIO:
 		smp_send_stop();
 		devid.devno = dump_block_ccw->ipl_info.ccw.devno;
 		devid.ssid  = 0;
 		reipl_ccw_dev(&devid);
 		break;
-	case IPL_METHOD_CCW_VM:
+	case DUMP_METHOD_CCW_VM:
 		smp_send_stop();
 		sprintf(buf, "STORE STATUS");
 		__cpcmd(buf, NULL, 0, NULL);
 		sprintf(buf, "IPL %X", dump_block_ccw->ipl_info.ccw.devno);
 		__cpcmd(buf, NULL, 0, NULL);
 		break;
-	case IPL_METHOD_CCW_DIAG:
+	case DUMP_METHOD_CCW_DIAG:
 		diag308(DIAG308_SET, dump_block_ccw);
 		diag308(DIAG308_DUMP, NULL);
 		break;
-	case IPL_METHOD_FCP_RW_DIAG:
+	case DUMP_METHOD_FCP_DIAG:
 		diag308(DIAG308_SET, dump_block_fcp);
 		diag308(DIAG308_DUMP, NULL);
 		break;
-	case IPL_METHOD_NONE:
+	case DUMP_METHOD_NONE:
 	default:
 		return;
 	}
@@ -777,12 +844,13 @@
 	rc = firmware_register(&ipl_subsys);
 	if (rc)
 		return rc;
-	switch (ipl_get_type()) {
+	switch (ipl_info.type) {
 	case IPL_TYPE_CCW:
 		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
 					&ipl_ccw_attr_group);
 		break;
 	case IPL_TYPE_FCP:
+	case IPL_TYPE_FCP_DUMP:
 		rc = ipl_register_fcp_files();
 		break;
 	case IPL_TYPE_NSS:
@@ -852,7 +920,7 @@
 	/* FIXME: check for diag308_set_works when enabling diag ccw reipl */
 	if (!MACHINE_IS_VM)
 		sys_reipl_ccw_loadparm_attr.attr.mode = S_IRUGO;
-	if (ipl_get_type() == IPL_TYPE_CCW)
+	if (ipl_info.type == IPL_TYPE_CCW)
 		reipl_block_ccw->ipl_info.ccw.devno = ipl_devno;
 	reipl_capabilities |= IPL_TYPE_CCW;
 	return 0;
@@ -862,9 +930,9 @@
 {
 	int rc;
 
-	if ((!diag308_set_works) && (ipl_get_type() != IPL_TYPE_FCP))
+	if ((!diag308_set_works) && (ipl_info.type != IPL_TYPE_FCP))
 		return 0;
-	if ((!diag308_set_works) && (ipl_get_type() == IPL_TYPE_FCP))
+	if ((!diag308_set_works) && (ipl_info.type == IPL_TYPE_FCP))
 		make_attrs_ro(reipl_fcp_attrs);
 
 	reipl_block_fcp = (void *) get_zeroed_page(GFP_KERNEL);
@@ -875,7 +943,7 @@
 		free_page((unsigned long)reipl_block_fcp);
 		return rc;
 	}
-	if (ipl_get_type() == IPL_TYPE_FCP) {
+	if (ipl_info.type == IPL_TYPE_FCP) {
 		memcpy(reipl_block_fcp, IPL_PARMBLOCK_START, PAGE_SIZE);
 	} else {
 		reipl_block_fcp->hdr.len = IPL_PARM_BLK_FCP_LEN;
@@ -909,7 +977,7 @@
 	rc = reipl_nss_init();
 	if (rc)
 		return rc;
-	rc = reipl_set_type(ipl_get_type());
+	rc = reipl_set_type(ipl_info.type);
 	if (rc)
 		return rc;
 	return 0;
@@ -931,7 +999,7 @@
 	dump_block_ccw->hdr.version = IPL_PARM_BLOCK_VERSION;
 	dump_block_ccw->hdr.blk0_len = IPL_PARM_BLK0_CCW_LEN;
 	dump_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
-	dump_capabilities |= IPL_TYPE_CCW;
+	dump_capabilities |= DUMP_TYPE_CCW;
 	return 0;
 }
 
@@ -956,7 +1024,7 @@
 	dump_block_fcp->hdr.blk0_len = IPL_PARM_BLK0_FCP_LEN;
 	dump_block_fcp->hdr.pbt = DIAG308_IPL_TYPE_FCP;
 	dump_block_fcp->ipl_info.fcp.opt = DIAG308_IPL_OPT_DUMP;
-	dump_capabilities |= IPL_TYPE_FCP;
+	dump_capabilities |= DUMP_TYPE_FCP;
 	return 0;
 }
 
@@ -995,7 +1063,7 @@
 	rc = dump_fcp_init();
 	if (rc)
 		return rc;
-	dump_set_type(IPL_TYPE_NONE);
+	dump_set_type(DUMP_TYPE_NONE);
 	return 0;
 }
 
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/setup.c	2007-04-27 16:04:59.000000000 +0200
@@ -285,6 +285,26 @@
 	}
 }
 
+#if defined(CONFIG_ZFCPDUMP) || defined(CONFIG_ZFCPDUMP_MODULE)
+static void __init setup_zfcpdump(unsigned int console_devno)
+{
+	static char str[64];
+
+	if (ipl_info.type != IPL_TYPE_FCP_DUMP)
+		return;
+	if (console_devno != -1)
+		sprintf(str, "cio_ignore=all,!0.0.%04x,!0.0.%04x",
+			ipl_info.data.fcp.dev_id.devno, console_devno);
+	else
+		sprintf(str, "cio_ignore=all,!0.0.%04x",
+			ipl_info.data.fcp.dev_id.devno);
+	strcat(COMMAND_LINE, str);
+	console_loglevel = 2;
+}
+#else
+static inline void setup_zfcpdump(unsigned int console_devno) {}
+#endif /* CONFIG_ZFCPDUMP */
+
 #ifdef CONFIG_SMP
 void (*_machine_restart)(char *command) = machine_restart_smp;
 void (*_machine_halt)(void) = machine_halt_smp;
@@ -586,13 +606,20 @@
 	}
 }
 
+unsigned long real_memory_size;
+EXPORT_SYMBOL_GPL(real_memory_size);
+
 static void __init setup_memory_end(void)
 {
-	unsigned long real_size, memory_size;
+	unsigned long memory_size;
 	unsigned long max_mem, max_phys;
 	int i;
 
-	memory_size = real_size = 0;
+#if defined(CONFIG_ZFCPDUMP) || defined(CONFIG_ZFCPDUMP_MODULE)
+	if (ipl_info.type == IPL_TYPE_FCP_DUMP)
+		memory_end = ZFCPDUMP_HSA_SIZE;
+#endif
+	memory_size = 0;
 	max_phys = VMALLOC_END_INIT - VMALLOC_MIN_SIZE;
 	memory_end &= PAGE_MASK;
 
@@ -601,7 +628,8 @@
 	for (i = 0; i < MEMORY_CHUNKS; i++) {
 		struct mem_chunk *chunk = &memory_chunk[i];
 
-		real_size = max(real_size, chunk->addr + chunk->size);
+		real_memory_size = max(real_memory_size,
+				       chunk->addr + chunk->size);
 		if (chunk->addr >= max_mem) {
 			memset(chunk, 0, sizeof(*chunk));
 			continue;
@@ -765,6 +793,7 @@
 
 	parse_early_param();
 
+	setup_ipl_info();
 	setup_memory_end();
 	setup_addressing_mode();
 	setup_memory();
@@ -782,6 +811,9 @@
 
         /* Setup default console */
 	conmode_default();
+
+	/* Setup zfcpdump support */
+	setup_zfcpdump(console_devno);
 }
 
 void print_cpu_info(struct cpuinfo_S390 *cpuinfo)
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/smp.c	2007-04-27 16:04:59.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/timex.h>
+#include <linux/bootmem.h>
 #include <asm/ipl.h>
 #include <asm/setup.h>
 #include <asm/sigp.h>
@@ -40,6 +41,7 @@
 #include <asm/cpcmd.h>
 #include <asm/tlbflush.h>
 #include <asm/timer.h>
+#include <asm/lowcore.h>
 
 extern volatile int __cpu_logical_map[];
 
@@ -395,6 +397,65 @@
 	on_each_cpu(smp_ctl_bit_callback, &parms, 0, 1);
 }
 
+#if defined(CONFIG_ZFCPDUMP) || defined(CONFIG_ZFCPDUMP_MODULE)
+
+/*
+ * zfcpdump_prefix_array holds prefix registers for the following scenario:
+ * 64 bit zfcpdump kernel and 31 bit kernel which is to be dumped. We have to
+ * save its prefix registers, since they get lost, when switching from 31 bit
+ * to 64 bit.
+ */
+unsigned int zfcpdump_prefix_array[NR_CPUS + 1] \
+	__attribute__((__section__(".data")));
+
+static void __init smp_get_save_areas(void)
+{
+	unsigned int cpu, cpu_num, rc;
+	__u16 boot_cpu_addr;
+
+	if (ipl_info.type != IPL_TYPE_FCP_DUMP)
+		return;
+	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
+	cpu_num = 1;
+	for (cpu = 0; cpu <= 65535; cpu++) {
+		if ((u16) cpu == boot_cpu_addr)
+			continue;
+		__cpu_logical_map[1] = (__u16) cpu;
+		if (signal_processor(1, sigp_sense) == sigp_not_operational)
+			continue;
+		if (cpu_num >= NR_CPUS) {
+			printk("WARNING: Registers for cpu %i are not "
+			       "saved, since dump kernel was compiled with"
+			       "NR_CPUS=%i!\n", cpu_num, NR_CPUS);
+			continue;
+		}
+		zfcpdump_save_areas[cpu_num] =
+			alloc_bootmem(sizeof(union save_area));
+		while (1) {
+			rc = signal_processor(1, sigp_stop_and_store_status);
+			if (rc != sigp_busy)
+				break;
+			cpu_relax();
+		}
+		memcpy(zfcpdump_save_areas[cpu_num],
+		       (void *)(unsigned long) store_prefix() +
+		       SAVE_AREA_BASE, SAVE_AREA_SIZE);
+#ifdef __s390x__
+		/* copy original prefix register */
+		zfcpdump_save_areas[cpu_num]->s390x.pref_reg =
+			zfcpdump_prefix_array[cpu_num];
+#endif
+		cpu_num++;
+	}
+}
+
+union save_area *zfcpdump_save_areas[NR_CPUS + 1];
+EXPORT_SYMBOL_GPL(zfcpdump_save_areas);
+
+#else
+#define smp_get_save_areas() do { } while (0)
+#endif
+
 /*
  * Lets check how many CPUs we have.
  */
@@ -589,6 +650,7 @@
 {
 	unsigned int phy_cpus, pos_cpus, cpu;
 
+	smp_get_save_areas();
 	phy_cpus = smp_count_cpus();
 	pos_cpus = min(phy_cpus + additional_cpus, (unsigned int) NR_CPUS);
 
Index: quilt-2.6/arch/s390/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/Makefile	2007-04-27 16:04:58.000000000 +0200
+++ quilt-2.6/arch/s390/Makefile	2007-04-27 16:04:59.000000000 +0200
@@ -105,6 +105,9 @@
 image: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+zfcpdump:
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
Index: quilt-2.6/Documentation/s390/zfcpdump.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/Documentation/s390/zfcpdump.txt	2007-04-27 16:04:59.000000000 +0200
@@ -0,0 +1,87 @@
+s390 SCSI dump tool (zfcpdump)
+
+System z machines (z900 or higher) provide hardware support for creating system
+dumps on SCSI disks. The dump process is initiated by booting a dump tool, which
+has to create a dump of the current (probably crashed) Linux image. In order to
+not overwrite memory of the crashed Linux with data of the dump tool, the
+hardware saves some memory plus the register sets of the boot cpu before the
+dump tool is loaded. There exists an SCLP hardware interface to obtain the saved
+memory afterwards. Currently 32 MB are saved.
+
+This zfcpdump implementation consists of a Linux dump kernel together with
+a userspace dump tool, which are loaded together into the saved memory region
+below 32 MB. zfcpdump is installed on a SCSI disk using zipl (as contained in
+the s390-tools package) to make the device bootable. The operator of a Linux
+system can then trigger a SCSI dump by booting the SCSI disk, where zfcpdump
+resides on.
+
+The kernel part of zfcpdump is implemented as a debugfs file under "zcore/mem",
+which exports memory and registers of the crashed Linux in an s390
+standalone dump format. It can be used in the same way as e.g. /dev/mem. The
+dump format defines a 4K header followed by plain uncompressed memory. The
+register sets are stored in the prefix pages of the respective cpus. To build a
+dump enabled kernel with the zcore driver, the kernel config option
+CONFIG_ZFCPDUMP has to be set. When reading from "zcore/mem", the part of
+memory, which has been saved by hardware is read by the driver via the SCLP
+hardware interface. The second part is just copied from the non overwritten real
+memory.
+
+The userspace application of zfcpdump can reside e.g. in an intitramfs or an
+initrd. It reads from zcore/mem and writes the system dump to a file on a
+SCSI disk.
+
+To build a zfcpdump kernel use the following settings in your kernel
+configuration:
+ * CONFIG_ZFCPDUMP=y
+ * Enable ZFCP driver
+ * Enable SCSI driver
+ * Enable ext2 and ext3 filesystems
+ * Disable as many features as possible to keep the kernel small.
+   E.g. network support is not needed at all.
+
+To use the zfcpdump userspace application in an initramfs you have to do the
+following:
+
+ * Copy the zfcpdump executable somewhere into your Linux tree.
+   E.g. to "arch/s390/boot/zfcpdump. If you do not want to include
+   shared libraries, compile the tool with the "-static" gcc option.
+ * If you want to include e2fsck, add it to your source tree, too. The zfcpdump
+   application attempts to start /sbin/e2fsck from the ramdisk.
+ * Use an initramfs config file like the following:
+
+   dir /dev 755 0 0
+   nod /dev/console 644 0 0 c 5 1
+   nod /dev/null 644 0 0 c 1 3
+   nod /dev/sda1 644 0 0 b 8 1
+   nod /dev/sda2 644 0 0 b 8 2
+   nod /dev/sda3 644 0 0 b 8 3
+   nod /dev/sda4 644 0 0 b 8 4
+   nod /dev/sda5 644 0 0 b 8 5
+   nod /dev/sda6 644 0 0 b 8 6
+   nod /dev/sda7 644 0 0 b 8 7
+   nod /dev/sda8 644 0 0 b 8 8
+   nod /dev/sda9 644 0 0 b 8 9
+   nod /dev/sda10 644 0 0 b 8 10
+   nod /dev/sda11 644 0 0 b 8 11
+   nod /dev/sda12 644 0 0 b 8 12
+   nod /dev/sda13 644 0 0 b 8 13
+   nod /dev/sda14 644 0 0 b 8 14
+   nod /dev/sda15 644 0 0 b 8 15
+   file /init arch/s390/boot/zfcpdump 755 0 0
+   file /sbin/e2fsck arch/s390/boot/e2fsck 755 0 0
+   dir /proc 755 0 0
+   dir /sys 755 0 0
+   dir /mnt 755 0 0
+   dir /sbin 755 0 0
+
+ * Issue "make image" to build the zfcpdump image with initramfs.
+
+In a Linux distribution the zfcpdump enabled kernel image must be copied to
+/usr/share/zfcpdump/zfcpdump.image, where the s390 zipl tool is looking for the
+dump kernel when preparing a SCSI dump disk.
+
+If you use a ramdisk copy it to "/usr/share/zfcpdump/zfcpdump.rd".
+
+For more information on how to use zfcpdump refer to the s390 'Using the Dump
+Tools book', which is available from
+http://www.ibm.com/developerworks/linux/linux390.
Index: quilt-2.6/drivers/s390/char/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/char/Makefile	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/drivers/s390/char/Makefile	2007-04-27 16:04:59.000000000 +0200
@@ -29,3 +29,6 @@
 obj-$(CONFIG_S390_TAPE_3590) += tape_3590.o
 obj-$(CONFIG_MONREADER) += monreader.o
 obj-$(CONFIG_MONWRITER) += monwriter.o
+
+zcore_mod-objs := sclp_sdias.o zcore.o
+obj-$(CONFIG_ZFCPDUMP) += zcore_mod.o
Index: quilt-2.6/drivers/s390/char/sclp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp.h	2007-04-27 16:04:59.000000000 +0200
@@ -27,6 +27,7 @@
 #define EvTyp_CntlProgIdent	0x0B
 #define EvTyp_SigQuiesce	0x1D
 #define EvTyp_VT220Msg		0x1A
+#define EvTyp_SDIAS		0x1C
 
 #define EvTyp_OpCmd_Mask	0x80000000
 #define EvTyp_Msg_Mask		0x40000000
@@ -36,6 +37,7 @@
 #define EvTyp_CtlProgIdent_Mask	0x00200000
 #define EvTyp_SigQuiesce_Mask	0x00000008
 #define EvTyp_VT220Msg_Mask	0x00000040
+#define EvTyp_SDIAS_Mask	0x00000010
 
 #define GnrlMsgFlgs_DOM		0x8000
 #define GnrlMsgFlgs_SndAlrm	0x4000
Index: quilt-2.6/drivers/s390/char/sclp_sdias.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/drivers/s390/char/sclp_sdias.c	2007-04-27 16:04:59.000000000 +0200
@@ -0,0 +1,255 @@
+/*
+ * Sclp "store data in absolut storage"
+ *
+ * Copyright IBM Corp. 2003,2007
+ * Author(s): Michael Holzheu
+ */
+
+#include <linux/sched.h>
+#include <asm/sclp.h>
+#include <asm/debug.h>
+#include <asm/ipl.h>
+#include "sclp.h"
+#include "sclp_rw.h"
+
+#define TRACE(x...) debug_sprintf_event(sdias_dbf, 1, x)
+#define ERROR_MSG(x...) printk ( KERN_ALERT "SDIAS: " x )
+
+#define SDIAS_RETRIES 300
+#define SDIAS_SLEEP_TICKS 50
+
+#define EQ_STORE_DATA	0x0
+#define EQ_SIZE		0x1
+#define DI_FCP_DUMP	0x0
+#define ASA_SIZE_32	0x0
+#define ASA_SIZE_64	0x1
+#define EVSTATE_ALL_STORED	0x0
+#define EVSTATE_NO_DATA		0x3
+#define EVSTATE_PART_STORED	0x10
+
+static struct debug_info *sdias_dbf;
+
+static struct sclp_register sclp_sdias_register = {
+	.send_mask = EvTyp_SDIAS_Mask,
+};
+
+struct sdias_evbuf {
+	struct	evbuf_header hdr;
+	u8	event_qual;
+	u8	data_id;
+	u64	reserved2;
+	u32	event_id;
+	u16	reserved3;
+	u8	asa_size;
+	u8	event_status;
+	u32	reserved4;
+	u32	blk_cnt;
+	u64	asa;
+	u32	reserved5;
+	u32	fbn;
+	u32	reserved6;
+	u32	lbn;
+	u16	reserved7;
+	u16	dbs;
+} __attribute__((packed));
+
+struct sdias_sccb {
+	struct sccb_header  hdr;
+	struct sdias_evbuf  evbuf;
+} __attribute__((packed));
+
+static struct sdias_sccb sccb __attribute__((aligned(4096)));
+
+static int sclp_req_done;
+static wait_queue_head_t sdias_wq;
+static DEFINE_MUTEX(sdias_mutex);
+
+static void sdias_callback(struct sclp_req *request, void *data)
+{
+	struct sdias_sccb *sccb;
+
+	sccb = (struct sdias_sccb *) request->sccb;
+	sclp_req_done = 1;
+	wake_up(&sdias_wq); /* Inform caller, that request is complete */
+	TRACE("callback done\n");
+}
+
+static int sdias_sclp_send(struct sclp_req *req)
+{
+	int retries;
+	int rc;
+
+	for (retries = SDIAS_RETRIES; retries; retries--) {
+		sclp_req_done = 0;
+		TRACE("add request\n");
+		rc = sclp_add_request(req);
+		if (rc) {
+			/* not initiated, wait some time and retry */
+			set_current_state(TASK_INTERRUPTIBLE);
+			TRACE("add request failed: rc = %i\n",rc);
+			schedule_timeout(SDIAS_SLEEP_TICKS);
+			continue;
+		}
+		/* initiated, wait for completion of service call */
+		wait_event(sdias_wq, (sclp_req_done == 1));
+		if (req->status == SCLP_REQ_FAILED) {
+			TRACE("sclp request failed\n");
+			rc = -EIO;
+			continue;
+		}
+		TRACE("request done\n");
+		break;
+	}
+	return rc;
+}
+
+/*
+ * Get number of blocks (4K) available in the HSA
+ */
+int sclp_sdias_blk_count(void)
+{
+	struct sclp_req request;
+	int rc;
+
+	mutex_lock(&sdias_mutex);
+
+	memset(&sccb, 0, sizeof(sccb));
+	memset(&request, 0, sizeof(request));
+
+	sccb.hdr.length = sizeof(sccb);
+	sccb.evbuf.hdr.length = sizeof(struct sdias_evbuf);
+	sccb.evbuf.hdr.type = EvTyp_SDIAS;
+	sccb.evbuf.event_qual = EQ_SIZE;
+	sccb.evbuf.data_id = DI_FCP_DUMP;
+	sccb.evbuf.event_id = 4712;
+	sccb.evbuf.dbs = 1;
+
+	request.sccb = &sccb;
+	request.command = SCLP_CMDW_WRITE_EVENT_DATA;
+	request.status = SCLP_REQ_FILLED;
+	request.callback = sdias_callback;
+
+	rc = sdias_sclp_send(&request);
+	if (rc) {
+		ERROR_MSG("sclp_send failed for get_nr_blocks\n");
+		goto out;
+	}
+	if (sccb.hdr.response_code != 0x0020) {
+		TRACE("send failed: %x\n", sccb.hdr.response_code);
+		rc = -EIO;
+		goto out;
+	}
+
+	switch (sccb.evbuf.event_status) {
+		case 0:
+			rc = sccb.evbuf.blk_cnt;
+			break;
+		default:
+			ERROR_MSG("SCLP error: %x\n", sccb.evbuf.event_status);
+			rc = -EIO;
+			goto out;
+	}
+	TRACE("%i blocks\n", rc);
+out:
+	mutex_unlock(&sdias_mutex);
+	return rc;
+}
+
+/*
+ * Copy from HSA to absolute storage (not reentrant):
+ *
+ * @dest     : Address of buffer where data should be copied
+ * @start_blk: Start Block (beginning with 1)
+ * @nr_blks  : Number of 4K blocks to copy
+ *
+ * Return Value: 0 : Requested 'number' of blocks of data copied
+ *		 <0: ERROR - negative event status
+ */
+int sclp_sdias_copy(void *dest, int start_blk, int nr_blks)
+{
+	struct sclp_req request;
+	int rc;
+
+	mutex_lock(&sdias_mutex);
+
+	memset(&sccb, 0, sizeof(sccb));
+	memset(&request, 0, sizeof(request));
+
+	sccb.hdr.length = sizeof(sccb);
+	sccb.evbuf.hdr.length = sizeof(struct sdias_evbuf);
+	sccb.evbuf.hdr.type = EvTyp_SDIAS;
+	sccb.evbuf.hdr.flags = 0;
+	sccb.evbuf.event_qual = EQ_STORE_DATA;
+	sccb.evbuf.data_id = DI_FCP_DUMP;
+	sccb.evbuf.event_id = 4712;
+#ifdef __s390x__
+	sccb.evbuf.asa_size = ASA_SIZE_64;
+#else
+	sccb.evbuf.asa_size = ASA_SIZE_32;
+#endif
+	sccb.evbuf.event_status = 0;
+	sccb.evbuf.blk_cnt = nr_blks;
+	sccb.evbuf.asa = (unsigned long)dest;
+	sccb.evbuf.fbn = start_blk;
+	sccb.evbuf.lbn = 0;
+	sccb.evbuf.dbs = 1;
+
+	request.sccb	 = &sccb;
+	request.command  = SCLP_CMDW_WRITE_EVENT_DATA;
+	request.status	 = SCLP_REQ_FILLED;
+	request.callback = sdias_callback;
+
+	rc = sdias_sclp_send(&request);
+	if (rc) {
+		ERROR_MSG("sclp_send failed: %x\n", rc);
+		goto out;
+	}
+	if (sccb.hdr.response_code != 0x0020) {
+		TRACE("copy failed: %x\n", sccb.hdr.response_code);
+		rc = -EIO;
+		goto out;
+	}
+
+	switch (sccb.evbuf.event_status) {
+		case EVSTATE_ALL_STORED:
+			TRACE("all stored\n");
+		case EVSTATE_PART_STORED:
+			TRACE("part stored: %i\n", sccb.evbuf.blk_cnt);
+			break;
+		case EVSTATE_NO_DATA:
+			TRACE("no data\n");
+		default:
+			ERROR_MSG("Error from SCLP while copying hsa. "
+				  "Event status = %x\n",
+				sccb.evbuf.event_status);
+			rc = -EIO;
+	}
+out:
+	mutex_unlock(&sdias_mutex);
+	return rc;
+}
+
+int __init sdias_init(void)
+{
+	int rc;
+
+	if (ipl_info.type != IPL_TYPE_FCP_DUMP)
+		return 0;
+	sdias_dbf = debug_register("dump_sdias", 4, 1, 4 * sizeof(long));
+	debug_register_view(sdias_dbf, &debug_sprintf_view);
+	debug_set_level(sdias_dbf, 6);
+	rc = sclp_register(&sclp_sdias_register);
+	if (rc) {
+		ERROR_MSG("sclp register failed\n");
+		return rc;
+	}
+	init_waitqueue_head(&sdias_wq);
+	TRACE("init done\n");
+	return 0;
+}
+
+void __exit sdias_exit(void)
+{
+	debug_unregister(sdias_dbf);
+	sclp_unregister(&sclp_sdias_register);
+}
Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/drivers/s390/char/zcore.c	2007-04-27 16:04:59.000000000 +0200
@@ -0,0 +1,651 @@
+/*
+ * zcore module to export memory content and register sets for creating system
+ * dumps on SCSI disks (zfcpdump). The "zcore/mem" debugfs file shows the same
+ * dump format as s390 standalone dumps.
+ *
+ * For more information please refer to Documentation/s390/zfcpdump.txt
+ *
+ * Copyright IBM Corp. 2003,2007
+ * Author(s): Michael Holzheu
+ */
+
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/utsname.h>
+#include <linux/debugfs.h>
+#include <asm/ipl.h>
+#include <asm/sclp.h>
+#include <asm/setup.h>
+#include <asm/sigp.h>
+#include <asm/uaccess.h>
+#include <asm/debug.h>
+#include <asm/processor.h>
+#include <asm/irqflags.h>
+
+#define TRACE(x...) debug_sprintf_event(zcore_dbf, 1, x)
+#define MSG(x...) printk( KERN_ALERT x )
+#define ERROR_MSG(x...) printk ( KERN_ALERT "DUMP: " x )
+
+#define TO_USER		0
+#define TO_KERNEL	1
+
+enum arch_id {
+	ARCH_S390	= 0,
+	ARCH_S390X	= 1,
+};
+
+/* dump system info */
+
+struct sys_info {
+	enum arch_id	arch;
+	unsigned long	sa_base;
+	u32		sa_size;
+	int		cpu_map[NR_CPUS];
+	unsigned long	mem_size;
+	union save_area	lc_mask;
+};
+
+static struct sys_info sys_info;
+static struct debug_info *zcore_dbf;
+static int hsa_available;
+static struct dentry *zcore_dir;
+static struct dentry *zcore_file;
+
+/*
+ * Copy memory from HSA to kernel or user memory (not reentrant):
+ *
+ * @dest:  Kernel or user buffer where memory should be copied to
+ * @src:   Start address within HSA where data should be copied
+ * @count: Size of buffer, which should be copied
+ * @mode:  Either TO_KERNEL or TO_USER
+ */
+static int memcpy_hsa(void *dest, unsigned long src, size_t count, int mode)
+{
+	int offs, blk_num;
+	static char buf[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
+
+	if (count == 0)
+		return 0;
+
+	/* copy first block */
+	offs = 0;
+	if ((src % PAGE_SIZE) != 0) {
+		blk_num = src / PAGE_SIZE + 2;
+		if (sclp_sdias_copy(buf, blk_num, 1)) {
+			TRACE("sclp_sdias_copy() failed\n");
+			return -EIO;
+		}
+		offs = min((PAGE_SIZE - (src % PAGE_SIZE)), count);
+		if (mode == TO_USER) {
+			if (copy_to_user((__force __user void*) dest,
+					 buf + (src % PAGE_SIZE), offs))
+				return -EFAULT;
+		} else
+			memcpy(dest, buf + (src % PAGE_SIZE), offs);
+	}
+	if (offs == count)
+		goto out;
+
+	/* copy middle */
+	for (; (offs + PAGE_SIZE) <= count; offs += PAGE_SIZE) {
+		blk_num = (src + offs) / PAGE_SIZE + 2;
+		if (sclp_sdias_copy(buf, blk_num, 1)) {
+			TRACE("sclp_sdias_copy() failed\n");
+			return -EIO;
+		}
+		if (mode == TO_USER) {
+			if (copy_to_user((__force __user void*) dest + offs,
+					 buf, PAGE_SIZE))
+				return -EFAULT;
+		} else
+			memcpy(dest + offs, buf, PAGE_SIZE);
+	}
+	if (offs == count)
+		goto out;
+
+	/* copy last block */
+	blk_num = (src + offs) / PAGE_SIZE + 2;
+	if (sclp_sdias_copy(buf, blk_num, 1)) {
+		TRACE("sclp_sdias_copy() failed\n");
+		return -EIO;
+	}
+	if (mode == TO_USER) {
+		if (copy_to_user((__force __user void*) dest + offs, buf,
+				 PAGE_SIZE))
+			return -EFAULT;
+	} else
+		memcpy(dest + offs, buf, count - offs);
+out:
+	return 0;
+}
+
+static int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count)
+{
+	return memcpy_hsa((void __force *) dest, src, count, TO_USER);
+}
+
+static int memcpy_hsa_kernel(void *dest, unsigned long src, size_t count)
+{
+	return memcpy_hsa(dest, src, count, TO_KERNEL);
+}
+
+static int memcpy_real(void *dest, unsigned long src, size_t count)
+{
+	unsigned long flags;
+	int rc = -EFAULT;
+	register unsigned long _dest asm("2") = (unsigned long) dest;
+	register unsigned long _len1 asm("3") = (unsigned long) count;
+	register unsigned long _src  asm("4") = src;
+	register unsigned long _len2 asm("5") = (unsigned long) count;
+
+	if (count == 0)
+		return 0;
+	flags = __raw_local_irq_stnsm(0xf8); /* switch to real mode */
+	asm volatile (
+		"0:	mvcle	%1,%2,0x0\n"
+		"1:	jo	0b\n"
+		"	lhi	%0,0x0\n"
+		"2:\n"
+		EX_TABLE(1b,2b)
+		: "+d" (rc)
+		: "d" (_dest), "d" (_src), "d" (_len1), "d" (_len2)
+		: "cc", "memory");
+	__raw_local_irq_ssm(flags);
+
+	return rc;
+}
+
+static int memcpy_real_user(__user void *dest, unsigned long src, size_t count)
+{
+	static char buf[4096];
+	int offs = 0, size;
+
+	while (offs < count) {
+		size = min(sizeof(buf), count - offs);
+		if (memcpy_real(buf, src + offs, size))
+			return -EFAULT;
+		if (copy_to_user(dest + offs, buf, size))
+			return -EFAULT;
+		offs += size;
+	}
+	return 0;
+}
+
+#ifdef __s390x__
+/*
+ * Convert s390x (64 bit) cpu info to s390 (32 bit) cpu info
+ */
+static void __init s390x_to_s390_regs(union save_area *out, union save_area *in,
+				      int cpu)
+{
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		out->s390.gp_regs[i] = in->s390x.gp_regs[i] & 0x00000000ffffffff;
+		out->s390.acc_regs[i] = in->s390x.acc_regs[i];
+		out->s390.ctrl_regs[i] =
+			in->s390x.ctrl_regs[i] & 0x00000000ffffffff;
+	}
+	/* locore for 31 bit has only space for fpregs 0,2,4,6 */
+	out->s390.fp_regs[0] = in->s390x.fp_regs[0];
+	out->s390.fp_regs[1] = in->s390x.fp_regs[2];
+	out->s390.fp_regs[2] = in->s390x.fp_regs[4];
+	out->s390.fp_regs[3] = in->s390x.fp_regs[6];
+	memcpy(&(out->s390.psw[0]), &(in->s390x.psw[0]), 4);
+	out->s390.psw[1] |= 0x8; /* set bit 12 */
+	memcpy(&(out->s390.psw[4]),&(in->s390x.psw[12]), 4);
+	out->s390.psw[4] |= 0x80; /* set (31bit) addressing bit */
+	out->s390.pref_reg = in->s390x.pref_reg;
+	out->s390.timer = in->s390x.timer;
+	out->s390.clk_cmp = in->s390x.clk_cmp;
+}
+
+static void __init s390x_to_s390_save_areas(void)
+{
+	int i = 1;
+	static union save_area tmp;
+
+	while (zfcpdump_save_areas[i]) {
+		s390x_to_s390_regs(&tmp, zfcpdump_save_areas[i], i);
+		memcpy(zfcpdump_save_areas[i], &tmp, sizeof(tmp));
+		i++;
+	}
+}
+
+#endif /* __s390x__ */
+
+static int __init init_cpu_info(enum arch_id arch)
+{
+	union save_area *sa;
+
+	/* get info for boot cpu from lowcore, stored in the HSA */
+
+	sa = kmalloc(sizeof(*sa), GFP_KERNEL);
+	if (!sa) {
+		ERROR_MSG("kmalloc failed: %s: %i\n",__FUNCTION__, __LINE__);
+		return -ENOMEM;
+	}
+	if (memcpy_hsa_kernel(sa, sys_info.sa_base, sys_info.sa_size) < 0) {
+		ERROR_MSG("could not copy from HSA\n");
+		kfree(sa);
+		return -EIO;
+	}
+	zfcpdump_save_areas[0] = sa;
+
+#ifdef __s390x__
+	/* convert s390x regs to s390, if we are dumping an s390 Linux */
+
+	if (arch == ARCH_S390)
+		s390x_to_s390_save_areas();
+#endif
+
+	return 0;
+}
+
+static DEFINE_MUTEX(zcore_mutex);
+
+#define DUMP_VERSION	0x3
+#define DUMP_MAGIC	0xa8190173618f23fdULL
+#define DUMP_ARCH_S390X	2
+#define DUMP_ARCH_S390	1
+#define HEADER_SIZE	4096
+
+/* dump header dumped according to s390 crash dump format */
+
+struct zcore_header {
+	u64 magic;
+	u32 version;
+	u32 header_size;
+	u32 dump_level;
+	u32 page_size;
+	u64 mem_size;
+	u64 mem_start;
+	u64 mem_end;
+	u32 num_pages;
+	u32 pad1;
+	u64 tod;
+	cpuid_t cpu_id;
+	u32 arch_id;
+	u32 build_arch;
+	char pad2[4016];
+} __attribute__((packed,__aligned__(16)));
+
+static struct zcore_header zcore_header = {
+	.magic		= DUMP_MAGIC,
+	.version	= DUMP_VERSION,
+	.header_size	= 4096,
+	.dump_level	= 0,
+	.page_size	= PAGE_SIZE,
+	.mem_start	= 0,
+#ifdef __s390x__
+	.build_arch	= DUMP_ARCH_S390X,
+#else
+	.build_arch	= DUMP_ARCH_S390,
+#endif
+};
+
+/*
+ * Copy lowcore info to buffer. Use map in order to copy only register parts.
+ *
+ * @buf:    User buffer
+ * @sa:     Pointer to save area
+ * @sa_off: Offset in save area to copy
+ * @len:    Number of bytes to copy
+ */
+static int copy_lc(void __user *buf, void *sa, int sa_off, int len)
+{
+	int i;
+	char *lc_mask = (char*)&sys_info.lc_mask;
+
+	for (i = 0; i < len; i++) {
+		if (!lc_mask[i + sa_off])
+			continue;
+		if (copy_to_user(buf + i, sa + sa_off + i, 1))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+/*
+ * Copy lowcores info to memory, if necessary
+ *
+ * @buf:   User buffer
+ * @addr:  Start address of buffer in dump memory
+ * @count: Size of buffer
+ */
+static int zcore_add_lc(char __user *buf, unsigned long start, size_t count)
+{
+	unsigned long end;
+	int i = 0;
+
+	if (count == 0)
+		return 0;
+
+	end = start + count;
+	while (zfcpdump_save_areas[i]) {
+		unsigned long cp_start, cp_end; /* copy range */
+		unsigned long sa_start, sa_end; /* save area range */
+		unsigned long prefix;
+		unsigned long sa_off, len, buf_off;
+
+		if (sys_info.arch == ARCH_S390)
+			prefix = zfcpdump_save_areas[i]->s390.pref_reg;
+		else
+			prefix = zfcpdump_save_areas[i]->s390x.pref_reg;
+
+		sa_start = prefix + sys_info.sa_base;
+		sa_end = prefix + sys_info.sa_base + sys_info.sa_size;
+
+		if ((end < sa_start) || (start > sa_end))
+			goto next;
+		cp_start = max(start, sa_start);
+		cp_end = min(end, sa_end);
+
+		buf_off = cp_start - start;
+		sa_off = cp_start - sa_start;
+		len = cp_end - cp_start;
+
+		TRACE("copy_lc for: %lx\n", start);
+		if (copy_lc(buf + buf_off, zfcpdump_save_areas[i], sa_off, len))
+			return -EFAULT;
+next:
+		i++;
+	}
+	return 0;
+}
+
+/*
+ * Read routine for zcore character device
+ * First 4K are dump header
+ * Next 32MB are HSA Memory
+ * Rest is read from absolute Memory
+ */
+static ssize_t zcore_read(struct file *file, char __user *buf, size_t count,
+			  loff_t *ppos)
+{
+	unsigned long mem_start; /* Start address in memory */
+	size_t mem_offs;	 /* Offset in dump memory */
+	size_t hdr_count;	 /* Size of header part of output buffer */
+	size_t size;
+	int rc;
+
+	mutex_lock(&zcore_mutex);
+
+	if (*ppos > (sys_info.mem_size + HEADER_SIZE)) {
+		rc = -EINVAL;
+		goto fail;
+	}
+
+	count = min(count, (size_t) (sys_info.mem_size + HEADER_SIZE - *ppos));
+
+	/* Copy dump header */
+	if (*ppos < HEADER_SIZE) {
+		size = min(count, (size_t) (HEADER_SIZE - *ppos));
+		if (copy_to_user(buf, &zcore_header + *ppos, size)) {
+			rc = -EFAULT;
+			goto fail;
+		}
+		hdr_count = size;
+		mem_start = 0;
+	} else {
+		hdr_count = 0;
+		mem_start = *ppos - HEADER_SIZE;
+	}
+
+	mem_offs = 0;
+
+	/* Copy from HSA data */
+	if (*ppos < (ZFCPDUMP_HSA_SIZE + HEADER_SIZE)) {
+		size = min((count - hdr_count), (size_t) (ZFCPDUMP_HSA_SIZE
+			   - mem_start));
+		rc = memcpy_hsa_user(buf + hdr_count, mem_start, size);
+		if (rc)
+			goto fail;
+
+		mem_offs += size;
+	}
+
+	/* Copy from real mem */
+	size = count - mem_offs - hdr_count;
+	rc = memcpy_real_user(buf + hdr_count + mem_offs, mem_start + mem_offs,
+			      size);
+	if (rc)
+		goto fail;
+
+	/*
+	 * Since s390 dump analysis tools like lcrash or crash
+	 * expect register sets in the prefix pages of the cpus,
+	 * we copy them into the read buffer, if necessary.
+	 * buf + hdr_count: Start of memory part of output buffer
+	 * mem_start: Start memory address to copy from
+	 * count - hdr_count: Size of memory area to copy
+	 */
+	if (zcore_add_lc(buf + hdr_count, mem_start, count - hdr_count)) {
+		rc = -EFAULT;
+		goto fail;
+	}
+	*ppos += count;
+fail:
+	mutex_unlock(&zcore_mutex);
+	return (rc < 0) ? rc : count;
+}
+
+static int zcore_open(struct inode *inode, struct file *filp)
+{
+	if (!hsa_available)
+		return -ENODATA;
+	else
+		return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
+}
+
+static int zcore_release(struct inode *inode, struct file *filep)
+{
+	diag308(DIAG308_REL_HSA, NULL);
+	hsa_available = 0;
+	return 0;
+}
+
+static loff_t zcore_lseek(struct file *file, loff_t offset, int orig)
+{
+	loff_t rc;
+
+	mutex_lock(&zcore_mutex);
+	switch (orig) {
+	case 0:
+		file->f_pos = offset;
+		rc = file->f_pos;
+		break;
+	case 1:
+		file->f_pos += offset;
+		rc = file->f_pos;
+		break;
+	default:
+		rc = -EINVAL;
+	}
+	mutex_unlock(&zcore_mutex);
+	return rc;
+}
+
+static struct file_operations zcore_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= zcore_lseek,
+	.read		= zcore_read,
+	.open		= zcore_open,
+	.release	= zcore_release,
+};
+
+
+static void __init set_s390_lc_mask(union save_area *map)
+{
+	memset(&map->s390.ext_save, 0xff, sizeof(map->s390.ext_save));
+	memset(&map->s390.timer, 0xff, sizeof(map->s390.timer));
+	memset(&map->s390.clk_cmp, 0xff, sizeof(map->s390.clk_cmp));
+	memset(&map->s390.psw, 0xff, sizeof(map->s390.psw));
+	memset(&map->s390.pref_reg, 0xff, sizeof(map->s390.pref_reg));
+	memset(&map->s390.acc_regs, 0xff, sizeof(map->s390.acc_regs));
+	memset(&map->s390.fp_regs, 0xff, sizeof(map->s390.fp_regs));
+	memset(&map->s390.gp_regs, 0xff, sizeof(map->s390.gp_regs));
+	memset(&map->s390.ctrl_regs, 0xff, sizeof(map->s390.ctrl_regs));
+}
+
+static void __init set_s390x_lc_mask(union save_area *map)
+{
+	memset(&map->s390x.fp_regs, 0xff, sizeof(map->s390x.fp_regs));
+	memset(&map->s390x.gp_regs, 0xff, sizeof(map->s390x.gp_regs));
+	memset(&map->s390x.psw, 0xff, sizeof(map->s390x.psw));
+	memset(&map->s390x.pref_reg, 0xff, sizeof(map->s390x.pref_reg));
+	memset(&map->s390x.fp_ctrl_reg, 0xff, sizeof(map->s390x.fp_ctrl_reg));
+	memset(&map->s390x.tod_reg, 0xff, sizeof(map->s390x.tod_reg));
+	memset(&map->s390x.timer, 0xff, sizeof(map->s390x.timer));
+	memset(&map->s390x.clk_cmp, 0xff, sizeof(map->s390x.clk_cmp));
+	memset(&map->s390x.acc_regs, 0xff, sizeof(map->s390x.acc_regs));
+	memset(&map->s390x.ctrl_regs, 0xff, sizeof(map->s390x.ctrl_regs));
+}
+
+/*
+ * Initialize dump globals for a given architecture
+ */
+static int __init sys_info_init(enum arch_id arch)
+{
+	switch (arch) {
+	case ARCH_S390X:
+		MSG("DETECTED 'S390X (64 bit) OS'\n");
+		sys_info.sa_base = SAVE_AREA_BASE_S390X;
+		sys_info.sa_size = sizeof(struct save_area_s390x);
+		set_s390x_lc_mask(&sys_info.lc_mask);
+		break;
+	case ARCH_S390:
+		MSG("DETECTED 'S390 (32 bit) OS'\n");
+		sys_info.sa_base = SAVE_AREA_BASE_S390;
+		sys_info.sa_size = sizeof(struct save_area_s390);
+		set_s390_lc_mask(&sys_info.lc_mask);
+		break;
+	default:
+		ERROR_MSG("unknown architecture 0x%x.\n",arch);
+		return -EINVAL;
+	}
+	sys_info.arch = arch;
+	if (init_cpu_info(arch)) {
+		ERROR_MSG("get cpu info failed\n");
+		return -ENOMEM;
+	}
+	sys_info.mem_size = real_memory_size;
+
+	return 0;
+}
+
+static int __init check_sdias(void)
+{
+	int rc, act_hsa_size;
+
+	rc = sclp_sdias_blk_count();
+	if (rc < 0) {
+		ERROR_MSG("Could not determine HSA size\n");
+		return rc;
+	}
+	act_hsa_size = (rc - 1) * PAGE_SIZE;
+	if (act_hsa_size < ZFCPDUMP_HSA_SIZE) {
+		ERROR_MSG("HSA size too small: %i\n", act_hsa_size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void __init zcore_header_init(int arch, struct zcore_header *hdr)
+{
+	if (arch == ARCH_S390X)
+		hdr->arch_id = DUMP_ARCH_S390X;
+	else
+		hdr->arch_id = DUMP_ARCH_S390;
+	hdr->mem_size = sys_info.mem_size;
+	hdr->mem_end = sys_info.mem_size;
+	hdr->num_pages = sys_info.mem_size / PAGE_SIZE;
+	hdr->tod = get_clock();
+	get_cpu_id(&hdr->cpu_id);
+}
+
+extern int sdias_init(void);
+
+static int __init zcore_init(void)
+{
+	unsigned char arch;
+	int rc;
+
+	if (ipl_info.type != IPL_TYPE_FCP_DUMP)
+		return -ENODATA;
+
+	zcore_dbf = debug_register("zcore", 4, 1, 4 * sizeof(long));
+	debug_register_view(zcore_dbf, &debug_sprintf_view);
+	debug_set_level(zcore_dbf, 6);
+
+	TRACE("devno:  %x\n", ipl_info.data.fcp.dev_id.devno);
+	TRACE("wwpn:   %llx\n", (unsigned long long) ipl_info.data.fcp.wwpn);
+	TRACE("lun:    %llx\n", (unsigned long long) ipl_info.data.fcp.lun);
+
+	rc = sdias_init();
+	if (rc)
+		goto fail;
+
+	rc = check_sdias();
+	if (rc) {
+		ERROR_MSG("Dump initialization failed\n");
+		goto fail;
+	}
+
+	rc = memcpy_hsa_kernel(&arch, __LC_AR_MODE_ID, 1);
+	if (rc) {
+		ERROR_MSG("sdial memcpy for arch id failed\n");
+		goto fail;
+	}
+
+#ifndef __s390x__
+	if (arch == ARCH_S390X) {
+		ERROR_MSG("32 bit dumper can't dump 64 bit system!\n");
+		rc = -EINVAL;
+		goto fail;
+	}
+#endif
+
+	rc = sys_info_init(arch);
+	if (rc) {
+		ERROR_MSG("arch init failed\n");
+		goto fail;
+	}
+
+	zcore_header_init(arch, &zcore_header);
+
+	zcore_dir = debugfs_create_dir("zcore" , NULL);
+	if (!zcore_dir) {
+		rc = -ENOMEM;
+		goto fail;
+	}
+	zcore_file = debugfs_create_file("mem", S_IRUSR, zcore_dir, NULL,
+					 &zcore_fops);
+	if (!zcore_file) {
+		debugfs_remove(zcore_dir);
+		rc = -ENOMEM;
+		goto fail;
+	}
+	hsa_available = 1;
+	return 0;
+
+fail:
+	diag308(DIAG308_REL_HSA, NULL);
+	return rc;
+}
+
+extern void sdias_exit(void);
+
+static void __exit zcore_exit(void)
+{
+	debug_unregister(zcore_dbf);
+	sdias_exit();
+	diag308(DIAG308_REL_HSA, NULL);
+}
+
+MODULE_AUTHOR("Copyright IBM Corp. 2003,2007");
+MODULE_DESCRIPTION("zcore module for zfcpdump support");
+MODULE_LICENSE("GPL");
+
+subsys_initcall(zcore_init);
+module_exit(zcore_exit);
Index: quilt-2.6/include/asm-s390/ipl.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ipl.h	2007-04-27 16:04:52.000000000 +0200
+++ quilt-2.6/include/asm-s390/ipl.h	2007-04-27 16:04:59.000000000 +0200
@@ -8,6 +8,8 @@
 #define _ASM_S390_IPL_H
 
 #include <asm/types.h>
+#include <asm/cio.h>
+#include <asm/setup.h>
 
 #define IPL_PARMBLOCK_ORIGIN	0x2000
 
@@ -79,6 +81,7 @@
 extern u32 ipl_flags;
 
 extern u32 dump_prefix_page;
+
 extern void do_reipl(void);
 extern void ipl_save_parameters(void);
 
@@ -88,6 +91,35 @@
 	IPL_NSS_VALID		= 4,
 };
 
+enum ipl_type {
+	IPL_TYPE_UNKNOWN	= 1,
+	IPL_TYPE_CCW		= 2,
+	IPL_TYPE_FCP		= 4,
+	IPL_TYPE_FCP_DUMP	= 8,
+	IPL_TYPE_NSS		= 16,
+};
+
+struct ipl_info
+{
+	enum ipl_type type;
+	union {
+		struct {
+			struct ccw_dev_id dev_id;
+		} ccw;
+		struct {
+			struct ccw_dev_id dev_id;
+			u64 wwpn;
+			u64 lun;
+		} fcp;
+		struct {
+			char name[NSS_NAME_SIZE + 1];
+		} nss;
+	} data;
+};
+
+extern struct ipl_info ipl_info;
+extern void setup_ipl_info(void);
+
 /*
  * DIAG 308 support
  */
Index: quilt-2.6/include/asm-s390/lowcore.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/lowcore.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-s390/lowcore.h	2007-04-27 16:04:59.000000000 +0200
@@ -147,6 +147,52 @@
 void mcck_int_handler(void);
 void io_int_handler(void);
 
+struct save_area_s390 {
+	u32	ext_save;
+	u64	timer;
+	u64	clk_cmp;
+	u8	pad1[24];
+	u8	psw[8];
+	u32	pref_reg;
+	u8	pad2[20];
+	u32	acc_regs[16];
+	u64	fp_regs[4];
+	u32	gp_regs[16];
+	u32	ctrl_regs[16];
+}  __attribute__((packed));
+
+struct save_area_s390x {
+	u64	fp_regs[16];
+	u64	gp_regs[16];
+	u8	psw[16];
+	u8	pad1[8];
+	u32	pref_reg;
+	u32	fp_ctrl_reg;
+	u8	pad2[4];
+	u32	tod_reg;
+	u64	timer;
+	u64	clk_cmp;
+	u8	pad3[8];
+	u32	acc_regs[16];
+	u64	ctrl_regs[16];
+}  __attribute__((packed));
+
+union save_area {
+	struct save_area_s390	s390;
+	struct save_area_s390x	s390x;
+};
+
+#define SAVE_AREA_BASE_S390	0xd4
+#define SAVE_AREA_BASE_S390X	0x1200
+
+#ifndef __s390x__
+#define SAVE_AREA_SIZE sizeof(struct save_area_s390)
+#define SAVE_AREA_BASE SAVE_AREA_BASE_S390
+#else
+#define SAVE_AREA_SIZE sizeof(struct save_area_s390x)
+#define SAVE_AREA_BASE SAVE_AREA_BASE_S390X
+#endif
+
 struct _lowcore
 {
 #ifndef __s390x__
Index: quilt-2.6/include/asm-s390/sclp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/sclp.h	2007-04-27 16:04:54.000000000 +0200
+++ quilt-2.6/include/asm-s390/sclp.h	2007-04-27 16:04:59.000000000 +0200
@@ -44,6 +44,8 @@
 
 extern struct sclp_readinfo_sccb s390_readinfo_sccb;
 extern void sclp_readinfo_early(void);
+extern int sclp_sdias_blk_count(void);
+extern int sclp_sdias_copy(void *dest, int blk_num, int nr_blks);
 extern int sclp_chp_configure(struct chp_id chpid);
 extern int sclp_chp_deconfigure(struct chp_id chpid);
 extern int sclp_chp_read_info(struct sclp_chp_info *info);
Index: quilt-2.6/include/asm-s390/setup.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/setup.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-s390/setup.h	2007-04-27 16:04:59.000000000 +0200
@@ -40,6 +40,7 @@
 };
 
 extern struct mem_chunk memory_chunk[];
+extern unsigned long real_memory_size;
 
 #ifdef CONFIG_S390_SWITCH_AMODE
 extern unsigned int switch_amode;
@@ -77,6 +78,7 @@
 #endif /* __s390x__ */
 
 #define MACHINE_HAS_SCLP	(!MACHINE_IS_P390)
+#define ZFCPDUMP_HSA_SIZE	(32UL<<20)
 
 /*
  * Console mode. Override with conmode=
Index: quilt-2.6/include/asm-s390/smp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/smp.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-s390/smp.h	2007-04-27 16:04:59.000000000 +0200
@@ -119,4 +119,5 @@
 #define smp_setup_cpu_possible_map()	do { } while (0)
 #endif
 
+extern union save_area *zfcpdump_save_areas[NR_CPUS + 1];
 #endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
