Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817BAC433B4
	for <linux-s390@archiver.kernel.org>; Fri, 30 Apr 2021 17:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673E26145A
	for <linux-s390@archiver.kernel.org>; Fri, 30 Apr 2021 17:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhD3RL0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 30 Apr 2021 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3RLZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 30 Apr 2021 13:11:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2FAC06174A
        for <linux-s390@vger.kernel.org>; Fri, 30 Apr 2021 10:10:37 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s22so28731222pgk.6
        for <linux-s390@vger.kernel.org>; Fri, 30 Apr 2021 10:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CxmawVwVfL+jaT3YHah7mQNNhzkrmY403jm1OzTv2dY=;
        b=VcafhmvEswkm4ZEKDJ2M9anPp9plDKopWYtWGnZU+zWpg1SwK5cT3nKtCcAZILmdmQ
         KRe0KKVLa9K3XfEliT832dC6QXE686Cp0kejsHpZxtXsyOttNYK4CUm8/+Th1Vmoho4H
         AeGTJ2v2pPDl8itmVFQT/m5dJJ6AU6umZRgOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CxmawVwVfL+jaT3YHah7mQNNhzkrmY403jm1OzTv2dY=;
        b=Cs4EwC4RbXa2H3s2O6w252JxNVMjTot6CPtR8p3Mdqtm5ZdjzapD9upa2YIb/ah6vP
         iGzmw5J346+2+TyFOZ4qDHcKt9i0Mb/ZFUQocqHgzGkWhUFh/y63qVxyaq/sFvbFqPau
         IKIsaF9RqGuekNLCS+hI4ZwEo7Q+hz7Fi+7q5WZCSyQUQZIEsQCVbx48ZZVoTd8UbdDd
         bnN84wD2uvWOGLlKQXXJ3y9QN/cR4P0E9afZrTxtTJ94X0yfnk03vEgbd0ZKIX9O0zGh
         nKpVP2HlUhEDYujEpAM9QY24HnAnA8qZ9r0ptg3A4UlPHQctPvqBDzr0DvnsDbk9Gyf2
         bqIg==
X-Gm-Message-State: AOAM531vbhHI1CJ2/PM9igCyC8r5rWOXGQr6X2vg9KgDtj9PR2rWiIWL
        VId7ll/XR+RjL9F6rbbdBHP7P5NX3e8OssZa
X-Google-Smtp-Source: ABdhPJyFevLXgoYmAMn4g1knYUf/qi1JknADCS3J/w784XMIgV/po/1gafrOwY3gW5A+8oLPZetj/Q==
X-Received: by 2002:a63:1b5e:: with SMTP id b30mr5427948pgm.254.1619802637074;
        Fri, 30 Apr 2021 10:10:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q18sm2729233pfj.131.2021.04.30.10.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 10:10:36 -0700 (PDT)
Date:   Fri, 30 Apr 2021 10:10:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/entry: add support for syscall stack randomization
Message-ID: <202104301007.5D0C6F9386@keescook>
References: <20210429091451.1062594-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429091451.1062594-1-svens@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Apr 29, 2021 at 11:14:51AM +0200, Sven Schnelle wrote:
> This adds support for adding a random offset to the stack while handling
> syscalls. The patch uses get_tod_clock_fast() as this is considered good

Nice! :)

> enough and has much less performance penalty compared to using
> get_random_int(). The patch also adds randomization in pgm_check_handler()
> as the sigreturn/rt_sigreturn system calls might be called from there.

Ah, interesting. Is this path to syscalls unique to s390? (As in, should
x86 and arm64 gain coverage over a path that got missed?)

> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  arch/s390/Kconfig                    |  1 +
>  arch/s390/include/asm/entry-common.h | 10 ++++++++++
>  arch/s390/kernel/syscall.c           |  1 +
>  arch/s390/kernel/traps.c             |  2 ++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index c1ff874e6c2e..1900428ce557 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -137,6 +137,7 @@ config S390
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN
>  	select HAVE_ARCH_KASAN_VMALLOC
> +	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_SOFT_DIRTY
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
> index 9cceb26ed63f..baa8005090c3 100644
> --- a/arch/s390/include/asm/entry-common.h
> +++ b/arch/s390/include/asm/entry-common.h
> @@ -4,9 +4,11 @@
>  
>  #include <linux/sched.h>
>  #include <linux/audit.h>
> +#include <linux/randomize_kstack.h>
>  #include <linux/tracehook.h>
>  #include <linux/processor.h>
>  #include <linux/uaccess.h>
> +#include <asm/timex.h>
>  #include <asm/fpu/api.h>
>  
>  #define ARCH_EXIT_TO_USER_MODE_WORK (_TIF_GUARDED_STORAGE | _TIF_PER_TRAP)
> @@ -48,6 +50,14 @@ static __always_inline void arch_exit_to_user_mode(void)
>  
>  #define arch_exit_to_user_mode arch_exit_to_user_mode
>  
> +static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
> +						  unsigned long ti_work)
> +{
> +	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);

What's the stack alignment on s390? Or, better question, what's the
expected number of entropy bits?

> +}
> +
> +#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
> +
>  static inline bool on_thread_stack(void)
>  {
>  	return !(((unsigned long)(current->stack) ^ current_stack_pointer()) & ~(THREAD_SIZE - 1));
> diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
> index bc8e650e377d..4e5cc7d2364e 100644
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -142,6 +142,7 @@ void do_syscall(struct pt_regs *regs)
>  
>  void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
>  {
> +	add_random_kstack_offset();
>  	enter_from_user_mode(regs);
>  
>  	memcpy(&regs->gprs[8], S390_lowcore.save_area_sync, 8 * sizeof(unsigned long));
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index 63021d484626..8dd23c703718 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -17,6 +17,7 @@
>  #include "asm/ptrace.h"
>  #include <linux/kprobes.h>
>  #include <linux/kdebug.h>
> +#include <linux/randomize_kstack.h>
>  #include <linux/extable.h>
>  #include <linux/ptrace.h>
>  #include <linux/sched.h>
> @@ -301,6 +302,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
>  	unsigned int trapnr, syscall_redirect = 0;
>  	irqentry_state_t state;
>  
> +	add_random_kstack_offset();
>  	regs->int_code = *(u32 *)&S390_lowcore.pgm_ilc;
>  	regs->int_parm_long = S390_lowcore.trans_exc_code;


-- 
Kees Cook
