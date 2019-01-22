Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] s390: kernel: no need to check return value of debugfs_create functions
Date: Tue, 22 Jan 2019 16:21:02 +0100
Message-Id: <20190122152151.16139-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/debug.c    | 6 ------
 arch/s390/kernel/kdebugfs.c | 2 --
 arch/s390/kernel/sysinfo.c  | 2 --
 3 files changed, 10 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index d374f9b218b4..0ebf08c3b35e 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1056,12 +1056,6 @@ int debug_register_view(debug_info_t *id, struct debug_view *view)
 		mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
 	pde = debugfs_create_file(view->name, mode, id->debugfs_root_entry,
 				  id, &debug_file_ops);
-	if (!pde) {
-		pr_err("Registering view %s/%s failed due to out of "
-		       "memory\n", id->name, view->name);
-		rc = -1;
-		goto out;
-	}
 	spin_lock_irqsave(&id->lock, flags);
 	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
 		if (!id->views[i])
diff --git a/arch/s390/kernel/kdebugfs.c b/arch/s390/kernel/kdebugfs.c
index 2c46bd6c6fd2..33130c7daf55 100644
--- a/arch/s390/kernel/kdebugfs.c
+++ b/arch/s390/kernel/kdebugfs.c
@@ -9,8 +9,6 @@ EXPORT_SYMBOL(arch_debugfs_dir);
 static int __init arch_kdebugfs_init(void)
 {
 	arch_debugfs_dir = debugfs_create_dir("s390", NULL);
-	if (IS_ERR(arch_debugfs_dir))
-		arch_debugfs_dir = NULL;
 	return 0;
 }
 postcore_initcall(arch_kdebugfs_init);
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 12f80d1f0415..2ac3c9b56a13 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -545,8 +545,6 @@ static __init int stsi_init_debugfs(void)
 	int lvl, i;
 
 	stsi_root = debugfs_create_dir("stsi", arch_debugfs_dir);
-	if (IS_ERR_OR_NULL(stsi_root))
-		return 0;
 	lvl = stsi(NULL, 0, 0, 0);
 	if (lvl > 0)
 		stsi_0_0_0 = lvl;
-- 
2.20.1
