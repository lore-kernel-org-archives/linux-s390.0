Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] s390: hypfs: no need to check return value of debugfs_create functions
Date: Tue, 22 Jan 2019 16:21:00 +0100
Message-Id: <20190122152151.16139-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/hypfs/hypfs.h        |  6 +++---
 arch/s390/hypfs/hypfs_dbfs.c   |  8 ++------
 arch/s390/hypfs/hypfs_diag.c   |  9 ++++-----
 arch/s390/hypfs/hypfs_diag0c.c |  3 ++-
 arch/s390/hypfs/hypfs_sprp.c   |  6 +++---
 arch/s390/hypfs/hypfs_vm.c     |  3 ++-
 arch/s390/hypfs/inode.c        | 11 +++--------
 7 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/arch/s390/hypfs/hypfs.h b/arch/s390/hypfs/hypfs.h
index 52348e0a812e..05f3f9aee5fc 100644
--- a/arch/s390/hypfs/hypfs.h
+++ b/arch/s390/hypfs/hypfs.h
@@ -43,7 +43,7 @@ int hypfs_diag0c_init(void);
 void hypfs_diag0c_exit(void);
 
 /* Set Partition-Resource Parameter */
-int hypfs_sprp_init(void);
+void hypfs_sprp_init(void);
 void hypfs_sprp_exit(void);
 
 /* debugfs interface */
@@ -69,9 +69,9 @@ struct hypfs_dbfs_file {
 	struct dentry		*dentry;
 };
 
-extern int hypfs_dbfs_init(void);
+extern void hypfs_dbfs_init(void);
 extern void hypfs_dbfs_exit(void);
-extern int hypfs_dbfs_create_file(struct hypfs_dbfs_file *df);
+extern void hypfs_dbfs_create_file(struct hypfs_dbfs_file *df);
 extern void hypfs_dbfs_remove_file(struct hypfs_dbfs_file *df);
 
 #endif /* _HYPFS_H_ */
diff --git a/arch/s390/hypfs/hypfs_dbfs.c b/arch/s390/hypfs/hypfs_dbfs.c
index b9bdf5c1918e..f4c7dbfaf8ee 100644
--- a/arch/s390/hypfs/hypfs_dbfs.c
+++ b/arch/s390/hypfs/hypfs_dbfs.c
@@ -78,14 +78,11 @@ static const struct file_operations dbfs_ops = {
 	.unlocked_ioctl = dbfs_ioctl,
 };
 
-int hypfs_dbfs_create_file(struct hypfs_dbfs_file *df)
+void hypfs_dbfs_create_file(struct hypfs_dbfs_file *df)
 {
 	df->dentry = debugfs_create_file(df->name, 0400, dbfs_dir, df,
 					 &dbfs_ops);
-	if (IS_ERR(df->dentry))
-		return PTR_ERR(df->dentry);
 	mutex_init(&df->lock);
-	return 0;
 }
 
 void hypfs_dbfs_remove_file(struct hypfs_dbfs_file *df)
@@ -93,10 +90,9 @@ void hypfs_dbfs_remove_file(struct hypfs_dbfs_file *df)
 	debugfs_remove(df->dentry);
 }
 
-int hypfs_dbfs_init(void)
+void hypfs_dbfs_init(void)
 {
 	dbfs_dir = debugfs_create_dir("s390_hypfs", NULL);
-	return PTR_ERR_OR_ZERO(dbfs_dir);
 }
 
 void hypfs_dbfs_exit(void)
diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 3452e18bb1ca..f0bc4dc3e9bf 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -440,11 +440,10 @@ __init int hypfs_diag_init(void)
 		pr_err("The hardware system does not support hypfs\n");
 		return -ENODATA;
 	}
-	if (diag204_info_type == DIAG204_INFO_EXT) {
-		rc = hypfs_dbfs_create_file(&dbfs_file_d204);
-		if (rc)
-			return rc;
-	}
+
+	if (diag204_info_type == DIAG204_INFO_EXT)
+		hypfs_dbfs_create_file(&dbfs_file_d204);
+
 	if (MACHINE_IS_LPAR) {
 		rc = diag224_get_name_table();
 		if (rc) {
diff --git a/arch/s390/hypfs/hypfs_diag0c.c b/arch/s390/hypfs/hypfs_diag0c.c
index cebf05150cc1..46bf190234b9 100644
--- a/arch/s390/hypfs/hypfs_diag0c.c
+++ b/arch/s390/hypfs/hypfs_diag0c.c
@@ -125,7 +125,8 @@ int __init hypfs_diag0c_init(void)
 {
 	if (!MACHINE_IS_VM)
 		return 0;
-	return hypfs_dbfs_create_file(&dbfs_file_0c);
+	hypfs_dbfs_create_file(&dbfs_file_0c);
+	return 0;
 }
 
 /*
diff --git a/arch/s390/hypfs/hypfs_sprp.c b/arch/s390/hypfs/hypfs_sprp.c
index 601b70786dc8..7d9fb496d155 100644
--- a/arch/s390/hypfs/hypfs_sprp.c
+++ b/arch/s390/hypfs/hypfs_sprp.c
@@ -137,11 +137,11 @@ static struct hypfs_dbfs_file hypfs_sprp_file = {
 	.unlocked_ioctl = hypfs_sprp_ioctl,
 };
 
-int hypfs_sprp_init(void)
+void hypfs_sprp_init(void)
 {
 	if (!sclp.has_sprp)
-		return 0;
-	return hypfs_dbfs_create_file(&hypfs_sprp_file);
+		return;
+	hypfs_dbfs_create_file(&hypfs_sprp_file);
 }
 
 void hypfs_sprp_exit(void)
diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index c4b7b681e055..42f2375c203e 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -279,7 +279,8 @@ int hypfs_vm_init(void)
 		guest_query = local_guest;
 	else
 		return -EACCES;
-	return hypfs_dbfs_create_file(&dbfs_file_2fc);
+	hypfs_dbfs_create_file(&dbfs_file_2fc);
+	return 0;
 }
 
 void hypfs_vm_exit(void)
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index c681329fdeec..ccad1398abd4 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -456,9 +456,8 @@ static int __init hypfs_init(void)
 {
 	int rc;
 
-	rc = hypfs_dbfs_init();
-	if (rc)
-		return rc;
+	hypfs_dbfs_init();
+
 	if (hypfs_diag_init()) {
 		rc = -ENODATA;
 		goto fail_dbfs_exit;
@@ -467,10 +466,7 @@ static int __init hypfs_init(void)
 		rc = -ENODATA;
 		goto fail_hypfs_diag_exit;
 	}
-	if (hypfs_sprp_init()) {
-		rc = -ENODATA;
-		goto fail_hypfs_vm_exit;
-	}
+	hypfs_sprp_init();
 	if (hypfs_diag0c_init()) {
 		rc = -ENODATA;
 		goto fail_hypfs_sprp_exit;
@@ -489,7 +485,6 @@ static int __init hypfs_init(void)
 	hypfs_diag0c_exit();
 fail_hypfs_sprp_exit:
 	hypfs_sprp_exit();
-fail_hypfs_vm_exit:
 	hypfs_vm_exit();
 fail_hypfs_diag_exit:
 	hypfs_diag_exit();
-- 
2.20.1
