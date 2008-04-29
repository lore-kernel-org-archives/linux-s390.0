Return-Path: <linux-kernel-owner+w=401wt.eu-S1765982AbYD2OVX@vger.kernel.org>
Message-Id: <20080429140251.004942050@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/15] uaccess_mvcos: #ifdef config dependent code.
Content-Disposition: inline; filename=010-uaccess-warning.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

arch/s390/lib/uaccess_mvcos.c:166:
 warning: 'strnlen_user_mvcos' defined but not used
arch/s390/lib/uaccess_mvcos.c:186:
 warning: 'strncpy_from_user_mvcos' defined but not used

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/uaccess_mvcos.c |    2 ++
 1 file changed, 2 insertions(+)

Index: quilt-2.6/arch/s390/lib/uaccess_mvcos.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/uaccess_mvcos.c
+++ quilt-2.6/arch/s390/lib/uaccess_mvcos.c
@@ -162,6 +162,7 @@ static size_t clear_user_mvcos(size_t si
 	return size;
 }
 
+#ifdef CONFIG_S390_SWITCH_AMODE
 static size_t strnlen_user_mvcos(size_t count, const char __user *src)
 {
 	char buf[256];
@@ -199,6 +200,7 @@ static size_t strncpy_from_user_mvcos(si
 	} while ((len_str == len) && (done < count));
 	return done;
 }
+#endif /* CONFIG_S390_SWITCH_AMODE */
 
 struct uaccess_ops uaccess_mvcos = {
 	.copy_from_user = copy_from_user_mvcos_check,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
