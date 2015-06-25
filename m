Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Minfei Huang <mhuang@redhat.com>
Subject: [PATCH] kexec: Make a pair of reserved pages when kdump fails to start
Date: Thu, 25 Jun 2015 11:31:22 +0800
Message-Id: <1435203082-25338-1-git-send-email-mhuang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ebiederm@xmission.com, vgoyal@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, holzheu@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

From: Minfei Huang <mnfhuang@gmail.com>

For some arch, kexec shall map the reserved pages, then use them, when
we try to start the kdump service.

Now kexec will never unmap the reserved pages, once it fails to continue
starting the kdump service.

Make a pair of reserved pages in kdump starting path, whatever kexec
fails or not.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
---
 kernel/kexec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 7a36fdc..ab32d59 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1308,19 +1308,23 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 			image->preserve_context = 1;
 		result = machine_kexec_prepare(image);
 		if (result)
-			goto out;
+			goto failure;
 
 		for (i = 0; i < nr_segments; i++) {
 			result = kimage_load_segment(image, &image->segment[i]);
 			if (result)
-				goto out;
+				goto failure;
 		}
 		kimage_terminate(image);
+
+failure:
 		if (flags & KEXEC_ON_CRASH)
 			crash_unmap_reserved_pages();
 	}
-	/* Install the new kernel, and  Uninstall the old */
-	image = xchg(dest_image, image);
+
+	if (result == 0)
+		/* Install the new kernel, and  Uninstall the old */
+		image = xchg(dest_image, image);
 
 out:
 	mutex_unlock(&kexec_mutex);
-- 
2.2.2
