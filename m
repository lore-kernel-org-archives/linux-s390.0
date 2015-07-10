Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Minfei Huang <mnfhuang@gmail.com>
Subject: [PATCH v4] kexec: Make a pair of map and unmap reserved pages when kdump fails to start
Date: Fri, 10 Jul 2015 13:12:17 +0800
Message-Id: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ebiederm@xmission.com, vgoyal@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, holzheu@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

For some arch, kexec shall map the reserved pages, then use them, when
we try to start the kdump service.

Now kexec will never unmap the reserved pages, once it fails to continue
starting the kdump service. So we make a pair of map/unmap reserved
pages whatever kexec fails or not in code path.

In order to make code readable, wrap a new function __kexec_load which
contains all of the logic to deal with the image loading.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
---
v3:
- reconstruct the patch, wrap a new function to deal with the code logic, based on Vivek and Michael's patch
v2:
- replace the "failure" label with "fail_unmap_pages"
v1:
- reconstruct the patch code
---
 kernel/kexec.c | 112 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index a785c10..2232c90 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1247,10 +1247,71 @@ int kexec_load_disabled;
 
 static DEFINE_MUTEX(kexec_mutex);
 
+static int __kexec_load(unsigned long entry, unsigned long nr_segments,
+			struct kexec_segment __user *segments,
+			unsigned long flags)
+{
+	int result = 0;
+	struct kimage **dest_image, *image;
+
+	dest_image = &kexec_image;
+
+	if (flags & KEXEC_ON_CRASH)
+		dest_image = &kexec_crash_image;
+
+	if (nr_segments == 0) {
+		/* Install the new kernel, and  Uninstall the old */
+		image = xchg(dest_image, image);
+		kimage_free(image);
+	} else {
+		unsigned long i;
+
+		if (flags & KEXEC_ON_CRASH) {
+			/*
+			 * Loading another kernel to switch to if this one
+			 * crashes.  Free any current crash dump kernel before
+			 * we corrupt it.
+			 */
+			kimage_free(xchg(&kexec_crash_image, NULL));
+		}
+
+		result = kimage_alloc_init(&image, entry,
+				nr_segments, segments, flags);
+		if (result)
+			return result;
+
+		if (flags & KEXEC_ON_CRASH)
+			crash_map_reserved_pages();
+
+		if (flags & KEXEC_PRESERVE_CONTEXT)
+			image->preserve_context = 1;
+
+		result = machine_kexec_prepare(image);
+		if (result)
+			goto failure_unmap_mem;
+
+		for (i = 0; i < nr_segments; i++) {
+			result = kimage_load_segment(image, &image->segment[i]);
+			if (result)
+				goto failure_unmap_mem;
+		}
+
+		kimage_terminate(image);
+
+		/* Install the new kernel, and  Uninstall the old */
+		image = xchg(dest_image, image);
+
+failure_unmap_mem:
+		if (flags & KEXEC_ON_CRASH)
+			crash_unmap_reserved_pages();
+		kimage_free(image);
+	}
+	return result;
+}
+
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	struct kimage **dest_image, *image;
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
@@ -1275,9 +1336,6 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	if (nr_segments > KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
-	image = NULL;
-	result = 0;
-
 	/* Because we write directly to the reserved memory
 	 * region when loading crash kernels we need a mutex here to
 	 * prevent multiple crash  kernels from attempting to load
@@ -1289,53 +1347,9 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
-	dest_image = &kexec_image;
-	if (flags & KEXEC_ON_CRASH)
-		dest_image = &kexec_crash_image;
-	if (nr_segments > 0) {
-		unsigned long i;
-
-		if (flags & KEXEC_ON_CRASH) {
-			/*
-			 * Loading another kernel to switch to if this one
-			 * crashes.  Free any current crash dump kernel before
-			 * we corrupt it.
-			 */
+	result = __kexec_load(entry, nr_segments, segments, flags);
 
-			kimage_free(xchg(&kexec_crash_image, NULL));
-			result = kimage_alloc_init(&image, entry, nr_segments,
-						   segments, flags);
-			crash_map_reserved_pages();
-		} else {
-			/* Loading another kernel to reboot into. */
-
-			result = kimage_alloc_init(&image, entry, nr_segments,
-						   segments, flags);
-		}
-		if (result)
-			goto out;
-
-		if (flags & KEXEC_PRESERVE_CONTEXT)
-			image->preserve_context = 1;
-		result = machine_kexec_prepare(image);
-		if (result)
-			goto out;
-
-		for (i = 0; i < nr_segments; i++) {
-			result = kimage_load_segment(image, &image->segment[i]);
-			if (result)
-				goto out;
-		}
-		kimage_terminate(image);
-		if (flags & KEXEC_ON_CRASH)
-			crash_unmap_reserved_pages();
-	}
-	/* Install the new kernel, and  Uninstall the old */
-	image = xchg(dest_image, image);
-
-out:
 	mutex_unlock(&kexec_mutex);
-	kimage_free(image);
 
 	return result;
 }
-- 
2.2.2
