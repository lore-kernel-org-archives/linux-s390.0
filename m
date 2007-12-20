Return-Path: <linux-kernel-owner+w=401wt.eu-S936358AbXLTPff@vger.kernel.org>
Message-Id: <20071220152110.314606422@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 33/47] kernel: Shutdown Actions Interface
Content-Disposition: inline; filename=132-shutdown-actions.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

In case of a kernel panic it is currently possible to specify that a dump
should be created, the system should be rebooted or stopped. Virtual sysfs
files under the directory /sys/firmware/ are used for that configuration.
In addition to that, there are kernel parameters 'vmhalt', 'vmpoff'
and 'vmpanic', which can be used to specify z/VM commands, which are
automatically executed in case of halt, power off or a kernel panic.
This patch combines both functionalities and allows to specify the z/VM CP
commands also via sysfs attributes. In addition to that, it enhances the
existing handling of shutdown triggers (e.g. halt or panic) and associated
shutdown actions (e.g. dump or reipl) and makes it more flexible.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c   |  923 ++++++++++++++++++++++++++++++-----------------
 arch/s390/kernel/setup.c |  103 -----
 arch/s390/kernel/smp.c   |   27 -
 include/asm-s390/ipl.h   |    4 
 4 files changed, 595 insertions(+), 462 deletions(-)

Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -2,7 +2,7 @@
  *  arch/s390/kernel/ipl.c
  *    ipl/reipl/dump support for Linux on s390.
  *
- *    Copyright (C) IBM Corp. 2005,2006
+ *    Copyright IBM Corp. 2005,2007
  *    Author(s): Michael Holzheu <holzheu@de.ibm.com>
  *		 Heiko Carstens <heiko.carstens@de.ibm.com>
  *		 Volker Sameske <sameske@de.ibm.com>
@@ -31,6 +31,43 @@
 #define IPL_FCP_DUMP_STR	"fcp_dump"
 #define IPL_NSS_STR		"nss"
 
