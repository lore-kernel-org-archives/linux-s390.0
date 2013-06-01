Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1370080791.29224.40.camel@localhost.localdomain>
Subject: [PATCH] [S390] hypfs: Cocci spatch "ptr_ret.spatch"
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 01 Jun 2013 11:59:51 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -651,9 +651,7 @@ static int hypfs_create_cpu_files(struct
 	}
 	diag224_idx2name(cpu_info__ctidx(diag204_info_type, cpu_info), buffer);
 	rc = hypfs_create_str(sb, cpu_dir, "type", buffer);
-	if (IS_ERR(rc))
-		return PTR_ERR(rc);
-	return 0;
+	return PTR_RET(rc);
 }
 
 static void *hypfs_create_lpar_files(struct super_block *sb,
@@ -702,9 +700,7 @@ static int hypfs_create_phys_cpu_files(s
 		return PTR_ERR(rc);
 	diag224_idx2name(phys_cpu__ctidx(diag204_info_type, cpu_info), buffer);
 	rc = hypfs_create_str(sb, cpu_dir, "type", buffer);
-	if (IS_ERR(rc))
-		return PTR_ERR(rc);
-	return 0;
+	return PTR_RET(rc);
 }
 
 static void *hypfs_create_phys_files(struct super_block *sb,
