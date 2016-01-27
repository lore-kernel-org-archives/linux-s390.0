Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dmitry Safonov <dsafonov@virtuozzo.com>
Subject: [PATCH] kexec: unmap reserved pages for each error-return way
Date: Wed, 27 Jan 2016 14:48:31 +0300
Message-ID: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ebiederm@xmission.com, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org, holzheu@linux.vnet.ibm.com, dyoung@redhat.com, 0x7f454c46@gmail.com, Dmitry Safonov <dsafonov@virtuozzo.com>
List-ID: <linux-s390.vger.kernel.org>

For allocation of kimage failure or kexec_prepare or load segments
errors there is no need to keep crashkernel memory mapped.
It will affect only s390 as map/unmap hook defined only for it.
As on unmap s390 also changes os_info structure let's check return code
and add info only on success.

Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 arch/s390/kernel/machine_kexec.c | 39 +++++++++++++++++----------------------
 include/linux/kexec.h            |  2 +-
 kernel/kexec.c                   |  4 ++--
 kernel/kexec_core.c              |  4 ++--
 4 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index 2f1b721..60bf374 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -49,7 +49,7 @@ static int machine_kdump_pm_cb(struct notifier_block *nb, unsigned long action,
 	case PM_POST_SUSPEND:
 	case PM_POST_HIBERNATION:
 		if (crashk_res.start)
-			crash_unmap_reserved_pages();
+			crash_unmap_reserved_pages(0);
 		break;
 	default:
 		return NOTIFY_DONE;
@@ -147,39 +147,34 @@ static int kdump_csum_valid(struct kimage *image)
 }
 
 /*
- * Map or unmap crashkernel memory
+ * Map crashkernel memory
  */
-static void crash_map_pages(int enable)
+void crash_map_reserved_pages(void)
 {
 	unsigned long size = resource_size(&crashk_res);
 
 	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
 	       size % KEXEC_CRASH_MEM_ALIGN);
-	if (enable)
-		vmem_add_mapping(crashk_res.start, size);
-	else {
-		vmem_remove_mapping(crashk_res.start, size);
-		if (size)
-			os_info_crashkernel_add(crashk_res.start, size);
-		else
-			os_info_crashkernel_add(0, 0);
-	}
-}
-
-/*
- * Map crashkernel memory
- */
-void crash_map_reserved_pages(void)
-{
-	crash_map_pages(1);
+	vmem_add_mapping(crashk_res.start, size);
 }
 
 /*
  * Unmap crashkernel memory
  */
-void crash_unmap_reserved_pages(void)
+void crash_unmap_reserved_pages(int error)
 {
-	crash_map_pages(0);
+	unsigned long size = resource_size(&crashk_res);
+
+	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
+	       size % KEXEC_CRASH_MEM_ALIGN);
+	vmem_remove_mapping(crashk_res.start, size);
+
+	if (error)
+		return;
+	if (size)
+		os_info_crashkernel_add(crashk_res.start, size);
+	else
+		os_info_crashkernel_add(0, 0);
 }
 
 /*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 2cc643c..ef3bd1e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -231,7 +231,7 @@ int kexec_should_crash(struct task_struct *);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 void crash_save_vmcoreinfo(void);
 void crash_map_reserved_pages(void);
-void crash_unmap_reserved_pages(void);
+void crash_unmap_reserved_pages(int error);
 void arch_crash_save_vmcoreinfo(void);
 __printf(1, 2)
 void vmcoreinfo_append_str(const char *fmt, ...);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index ee70aef..dfc6c18 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -204,13 +204,13 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 				goto out;
 		}
 		kimage_terminate(image);
-		if (flags & KEXEC_ON_CRASH)
-			crash_unmap_reserved_pages();
 	}
 	/* Install the new kernel, and  Uninstall the old */
 	image = xchg(dest_image, image);
 
 out:
+	if ((flags & KEXEC_ON_CRASH) && (nr_segments > 0))
+		crash_unmap_reserved_pages(result);
 	mutex_unlock(&kexec_mutex);
 	kimage_free(image);
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8dc6591..cae5d11 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -965,7 +965,7 @@ int crash_shrink_memory(unsigned long new_size)
 	crashk_res.end = end - 1;
 
 	insert_resource(&iomem_resource, ram_res);
-	crash_unmap_reserved_pages();
+	crash_unmap_reserved_pages(0);
 
 unlock:
 	mutex_unlock(&kexec_mutex);
@@ -1555,5 +1555,5 @@ int kernel_kexec(void)
 void __weak crash_map_reserved_pages(void)
 {}
 
-void __weak crash_unmap_reserved_pages(void)
+void __weak crash_unmap_reserved_pages(int error)
 {}
-- 
2.7.0