+#define DUMP_CCW_STR		"ccw"
+#define DUMP_FCP_STR		"fcp"
+#define DUMP_NONE_STR		"none"
+
+/*
+ * Four shutdown trigger types are supported:
+ * - panic
+ * - halt
+ * - power off
+ * - reipl
+ */
+#define ON_PANIC_STR		"on_panic"
+#define ON_HALT_STR		"on_halt"
+#define ON_POFF_STR		"on_poff"
+#define ON_REIPL_STR		"on_reboot"
+
+struct shutdown_action;
+struct shutdown_trigger {
+	char *name;
+	struct shutdown_action *action;
+};
+
+/*
+ * Five shutdown action types are supported:
+ */
+#define SHUTDOWN_ACTION_IPL_STR		"ipl"
+#define SHUTDOWN_ACTION_REIPL_STR	"reipl"
+#define SHUTDOWN_ACTION_DUMP_STR	"dump"
+#define SHUTDOWN_ACTION_VMCMD_STR	"vmcmd"
+#define SHUTDOWN_ACTION_STOP_STR	"stop"
+
+struct shutdown_action {
+	char *name;
+	void (*fn) (struct shutdown_trigger *trigger);
+	int (*init) (void);
+};
+
 static char *ipl_type_str(enum ipl_type type)
 {
 	switch (type) {
@@ -54,10 +91,6 @@ enum dump_type {
 	DUMP_TYPE_FCP	= 4,
 };
 
-#define DUMP_NONE_STR	 "none"
-#define DUMP_CCW_STR	 "ccw"
-#define DUMP_FCP_STR	 "fcp"
-
 static char *dump_type_str(enum dump_type type)
 {
 	switch (type) {
@@ -99,30 +132,6 @@ enum dump_method {
 	DUMP_METHOD_FCP_DIAG,
 };
 
-enum shutdown_action {
-	SHUTDOWN_REIPL,
-	SHUTDOWN_DUMP,
-	SHUTDOWN_STOP,
-};
-
-#define SHUTDOWN_REIPL_STR "reipl"
-#define SHUTDOWN_DUMP_STR  "dump"
-#define SHUTDOWN_STOP_STR  "stop"
-
-static char *shutdown_action_str(enum shutdown_action action)
-{
-	switch (action) {
-	case SHUTDOWN_REIPL:
-		return SHUTDOWN_REIPL_STR;
-	case SHUTDOWN_DUMP:
-		return SHUTDOWN_DUMP_STR;
-	case SHUTDOWN_STOP:
-		return SHUTDOWN_STOP_STR;
-	default:
-		return NULL;
-	}
-}
-
 static int diag308_set_works = 0;
 
 static int reipl_capabilities = IPL_TYPE_UNKNOWN;
@@ -140,8 +149,6 @@ static enum dump_method dump_method = DU
 static struct ipl_parameter_block *dump_block_fcp;
 static struct ipl_parameter_block *dump_block_ccw;
 
-static enum shutdown_action on_panic_action = SHUTDOWN_STOP;
-
 static struct sclp_ipl_info sclp_ipl_info;
 
 int diag308(unsigned long subcode, void *addr)
@@ -200,8 +207,8 @@ static ssize_t sys_##_prefix##_##_name##
 static ssize_t sys_##_prefix##_##_name##_store(struct kset *kset,	\
 		const char *buf, size_t len)				\
 {									\
-	if (sscanf(buf, _fmt_in, _value) != 1)				\
-		return -EINVAL;						\
+	strncpy(_value, buf, sizeof(_value) - 1);			\
+	strstrip(_value);						\
 	return len;							\
 }									\
 static struct subsys_attribute sys_##_prefix##_##_name##_attr =		\
@@ -240,33 +247,6 @@ static __init enum ipl_type get_ipl_type
 	return IPL_TYPE_FCP;
 }
 
-void __init setup_ipl_info(void)
-{
-	ipl_info.type = get_ipl_type();
-	switch (ipl_info.type) {
-	case IPL_TYPE_CCW:
-		ipl_info.data.ccw.dev_id.devno = ipl_devno;
-		ipl_info.data.ccw.dev_id.ssid = 0;
-		break;
-	case IPL_TYPE_FCP:
-	case IPL_TYPE_FCP_DUMP:
-		ipl_info.data.fcp.dev_id.devno =
-			IPL_PARMBLOCK_START->ipl_info.fcp.devno;
-		ipl_info.data.fcp.dev_id.ssid = 0;
-		ipl_info.data.fcp.wwpn = IPL_PARMBLOCK_START->ipl_info.fcp.wwpn;
-		ipl_info.data.fcp.lun = IPL_PARMBLOCK_START->ipl_info.fcp.lun;
-		break;
-	case IPL_TYPE_NSS:
-		strncpy(ipl_info.data.nss.name, kernel_nss_name,
-			sizeof(ipl_info.data.nss.name));
-		break;
-	case IPL_TYPE_UNKNOWN:
-	default:
-		/* We have no info to copy */
-		break;
-	}
-}
-
 struct ipl_info ipl_info;
 EXPORT_SYMBOL_GPL(ipl_info);
 
@@ -420,8 +400,77 @@ static struct attribute_group ipl_unknow
 
 static decl_subsys(ipl, NULL, NULL);
 
+static int __init ipl_register_fcp_files(void)
+{
+	int rc;
+
+	rc = sysfs_create_group(&ipl_subsys.kobj,
+				&ipl_fcp_attr_group);
+	if (rc)
+		goto out;
+	rc = sysfs_create_bin_file(&ipl_subsys.kobj,
+				   &ipl_parameter_attr);
+	if (rc)
+		goto out_ipl_parm;
+	rc = sysfs_create_bin_file(&ipl_subsys.kobj,
+				   &ipl_scp_data_attr);
+	if (!rc)
+		goto out;
+
+	sysfs_remove_bin_file(&ipl_subsys.kobj, &ipl_parameter_attr);
+
+out_ipl_parm:
+	sysfs_remove_group(&ipl_subsys.kobj, &ipl_fcp_attr_group);
+out:
+	return rc;
+}
+
+static void ipl_run(struct shutdown_trigger *trigger)
+{
+	diag308(DIAG308_IPL, NULL);
+	if (MACHINE_IS_VM)
+		__cpcmd("IPL", NULL, 0, NULL);
+	else if (ipl_info.type == IPL_TYPE_CCW)
+		reipl_ccw_dev(&ipl_info.data.ccw.dev_id);
+}
+
+static int ipl_init(void)
+{
+	int rc;
+
+	rc = firmware_register(&ipl_subsys);
+	if (rc)
+		goto out;
+	switch (ipl_info.type) {
+	case IPL_TYPE_CCW:
+		rc = sysfs_create_group(&ipl_subsys.kobj,
+					&ipl_ccw_attr_group);
+		break;
+	case IPL_TYPE_FCP:
+	case IPL_TYPE_FCP_DUMP:
+		rc = ipl_register_fcp_files();
+		break;
+	case IPL_TYPE_NSS:
+		rc = sysfs_create_group(&ipl_subsys.kobj,
+					&ipl_nss_attr_group);
+		break;
+	default:
+		rc = sysfs_create_group(&ipl_subsys.kobj,
+					&ipl_unknown_attr_group);
+		break;
+	}
+out:
+	if (rc)
+		panic("ipl_init failed: rc = %i\n", rc);
+
+	return 0;
+}
+
+static struct shutdown_action ipl_action = {SHUTDOWN_ACTION_IPL_STR, ipl_run,
+					    ipl_init};
+
 /*
- * reipl section
+ * reipl shutdown action: Reboot Linux on shutdown.
  */
 
 /* FCP reipl device attributes */
@@ -592,135 +641,7 @@ static struct subsys_attribute reipl_typ
 
 static decl_subsys(reipl, NULL, NULL);
 
-/*
- * dump section
- */
-
-/* FCP dump device attributes */
-
-DEFINE_IPL_ATTR_RW(dump_fcp, wwpn, "0x%016llx\n", "%016llx\n",
-		   dump_block_fcp->ipl_info.fcp.wwpn);
-DEFINE_IPL_ATTR_RW(dump_fcp, lun, "0x%016llx\n", "%016llx\n",
-		   dump_block_fcp->ipl_info.fcp.lun);
-DEFINE_IPL_ATTR_RW(dump_fcp, bootprog, "%lld\n", "%lld\n",
-		   dump_block_fcp->ipl_info.fcp.bootprog);
-DEFINE_IPL_ATTR_RW(dump_fcp, br_lba, "%lld\n", "%lld\n",
-		   dump_block_fcp->ipl_info.fcp.br_lba);
-DEFINE_IPL_ATTR_RW(dump_fcp, device, "0.0.%04llx\n", "0.0.%llx\n",
-		   dump_block_fcp->ipl_info.fcp.devno);
-
-static struct attribute *dump_fcp_attrs[] = {
-	&sys_dump_fcp_device_attr.attr,
-	&sys_dump_fcp_wwpn_attr.attr,
-	&sys_dump_fcp_lun_attr.attr,
-	&sys_dump_fcp_bootprog_attr.attr,
-	&sys_dump_fcp_br_lba_attr.attr,
-	NULL,
-};
-
-static struct attribute_group dump_fcp_attr_group = {
-	.name  = IPL_FCP_STR,
-	.attrs = dump_fcp_attrs,
-};
-
-/* CCW dump device attributes */
-
-DEFINE_IPL_ATTR_RW(dump_ccw, device, "0.0.%04llx\n", "0.0.%llx\n",
-		   dump_block_ccw->ipl_info.ccw.devno);
-
-static struct attribute *dump_ccw_attrs[] = {
-	&sys_dump_ccw_device_attr.attr,
-	NULL,
-};
-
-static struct attribute_group dump_ccw_attr_group = {
-	.name  = IPL_CCW_STR,
-	.attrs = dump_ccw_attrs,
-};
-
-/* dump type */
-
-static int dump_set_type(enum dump_type type)
-{
-	if (!(dump_capabilities & type))
-		return -EINVAL;
-	switch(type) {
-	case DUMP_TYPE_CCW:
-		if (MACHINE_IS_VM)
-			dump_method = DUMP_METHOD_CCW_VM;
-		else if (diag308_set_works)
-			dump_method = DUMP_METHOD_CCW_DIAG;
-		else
-			dump_method = DUMP_METHOD_CCW_CIO;
-		break;
-	case DUMP_TYPE_FCP:
-		dump_method = DUMP_METHOD_FCP_DIAG;
-		break;
-	default:
-		dump_method = DUMP_METHOD_NONE;
-	}
-	dump_type = type;
-	return 0;
-}
-
-static ssize_t dump_type_show(struct kset *kset, char *page)
-{
-	return sprintf(page, "%s\n", dump_type_str(dump_type));
-}
-
-static ssize_t dump_type_store(struct kset *kset, const char *buf,
-			       size_t len)
-{
-	int rc = -EINVAL;
-
-	if (strncmp(buf, DUMP_NONE_STR, strlen(DUMP_NONE_STR)) == 0)
-		rc = dump_set_type(DUMP_TYPE_NONE);
-	else if (strncmp(buf, DUMP_CCW_STR, strlen(DUMP_CCW_STR)) == 0)
-		rc = dump_set_type(DUMP_TYPE_CCW);
-	else if (strncmp(buf, DUMP_FCP_STR, strlen(DUMP_FCP_STR)) == 0)
-		rc = dump_set_type(DUMP_TYPE_FCP);
-	return (rc != 0) ? rc : len;
-}
-
-static struct subsys_attribute dump_type_attr =
-		__ATTR(dump_type, 0644, dump_type_show, dump_type_store);
-
-static decl_subsys(dump, NULL, NULL);
-
-/*
- * Shutdown actions section
- */
-
-static decl_subsys(shutdown_actions, NULL, NULL);
-
-/* on panic */
-
-static ssize_t on_panic_show(struct kset *kset, char *page)
-{
-	return sprintf(page, "%s\n", shutdown_action_str(on_panic_action));
-}
-
-static ssize_t on_panic_store(struct kset *kset, const char *buf,
-			      size_t len)
-{
-	if (strncmp(buf, SHUTDOWN_REIPL_STR, strlen(SHUTDOWN_REIPL_STR)) == 0)
-		on_panic_action = SHUTDOWN_REIPL;
-	else if (strncmp(buf, SHUTDOWN_DUMP_STR,
-			 strlen(SHUTDOWN_DUMP_STR)) == 0)
-		on_panic_action = SHUTDOWN_DUMP;
-	else if (strncmp(buf, SHUTDOWN_STOP_STR,
-			 strlen(SHUTDOWN_STOP_STR)) == 0)
-		on_panic_action = SHUTDOWN_STOP;
-	else
-		return -EINVAL;
-
-	return len;
-}
-
-static struct subsys_attribute on_panic_attr =
-		__ATTR(on_panic, 0644, on_panic_show, on_panic_store);
-
-void do_reipl(void)
+void reipl_run(struct shutdown_trigger *trigger)
 {
 	struct ccw_dev_id devid;
 	static char buf[100];
@@ -771,110 +692,18 @@ void do_reipl(void)
 	default:
 		break;
 	}
-	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
 }
 
-static void do_dump(void)
+static void __init reipl_probe(void)
 {
-	struct ccw_dev_id devid;
-	static char buf[100];
+	void *buffer;
 
-	switch (dump_method) {
-	case DUMP_METHOD_CCW_CIO:
-		smp_send_stop();
-		devid.devno = dump_block_ccw->ipl_info.ccw.devno;
-		devid.ssid  = 0;
-		reipl_ccw_dev(&devid);
-		break;
-	case DUMP_METHOD_CCW_VM:
-		smp_send_stop();
-		sprintf(buf, "STORE STATUS");
-		__cpcmd(buf, NULL, 0, NULL);
-		sprintf(buf, "IPL %X", dump_block_ccw->ipl_info.ccw.devno);
-		__cpcmd(buf, NULL, 0, NULL);
-		break;
-	case DUMP_METHOD_CCW_DIAG:
-		diag308(DIAG308_SET, dump_block_ccw);
-		diag308(DIAG308_DUMP, NULL);
-		break;
-	case DUMP_METHOD_FCP_DIAG:
-		diag308(DIAG308_SET, dump_block_fcp);
-		diag308(DIAG308_DUMP, NULL);
-		break;
-	case DUMP_METHOD_NONE:
-	default:
+	buffer = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!buffer)
 		return;
-	}
-	printk(KERN_EMERG "Dump failed!\n");
-}
-
-/* init functions */
-
-static int __init ipl_register_fcp_files(void)
-{
-	int rc;
-
-	rc = sysfs_create_group(&ipl_subsys.kobj,
-				&ipl_fcp_attr_group);
-	if (rc)
-		goto out;
-	rc = sysfs_create_bin_file(&ipl_subsys.kobj,
-				   &ipl_parameter_attr);
-	if (rc)
-		goto out_ipl_parm;
-	rc = sysfs_create_bin_file(&ipl_subsys.kobj,
-				   &ipl_scp_data_attr);
-	if (!rc)
-		goto out;
-
-	sysfs_remove_bin_file(&ipl_subsys.kobj, &ipl_parameter_attr);
-
-out_ipl_parm:
-	sysfs_remove_group(&ipl_subsys.kobj, &ipl_fcp_attr_group);
-out:
-	return rc;
-}
-
-static int __init ipl_init(void)
-{
-	int rc;
-
-	rc = firmware_register(&ipl_subsys);
-	if (rc)
-		return rc;
-	switch (ipl_info.type) {
-	case IPL_TYPE_CCW:
-		rc = sysfs_create_group(&ipl_subsys.kobj,
-					&ipl_ccw_attr_group);
-		break;
-	case IPL_TYPE_FCP:
-	case IPL_TYPE_FCP_DUMP:
-		rc = ipl_register_fcp_files();
-		break;
-	case IPL_TYPE_NSS:
-		rc = sysfs_create_group(&ipl_subsys.kobj,
-					&ipl_nss_attr_group);
-		break;
-	default:
-		rc = sysfs_create_group(&ipl_subsys.kobj,
-					&ipl_unknown_attr_group);
-		break;
-	}
-	if (rc)
-		firmware_unregister(&ipl_subsys);
-	return rc;
-}
-
-static void __init reipl_probe(void)
-{
-	void *buffer;
-
-	buffer = (void *) get_zeroed_page(GFP_KERNEL);
-	if (!buffer)
-		return;
-	if (diag308(DIAG308_STORE, buffer) == DIAG308_RC_OK)
-		diag308_set_works = 1;
-	free_page((unsigned long)buffer);
+	if (diag308(DIAG308_STORE, buffer) == DIAG308_RC_OK)
+		diag308_set_works = 1;
+	free_page((unsigned long)buffer);
 }
 
 static int __init reipl_nss_init(void)
