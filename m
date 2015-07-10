Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Jul 2015 11:14:06 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150710111406.279dba14@holzheu>
In-Reply-To: <20150710090322.GA5138@dhcp-128-21.nay.redhat.com>
References: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
	<20150710105413.04e1db00@holzheu>
	<20150710090322.GA5138@dhcp-128-21.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Minfei Huang <mnfhuang@gmail.com>
Cc: ebiederm@xmission.com, vgoyal@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 10 Jul 2015 17:03:22 +0800
Minfei Huang <mnfhuang@gmail.com> wrote:

> On 07/10/15 at 10:54P, Michael Holzheu wrote:
> > On Fri, 10 Jul 2015 13:12:17 +0800
> > Minfei Huang <mnfhuang@gmail.com> wrote:
> > 
> > > For some arch, kexec shall map the reserved pages, then use them, when
> > > we try to start the kdump service.
> > > 
> > > Now kexec will never unmap the reserved pages, once it fails to continue
> > > starting the kdump service. So we make a pair of map/unmap reserved
> > > pages whatever kexec fails or not in code path.
> > > 
> > > In order to make code readable, wrap a new function __kexec_load which
> > > contains all of the logic to deal with the image loading.
> > > 
> > > Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> > > ---
> > > v3:
> > > - reconstruct the patch, wrap a new function to deal with the code logic, based on Vivek and Michael's patch
> > > v2:
> > > - replace the "failure" label with "fail_unmap_pages"
> > > v1:
> > > - reconstruct the patch code
> > > ---
> > >  kernel/kexec.c | 112 ++++++++++++++++++++++++++++++++-------------------------
> > >  1 file changed, 63 insertions(+), 49 deletions(-)
> > > 
> > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > index a785c10..2232c90 100644
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -1247,10 +1247,71 @@ int kexec_load_disabled;
> > > 
> > >  static DEFINE_MUTEX(kexec_mutex);
> > > 
> > > +static int __kexec_load(unsigned long entry, unsigned long nr_segments,
> > > +			struct kexec_segment __user *segments,
> > > +			unsigned long flags)
> > > +{
> > > +	int result = 0;
> > > +	struct kimage **dest_image, *image;
> > > +
> > > +	dest_image = &kexec_image;
> > > +
> > > +	if (flags & KEXEC_ON_CRASH)
> > > +		dest_image = &kexec_crash_image;
> > > +
> > > +	if (nr_segments == 0) {
> > > +		/* Install the new kernel, and  Uninstall the old */
> > > +		image = xchg(dest_image, image);
> > > +		kimage_free(image);
> > 
> > Well this is wrong and should probably be:
> > 
> >         if (nr_segments == 0) {
> >                 /* Uninstall image */
> >                 image = xchg(dest_image, NULL);
> >                 kimage_free(image);
> > 
> 
> You are right. It should be what you commented.

And after rethinking a bit, I think a one liner and an early exit
would be better in this case:

         if (nr_segments == 0) {
                 /* Uninstall image */
                 kimage_free(xchg(dest_image, NULL));
                 return 0;
         }

What about the following patch:
---
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 7a36fdc..7837c4e 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1236,10 +1236,68 @@ int kexec_load_disabled;
 
 static DEFINE_MUTEX(kexec_mutex);
 
+static int __kexec_load(unsigned long entry, unsigned long nr_segments,
+			struct kexec_segment __user *segments,
+			unsigned long flags)
+{
+	struct kimage **dest_image, *image;
+	unsigned long i;
+	int result;
+
+	if (flags & KEXEC_ON_CRASH)
+		dest_image = &kexec_crash_image;
+	else
+		dest_image = &kexec_image;
+
+	if (nr_segments == 0) {
+		/* Uninstall image */
+		kfree(xchg(dest_image, NULL));
+		return 0;
+	}
+	if (flags & KEXEC_ON_CRASH) {
+		/*
+		 * Loading another kernel to switch to if this one
+		 * crashes.  Free any current crash dump kernel before
+		 * we corrupt it.
+		 */
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
+		goto failure_unmap_mem;
+
+	for (i = 0; i < nr_segments; i++) {
+		result = kimage_load_segment(image, &image->segment[i]);
+		if (result)
+			goto failure_unmap_mem;
+	}
+
+	kimage_terminate(image);
+
+	/* Install the new kernel and uninstall the old */
+	image = xchg(dest_image, image);
+
+failure_unmap_mem:
+	if (flags & KEXEC_ON_CRASH)
+		crash_unmap_reserved_pages();
+	kimage_free(image);
+	return result;
+}
+
 SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		struct kexec_segment __user *, segments, unsigned long, flags)
 {
-	struct kimage **dest_image, *image;
 	int result;
 
 	/* We only trust the superuser with rebooting the system. */
@@ -1264,9 +1322,6 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	if (nr_segments > KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
-	image = NULL;
-	result = 0;
-
 	/* Because we write directly to the reserved memory
 	 * region when loading crash kernels we need a mutex here to
 	 * prevent multiple crash  kernels from attempting to load
@@ -1278,53 +1333,9 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
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
-		if (result)
-			goto out;
+	result = __kexec_load(entry, nr_segments, segments, flags);
 
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
