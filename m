Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76BEC4320A
	for <linux-s390@archiver.kernel.org>; Sat, 31 Jul 2021 02:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB496069E
	for <linux-s390@archiver.kernel.org>; Sat, 31 Jul 2021 02:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhGaCHt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhGaCHt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Jul 2021 22:07:49 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1DB560EFD;
        Sat, 31 Jul 2021 02:07:42 +0000 (UTC)
Date:   Fri, 30 Jul 2021 22:07:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] ftrace: Introduce ftrace_need_init_nop()
Message-ID: <20210730220741.4da6fdf6@oasis.local.home>
In-Reply-To: <20210728212546.128248-2-iii@linux.ibm.com>
References: <20210728212546.128248-1-iii@linux.ibm.com>
        <20210728212546.128248-2-iii@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 28 Jul 2021 23:25:45 +0200
Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> Implementing live patching on s390 requires each function's prologue to
> contain a very special kind of nop, which gcc and clang don't generate.
> However, the current code assumes that if CC_USING_NOP_MCOUNT is
> defined, then whatever the compiler generates is good enough.
> 
> Move the CC_USING_NOP_MCOUNT check into the new ftrace_need_init_nop()
> macro, that the architectures can override.
> 
> An alternative solution is to disable using -mnop-mcount in the
> Makefile, however, this makes the build logic (even) more complicated
> and forces the arch-specific code to deal with the useless __fentry__
> symbol.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

I'm fine with this patch, and also you taking it in via the s390 tree.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> ---
>  include/linux/ftrace.h | 16 ++++++++++++++++
>  kernel/trace/ftrace.c  |  4 ++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index a69f363b61bf..f1ea8988a045 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -643,6 +643,22 @@ static inline int ftrace_disable_ftrace_graph_caller(void) { return 0; }
>  extern int ftrace_make_nop(struct module *mod,
>  			   struct dyn_ftrace *rec, unsigned long addr);
>  
> +/**
> + * ftrace_need_init_nop - return whether nop call sites should be initialized
> + *
> + * Normally the compiler's -mnop-mcount generates suitable nops, so we don't
> + * need to call ftrace_init_nop() if the code is built with that flag.
> + * Architectures where this is not always the case may define their own
> + * condition.
> + *
> + * Return must be:
> + *  0       if ftrace_init_nop() should be called
> + *  Nonzero if ftrace_init_nop() should not be called
> + */
> +
> +#ifndef ftrace_need_init_nop
> +#define ftrace_need_init_nop() (!__is_defined(CC_USING_NOP_MCOUNT))
> +#endif
>  
>  /**
>   * ftrace_init_nop - initialize a nop call site
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7b180f61e6d3..7efbc8aaf7f6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3100,6 +3100,7 @@ ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
>  
>  static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>  {
> +	bool init_nop = ftrace_need_init_nop();
>  	struct ftrace_page *pg;
>  	struct dyn_ftrace *p;
>  	u64 start, stop;
> @@ -3138,8 +3139,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>  			 * Do the initial record conversion from mcount jump
>  			 * to the NOP instructions.
>  			 */
> -			if (!__is_defined(CC_USING_NOP_MCOUNT) &&
> -			    !ftrace_nop_initialize(mod, p))
> +			if (init_nop && !ftrace_nop_initialize(mod, p))
>  				break;
>  
>  			update_cnt++;