@@ -954,7 +783,7 @@ static int __init reipl_fcp_init(void)
 	return 0;
 }
 
-static int __init reipl_init(void)
+static int reipl_init(void)
 {
 	int rc;
 
@@ -981,6 +810,136 @@ static int __init reipl_init(void)
 	return 0;
 }
 
+static struct shutdown_action reipl_action = {SHUTDOWN_ACTION_REIPL_STR,
+					      reipl_run, reipl_init};
+
+/*
+ * dump shutdown action: Dump Linux on shutdown.
+ */
+
+/* FCP dump device attributes */
+
+DEFINE_IPL_ATTR_RW(dump_fcp, wwpn, "0x%016llx\n", "%016llx\n",
+		   dump_block_fcp->ipl_info.fcp.wwpn);
+DEFINE_IPL_ATTR_RW(dump_fcp, lun, "0x%016llx\n", "%016llx\n",
+		   dump_block_fcp->ipl_info.fcp.lun);
+DEFINE_IPL_ATTR_RW(dump_fcp, bootprog, "%lld\n", "%lld\n",
+		   dump_block_fcp->ipl_info.fcp.bootprog);
+DEFINE_IPL_ATTR_RW(dump_fcp, br_lba, "%lld\n", "%lld\n",
+		   dump_block_fcp->ipl_info.fcp.br_lba);
+DEFINE_IPL_ATTR_RW(dump_fcp, device, "0.0.%04llx\n", "0.0.%llx\n",
+		   dump_block_fcp->ipl_info.fcp.devno);
+
+static struct attribute *dump_fcp_attrs[] = {
+	&sys_dump_fcp_device_attr.attr,
+	&sys_dump_fcp_wwpn_attr.attr,
+	&sys_dump_fcp_lun_attr.attr,
+	&sys_dump_fcp_bootprog_attr.attr,
+	&sys_dump_fcp_br_lba_attr.attr,
+	NULL,
+};
+
+static struct attribute_group dump_fcp_attr_group = {
+	.name  = IPL_FCP_STR,
+	.attrs = dump_fcp_attrs,
+};
+
+/* CCW dump device attributes */
+
+DEFINE_IPL_ATTR_RW(dump_ccw, device, "0.0.%04llx\n", "0.0.%llx\n",
+		   dump_block_ccw->ipl_info.ccw.devno);
+
+static struct attribute *dump_ccw_attrs[] = {
+	&sys_dump_ccw_device_attr.attr,
+	NULL,
+};
+
+static struct attribute_group dump_ccw_attr_group = {
+	.name  = IPL_CCW_STR,
+	.attrs = dump_ccw_attrs,
+};
+
+/* dump type */
+
+static int dump_set_type(enum dump_type type)
+{
+	if (!(dump_capabilities & type))
+		return -EINVAL;
+	switch (type) {
+	case DUMP_TYPE_CCW:
+		if (MACHINE_IS_VM)
+			dump_method = DUMP_METHOD_CCW_VM;
+		else
+			dump_method = DUMP_METHOD_CCW_CIO;
+		break;
+	case DUMP_TYPE_FCP:
+		dump_method = DUMP_METHOD_FCP_DIAG;
+		break;
+	default:
+		dump_method = DUMP_METHOD_NONE;
+	}
+	dump_type = type;
+	return 0;
+}
+
+static ssize_t dump_type_show(struct kset *kset, char *page)
+{
+	return sprintf(page, "%s\n", dump_type_str(dump_type));
+}
+
+static ssize_t dump_type_store(struct kset *kset, const char *buf,
+			       size_t len)
+{
+	int rc = -EINVAL;
+
+	if (strncmp(buf, DUMP_NONE_STR, strlen(DUMP_NONE_STR)) == 0)
+		rc = dump_set_type(DUMP_TYPE_NONE);
+	else if (strncmp(buf, DUMP_CCW_STR, strlen(DUMP_CCW_STR)) == 0)
+		rc = dump_set_type(DUMP_TYPE_CCW);
+	else if (strncmp(buf, DUMP_FCP_STR, strlen(DUMP_FCP_STR)) == 0)
+		rc = dump_set_type(DUMP_TYPE_FCP);
+	return (rc != 0) ? rc : len;
+}
+
+static struct subsys_attribute dump_type_attr =
+		__ATTR(dump_type, 0644, dump_type_show, dump_type_store);
+
+static decl_subsys(dump, NULL, NULL);
+
+static void dump_run(struct shutdown_trigger *trigger)
+{
+	struct ccw_dev_id devid;
+	static char buf[100];
+
+	switch (dump_method) {
+	case DUMP_METHOD_CCW_CIO:
+		smp_send_stop();
+		devid.devno = dump_block_ccw->ipl_info.ccw.devno;
+		devid.ssid  = 0;
+		reipl_ccw_dev(&devid);
+		break;
+	case DUMP_METHOD_CCW_VM:
+		smp_send_stop();
+		sprintf(buf, "STORE STATUS");
+		__cpcmd(buf, NULL, 0, NULL);
+		sprintf(buf, "IPL %X", dump_block_ccw->ipl_info.ccw.devno);
+		__cpcmd(buf, NULL, 0, NULL);
+		break;
+	case DUMP_METHOD_CCW_DIAG:
+		diag308(DIAG308_SET, dump_block_ccw);
+		diag308(DIAG308_DUMP, NULL);
+		break;
+	case DUMP_METHOD_FCP_DIAG:
+		diag308(DIAG308_SET, dump_block_fcp);
+		diag308(DIAG308_DUMP, NULL);
+		break;
+	case DUMP_METHOD_NONE:
+	default:
+		return;
+	}
+	printk(KERN_EMERG "Dump failed!\n");
+}
+
 static int __init dump_ccw_init(void)
 {
 	int rc;
@@ -1026,24 +985,7 @@ static int __init dump_fcp_init(void)
 	return 0;
 }
 
