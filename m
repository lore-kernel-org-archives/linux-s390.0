Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbgEKGIe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 May 2020 02:08:34 -0400
Date: Mon, 11 May 2020 08:07:51 +0200
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH -next] s390: Remove two unused inline functions
Message-ID: <20200511060750.GA93884@tuxmaker.boeblingen.de.ibm.com>
References: <20200508140724.11324-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508140724.11324-1-yuehaibing@huawei.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Cc: rostedt@goodmis.org, mingo@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Fri, May 08, 2020 at 10:07:24PM +0800, YueHaibing wrote:
> commit 657480d9c015 ("s390: support KPROBES_ON_FTRACE")
> left behind this, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/s390/kernel/ftrace.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> index 4cd9b1ada834..44e01dd1e624 100644
> --- a/arch/s390/kernel/ftrace.c
> +++ b/arch/s390/kernel/ftrace.c
> @@ -72,22 +72,6 @@ static inline void ftrace_generate_orig_insn(struct ftrace_insn *insn)
>  #endif
>  }
>  
> -static inline void ftrace_generate_kprobe_nop_insn(struct ftrace_insn *insn)
> -{
> -#ifdef CONFIG_KPROBES
> -	insn->opc = BREAKPOINT_INSTRUCTION;
> -	insn->disp = KPROBE_ON_FTRACE_NOP;
> -#endif
> -}
> -
> -static inline void ftrace_generate_kprobe_call_insn(struct ftrace_insn *insn)
> -{
> -#ifdef CONFIG_KPROBES
> -	insn->opc = BREAKPOINT_INSTRUCTION;
> -	insn->disp = KPROBE_ON_FTRACE_CALL;
> -#endif
> -}
> -
>  int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>  		       unsigned long addr)
>  {
> -- 
> 2.17.1

Thanks for noticing, looks like i missed them.

Acked-by: Sven Schnelle <svens@linux.ibm.com>

Sven
