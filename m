Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DCFC432BE
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 23:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3C860FC0
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 23:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbhH3X6A (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Aug 2021 19:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhH3X57 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Aug 2021 19:57:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF56C061575;
        Mon, 30 Aug 2021 16:57:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630367824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=II7kr15IK3yVzn+wqs9ggAl0e2ITXLSBVCs7oul256g=;
        b=UJB1BmN/GLRUpjfKiStlGPks9y33OJXh4aIazBHTPzmvfv4M0prAA4xBlqgXtHMlcWJqgG
        TEKtGLfHWPJ+CjFYxzc5MNxi61kyqTxOWLpYrs2ahn/t6ZxwMO0sVH+km7MvA2/VEuIF/o
        7Td7pNcLWVyGNPMLS6TFZgGwvwUvXz84W78JsohtW/FNIVJV02T8qjb3t6M+r/yQokqsGD
        U4jTd4p1dr4iOVZP4b92IoB/jL8azc25f9KCrBvph7MX5y1S2DbDyzJyKumyi9A8CoMXhp
        8I/e0GmF1PJqZFicaj5ulPla+D18vYEkMcOveENl7v0YgifeAuuJxJUZJTNx3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630367824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=II7kr15IK3yVzn+wqs9ggAl0e2ITXLSBVCs7oul256g=;
        b=jW+3yxOxWsNazbUV71bYBpQpOtxBxmUYZjDNl9y+QHieHL4Xmr9Bs3f8+Jqt1snWyJG6zp
        WZpTofMv5RDgh9Dg==
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Linux 5.14
In-Reply-To: <87wno2fzbq.ffs@tglx>
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
 <20210830201225.GA2671970@roeck-us.net> <87wno2fzbq.ffs@tglx>
Date:   Tue, 31 Aug 2021 01:57:03 +0200
Message-ID: <8735qqfpv4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 30 2021 at 22:32, Thomas Gleixner wrote:

> On Mon, Aug 30 2021 at 13:12, Guenter Roeck wrote:
>> On Sun, Aug 29, 2021 at 03:19:23PM -0700, Linus Torvalds wrote:
>> So far so good, but there is a brand new runtime warning, seen when booting
>> s390 images.
>>
>> [    3.218816] ------------[ cut here ]------------
>> [    3.219010] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:5779 sched_core_cpu_starting+0x172/0x180
>> [    3.222992]  [<0000000000186e86>] sched_core_cpu_starting+0x176/0x180
>> [    3.223114] ([<0000000000186dc4>] sched_core_cpu_starting+0xb4/0x180)
>> [    3.223182]  [<00000000001963e4>] sched_cpu_starting+0x2c/0x68
>> [    3.223243]  [<000000000014f288>] cpuhp_invoke_callback+0x318/0x970
>> [    3.223304]  [<000000000014f970>] cpuhp_invoke_callback_range+0x90/0x108
>> [    3.223364]  [<000000000015123c>] notify_cpu_starting+0x84/0xa8
>> [    3.223426]  [<0000000000117bca>] smp_init_secondary+0x72/0xf0
>> [    3.223492]  [<0000000000117846>] smp_start_secondary+0x86/0x90
>>
>> Commit 3c474b3239f12 ("sched: Fix Core-wide rq->lock for uninitialized
>> CPUs") sems to be the culprit. Indeed, the warning is gone after reverting
>> this commit.
>
> The warning is gone, but the underlying S390 problem persists:
>
> S390 invokes notify_cpu_starting() _before_ updating the topology masks.

And interestingly enough that very commit was tested on S390:

  https://lore.kernel.org/r/yt9dy28o8q0o.fsf@linux.ibm.com

Thanks,

        tglx