-#define SHUTDOWN_ON_PANIC_PRIO 0
-
-static int shutdown_on_panic_notify(struct notifier_block *self,
-				    unsigned long event, void *data)
-{
-	if (on_panic_action == SHUTDOWN_DUMP)
-		do_dump();
-	else if (on_panic_action == SHUTDOWN_REIPL)
-		do_reipl();
-	return NOTIFY_OK;
-}
-
-static struct notifier_block shutdown_on_panic_nb = {
-	.notifier_call = shutdown_on_panic_notify,
-	.priority = SHUTDOWN_ON_PANIC_PRIO
-};
-
-static int __init dump_init(void)
+static int dump_init(void)
 {
 	int rc;
 
@@ -1065,46 +1007,362 @@ static int __init dump_init(void)
 	return 0;
 }
 
-static int __init shutdown_actions_init(void)
+static struct shutdown_action dump_action = {SHUTDOWN_ACTION_DUMP_STR,
+					     dump_run, dump_init};
+
+/*
+ * vmcmd shutdown action: Trigger vm command on shutdown.
+ */
+
+static char vmcmd_on_reboot[128];
+static char vmcmd_on_panic[128];
+static char vmcmd_on_halt[128];
+static char vmcmd_on_poff[128];
+
+DEFINE_IPL_ATTR_STR_RW(vmcmd, on_reboot, "%s\n", "%s\n", vmcmd_on_reboot);
+DEFINE_IPL_ATTR_STR_RW(vmcmd, on_panic, "%s\n", "%s\n", vmcmd_on_panic);
+DEFINE_IPL_ATTR_STR_RW(vmcmd, on_halt, "%s\n", "%s\n", vmcmd_on_halt);
+DEFINE_IPL_ATTR_STR_RW(vmcmd, on_poff, "%s\n", "%s\n", vmcmd_on_poff);
+
+static struct attribute *vmcmd_attrs[] = {
+	&sys_vmcmd_on_reboot_attr.attr,
+	&sys_vmcmd_on_panic_attr.attr,
+	&sys_vmcmd_on_halt_attr.attr,
+	&sys_vmcmd_on_poff_attr.attr,
+	NULL,
+};
+
+static struct attribute_group vmcmd_attr_group = {
+	.attrs = vmcmd_attrs,
+};
+
+static decl_subsys(vmcmd, NULL, NULL);
+
+static void vmcmd_run(struct shutdown_trigger *trigger)
+{
+	char *cmd, *next_cmd;
+
+	if (strcmp(trigger->name, ON_REIPL_STR) == 0)
+		cmd = vmcmd_on_reboot;
+	else if (strcmp(trigger->name, ON_PANIC_STR) == 0)
+		cmd = vmcmd_on_panic;
+	else if (strcmp(trigger->name, ON_HALT_STR) == 0)
+		cmd = vmcmd_on_halt;
+	else if (strcmp(trigger->name, ON_POFF_STR) == 0)
+		cmd = vmcmd_on_poff;
+	else
+		return;
+
+	if (strlen(cmd) == 0)
+		return;
+	do {
+		next_cmd = strchr(cmd, '\n');
+		if (next_cmd) {
+			next_cmd[0] = 0;
+			next_cmd += 1;
+		}
+		__cpcmd(cmd, NULL, 0, NULL);
+		cmd = next_cmd;
+	} while (cmd != NULL);
+}
+
+static int vmcmd_init(void)
 {
 	int rc;
 
-	rc = firmware_register(&shutdown_actions_subsys);
+	if (!MACHINE_IS_VM)
+		return -ENOTSUPP;
+	rc = firmware_register(&vmcmd_subsys);
 	if (rc)
 		return rc;
-	rc = subsys_create_file(&shutdown_actions_subsys, &on_panic_attr);
-	if (rc) {
-		firmware_unregister(&shutdown_actions_subsys);
-		return rc;
+	return sysfs_create_group(&vmcmd_subsys.kobj, &vmcmd_attr_group);
+}
+
+static struct shutdown_action vmcmd_action = {SHUTDOWN_ACTION_VMCMD_STR,
+					      vmcmd_run, vmcmd_init};
+
+/*
+ * stop shutdown action: Stop Linux on shutdown.
+ */
+
+static void stop_run(struct shutdown_trigger *trigger)
+{
+	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
+	for (;;);
+}
+
+static struct shutdown_action stop_action = {SHUTDOWN_ACTION_STOP_STR,
+					     stop_run, NULL};
+
+/* action list */
+
+static struct shutdown_action *shutdown_actions_list[] = {
+	&ipl_action, &reipl_action, &dump_action, &vmcmd_action, &stop_action};
+#define SHUTDOWN_ACTIONS_COUNT (sizeof(shutdown_actions_list) / sizeof(void *))
+
+/*
+ * Trigger section
+ */
+
+static decl_subsys(shutdown_actions, NULL, NULL);
+
+static int set_trigger(const char *buf, struct shutdown_trigger *trigger,
+		       size_t len)
+{
+	int i;
+
+	for (i = 0; i < SHUTDOWN_ACTIONS_COUNT; i++) {
+		if (!shutdown_actions_list[i])
+			continue;
+		if (strncmp(buf, shutdown_actions_list[i]->name,
+			    strlen(shutdown_actions_list[i]->name)) == 0) {
+			trigger->action = shutdown_actions_list[i];
+			return len;
+		}
 	}
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &shutdown_on_panic_nb);
-	return 0;
+	return -EINVAL;
 }
 
