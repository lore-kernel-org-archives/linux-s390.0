Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729846AbgEKUhi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 May 2020 16:37:38 -0400
Subject: Re: [PATCH -next] s390: Remove two unused inline functions
References: <20200508140724.11324-1-yuehaibing@huawei.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <3d8212c5-fb46-9fa7-a118-52dd8ef246d1@de.ibm.com>
Date: Mon, 11 May 2020 22:36:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200508140724.11324-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: YueHaibing <yuehaibing@huawei.com>, rostedt@goodmis.org, mingo@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 08.05.20 16:07, YueHaibing wrote:
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
> 

thanks, applied.
