Return-Path: <linux-kernel-owner+w=401wt.eu-S1765713AbXKPRqd@vger.kernel.org>
Subject: Re: [patch 6/6] kernel: Shutdown Actions Interface
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reply-To: holzheu@linux.vnet.ibm.com
In-Reply-To: <3ae72650711160715w8479bacs445993b7766e6529@mail.gmail.com>
References: <20071116142942.978412023@de.ibm.com>
	 <20071116143322.198591347@de.ibm.com>
	 <3ae72650711160715w8479bacs445993b7766e6529@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 18:44:30 +0100
Message-Id: <1195235070.6355.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>, Greg KH <greg@kroah.com>, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2007-11-16 at 16:15 +0100, Kay Sievers wrote:
> On Nov 16, 2007 3:29 PM, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> > From: Michael Holzheu <holzheu@de.ibm.com>
> 
> > -static struct subsys_attribute dump_type_attr =
> > -               __ATTR(dump_type, 0644, dump_type_show, dump_type_store);
> > -
> > -static decl_subsys(dump, NULL, NULL);
> 
> I guess this will conflict with:
> http://git.kernel.org/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=driver/kobject-convert-s390-ipl.c-to-kobj_attr-interface.patch;hb=HEAD
> 
> which in in -mm.
> 

Right. Patch 6/6 together with the following patch will compile with
Greg's "subsys" changes in the -mm tree. To merge the two patches we
have to:

1. Remove Greg's changes in ipl.c
2. Apply patch 6/6 
3. Apply this patch

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

---

 arch/s390/kernel/ipl.c |  192 ++++++++++++++++++++++++++++---------------------
 1 files changed, 111 insertions(+), 81 deletions(-)

diff -Naurp linux-2.6.23-mm/arch/s390/kernel/ipl.c linux-2.6.23-mm-ipl-fix/arch/s390/kernel/ipl.c
--- linux-2.6.23-mm/arch/s390/kernel/ipl.c	2007-11-16 17:05:57.000000000 +0100
+++ linux-2.6.23-mm-ipl-fix/arch/s390/kernel/ipl.c	2007-11-16 18:25:53.000000000 +0100
@@ -169,23 +169,24 @@ EXPORT_SYMBOL_GPL(diag308);
 /* SYSFS */
 
 #define DEFINE_IPL_ATTR_RO(_prefix, _name, _format, _value)		\
-static ssize_t sys_##_prefix##_##_name##_show(struct kset *kset,	\
-		char *page)						\
+static ssize_t sys_##_prefix##_##_name##_show(struct kobject *kobj,	\
+		struct kobj_attribute *attr, char *page)		\
 {									\
 	return sprintf(page, _format, _value);				\
 }									\
-static struct subsys_attribute sys_##_prefix##_##_name##_attr =		\
+static struct kobj_attribute sys_##_prefix##_##_name##_attr =		\
 	__ATTR(_name, S_IRUGO, sys_##_prefix##_##_name##_show, NULL);
 
 #define DEFINE_IPL_ATTR_RW(_prefix, _name, _fmt_out, _fmt_in, _value)	\
-static ssize_t sys_##_prefix##_##_name##_show(struct kset *kset,	\
-		char *page)						\
+static ssize_t sys_##_prefix##_##_name##_show(struct kobject *kobj,	\
+		struct kobj_attribute *attr, char *page)		\
 {									\
 	return sprintf(page, _fmt_out,					\
 			(unsigned long long) _value);			\
 }									\
-static ssize_t sys_##_prefix##_##_name##_store(struct kset *kset,	\
-		const char *buf, size_t len)				\
+static ssize_t sys_##_prefix##_##_name##_store(struct kobject *kobj,	\
+		struct kobj_attribute *attr, const char *buf,		\
+		size_t len)						\
 {									\
 	unsigned long long value;					\
 	if (sscanf(buf, _fmt_in, &value) != 1)				\
@@ -193,25 +194,26 @@ static ssize_t sys_##_prefix##_##_name##
 	_value = value;							\
 	return len;							\
 }									\