-static int __init s390_ipl_init(void)
+/* on reipl */
+
+static struct shutdown_trigger on_reboot_trigger = {ON_REIPL_STR,
+						    &reipl_action};
+
+static ssize_t on_reboot_show(struct kset *kset, char *page)
 {
-	int rc;
+	return sprintf(page, "%s\n", on_reboot_trigger.action->name);
+}
+
+static ssize_t on_reboot_store(struct kset *kset, const char *buf, size_t len)
+{
+	return set_trigger(buf, &on_reboot_trigger, len);
+}
+
+static struct subsys_attribute on_reboot_attr =
+		__ATTR(on_reboot, 0644, on_reboot_show, on_reboot_store);
+
+static void do_machine_restart(char *__unused)
+{
+	smp_send_stop();
+	on_reboot_trigger.action->fn(&on_reboot_trigger);
+	reipl_run(NULL);
+}
+void (*_machine_restart)(char *command) = do_machine_restart;
+
+/* on panic */
+
+static struct shutdown_trigger on_panic_trigger = {ON_PANIC_STR, &stop_action};
+
+static ssize_t on_panic_show(struct kset *kset, char *page)
+{
+	return sprintf(page, "%s\n", on_panic_trigger.action->name);
+}
+
+static ssize_t on_panic_store(struct kset *kset, const char *buf,
+			      size_t len)
+{
+	return set_trigger(buf, &on_panic_trigger, len);
+}
+
+static struct subsys_attribute on_panic_attr =
+		__ATTR(on_panic, 0644, on_panic_show, on_panic_store);
+
+static void do_panic(void)
+{
+	on_panic_trigger.action->fn(&on_panic_trigger);
+	stop_run(&on_panic_trigger);
+}
+
+/* on halt */
+
+static struct shutdown_trigger on_halt_trigger = {ON_HALT_STR, &stop_action};
+
+static ssize_t on_halt_show(struct kset *kset, char *page)
+{
+	return sprintf(page, "%s\n", on_halt_trigger.action->name);
+}
+
+static ssize_t on_halt_store(struct kset *kset, const char *buf, size_t len)
+{
+	return set_trigger(buf, &on_halt_trigger, len);
+}
+
+static struct subsys_attribute on_halt_attr =
+		__ATTR(on_halt, 0644, on_halt_show, on_halt_store);
 
