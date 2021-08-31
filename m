Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB6C432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 15:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279746103A
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 15:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhHaPDT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Aug 2021 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHaPDT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 31 Aug 2021 11:03:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4FC061760
        for <linux-s390@vger.kernel.org>; Tue, 31 Aug 2021 08:02:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x6so20014280wrv.13
        for <linux-s390@vger.kernel.org>; Tue, 31 Aug 2021 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oG874AdcXI3o82/TGwk+Cx3DBaSWTb47/JMNkLWiZok=;
        b=qcHtViW34mFDs+6eJ7L3v7AeMjvSULLglQaq36dZekNuXmZKBNmq+4taLB0F2VWTjT
         40WyqXFDclhaTCz5+gwNk6rs2oUKYZervqn/hdmQlKkhpXWKNKZNoV9OA0Td1nSgKa58
         AuAasxJkQnRr5N1vM+dUJ5t7pc2GmRXfqQBaC/e8Zp+paD3q3zO3gfIkVnTvJwb07dtv
         f74Hu8ydFGVqimcPjIynxZK/BgGGBjqiyEjw1vQQiUzXabHz7jHIJlODSnDvwnhodBJc
         zeNwNLnjwJtxFzlNoes+uCJ+QcTRTbZIINLN8lObUnpZMWiAv1r3ET1ju0xp/18AVVDf
         SK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oG874AdcXI3o82/TGwk+Cx3DBaSWTb47/JMNkLWiZok=;
        b=bC/F3pLswYMQvcgt/7sokt0ldIubfMdqUDS1jqy2j0o95PCgyGtPYR0Hz842xR0Riz
         ETFiLuuMkXoCuD1b8jWJ9cKpRRxwvNqvJ2pEuDZ9talA9EPqVn8J6zriGfytnGsAPZn2
         h0ruKB81J6Nu/5zt+W3b12Cyb3CIgmlPc9IIR/+KOGw4QlE3FxIG+IYF9AeNEL6sWpI3
         nyrj06PjLmm4hhk+Q73yYsGWyJiW5h+urn8PLP50iCDxsJuP9FRl8a8J4ETtL19b9p2o
         VSsVm+5z2RuXIZeDIB7wrK47jVw6iZ3C9UjCN0tsaneBWeTbYpjlkebemCmciuy7zCzL
         CL3g==
X-Gm-Message-State: AOAM531/DMZAUKXNMufO6E16DVbCi63tldq3IlWq8PiKHkm97bdFU8Pm
        dfEAtq62gKW/dTU8BEXr21XYcg==
X-Google-Smtp-Source: ABdhPJyk6IGggC9wvbTFCze2ISYZ4szGyjRQ/DsvvyAKPPgzPn8KiCuYhlqw2i3+BmV0nOK5RKcEpg==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr31678862wrb.329.1630422142080;
        Tue, 31 Aug 2021 08:02:22 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:3729:c12:7ee0:e9bc])
        by smtp.gmail.com with ESMTPSA id p9sm2401009wrg.14.2021.08.31.08.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 08:02:20 -0700 (PDT)
Date:   Tue, 31 Aug 2021 17:02:15 +0200
From:   Marco Elver <elver@google.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
Message-ID: <YS5Ed4Cyf+rOf9MR@elver.google.com>
References: <YSzZFgBt6nMvpVgc@osiris>
 <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
 <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com>
 <YS4AufXrOCa4rzN0@osiris>
 <CANpmjNPp3dAcr+WfYxM6_uQOmFmDf60aL-LbXF12NCzP6P3-6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPp3dAcr+WfYxM6_uQOmFmDf60aL-LbXF12NCzP6P3-6Q@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 31, 2021 at 12:46PM +0200, Marco Elver wrote:
> On Tue, 31 Aug 2021 at 12:13, Heiko Carstens <hca@linux.ibm.com> wrote:
> [...]
> > I really don't think this is QEMU related. The test fails are sort of
> > expected: we've seen KCSAN reports when the kernel boots and wanted to
> > fix them later.
> > However I have to admit that I wasn't aware of the KCSAN KUNIT tests,
> > and wouldn't have sent the s390 KCSAN enablement upstream if I would
> > have been aware of failing self tests.
> >
> > We'll fix them, and I let you know if things are supposed to work.
> >
> > Thanks a lot for making aware of this!
> 
> Note: Set `CONFIG_KCSAN_REPORT_ONCE_IN_MS=100` (or smaller) instead of
> the default to make the test complete faster.
> 
> The pattern I see from what Nathan reported is that all test cases
> that expect race reports don't observe them ("not ok" cases), and all
> those where no races are meant to be reported are fine ("ok" cases).
> Without actually seeing the log, I'm guessing that no races are
> reported at all, which is certainly not working as intended.

I repro'd, and the problem is part QEMU TCG and a minor problem with
stack_trace_save() on s390:

1. QEMU TCG doesn't seem to want to execute threads concurrently,
   resulting in no "value changes" being observed. This is probably just
   a limitation of TCG, and if run on a real CPU, shouldn't be a problem.
   On QEMU, most test cases will pass with CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
   (There's one left that requires value changes to be observable)

2. stack_trace_save() is subtly broken on s390: it starts the trace in
   stack_trace_save() itself. This is incorrect, as the trace should
   start with the caller. We reported something similar to arm64, also
   because one of our sanitizer tests failed:
   https://lkml.kernel.org/r/20210319184106.5688-1-mark.rutland@arm.com

I noticed because stack traces like this: 

| read to 0x0000000001309128 of 8 bytes by task 49 on cpu 1:
|  print_report+0x48/0x6c0
|  kcsan_report_known_origin+0x112/0x200
|  kcsan_setup_watchpoint+0x464/0x500
|  test_kernel_read+0x2a/0x40
|  access_thread+0x84/0xb0
|  kthread+0x3aa/0x3d0
|  __ret_from_fork+0x58/0x90
|  ret_from_fork+0xa/0x30

, which should not be generated because KCSAN uses stack_trace_save(..., 1)
in print_report().

I fixed it with the below, and now most tests pass. Note that, other
debugging tools may also report misleading stack traces without the
stack_trace_save() fix (e.g. certain KFENCE reports).

If you have a better solution for how to fix stack_trace_save() on s390,
please discard my patch.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 31 Aug 2021 16:00:03 +0200
Subject: [PATCH] s390/stacktrace: do not include arch_stack_walk() in stack
 trace

Callers of stack_trace_save() expect that it does not include itself,
which attempts to exclude itself by skipping + 1. This contract is
broken if arch_stack_walk() still includes itself.

Fix it by skipping the initial entry in s390's arch_stack_walk().

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/s390/kernel/stacktrace.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 101477b3e263..47d1841af03e 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -16,11 +16,16 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 {
 	struct unwind_state state;
 	unsigned long addr;
+	bool init = true;
 
 	unwind_for_each_frame(&state, task, regs, 0) {
 		addr = unwind_get_return_address(&state);
-		if (!addr || !consume_entry(cookie, addr))
+		if (!addr)
+			break;
+
+		if (!init && !consume_entry(cookie, addr))
 			break;
+		init = false;
 	}
 }
 
@@ -29,6 +34,7 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 {
 	struct unwind_state state;
 	unsigned long addr;
+	bool init = true;
 
 	unwind_for_each_frame(&state, task, NULL, 0) {
 		if (state.stack_info.type != STACK_TYPE_TASK)
@@ -50,8 +56,9 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			return -EINVAL;
 #endif
 
-		if (!consume_entry(cookie, addr))
+		if (!init && !consume_entry(cookie, addr))
 			return -EINVAL;
+		init = false;
 	}
 
 	/* Check for stack corruption */
-- 
2.33.0.259.gc128427fd7-goog

