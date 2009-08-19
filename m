From: Jason Baron <jbaron@redhat.com>
Subject: Re: [patch] Re: Next Aug 19: s390 build failure
	(arch/s390/kernel/built-in)
Date: Wed, 19 Aug 2009 09:16:20 -0400
Message-ID: <20090819131619.GA2649@redhat.com>
References: <20090819190233.86e78493.sfr@canb.auug.org.au> <4A8BDE59.2010400@in.ibm.com> <20090819114646.GB32317@elte.hu> <4A8BE82D.4000407@in.ibm.com> <20090819121556.GA24041@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752608AbZHSNRa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090819121556.GA24041@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sachin Sant <sachinp@in.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Aug 19, 2009 at 02:15:56PM +0200, Ingo Molnar wrote:
> thanks - does the patch below fix the bug for you?
> 
> 	Ingo
> 
> diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
> index 05f57cd..c5e87d8 100644
> --- a/arch/s390/kernel/ptrace.c
> +++ b/arch/s390/kernel/ptrace.c
> @@ -51,6 +51,9 @@
>  #include "compat_ptrace.h"
>  #endif
>  
> +DEFINE_TRACE(syscall_enter);
> +DEFINE_TRACE(syscall_exit);
> +
>  enum s390_regset {
>  	REGSET_GENERAL,
>  	REGSET_FP,

That should fix it...i was about to post the exact same patch.

thanks,

-Jason