-	sclp_get_ipl_info(&sclp_ipl_info);
+
+static void do_machine_halt(void)
+{
+	smp_send_stop();
+	on_halt_trigger.action->fn(&on_halt_trigger);
+	stop_run(&on_halt_trigger);
+}
+void (*_machine_halt)(void) = do_machine_halt;
+
+/* on power off */
+
+static struct shutdown_trigger on_poff_trigger = {ON_POFF_STR, &stop_action};
+
+static ssize_t on_poff_show(struct kset *kset, char *page)
+{
+	return sprintf(page, "%s\n", on_poff_trigger.action->name);
+}
+
+static ssize_t on_poff_store(struct kset *kset, const char *buf, size_t len)
+{
+	return set_trigger(buf, &on_poff_trigger, len);
+}
+
+static struct subsys_attribute on_poff_attr =
+		__ATTR(on_poff, 0644, on_poff_show, on_poff_store);
+
+
+static void do_machine_power_off(void)
+{
+	smp_send_stop();
+	on_poff_trigger.action->fn(&on_poff_trigger);
+	stop_run(&on_poff_trigger);
+}
+void (*_machine_power_off)(void) = do_machine_power_off;
+
+static void __init shutdown_triggers_init(void)
+{
+	if (firmware_register(&shutdown_actions_subsys))
+		goto fail;
+	if (subsys_create_file(&shutdown_actions_subsys, &on_reboot_attr))
+		goto fail;
+	if (subsys_create_file(&shutdown_actions_subsys, &on_panic_attr))
+		goto fail;
+	if (subsys_create_file(&shutdown_actions_subsys, &on_halt_attr))
+		goto fail;
+	if (subsys_create_file(&shutdown_actions_subsys, &on_poff_attr))
+		goto fail;
+
+	return;
+fail:
+	panic("shutdown_triggers_init failed\n");
+}
+
+static void __init shutdown_actions_init(void)
+{
+	int i;
+
+	for (i = 0; i < SHUTDOWN_ACTIONS_COUNT; i++) {
+		if (!shutdown_actions_list[i]->init)
+			continue;
+		if (shutdown_actions_list[i]->init())
+			shutdown_actions_list[i] = NULL;
+	}
+}
+
+static int __init s390_ipl_init(void)
+{
 	reipl_probe();
-	rc = ipl_init();
-	if (rc)
-		return rc;
-	rc = reipl_init();
-	if (rc)
-		return rc;
-	rc = dump_init();
-	if (rc)
-		return rc;
-	rc = shutdown_actions_init();
-	if (rc)
-		return rc;
+	shutdown_actions_init();
+	shutdown_triggers_init();
 	return 0;
 }
 
 __initcall(s390_ipl_init);
 
