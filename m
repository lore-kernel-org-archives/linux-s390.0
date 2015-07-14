Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Jul 2015 10:09:20 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150714140920.GA10792@redhat.com>
References: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
 <20150710105413.04e1db00@holzheu>
 <20150710090322.GA5138@dhcp-128-21.nay.redhat.com>
 <20150710111406.279dba14@holzheu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150710111406.279dba14@holzheu>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Minfei Huang <mnfhuang@gmail.com>, ebiederm@xmission.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jul 10, 2015 at 11:14:06AM +0200, Michael Holzheu wrote:

[..]
> What about the following patch:
> ---
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 7a36fdc..7837c4e 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1236,10 +1236,68 @@ int kexec_load_disabled;
>  
>  static DEFINE_MUTEX(kexec_mutex);
>  
> +static int __kexec_load(unsigned long entry, unsigned long nr_segments,

How about renaming the function to do_kexec_load()?

We also need to cleanup the description of commit. One needs to explain
problem better and what's the solution this patch is implemeting.

> +			struct kexec_segment __user *segments,
> +			unsigned long flags)
> +{
> +	struct kimage **dest_image, *image;
> +	unsigned long i;
> +	int result;
> +
> +	if (flags & KEXEC_ON_CRASH)
> +		dest_image = &kexec_crash_image;
> +	else
> +		dest_image = &kexec_image;
> +
> +	if (nr_segments == 0) {
> +		/* Uninstall image */
> +		kfree(xchg(dest_image, NULL));

kimage_free(), as you have already noted in a follow up mail.

> +		return 0;
> +	}
> +	if (flags & KEXEC_ON_CRASH) {
> +		/*
> +		 * Loading another kernel to switch to if this one
> +		 * crashes.  Free any current crash dump kernel before
> +		 * we corrupt it.
> +		 */
> +		kimage_free(xchg(&kexec_crash_image, NULL));
> +	}
> +
> +	result = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
> +	if (result)
> +		return result;
> +
> +	if (flags & KEXEC_ON_CRASH)
> +		crash_map_reserved_pages();
> +
> +	if (flags & KEXEC_PRESERVE_CONTEXT)
> +		image->preserve_context = 1;
> +
> +	result = machine_kexec_prepare(image);
> +	if (result)
> +		goto failure_unmap_mem;
> +
> +	for (i = 0; i < nr_segments; i++) {
> +		result = kimage_load_segment(image, &image->segment[i]);
> +		if (result)
> +			goto failure_unmap_mem;
> +	}
> +
> +	kimage_terminate(image);
> +
> +	/* Install the new kernel and uninstall the old */
> +	image = xchg(dest_image, image);
> +
> +failure_unmap_mem:

I don't like this tag "failure_unmap_mem". We are calling this both
in success path as well as failure path. So why not simply call it "out".

> +	if (flags & KEXEC_ON_CRASH)
> +		crash_unmap_reserved_pages();
> +	kimage_free(image);

Now kimage_free() is called with kexec_mutex held. Previously that was
not the case. I hope that's not a problem.

> +	return result;
> +}
> +

Thanks
Vivek
