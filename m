Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 1 Jul 2015 16:40:23 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150701164023.011988b1@holzheu>
In-Reply-To: <1435643086-8555-1-git-send-email-mnfhuang@gmail.com>
References: <1435643086-8555-1-git-send-email-mnfhuang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Minfei Huang <mnfhuang@gmail.com>
Cc: ebiederm@xmission.com, vgoyal@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Minfei,

Regarding functionality your patch looks ok for me.
But the code is not easy to read.

What about replacing the "failure" label with "fail_unmap_pages"?

Michael

On Tue, 30 Jun 2015 13:44:46 +0800
Minfei Huang <mnfhuang@gmail.com> wrote:

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
>  kernel/kexec.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 4589899..68f6dfb 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1291,35 +1291,37 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  			 */
> 
>  			kimage_free(xchg(&kexec_crash_image, NULL));
> -			result = kimage_alloc_init(&image, entry, nr_segments,
> -						   segments, flags);
> -			crash_map_reserved_pages();
> -		} else {
> -			/* Loading another kernel to reboot into. */
> -
> -			result = kimage_alloc_init(&image, entry, nr_segments,
> -						   segments, flags);
>  		}
> +
> +		result = kimage_alloc_init(&image, entry, nr_segments,
> +				segments, flags);
>  		if (result)
>  			goto out;
> 
> +		if (flags & KEXEC_ON_CRASH)
> +			crash_map_reserved_pages();
> +
>  		if (flags & KEXEC_PRESERVE_CONTEXT)
>  			image->preserve_context = 1;
>  		result = machine_kexec_prepare(image);
>  		if (result)
> -			goto out;
> +			goto failure;
> 
>  		for (i = 0; i < nr_segments; i++) {
>  			result = kimage_load_segment(image, &image->segment[i]);
>  			if (result)
> -				goto out;
> +				goto failure;
>  		}
>  		kimage_terminate(image);
> +
> +failure:
>  		if (flags & KEXEC_ON_CRASH)
>  			crash_unmap_reserved_pages();
>  	}
> -	/* Install the new kernel, and  Uninstall the old */
> -	image = xchg(dest_image, image);
> +
> +	if (result == 0)
> +		/* Install the new kernel, and  Uninstall the old */
> +		image = xchg(dest_image, image);
> 
>  out:
>  	mutex_unlock(&kexec_mutex);