+static void __init strncpy_skip_quote(char *dst, char *src, int n)
+{
+	int sx, dx;
+
+	dx = 0;
+	for (sx = 0; src[sx] != 0; sx++) {
+		if (src[sx] == '"')
+			continue;
+		dst[dx++] = src[sx];
+		if (dx >= n)
+			break;
+	}
+}
+
+static int __init vmcmd_on_reboot_setup(char *str)
+{
+	if (!MACHINE_IS_VM)
+		return 1;
+	strncpy_skip_quote(vmcmd_on_reboot, str, 127);
+	vmcmd_on_reboot[127] = 0;
+	on_panic_trigger.action = &vmcmd_action;
+	return 1;
+}
+__setup("vmreboot=", vmcmd_on_reboot_setup);
+
+static int __init vmcmd_on_panic_setup(char *str)
+{
+	if (!MACHINE_IS_VM)
+		return 1;
+	strncpy_skip_quote(vmcmd_on_panic, str, 127);
+	vmcmd_on_panic[127] = 0;
+	on_panic_trigger.action = &vmcmd_action;
+	return 1;
+}
+__setup("vmpanic=", vmcmd_on_panic_setup);
+
+static int __init vmcmd_on_halt_setup(char *str)
+{
+	if (!MACHINE_IS_VM)
+		return 1;
+	strncpy_skip_quote(vmcmd_on_halt, str, 127);
+	vmcmd_on_halt[127] = 0;
+	on_halt_trigger.action = &vmcmd_action;
+	return 1;
+}
+__setup("vmhalt=", vmcmd_on_halt_setup);
+
+static int __init vmcmd_on_poff_setup(char *str)
+{
+	if (!MACHINE_IS_VM)
+		return 1;
+	strncpy_skip_quote(vmcmd_on_poff, str, 127);
+	vmcmd_on_poff[127] = 0;
+	on_poff_trigger.action = &vmcmd_action;
+	return 1;
+}
+__setup("vmpoff=", vmcmd_on_poff_setup);
+
+static int on_panic_notify(struct notifier_block *self,
+			   unsigned long event, void *data)
+{
+	do_panic();
+	return NOTIFY_OK;
+}
+
+static struct notifier_block on_panic_nb = {
+	.notifier_call = on_panic_notify,
+	.priority = 0,
+};
+
+void __init setup_ipl(void)
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
+	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
+}
+
 void __init ipl_save_parameters(void)
 {
 	struct cio_iplinfo iplinfo;
@@ -1185,3 +1443,4 @@ void s390_reset_system(void)
 
 	do_reset_calls();
 }
