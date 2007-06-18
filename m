Return-Path: <linux-kernel-owner+w=401wt.eu-S1760872AbXFRHgl@vger.kernel.org>
Date: Mon, 18 Jun 2007 09:36:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch] use __asm__ rather than asm in asm-s390/ptrace.h
Message-ID: <20070618073605.GA3580@osiris.boeblingen.de.ibm.com>
References: <200706180223.07122.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200706180223.07122.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 18, 2007 at 02:23:06AM -0400, Mike Frysinger wrote:
> Since asm-s390/ptrace.h is exported to userspace, we need to make sure we use
> __asm__() rather than asm() as the latter is disabled when gcc compiles with
> GNU extensions turned off (like -std=c99).
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> diff --git a/include/asm-s390/ptrace.h b/include/asm-s390/ptrace.h
> index fa6ca87..4add355 100644
> --- a/include/asm-s390/ptrace.h
> +++ b/include/asm-s390/ptrace.h
> @@ -475,7 +475,7 @@ extern void show_regs(struct pt_regs * regs);
>  static inline void
>  psw_set_key(unsigned int key)
>  {
> -	asm volatile("spka 0(%0)" : : "d" (key));
> +	__asm__ __volatile__("spka 0(%0)" : : "d" (key));
>  }
> 
>  #endif /* __ASSEMBLY__ */

Hmm.. spka is a sort of priviledged instruction and shouldn't be
user space visible.
I will move it so it's under #ifdef __KERNEL__.
