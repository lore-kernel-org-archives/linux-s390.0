Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Jul 2015 17:54:11 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150709175411.7037a4fa@holzheu>
In-Reply-To: <20150707211840.GA4388@redhat.com>
References: <1435801552-1230-1-git-send-email-mnfhuang@gmail.com>
	<20150707211840.GA4388@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Minfei Huang <mnfhuang@gmail.com>, ebiederm@xmission.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 7 Jul 2015 17:18:40 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Thu, Jul 02, 2015 at 09:45:52AM +0800, Minfei Huang wrote:

[snip]

> I am thinking of moving kernel loading code in a separate function to
> make things little simpler. Right now it is confusing.
> 
> Can you please test attached patch. I have only compile tested it. This
> is primarily doing what you are doing but in a separate function. It
> seems more readable now.

The patch looks good to me. What about the following patch on top
to make things even more readable?
---
 kernel/kexec.c |   50 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1236,14 +1236,18 @@ int kexec_load_disabled;
 
 static DEFINE_MUTEX(kexec_mutex);
 
-static int __kexec_load(struct kimage **rimage, unsigned long entry,
-			unsigned long nr_segments,
+static int __kexec_load(unsigned long entry, unsigned long nr_segments,
 			struct kexec_segment __user * segments,
 			unsigned long flags)
 {
+	struct kimage *image, **dest_image;
 	unsigned long i;
 	int result;
-	struct kimage *image;
+
+	dest_image = (flags & KEXEC_ON_CRASH) ? &kexec_crash_image : &kexec_image;
+
+	if (nr_segments == 0)
+		return 0;
 
 	if (flags & KEXEC_ON_CRASH) {
 		/*
@@ -1251,7 +1255,6 @@ static int __kexec_load(struct kimage **
 		 * crashes.  Free any current crash dump kernel before
 		 * we corrupt it.
 		 */
-
 		kimage_free(xchg(&kexec_crash_image, NULL));
 	}
 
@@ -1267,30 +1270,29 @@ static int __kexec_load(struct kimage **
 
 	result = machine_kexec_prepare(image);
 	if (result)
-		goto out;
+		goto fail;
 
 	for (i = 0; i < nr_segments; i++) {
 		result = kimage_load_segment(image, &image->segment[i]);
 		if (result)
-			goto out;
+			goto fail;
 	}
-
 	kimage_terminate(image);
-	*rimage = image;
-out:
+	/* Install the new kernel, and  uninstall the old */
+	kimage_free(xchg(dest_image, image));
 	if (flags & KEXEC_ON_CRASH)
 		crash_unmap_reserved_pages();
-
-	/* Free image if there was an error */
-	if (result)
-		kimage_free(image);
+	return 0;
+fail:
+	if (flags & KEXEC_ON_CRASH)
+		crash_unmap_reserved_pages();
+	kimage_free(image);
 	return result;
 }
 
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	struct kimage **dest_image, *image;
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
@@ -1315,9 +1317,6 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 	if (nr_segments > KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
-	image = NULL;
-	result = 0;
-
 	/* Because we write directly to the reserved memory
 	 * region when loading crash kernels we need a mutex here to
 	 * prevent multiple crash  kernels from attempting to load
@@ -1329,24 +1328,9 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
-	dest_image = &kexec_image;
-	if (flags & KEXEC_ON_CRASH)
-		dest_image = &kexec_crash_image;
-
 	/* Load new kernel */
-	if (nr_segments > 0) {
-		result = __kexec_load(&image, entry, nr_segments, segments,
-				      flags);
-		if (result)
-			goto out;
-	}
-
-	/* Install the new kernel, and  Uninstall the old */
-	image = xchg(dest_image, image);
-
-out:
+	result = __kexec_load(entry, nr_segments, segments, flags);
 	mutex_unlock(&kexec_mutex);
-	kimage_free(image);
 
 	return result;
 }