+
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -126,75 +126,6 @@ void __cpuinit cpu_init(void)
 }
 
 /*
- * VM halt and poweroff setup routines
- */
-char vmhalt_cmd[128] = "";
-char vmpoff_cmd[128] = "";
-static char vmpanic_cmd[128] = "";
-
-static void strncpy_skip_quote(char *dst, char *src, int n)
-{
-        int sx, dx;
-
-        dx = 0;
-        for (sx = 0; src[sx] != 0; sx++) {
-                if (src[sx] == '"') continue;
-                dst[dx++] = src[sx];
-                if (dx >= n) break;
-        }
-}
-
-static int __init vmhalt_setup(char *str)
-{
-        strncpy_skip_quote(vmhalt_cmd, str, 127);
-        vmhalt_cmd[127] = 0;
-        return 1;
-}
-
-__setup("vmhalt=", vmhalt_setup);
-
-static int __init vmpoff_setup(char *str)
-{
-        strncpy_skip_quote(vmpoff_cmd, str, 127);
-        vmpoff_cmd[127] = 0;
-        return 1;
-}
-
-__setup("vmpoff=", vmpoff_setup);
-
-static int vmpanic_notify(struct notifier_block *self, unsigned long event,
-			  void *data)
-{
-	if (MACHINE_IS_VM && strlen(vmpanic_cmd) > 0)
-		cpcmd(vmpanic_cmd, NULL, 0, NULL);
-
-	return NOTIFY_OK;
-}
-
-#define PANIC_PRI_VMPANIC	0
-
-static struct notifier_block vmpanic_nb = {
-	.notifier_call = vmpanic_notify,
-	.priority = PANIC_PRI_VMPANIC
-};
-
-static int __init vmpanic_setup(char *str)
-{
-	static int register_done __initdata = 0;
-
-	strncpy_skip_quote(vmpanic_cmd, str, 127);
-	vmpanic_cmd[127] = 0;
-	if (!register_done) {
-		register_done = 1;
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &vmpanic_nb);
-	}
-	return 1;
-}
-
-__setup("vmpanic=", vmpanic_setup);
-
-/*
  * condev= and conmode= setup parameter.
  */
 
@@ -308,38 +239,6 @@ static void __init setup_zfcpdump(unsign
 static inline void setup_zfcpdump(unsigned int console_devno) {}
 #endif /* CONFIG_ZFCPDUMP */
 
-#ifdef CONFIG_SMP
-void (*_machine_restart)(char *command) = machine_restart_smp;
-void (*_machine_halt)(void) = machine_halt_smp;
-void (*_machine_power_off)(void) = machine_power_off_smp;
-#else
-/*
- * Reboot, halt and power_off routines for non SMP.
- */
-static void do_machine_restart_nonsmp(char * __unused)
-{
-	do_reipl();
-}
-
-static void do_machine_halt_nonsmp(void)
-{
-        if (MACHINE_IS_VM && strlen(vmhalt_cmd) > 0)
-		__cpcmd(vmhalt_cmd, NULL, 0, NULL);
-        signal_processor(smp_processor_id(), sigp_stop_and_store_status);
-}
-
-static void do_machine_power_off_nonsmp(void)
-{
-        if (MACHINE_IS_VM && strlen(vmpoff_cmd) > 0)
-		__cpcmd(vmpoff_cmd, NULL, 0, NULL);
-        signal_processor(smp_processor_id(), sigp_stop_and_store_status);
-}
-
-void (*_machine_restart)(char *command) = do_machine_restart_nonsmp;
-void (*_machine_halt)(void) = do_machine_halt_nonsmp;
-void (*_machine_power_off)(void) = do_machine_power_off_nonsmp;
-#endif
-
  /*
  * Reboot, halt and power_off stubs. They just call _machine_restart,
  * _machine_halt or _machine_power_off. 
@@ -913,7 +812,7 @@ setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
-	setup_ipl_info();
+	setup_ipl();
 	setup_memory_end();
 	setup_addressing_mode();
 	setup_memory();
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -234,33 +234,6 @@ void smp_send_stop(void)
 }
 
 /*
- * Reboot, halt and power_off routines for SMP.
- */
-void machine_restart_smp(char *__unused)
-{
-	smp_send_stop();
-	do_reipl();
-}
-
-void machine_halt_smp(void)
-{
-	smp_send_stop();
-	if (MACHINE_IS_VM && strlen(vmhalt_cmd) > 0)
-		__cpcmd(vmhalt_cmd, NULL, 0, NULL);
-	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
-	for (;;);
-}
-
-void machine_power_off_smp(void)
-{
-	smp_send_stop();
-	if (MACHINE_IS_VM && strlen(vmpoff_cmd) > 0)
-		__cpcmd(vmpoff_cmd, NULL, 0, NULL);
-	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
-	for (;;);
-}
-
-/*
  * This is the main routine where commands issued by other
  * cpus are handled.
  */
Index: quilt-2.6/include/asm-s390/ipl.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ipl.h
+++ quilt-2.6/include/asm-s390/ipl.h
@@ -83,6 +83,8 @@ extern u32 dump_prefix_page;
 extern unsigned int zfcpdump_prefix_array[];
 
 extern void do_reipl(void);
+extern void do_halt(void);
+extern void do_poff(void);
 extern void ipl_save_parameters(void);
 
 enum {
@@ -118,7 +120,7 @@ struct ipl_info
 };
 
 extern struct ipl_info ipl_info;
-extern void setup_ipl_info(void);
+extern void setup_ipl(void);
 
 /*
  * DIAG 308 support

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
