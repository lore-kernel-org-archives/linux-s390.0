Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Jul 2015 10:54:13 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150710105413.04e1db00@holzheu>
In-Reply-To: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
References: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Minfei Huang <mnfhuang@gmail.com>
Cc: ebiederm@xmission.com, vgoyal@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 10 Jul 2015 13:12:17 +0800
Minfei Huang <mnfhuang@gmail.com> wrote:

> For some arch, kexec shall map the reserved pages, then use them, when
> we try to start the kdump service.
> 
> Now kexec will never unmap the reserved pages, once it fails to continue
> starting the kdump service. So we make a pair of map/unmap reserved
> pages whatever kexec fails or not in code path.
> 
> In order to make code readable, wrap a new function __kexec_load which
> contains all of the logic to deal with the image loading.
> 
> Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> ---
> v3:
> - reconstruct the patch, wrap a new function to deal with the code logic, based on Vivek and Michael's patch
> v2:
> - replace the "failure" label with "fail_unmap_pages"
> v1:
> - reconstruct the patch code
> ---
>  kernel/kexec.c | 112 ++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 63 insertions(+), 49 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index a785c10..2232c90 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1247,10 +1247,71 @@ int kexec_load_disabled;
> 
>  static DEFINE_MUTEX(kexec_mutex);
> 
> +static int __kexec_load(unsigned long entry, unsigned long nr_segments,
> +			struct kexec_segment __user *segments,
> +			unsigned long flags)
> +{
> +	int result = 0;
> +	struct kimage **dest_image, *image;
> +
> +	dest_image = &kexec_image;
> +
> +	if (flags & KEXEC_ON_CRASH)
> +		dest_image = &kexec_crash_image;
> +
> +	if (nr_segments == 0) {
> +		/* Install the new kernel, and  Uninstall the old */
> +		image = xchg(dest_image, image);
> +		kimage_free(image);

Well this is wrong and should probably be:

        if (nr_segments == 0) {
                /* Uninstall image */
                image = xchg(dest_image, NULL);
                kimage_free(image);

> +	} else {
> +		unsigned long i;
> +
> +		if (flags & KEXEC_ON_CRASH) {
> +			/*

[snip]

> +			result = kimage_load_segment(image, &image->segment[i]);
> +			if (result)
> +				goto failure_unmap_mem;
> +		}
> +
> +		kimage_terminate(image);
> +
> +		/* Install the new kernel, and  Uninstall the old */

Perhaps fix the comment: Remove superfluous blank and lowercase "uninstall"?

> +		image = xchg(dest_image, image);
> +
> +failure_unmap_mem:
> +		if (flags & KEXEC_ON_CRASH)
> +			crash_unmap_reserved_pages();
> +		kimage_free(image);

Here the update patch:
---
diff --git a/kernel/kexec.c b/kernel/kexec.c
index e686a39..2f5b4aa 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1249,8 +1249,8 @@ static int __kexec_load(unsigned long entry, unsigned long nr_segments,
 		dest_image = &kexec_crash_image;
 
 	if (nr_segments == 0) {
-		/* Install the new kernel, and  Uninstall the old */
-		image = xchg(dest_image, image);
+		/* Uninstall image */
+		image = xchg(dest_image, NULL);
 		kimage_free(image);
 	} else {
 		unsigned long i;
@@ -1287,7 +1287,7 @@ static int __kexec_load(unsigned long entry, unsigned long nr_segments,
 
 		kimage_terminate(image);
 
-		/* Install the new kernel, and  Uninstall the old */
+		/* Install the new kernel, and uninstall the old */
 		image = xchg(dest_image, image);
 
 failure_unmap_mem:
