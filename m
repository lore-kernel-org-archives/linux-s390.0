Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AC8C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236DC60F3A
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbhJLNu5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236678AbhJLNu4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 09:50:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C6260E94;
        Tue, 12 Oct 2021 13:48:54 +0000 (UTC)
Date:   Tue, 12 Oct 2021 09:48:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] s390: DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Message-ID: <20211012094852.7f6a59b8@gandalf.local.home>
In-Reply-To: <20211012133802.2460757-1-hca@linux.ibm.com>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 12 Oct 2021 15:37:58 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> This small series adds DYNAMIC_FTRACE_WITH_DIRECT_CALL support for
> s390 and is based on linux-next 20211012.

Cool!

> 
> Besides the architecture backend this also adds s390 ftrace direct
> call samples, and slightly changes config option handling a bit, so
> that options only have to be selected. This way also additional future
> architectures can easily add their trampolines to the samples.

Makes sense.

> 
> If ok, I'd like to get this upstream via the s390 tree with the next
> merge window.

A quick look at the patches look fine to me. I'll do a bit more digging
before adding a Reviewed-by.

One thing you may want to note, we are working on fixing direct trampolines
that conflict with the function graph tracer, and have patches that fix it.
I'm not that familiar on how ftrace works on s390, but you may want to
investigate this, because if s390 has the issues that x86 has, where you
can't have both function graph tracing and a direct trampoline on the same
function.

See here:

  https://lore.kernel.org/all/20211008091336.33616-1-jolsa@kernel.org/

-- Steve


> 
> Heiko Carstens (4):
>   s390/ftrace: add HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALL support
>   s390: make STACK_FRAME_OVERHEAD available via asm-offsets.h
>   samples: add HAVE_SAMPLE_FTRACE_DIRECT config option
>   samples: add s390 support for ftrace direct call samples
> 
>  arch/s390/Kconfig                     |  2 ++
>  arch/s390/include/asm/ftrace.h        | 12 ++++++++
>  arch/s390/kernel/asm-offsets.c        |  1 +
>  arch/s390/kernel/mcount.S             | 23 ++++++++++----
>  arch/x86/Kconfig                      |  1 +
>  samples/Kconfig                       |  5 ++-
>  samples/ftrace/ftrace-direct-modify.c | 44 +++++++++++++++++++++++++++
>  samples/ftrace/ftrace-direct-too.c    | 28 +++++++++++++++++
>  samples/ftrace/ftrace-direct.c        | 28 +++++++++++++++++
>  9 files changed, 137 insertions(+), 7 deletions(-)
> 