-static struct subsys_attribute sys_##_prefix##_##_name##_attr =		\
+static struct kobj_attribute sys_##_prefix##_##_name##_attr =		\
 	__ATTR(_name,(S_IRUGO | S_IWUSR),				\
 			sys_##_prefix##_##_name##_show,			\
 			sys_##_prefix##_##_name##_store);
 
 #define DEFINE_IPL_ATTR_STR_RW(_prefix, _name, _fmt_out, _fmt_in, _value)\
-static ssize_t sys_##_prefix##_##_name##_show(struct kset *kset,	\
-		char *page)						\
+static ssize_t sys_##_prefix##_##_name##_show(struct kobject *kobj,	\
+		struct kobj_attribute *attr, char *page)		\
 {									\
 	return sprintf(page, _fmt_out, _value);				\
 }									\
-static ssize_t sys_##_prefix##_##_name##_store(struct kset *kset,	\
-		const char *buf, size_t len)				\
+static ssize_t sys_##_prefix##_##_name##_store(struct kobject *kobj,	\
+		struct kobj_attribute *attr, const char *buf, 		\
+		size_t len)						\
 {									\
 	strncpy(_value, buf, sizeof(_value) - 1);			\
 	strstrip(_value);						\
 	return len;							\
 }									\
-static struct subsys_attribute sys_##_prefix##_##_name##_attr =		\
+static struct kobj_attribute sys_##_prefix##_##_name##_attr =		\
 	__ATTR(_name,(S_IRUGO | S_IWUSR),				\
 			sys_##_prefix##_##_name##_show,			\
 			sys_##_prefix##_##_name##_store);
@@ -250,14 +252,16 @@ static __init enum ipl_type get_ipl_type
 struct ipl_info ipl_info;
 EXPORT_SYMBOL_GPL(ipl_info);
 
-static ssize_t ipl_type_show(struct kset *kset, char *page)
+static ssize_t ipl_type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *page)
 {
 	return sprintf(page, "%s\n", ipl_type_str(ipl_info.type));
 }
 
-static struct subsys_attribute sys_ipl_type_attr = __ATTR_RO(ipl_type);
+static struct kobj_attribute sys_ipl_type_attr = __ATTR_RO(ipl_type);
 
-static ssize_t sys_ipl_device_show(struct kset *kset, char *page)
+static ssize_t sys_ipl_device_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *page)
 {
 	struct ipl_parameter_block *ipl = IPL_PARMBLOCK_START;
 
@@ -272,7 +276,7 @@ static ssize_t sys_ipl_device_show(struc
 	}
 }
 
