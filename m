Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgEGNgw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 May 2020 09:36:52 -0400
Date: Thu, 7 May 2020 15:36:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 05/11] s390: Change s390_kernel_write() return type
 to match memcpy()
In-Reply-To: <be5119b30920d2da6fca3f6d2b1aca5712a2fd30.1588173720.git.jpoimboe@redhat.com>
Message-ID: <nycvar.YFH.7.76.2005071534170.25812@cbobk.fhfr.pm>
References: <cover.1588173720.git.jpoimboe@redhat.com> <be5119b30920d2da6fca3f6d2b1aca5712a2fd30.1588173720.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, Gerald Schaefer <gerald.schaefer@de.ibm.com>

On Wed, 29 Apr 2020, Josh Poimboeuf wrote:

> s390_kernel_write()'s function type is almost identical to memcpy().
> Change its return type to "void *" so they can be used interchangeably.
> 
> Cc: linux-s390@vger.kernel.org
> Cc: heiko.carstens@de.ibm.com
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

Also for this one -- s390 folks, could you please provide your Ack for 
taking things through livepatching.git as part of this series?

Thanks.

> ---
>  arch/s390/include/asm/uaccess.h | 2 +-
>  arch/s390/mm/maccess.c          | 9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
> index a470f1fa9f2a..324438889fe1 100644
> --- a/arch/s390/include/asm/uaccess.h
> +++ b/arch/s390/include/asm/uaccess.h
> @@ -276,6 +276,6 @@ static inline unsigned long __must_check clear_user(void __user *to, unsigned lo
>  }
>  
>  int copy_to_user_real(void __user *dest, void *src, unsigned long count);
> -void s390_kernel_write(void *dst, const void *src, size_t size);
> +void *s390_kernel_write(void *dst, const void *src, size_t size);
>  
>  #endif /* __S390_UACCESS_H */
> diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
> index de7ca4b6718f..22a0be655f27 100644
> --- a/arch/s390/mm/maccess.c
> +++ b/arch/s390/mm/maccess.c
> @@ -55,19 +55,22 @@ static notrace long s390_kernel_write_odd(void *dst, const void *src, size_t siz
>   */
>  static DEFINE_SPINLOCK(s390_kernel_write_lock);
>  
> -void notrace s390_kernel_write(void *dst, const void *src, size_t size)
> +notrace void *s390_kernel_write(void *dst, const void *src, size_t size)
>  {
> +	void *tmp = dst;
>  	unsigned long flags;
>  	long copied;
>  
>  	spin_lock_irqsave(&s390_kernel_write_lock, flags);
>  	while (size) {
> -		copied = s390_kernel_write_odd(dst, src, size);
> -		dst += copied;
> +		copied = s390_kernel_write_odd(tmp, src, size);
> +		tmp += copied;
>  		src += copied;
>  		size -= copied;
>  	}
>  	spin_unlock_irqrestore(&s390_kernel_write_lock, flags);
> +
> +	return dst;
>  }
>  
>  static int __no_sanitize_address __memcpy_real(void *dest, void *src, size_t count)
> -- 
> 2.21.1
> 

-- 
Jiri Kosina
SUSE Labs
