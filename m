Return-Path: <linux-kernel-owner+w=401wt.eu-S1756152AbZHNL26@vger.kernel.org>
Message-Id: <20090814112617.716407111@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 22/34] kernel: Append scpdata to kernel boot command line
Content-Disposition: inline; filename=121-scsi-ipl-parmaters.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Append scpdata to the kernel boot command line. If scpdata starts
with the equal sign (=), the kernel boot command line is replaced.
(For consistency with zIPL and IPL PARM parameters.)

To use scpdata for the kernel boot command line, scpdata must consist
of ascii characters only. If scpdata contains other characters,
scpdata is not appended to the kernel boot command line.
In addition, re-IPL is extended for setting scpdata for the next
Linux reboot.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/ipl.h   |    5 +
 arch/s390/include/asm/setup.h |    2 
 arch/s390/kernel/early.c      |   35 ++++++---
 arch/s390/kernel/ipl.c        |  157 +++++++++++++++++++++++++++++++++++++-----
 4 files changed, 172 insertions(+), 27 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/ipl.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/ipl.h
+++ quilt-2.6/arch/s390/include/asm/ipl.h
@@ -57,6 +57,8 @@ struct ipl_block_fcp {
 } __attribute__((packed));
 
 #define DIAG308_VMPARM_SIZE	64