-static struct subsys_attribute sys_ipl_device_attr =
+static struct kobj_attribute sys_ipl_device_attr =
 	__ATTR(device, S_IRUGO, sys_ipl_device_show, NULL);
 
 static ssize_t ipl_parameter_read(struct kobject *kobj, struct bin_attribute *attr,
@@ -347,7 +351,8 @@ static struct attribute_group ipl_fcp_at
 
 /* CCW ipl device attributes */
 
-static ssize_t ipl_ccw_loadparm_show(struct kset *kset, char *page)
+static ssize_t ipl_ccw_loadparm_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *page)
 {
 	char loadparm[LOADPARM_LEN + 1] = {};
 
@@ -359,7 +364,7 @@ static ssize_t ipl_ccw_loadparm_show(str
 	return sprintf(page, "%s\n", loadparm);
 }
 
-static struct subsys_attribute sys_ipl_ccw_loadparm_attr =
+static struct kobj_attribute sys_ipl_ccw_loadparm_attr =
 	__ATTR(loadparm, 0444, ipl_ccw_loadparm_show, NULL);
 
 static struct attribute *ipl_ccw_attrs[] = {
@@ -398,29 +403,29 @@ static struct attribute_group ipl_unknow
 	.attrs = ipl_unknown_attrs,
 };
 
-static decl_subsys(ipl, NULL, NULL);
+static struct kset *ipl_kset;
 
 static int __init ipl_register_fcp_files(void)
 {
 	int rc;
 
-	rc = sysfs_create_group(&ipl_subsys.kobj,
+	rc = sysfs_create_group(&ipl_kset->kobj,
 				&ipl_fcp_attr_group);
 	if (rc)
 		goto out;
-	rc = sysfs_create_bin_file(&ipl_subsys.kobj,
+	rc = sysfs_create_bin_file(&ipl_kset->kobj,
 				   &ipl_parameter_attr);
 	if (rc)
 		goto out_ipl_parm;
-	rc = sysfs_create_bin_file(&ipl_subsys.kobj,
+	rc = sysfs_create_bin_file(&ipl_kset->kobj,
 				   &ipl_scp_data_attr);
 	if (!rc)
 		goto out;
 
-	sysfs_remove_bin_file(&ipl_subsys.kobj, &ipl_parameter_attr);
+	sysfs_remove_bin_file(&ipl_kset->kobj, &ipl_parameter_attr);
 
 out_ipl_parm:
-	sysfs_remove_group(&ipl_subsys.kobj, &ipl_fcp_attr_group);
+	sysfs_remove_group(&ipl_kset->kobj, &ipl_fcp_attr_group);
 out:
 	return rc;
 }
@@ -438,12 +443,14 @@ static int ipl_init(void)
 {
 	int rc;
 
-	rc = firmware_register(&ipl_subsys);
-	if (rc)
+	ipl_kset = kset_create_and_register("ipl", NULL, firmware_kobj, NULL);
+	if (!ipl_kset) {
+		rc = -ENOMEM;
 		goto out;
+	}
 	switch (ipl_info.type) {
 	case IPL_TYPE_CCW:
-		rc = sysfs_create_group(&ipl_subsys.kobj,
+		rc = sysfs_create_group(&ipl_kset->kobj,
 					&ipl_ccw_attr_group);
 		break;
 	case IPL_TYPE_FCP:
@@ -451,11 +458,11 @@ static int ipl_init(void)
 		rc = ipl_register_fcp_files();
 		break;
 	case IPL_TYPE_NSS:
-		rc = sysfs_create_group(&ipl_subsys.kobj,
+		rc = sysfs_create_group(&ipl_kset->kobj,
 					&ipl_nss_attr_group);
 		break;
 	default:
-		rc = sysfs_create_group(&ipl_subsys.kobj,
+		rc = sysfs_create_group(&ipl_kset->kobj,
 					&ipl_unknown_attr_group);
 		break;
 	}
@@ -514,7 +521,8 @@ static void reipl_get_ascii_loadparm(cha
 	strstrip(loadparm);
 }
 
-static ssize_t reipl_ccw_loadparm_show(struct kset *kset, char *page)
+static ssize_t reipl_ccw_loadparm_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *page)
 {
 	char buf[LOADPARM_LEN + 1];
 
@@ -522,7 +530,8 @@ static ssize_t reipl_ccw_loadparm_show(s
 	return sprintf(page, "%s\n", buf);
 }
 
-static ssize_t reipl_ccw_loadparm_store(struct kset *kset,
+static ssize_t reipl_ccw_loadparm_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
 					const char *buf, size_t len)
 {
 	int i, lp_len;
@@ -549,7 +558,7 @@ static ssize_t reipl_ccw_loadparm_store(
 	return len;
 }
 
-static struct subsys_attribute sys_reipl_ccw_loadparm_attr =
+static struct kobj_attribute sys_reipl_ccw_loadparm_attr =
 	__ATTR(loadparm, 0644, reipl_ccw_loadparm_show,
 	       reipl_ccw_loadparm_store);
 
@@ -617,12 +626,14 @@ static int reipl_set_type(enum ipl_type 
 	return 0;
 }
 
-static ssize_t reipl_type_show(struct kset *kset, char *page)
+static ssize_t reipl_type_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *page)
 {
 	return sprintf(page, "%s\n", ipl_type_str(reipl_type));
 }
 
-static ssize_t reipl_type_store(struct kset *kset, const char *buf,
+static ssize_t reipl_type_store(struct kobject *kobj,
+				struct kobj_attribute *attr, const char *buf,
 				size_t len)
 {
 	int rc = -EINVAL;
@@ -636,10 +647,10 @@ static ssize_t reipl_type_store(struct k
 	return (rc != 0) ? rc : len;
 }
 
-static struct subsys_attribute reipl_type_attr =
+static struct kobj_attribute reipl_type_attr =
 		__ATTR(reipl_type, 0644, reipl_type_show, reipl_type_store);
 
-static decl_subsys(reipl, NULL, NULL);
+static struct kset *reipl_kset;
 
 void reipl_run(struct shutdown_trigger *trigger)
 {
@@ -712,7 +723,7 @@ static int __init reipl_nss_init(void)
 
 	if (!MACHINE_IS_VM)
 		return 0;
-	rc = sysfs_create_group(&reipl_subsys.kobj, &reipl_nss_attr_group);
+	rc = sysfs_create_group(&reipl_kset->kobj, &reipl_nss_attr_group);
 	if (rc)
 		return rc;
 	strncpy(reipl_nss_name, kernel_nss_name, NSS_NAME_SIZE + 1);
@@ -727,7 +738,7 @@ static int __init reipl_ccw_init(void)
 	reipl_block_ccw = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!reipl_block_ccw)
 		return -ENOMEM;
-	rc = sysfs_create_group(&reipl_subsys.kobj, &reipl_ccw_attr_group);
+	rc = sysfs_create_group(&reipl_kset->kobj, &reipl_ccw_attr_group);
 	if (rc) {
 		free_page((unsigned long)reipl_block_ccw);
 		return rc;
@@ -765,7 +776,7 @@ static int __init reipl_fcp_init(void)
 	reipl_block_fcp = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!reipl_block_fcp)
 		return -ENOMEM;
-	rc = sysfs_create_group(&reipl_subsys.kobj, &reipl_fcp_attr_group);
+	rc = sysfs_create_group(&reipl_kset->kobj, &reipl_fcp_attr_group);
 	if (rc) {
 		free_page((unsigned long)reipl_block_fcp);
 		return rc;
@@ -787,12 +798,13 @@ static int reipl_init(void)
 {
 	int rc;
 
-	rc = firmware_register(&reipl_subsys);
-	if (rc)
-		return rc;
-	rc = subsys_create_file(&reipl_subsys, &reipl_type_attr);
+	reipl_kset = kset_create_and_register("reipl", NULL, firmware_kobj,
+					      NULL);
+	if (!reipl_kset)
+		return -ENOMEM;
+	rc = sysfs_create_file(&reipl_kset->kobj, &reipl_type_attr.attr);
 	if (rc) {
-		firmware_unregister(&reipl_subsys);
+		kset_unregister(reipl_kset);
 		return rc;
 	}
 	rc = reipl_ccw_init();
@@ -882,12 +894,14 @@ static int dump_set_type(enum dump_type 
 	return 0;
 }
 
-static ssize_t dump_type_show(struct kset *kset, char *page)
+static ssize_t dump_type_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *page)
 {
 	return sprintf(page, "%s\n", dump_type_str(dump_type));
 }
 
-static ssize_t dump_type_store(struct kset *kset, const char *buf,
+static ssize_t dump_type_store(struct kobject *kobj,
+			       struct kobj_attribute *attr, const char *buf,
 			       size_t len)
 {
 	int rc = -EINVAL;
@@ -901,10 +915,10 @@ static ssize_t dump_type_store(struct ks
 	return (rc != 0) ? rc : len;
 }
 
-static struct subsys_attribute dump_type_attr =
+static struct kobj_attribute dump_type_attr =
 		__ATTR(dump_type, 0644, dump_type_show, dump_type_store);
 
-static decl_subsys(dump, NULL, NULL);
+static struct kset *dump_kset;
 
 static void dump_run(struct shutdown_trigger *trigger)
 {
@@ -947,7 +961,7 @@ static int __init dump_ccw_init(void)
 	dump_block_ccw = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!dump_block_ccw)
 		return -ENOMEM;
-	rc = sysfs_create_group(&dump_subsys.kobj, &dump_ccw_attr_group);
+	rc = sysfs_create_group(&dump_kset->kobj, &dump_ccw_attr_group);
 	if (rc) {
 		free_page((unsigned long)dump_block_ccw);
 		return rc;
@@ -971,7 +985,7 @@ static int __init dump_fcp_init(void)
 	dump_block_fcp = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!dump_block_fcp)
 		return -ENOMEM;
-	rc = sysfs_create_group(&dump_subsys.kobj, &dump_fcp_attr_group);
+	rc = sysfs_create_group(&dump_kset->kobj, &dump_fcp_attr_group);
 	if (rc) {
 		free_page((unsigned long)dump_block_fcp);
 		return rc;
@@ -989,12 +1003,13 @@ static int dump_init(void)
 {
 	int rc;
 
-	rc = firmware_register(&dump_subsys);
-	if (rc)
-		return rc;
-	rc = subsys_create_file(&dump_subsys, &dump_type_attr);
+	dump_kset = kset_create_and_register("dump", NULL, firmware_kobj,
+					     NULL);
+	if (!dump_kset)
+		return -ENOMEM;
+	rc = sysfs_create_file(&dump_kset->kobj, &dump_type_attr.attr);
 	if (rc) {
-		firmware_unregister(&dump_subsys);
+		kset_unregister(dump_kset);
 		return rc;
 	}
 	rc = dump_ccw_init();
@@ -1036,7 +1051,7 @@ static struct attribute_group vmcmd_attr
 	.attrs = vmcmd_attrs,
 };
 
-static decl_subsys(vmcmd, NULL, NULL);
+static struct kset *vmcmd_kset;
 
 static void vmcmd_run(struct shutdown_trigger *trigger)
 {
@@ -1068,14 +1083,13 @@ static void vmcmd_run(struct shutdown_tr
 
 static int vmcmd_init(void)
 {
-	int rc;
-
 	if (!MACHINE_IS_VM)
 		return -ENOTSUPP;
-	rc = firmware_register(&vmcmd_subsys);
-	if (rc)
-		return rc;
-	return sysfs_create_group(&vmcmd_subsys.kobj, &vmcmd_attr_group);
+	vmcmd_kset = kset_create_and_register("vmcmd", NULL, firmware_kobj,
+					      NULL);
+	if (!vmcmd_kset)
+		return -ENOMEM;
+	return sysfs_create_group(&vmcmd_kset->kobj, &vmcmd_attr_group);
 }
 
 static struct shutdown_action vmcmd_action = {SHUTDOWN_ACTION_VMCMD_STR,
@@ -1104,7 +1118,7 @@ static struct shutdown_action *shutdown_
  * Trigger section
  */
 
-static decl_subsys(shutdown_actions, NULL, NULL);
+static struct kset *shutdown_actions_kset;
 
 static int set_trigger(const char *buf, struct shutdown_trigger *trigger,
 		       size_t len)
@@ -1128,17 +1142,20 @@ static int set_trigger(const char *buf, 
 static struct shutdown_trigger on_reboot_trigger = {ON_REIPL_STR,
 						    &reipl_action};
 
-static ssize_t on_reboot_show(struct kset *kset, char *page)
+static ssize_t on_reboot_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *page)
 {
 	return sprintf(page, "%s\n", on_reboot_trigger.action->name);
 }
 
-static ssize_t on_reboot_store(struct kset *kset, const char *buf, size_t len)
+static ssize_t on_reboot_store(struct kobject *kobj,
+			       struct kobj_attribute *attr,
+			       const char *buf, size_t len)
 {
 	return set_trigger(buf, &on_reboot_trigger, len);
 }
 
-static struct subsys_attribute on_reboot_attr =
+static struct kobj_attribute on_reboot_attr =
 		__ATTR(on_reboot, 0644, on_reboot_show, on_reboot_store);
 
 static void do_machine_restart(char *__unused)
@@ -1153,18 +1170,20 @@ void (*_machine_restart)(char *command) 
 
 static struct shutdown_trigger on_panic_trigger = {ON_PANIC_STR, &stop_action};
 
-static ssize_t on_panic_show(struct kset *kset, char *page)
+static ssize_t on_panic_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *page)
 {
 	return sprintf(page, "%s\n", on_panic_trigger.action->name);
 }
 
-static ssize_t on_panic_store(struct kset *kset, const char *buf,
+static ssize_t on_panic_store(struct kobject *kobj,
+			      struct kobj_attribute *attr, const char *buf,
 			      size_t len)
 {
 	return set_trigger(buf, &on_panic_trigger, len);
 }
 
-static struct subsys_attribute on_panic_attr =
+static struct kobj_attribute on_panic_attr =
 		__ATTR(on_panic, 0644, on_panic_show, on_panic_store);
 
 static void do_panic(void)
@@ -1177,17 +1196,19 @@ static void do_panic(void)
 
 static struct shutdown_trigger on_halt_trigger = {ON_HALT_STR, &stop_action};
 
-static ssize_t on_halt_show(struct kset *kset, char *page)
+static ssize_t on_halt_show(struct kobject *kobj, struct kobj_attribute *attr,
+			    char *page)
 {
 	return sprintf(page, "%s\n", on_halt_trigger.action->name);
 }
 
-static ssize_t on_halt_store(struct kset *kset, const char *buf, size_t len)
+static ssize_t on_halt_store(struct kobject *kobj, struct kobj_attribute *attr,
+			     const char *buf, size_t len)
 {
 	return set_trigger(buf, &on_halt_trigger, len);
 }
 
-static struct subsys_attribute on_halt_attr =
+static struct kobj_attribute on_halt_attr =
 		__ATTR(on_halt, 0644, on_halt_show, on_halt_store);
 
 
@@ -1203,17 +1224,19 @@ void (*_machine_halt)(void) = do_machine
 
 static struct shutdown_trigger on_poff_trigger = {ON_POFF_STR, &stop_action};
 
-static ssize_t on_poff_show(struct kset *kset, char *page)
+static ssize_t on_poff_show(struct kobject *kobj, struct kobj_attribute *attr,
+			    char *page)
 {
 	return sprintf(page, "%s\n", on_poff_trigger.action->name);
 }
 
-static ssize_t on_poff_store(struct kset *kset, const char *buf, size_t len)
+static ssize_t on_poff_store(struct kobject *kobj, struct kobj_attribute *attr,
+			     const char *buf, size_t len)
 {
 	return set_trigger(buf, &on_poff_trigger, len);
 }
 
-static struct subsys_attribute on_poff_attr =
+static struct kobj_attribute on_poff_attr =
 		__ATTR(on_poff, 0644, on_poff_show, on_poff_store);
 
 
@@ -1227,15 +1250,22 @@ void (*_machine_power_off)(void) = do_ma
 
 static void __init shutdown_triggers_init(void)
 {
-	if (firmware_register(&shutdown_actions_subsys))
+	shutdown_actions_kset = kset_create_and_register("shutdown_actions",
+							 NULL, firmware_kobj,
+							 NULL);
+	if (!shutdown_actions_kset)
 		goto fail;
-	if (subsys_create_file(&shutdown_actions_subsys, &on_reboot_attr))
+	if (sysfs_create_file(&shutdown_actions_kset->kobj,
+			      &on_reboot_attr.attr))
 		goto fail;
-	if (subsys_create_file(&shutdown_actions_subsys, &on_panic_attr))
+	if (sysfs_create_file(&shutdown_actions_kset->kobj,
+			      &on_panic_attr.attr))
 		goto fail;
-	if (subsys_create_file(&shutdown_actions_subsys, &on_halt_attr))
+	if (sysfs_create_file(&shutdown_actions_kset->kobj,
+			      &on_halt_attr.attr))
 		goto fail;
-	if (subsys_create_file(&shutdown_actions_subsys, &on_poff_attr))
+	if (sysfs_create_file(&shutdown_actions_kset->kobj,
+			      &on_poff_attr.attr))
 		goto fail;
 
 	return;
