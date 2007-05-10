Return-Path: <linux-kernel-owner+w=401wt.eu-S1761493AbXEJN4x@vger.kernel.org>
Message-Id: <20070510135642.850309141@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:51:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/15] fix subsystem removal fallout
Content-Disposition: inline; filename=001-kset.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

This patch fixes compilation on s390 after the removal of
struct subsystem.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/inode.c |    2 +-
 arch/s390/kernel/ipl.c  |   26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

Index: quilt-2.6/arch/s390/hypfs/inode.c
===================================================================
--- quilt-2.6.orig/arch/s390/hypfs/inode.c
+++ quilt-2.6/arch/s390/hypfs/inode.c
@@ -477,7 +477,7 @@ static int __init hypfs_init(void)
 			goto fail_diag;
 		}
 	}
-	kset_set_kset_s(&s390_subsys, hypervisor_subsys);
+	kobj_set_kset_s(&s390_subsys, hypervisor_subsys);
 	rc = subsystem_register(&s390_subsys);
 	if (rc)
 		goto fail_sysfs;
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -816,23 +816,23 @@ static int __init ipl_register_fcp_files
 {
 	int rc;
 
-	rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+	rc = sysfs_create_group(&ipl_subsys.kobj,
 				&ipl_fcp_attr_group);
 	if (rc)
 		goto out;
-	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+	rc = sysfs_create_bin_file(&ipl_subsys.kobj,
 				   &ipl_parameter_attr);
 	if (rc)
 		goto out_ipl_parm;
-	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+	rc = sysfs_create_bin_file(&ipl_subsys.kobj,
 				   &ipl_scp_data_attr);
 	if (!rc)
 		goto out;
 
-	sysfs_remove_bin_file(&ipl_subsys.kset.kobj, &ipl_parameter_attr);
+	sysfs_remove_bin_file(&ipl_subsys.kobj, &ipl_parameter_attr);
 
 out_ipl_parm:
-	sysfs_remove_group(&ipl_subsys.kset.kobj, &ipl_fcp_attr_group);
+	sysfs_remove_group(&ipl_subsys.kobj, &ipl_fcp_attr_group);
 out:
 	return rc;
 }
@@ -846,7 +846,7 @@ static int __init ipl_init(void)
 		return rc;
 	switch (ipl_info.type) {
 	case IPL_TYPE_CCW:
-		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+		rc = sysfs_create_group(&ipl_subsys.kobj,
 					&ipl_ccw_attr_group);
 		break;
 	case IPL_TYPE_FCP:
@@ -854,11 +854,11 @@ static int __init ipl_init(void)
 		rc = ipl_register_fcp_files();
 		break;
 	case IPL_TYPE_NSS:
-		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+		rc = sysfs_create_group(&ipl_subsys.kobj,
 					&ipl_nss_attr_group);
 		break;
 	default:
-		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+		rc = sysfs_create_group(&ipl_subsys.kobj,
 					&ipl_unknown_attr_group);
 		break;
 	}
@@ -885,7 +885,7 @@ static int __init reipl_nss_init(void)
 
 	if (!MACHINE_IS_VM)
 		return 0;
-	rc = sysfs_create_group(&reipl_subsys.kset.kobj, &reipl_nss_attr_group);
+	rc = sysfs_create_group(&reipl_subsys.kobj, &reipl_nss_attr_group);
 	if (rc)
 		return rc;
 	strncpy(reipl_nss_name, kernel_nss_name, NSS_NAME_SIZE + 1);
@@ -900,7 +900,7 @@ static int __init reipl_ccw_init(void)
 	reipl_block_ccw = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!reipl_block_ccw)
 		return -ENOMEM;
-	rc = sysfs_create_group(&reipl_subsys.kset.kobj, &reipl_ccw_attr_group);
+	rc = sysfs_create_group(&reipl_subsys.kobj, &reipl_ccw_attr_group);
 	if (rc) {
 		free_page((unsigned long)reipl_block_ccw);
 		return rc;
@@ -938,7 +938,7 @@ static int __init reipl_fcp_init(void)
 	reipl_block_fcp = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!reipl_block_fcp)
 		return -ENOMEM;
-	rc = sysfs_create_group(&reipl_subsys.kset.kobj, &reipl_fcp_attr_group);
+	rc = sysfs_create_group(&reipl_subsys.kobj, &reipl_fcp_attr_group);
 	if (rc) {
 		free_page((unsigned long)reipl_block_fcp);
 		return rc;
@@ -990,7 +990,7 @@ static int __init dump_ccw_init(void)
 	dump_block_ccw = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!dump_block_ccw)
 		return -ENOMEM;
-	rc = sysfs_create_group(&dump_subsys.kset.kobj, &dump_ccw_attr_group);
+	rc = sysfs_create_group(&dump_subsys.kobj, &dump_ccw_attr_group);
 	if (rc) {
 		free_page((unsigned long)dump_block_ccw);
 		return rc;
@@ -1014,7 +1014,7 @@ static int __init dump_fcp_init(void)
 	dump_block_fcp = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!dump_block_fcp)
 		return -ENOMEM;
-	rc = sysfs_create_group(&dump_subsys.kset.kobj, &dump_fcp_attr_group);
+	rc = sysfs_create_group(&dump_subsys.kobj, &dump_fcp_attr_group);
 	if (rc) {
 		free_page((unsigned long)dump_block_fcp);
 		return rc;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
