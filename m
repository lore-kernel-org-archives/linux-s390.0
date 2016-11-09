Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 10:29:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] two bug fixes for 4.9-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161109102909.79ad19d1@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Two bug fixes
 * A memory alignment fix in the s390 only hypfs code
 * A fix for the generic percpu code that caused ftrace to break on s390.
   This is not relevant for x86 but for all architectures that use the
   generic percpu code.

Heiko Carstens (1):
      percpu: use notrace variant of preempt_disable/preempt_enable

Michael Holzheu (1):
      s390/hypfs: Use get_free_page() instead of kmalloc to ensure page alignment

 arch/s390/hypfs/hypfs_diag.c | 6 +++---
 include/asm-generic/percpu.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 28f03ca..794bebb 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -363,11 +363,11 @@ static void *diag204_store(void)
 static int diag224_get_name_table(void)
 {
 	/* memory must be below 2GB */
-	diag224_cpu_names = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
+	diag224_cpu_names = (char *) __get_free_page(GFP_KERNEL | GFP_DMA);
 	if (!diag224_cpu_names)
 		return -ENOMEM;
 	if (diag224(diag224_cpu_names)) {
-		kfree(diag224_cpu_names);
+		free_page((unsigned long) diag224_cpu_names);
 		return -EOPNOTSUPP;
 	}
 	EBCASC(diag224_cpu_names + 16, (*diag224_cpu_names + 1) * 16);
@@ -376,7 +376,7 @@ static int diag224_get_name_table(void)
 
 static void diag224_delete_name_table(void)
 {
-	kfree(diag224_cpu_names);
+	free_page((unsigned long) diag224_cpu_names);
 }
 
 static int diag224_idx2name(int index, char *name)
diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 40e8870..0504ef8 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -118,9 +118,9 @@
 #define this_cpu_generic_read(pcp)					\
 ({									\
 	typeof(pcp) __ret;						\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	__ret = raw_cpu_generic_read(pcp);				\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	__ret;								\
 })
 
