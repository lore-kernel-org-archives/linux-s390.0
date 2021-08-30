Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3477DC432BE
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 20:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A34160241
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 20:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhH3UQv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhH3UQu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Aug 2021 16:16:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49568C06175F
        for <linux-s390@vger.kernel.org>; Mon, 30 Aug 2021 13:15:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s10so8846264lfr.11
        for <linux-s390@vger.kernel.org>; Mon, 30 Aug 2021 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdkLBxeprc22pYzDrCGRhm5Mln6o/u5YuB0oLAShsfU=;
        b=SvQjZPnrKDQjoOS7De5eX7kZmrBx8eC1vg6xlCXuICo8J1kvbzxn9dHJ8HcjngZPv4
         gOe/9w6uT+FaAzMIiF3Oz/9mr9TlVU1tB1bUF9h/MPSHovgRZzP1BImuFmVtuvtc+2A6
         yzZ1Obpw0jtxLiElMSWmEulWzxyPRVL66CIO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdkLBxeprc22pYzDrCGRhm5Mln6o/u5YuB0oLAShsfU=;
        b=mS4+t5UwKTHJNKbdhQyZrW7U1o+taToten3VRwqf7q+vE1kuzvhC++AgO4HexhQxgV
         sVkEC7Bx3w218EfH6FT5CbH7zj6cCIFMguP3UTQwqYDgF1BdzRH24CDvN6ZRJHJhxaW1
         SBhSPLegwUnlQ9A7weDQ2jUrCtVe4El1Lx8LyPO8GSrVXPUT4BP41X1FdlswBByYTv4m
         1Ff0Lj/nQ84L9xOnS5YdcHgvh5Li7MQL9gp6i3gbWmHtRPRe4tkyX37lSgpZVDrsCjjd
         pogCEYmcRHHuvmwh3FnjuYVklTsjXEoKu4W1cc2VFqZ4ztpLqeJO8yx3Z1CidquXggVO
         LGRw==
X-Gm-Message-State: AOAM531953YT1MAsHwYWQHuaHjb6n2hOyQ3loaxjgkNLUYWbhr6Nn4ZI
        sAwKnJamoLUDSsrGt4qaNSEEPsYZc3+WNz567E0=
X-Google-Smtp-Source: ABdhPJxOCSznNUFinBscbPSa30SnxmIT8a04o4KrdHViJJaUmVA8VXcgYaqO8XdOPX9SoifjO4JhKw==
X-Received: by 2002:a05:6512:3406:: with SMTP id i6mr7080161lfr.165.1630354554073;
        Mon, 30 Aug 2021 13:15:54 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 7sm1491772lfq.2.2021.08.30.13.15.53
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 13:15:53 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id b4so33622836lfo.13
        for <linux-s390@vger.kernel.org>; Mon, 30 Aug 2021 13:15:53 -0700 (PDT)
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr6228220lfu.253.1630354553028;
 Mon, 30 Aug 2021 13:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
 <20210830201225.GA2671970@roeck-us.net>
In-Reply-To: <20210830201225.GA2671970@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 13:15:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2-1PyGj94cb+jYWb4vCcJ3JG6s6Li7c12dPOhdTs1RA@mail.gmail.com>
Message-ID: <CAHk-=wi2-1PyGj94cb+jYWb4vCcJ3JG6s6Li7c12dPOhdTs1RA@mail.gmail.com>
Subject: Re: Linux 5.14
To:     Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 30, 2021 at 1:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> So far so good, but there is a brand new runtime warning, seen when booting
> s390 images.
>
> [    3.218816] ------------[ cut here ]------------
> [    3.219010] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:5779 sched_core_cpu_starting+0x172/0x180
> [    3.222845] Call Trace:
> [    3.222992]  [<0000000000186e86>] sched_core_cpu_starting+0x176/0x180
> [    3.223114] ([<0000000000186dc4>] sched_core_cpu_starting+0xb4/0x180)
> [    3.223182]  [<00000000001963e4>] sched_cpu_starting+0x2c/0x68
> [    3.223243]  [<000000000014f288>] cpuhp_invoke_callback+0x318/0x970
> [    3.223304]  [<000000000014f970>] cpuhp_invoke_callback_range+0x90/0x108
> [    3.223364]  [<000000000015123c>] notify_cpu_starting+0x84/0xa8
> [    3.223426]  [<0000000000117bca>] smp_init_secondary+0x72/0xf0
> [    3.223492]  [<0000000000117846>] smp_start_secondary+0x86/0x90
>
> Commit 3c474b3239f12 ("sched: Fix Core-wide rq->lock for uninitialized
> CPUs") seems to be the culprit. Indeed, the warning is gone after reverting
> this commit.

Ouch, not great timing.

Adding the s390 people to the cc too, just to make sure everybody
involved is aware.

           Linus
