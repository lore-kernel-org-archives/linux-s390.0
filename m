Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 7 Jul 2015 17:18:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150707211840.GA4388@redhat.com>
References: <1435801552-1230-1-git-send-email-mnfhuang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1435801552-1230-1-git-send-email-mnfhuang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Minfei Huang <mnfhuang@gmail.com>
Cc: ebiederm@xmission.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, holzheu@linux.vnet.ibm.com, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 02, 2015 at 09:45:52AM +0800, Minfei Huang wrote:
> For some arch, kexec shall map the reserved pages, then use them, when
> we try to start the kdump service.
> 
> Now kexec will never unmap the reserved pages, once it fails to continue
> starting the kdump service.
> 
> Make a pair of reserved pages in kdump starting path, whatever kexec
> fails or not.
> 
> Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> ---
> v2:
> - replace the "failure" label with "fail_unmap_pages"
> v1:
> - reconstruct the patch code
> ---
>  kernel/kexec.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 

Hi Minfei,

I am thinking of moving kernel loading code in a separate function to
make things little simpler. Right now it is confusing.

Can you please test attached patch. I have only compile tested it. This
is primarily doing what you are doing but in a separate function. It
seems more readable now.

Thanks
Vivek


---
 kernel/kexec.c |   90 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 34 deletions(-)

Index: rhvgoyal-linux/kernel/kexec.c
===================================================================
--- rhvgoyal-linux.orig/kernel/kexec.c	2015-07-06 13:59:35.088129148 -0400
+++ rhvgoyal-linux/kernel/kexec.c	2015-07-07 17:14:23.593175644 -0400
@@ -1247,6 +1247,57 @@ int kexec_load_disabled;
 
 static DEFINE_MUTEX(kexec_mutex);
 
+static int __kexec_load(struct kimage **rimage, unsigned long entry,
+			unsigned long nr_segments,
+			struct kexec_segment __user * segments,
+			unsigned long flags)
+{
+	unsigned long i;
+	int result;
+	struct kimage *image;
+
+	if (flags & KEXEC_ON_CRASH) {
+		/*
+		 * Loading another kernel to switch to if this one
+		 * crashes.  Free any current crash dump kernel before
+		 * we corrupt it.
+		 */
+
+		kimage_free(xchg(&kexec_crash_image, NULL));
+	}
+
+	result = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
+	if (result)
+		return result;
+
+	if (flags & KEXEC_ON_CRASH)
+		crash_map_reserved_pages();
+
+	if (flags & KEXEC_PRESERVE_CONTEXT)
+		image->preserve_context = 1;
+
+	result = machine_kexec_prepare(image);
+	if (result)
+		goto out;
+
+	for (i = 0; i < nr_segments; i++) {
+		result = kimage_load_segment(image, &image->segment[i]);
+		if (result)
+			goto out;
+	}
+
+	kimage_terminate(image);
+	*rimage = image;
+out:
+	if (flags & KEXEC_ON_CRASH)
+		crash_unmap_reserved_pages();
+
+	/* Free image if there was an error */
+	if (result)
+		kimage_free(image);
+	return result;
+}
+
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
@@ -1292,44 +1343,15 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 	dest_image = &kexec_image;
 	if (flags & KEXEC_ON_CRASH)
 		dest_image = &kexec_crash_image;
-	if (nr_segments > 0) {
-		unsigned long i;
 
-		if (flags & KEXEC_ON_CRASH) {
-			/*
-			 * Loading another kernel to switch to if this one
-			 * crashes.  Free any current crash dump kernel before
-			 * we corrupt it.
-			 */
-
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
+	/* Load new kernel */
+	if (nr_segments > 0) {
+		result = __kexec_load(&image, entry, nr_segments, segments,
+				      flags);
 		if (result)
 			goto out;
-
-		for (i = 0; i < nr_segments; i++) {
-			result = kimage_load_segment(image, &image->segment[i]);
-			if (result)
-				goto out;
-		}
-		kimage_terminate(image);
-		if (flags & KEXEC_ON_CRASH)
-			crash_unmap_reserved_pages();
 	}
+
 	/* Install the new kernel, and  Uninstall the old */
 	image = xchg(dest_image, image);
 