+#define DIAG308_SCPDATA_SIZE	(PAGE_SIZE - (sizeof(struct ipl_list_hdr) + \
+				 offsetof(struct ipl_block_fcp, scp_data)))
 
 struct ipl_block_ccw {
 	u8  load_parm[8];
@@ -91,7 +93,8 @@ extern void do_halt(void);
 extern void do_poff(void);
 extern void ipl_save_parameters(void);
 extern void ipl_update_parameters(void);
-extern void get_ipl_vmparm(char *);
+extern size_t append_ipl_vmparm(char *, size_t);
+extern size_t append_ipl_scpdata(char *, size_t);
 
 enum {
 	IPL_DEVNO_VALID		= 1,
Index: quilt-2.6/arch/s390/include/asm/setup.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/setup.h
+++ quilt-2.6/arch/s390/include/asm/setup.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
 
-#define COMMAND_LINE_SIZE	1024
+#define COMMAND_LINE_SIZE	4096
 
 #define ARCH_COMMAND_LINE_SIZE	896
 
Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -81,6 +81,8 @@ asm(
 	"	br	14\n"
 	"	.size	savesys_ipl_nss, .-savesys_ipl_nss\n");
 
+static __initdata char upper_command_line[COMMAND_LINE_SIZE];
+
 static noinline __init void create_kernel_nss(void)
 {
 	unsigned int i, stext_pfn, eshared_pfn, end_pfn, min_size;
@@ -90,7 +92,6 @@ static noinline __init void create_kerne
 	int response;
 	size_t len;
 	char *savesys_ptr;
-	char upper_command_line[COMMAND_LINE_SIZE];
 	char defsys_cmd[DEFSYS_CMD_SIZE];
 	char savesys_cmd[SAVESYS_CMD_SIZE];
 
@@ -367,21 +368,35 @@ static __init void rescue_initrd(void)
 }
 
 /* Set up boot command line */
-static void __init setup_boot_command_line(void)
+static void __init append_to_cmdline(size_t (*ipl_data)(char *, size_t))
 {
-	char *parm = NULL;
+	char *parm, *delim;
+	size_t rc, len;
+
+	len = strlen(boot_command_line);
+
+	delim = boot_command_line + len;	/* '\0' character position */
+	parm  = boot_command_line + len + 1;	/* append right after '\0' */
+
+	rc = ipl_data(parm, COMMAND_LINE_SIZE - len - 1);
+	if (rc) {
+		if (*parm == '=')
+			memmove(boot_command_line, parm + 1, rc);
+		else
+			*delim = ' ';		/* replace '\0' with space */
+	}
+}
 
+static void __init setup_boot_command_line(void)
+{
 	/* copy arch command line */
 	strlcpy(boot_command_line, COMMAND_LINE, ARCH_COMMAND_LINE_SIZE);
 
 	/* append IPL PARM data to the boot command line */
-	if (MACHINE_IS_VM) {
-		parm = boot_command_line + strlen(boot_command_line);
-		*parm++ = ' ';
-		get_ipl_vmparm(parm);
-		if (parm[0] == '=')
-			memmove(boot_command_line, parm + 1, strlen(parm));
-	}
+	if (MACHINE_IS_VM)
+		append_to_cmdline(append_ipl_vmparm);
+
+	append_to_cmdline(append_ipl_scpdata);
 }
 
 
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -272,17 +272,18 @@ static ssize_t ipl_type_show(struct kobj
 static struct kobj_attribute sys_ipl_type_attr = __ATTR_RO(ipl_type);
 
 /* VM IPL PARM routines */
-static void reipl_get_ascii_vmparm(char *dest,
+size_t reipl_get_ascii_vmparm(char *dest, size_t size,
 				   const struct ipl_parameter_block *ipb)
 {
 	int i;
-	int len = 0;
+	size_t len;
 	char has_lowercase = 0;
 
+	len = 0;
 	if ((ipb->ipl_info.ccw.vm_flags & DIAG308_VM_FLAGS_VP_VALID) &&
 	    (ipb->ipl_info.ccw.vm_parm_len > 0)) {
 
-		len = ipb->ipl_info.ccw.vm_parm_len;
+		len = min_t(size_t, size - 1, ipb->ipl_info.ccw.vm_parm_len);
 		memcpy(dest, ipb->ipl_info.ccw.vm_parm, len);
 		/* If at least one character is lowercase, we assume mixed
 		 * case; otherwise we convert everything to lowercase.
@@ -299,14 +300,20 @@ static void reipl_get_ascii_vmparm(char 
 		EBCASC(dest, len);
 	}
 	dest[len] = 0;
+
+	return len;
 }
 
-void get_ipl_vmparm(char *dest)
+size_t append_ipl_vmparm(char *dest, size_t size)
 {
+	size_t rc;
+
+	rc = 0;
 	if (diag308_set_works && (ipl_block.hdr.pbt == DIAG308_IPL_TYPE_CCW))
-		reipl_get_ascii_vmparm(dest, &ipl_block);
+		rc = reipl_get_ascii_vmparm(dest, size, &ipl_block);
 	else
 		dest[0] = 0;
+	return rc;
 }
 
 static ssize_t ipl_vm_parm_show(struct kobject *kobj,
@@ -314,10 +321,56 @@ static ssize_t ipl_vm_parm_show(struct k
 {
 	char parm[DIAG308_VMPARM_SIZE + 1] = {};
 
-	get_ipl_vmparm(parm);
+	append_ipl_vmparm(parm, sizeof(parm));
 	return sprintf(page, "%s\n", parm);
 }
 
+static size_t scpdata_length(const char* buf, size_t count)
+{
+	while (count) {
+		if (buf[count - 1] != '\0' && buf[count - 1] != ' ')
+			break;
+		count--;
+	}
+	return count;
+}
+
+size_t reipl_append_ascii_scpdata(char *dest, size_t size,
+				  const struct ipl_parameter_block *ipb)
+{
+	size_t count;
+	size_t i;
+
+	count = min(size - 1, scpdata_length(ipb->ipl_info.fcp.scp_data,
+					     ipb->ipl_info.fcp.scp_data_len));
+	if (!count)
+		goto out;
+
+	for (i = 0; i < count; i++)
+		if (!isascii(ipb->ipl_info.fcp.scp_data[i])) {
+			count = 0;
+			goto out;
+		}
+
+	memcpy(dest, ipb->ipl_info.fcp.scp_data, count);
+out:
+	dest[count] = '\0';
+	return count;
+}
+
+size_t append_ipl_scpdata(char *dest, size_t len)
+{
+	size_t rc;
+
+	rc = 0;
+	if (ipl_block.hdr.pbt == DIAG308_IPL_TYPE_FCP)
+		rc = reipl_append_ascii_scpdata(dest, len, &ipl_block);
+	else
+		dest[0] = 0;
+	return rc;
+}
+
+
 static struct kobj_attribute sys_ipl_vm_parm_attr =
 	__ATTR(parm, S_IRUGO, ipl_vm_parm_show, NULL);
 
@@ -553,7 +606,7 @@ static ssize_t reipl_generic_vmparm_show
 {
 	char vmparm[DIAG308_VMPARM_SIZE + 1] = {};
 
-	reipl_get_ascii_vmparm(vmparm, ipb);
+	reipl_get_ascii_vmparm(vmparm, sizeof(vmparm), ipb);
 	return sprintf(page, "%s\n", vmparm);
 }
 
@@ -626,6 +679,59 @@ static struct kobj_attribute sys_reipl_c
 
 /* FCP reipl device attributes */
 
+static ssize_t reipl_fcp_scpdata_read(struct kobject *kobj,
+				      struct bin_attribute *attr,
+				      char *buf, loff_t off, size_t count)
+{
+	size_t size = reipl_block_fcp->ipl_info.fcp.scp_data_len;
+	void *scp_data = reipl_block_fcp->ipl_info.fcp.scp_data;
+
+	return memory_read_from_buffer(buf, count, &off, scp_data, size);
+}
+
+static ssize_t reipl_fcp_scpdata_write(struct kobject *kobj,
+				       struct bin_attribute *attr,
+				       char *buf, loff_t off, size_t count)
+{
+	size_t padding;
+	size_t scpdata_len;
+
+	if (off < 0)
+		return -EINVAL;
+
+	if (off >= DIAG308_SCPDATA_SIZE)
+		return -ENOSPC;
+
+	if (count > DIAG308_SCPDATA_SIZE - off)
+		count = DIAG308_SCPDATA_SIZE - off;
+
+	memcpy(reipl_block_fcp->ipl_info.fcp.scp_data, buf + off, count);
+	scpdata_len = off + count;
+
+	if (scpdata_len % 8) {
+		padding = 8 - (scpdata_len % 8);
+		memset(reipl_block_fcp->ipl_info.fcp.scp_data + scpdata_len,
+		       0, padding);
+		scpdata_len += padding;
+	}
+
+	reipl_block_fcp->ipl_info.fcp.scp_data_len = scpdata_len;
+	reipl_block_fcp->hdr.len = IPL_PARM_BLK_FCP_LEN + scpdata_len;
+	reipl_block_fcp->hdr.blk0_len = IPL_PARM_BLK0_FCP_LEN + scpdata_len;
+
+	return count;
+}
+
+static struct bin_attribute sys_reipl_fcp_scp_data_attr = {
+	.attr = {
+		.name = "scp_data",
+		.mode = S_IRUGO | S_IWUSR,
+	},
+	.size = PAGE_SIZE,
+	.read = reipl_fcp_scpdata_read,
+	.write = reipl_fcp_scpdata_write,
+};
+
 DEFINE_IPL_ATTR_RW(reipl_fcp, wwpn, "0x%016llx\n", "%016llx\n",
 		   reipl_block_fcp->ipl_info.fcp.wwpn);
 DEFINE_IPL_ATTR_RW(reipl_fcp, lun, "0x%016llx\n", "%016llx\n",
@@ -647,7 +753,6 @@ static struct attribute *reipl_fcp_attrs
 };
 
 static struct attribute_group reipl_fcp_attr_group = {
-	.name  = IPL_FCP_STR,
 	.attrs = reipl_fcp_attrs,
 };
 
@@ -895,6 +1000,7 @@ static struct kobj_attribute reipl_type_
 	__ATTR(reipl_type, 0644, reipl_type_show, reipl_type_store);
 
 static struct kset *reipl_kset;
+static struct kset *reipl_fcp_kset;
 
 static void get_ipl_string(char *dst, struct ipl_parameter_block *ipb,
 			   const enum ipl_method m)
@@ -906,7 +1012,7 @@ static void get_ipl_string(char *dst, st
 
 	reipl_get_ascii_loadparm(loadparm, ipb);
 	reipl_get_ascii_nss_name(nss_name, ipb);
-	reipl_get_ascii_vmparm(vmparm, ipb);
+	reipl_get_ascii_vmparm(vmparm, sizeof(vmparm), ipb);
 
 	switch (m) {
 	case REIPL_METHOD_CCW_VM:
@@ -1076,23 +1182,44 @@ static int __init reipl_fcp_init(void)
 	int rc;
 
 	if (!diag308_set_works) {
-		if (ipl_info.type == IPL_TYPE_FCP)
+		if (ipl_info.type == IPL_TYPE_FCP) {
 			make_attrs_ro(reipl_fcp_attrs);
-		else
+			sys_reipl_fcp_scp_data_attr.attr.mode = S_IRUGO;
+		} else
 			return 0;
 	}
 
 	reipl_block_fcp = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!reipl_block_fcp)
 		return -ENOMEM;
-	rc = sysfs_create_group(&reipl_kset->kobj, &reipl_fcp_attr_group);
+
+	/* sysfs: create fcp kset for mixing attr group and bin attrs */
+	reipl_fcp_kset = kset_create_and_add(IPL_FCP_STR, NULL,
+					     &reipl_kset->kobj);
+	if (!reipl_kset) {
+		free_page((unsigned long) reipl_block_fcp);
+		return -ENOMEM;
+	}
+
+	rc = sysfs_create_group(&reipl_fcp_kset->kobj, &reipl_fcp_attr_group);
 	if (rc) {
-		free_page((unsigned long)reipl_block_fcp);
+		kset_unregister(reipl_fcp_kset);
+		free_page((unsigned long) reipl_block_fcp);
 		return rc;
 	}
-	if (ipl_info.type == IPL_TYPE_FCP) {
+
+	rc = sysfs_create_bin_file(&reipl_fcp_kset->kobj,
+				   &sys_reipl_fcp_scp_data_attr);
+	if (rc) {
+		sysfs_remove_group(&reipl_fcp_kset->kobj, &reipl_fcp_attr_group);
+		kset_unregister(reipl_fcp_kset);
+		free_page((unsigned long) reipl_block_fcp);
+		return rc;
+	}
+
+	if (ipl_info.type == IPL_TYPE_FCP)
 		memcpy(reipl_block_fcp, IPL_PARMBLOCK_START, PAGE_SIZE);
-	} else {
+	else {
 		reipl_block_fcp->hdr.len = IPL_PARM_BLK_FCP_LEN;
 		reipl_block_fcp->hdr.version = IPL_PARM_BLOCK_VERSION;
 		reipl_block_fcp->hdr.blk0_len = IPL_PARM_BLK0_FCP_LEN;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
