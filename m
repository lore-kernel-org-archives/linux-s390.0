Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39168 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbgBKUMr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Feb 2020 15:12:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id j15so6314149pgm.6
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 12:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20200208140858.47970-1-natechancellor@gmail.com>
 <your-ad-here.call-01581426728-ext-3459@work.hours> <CAKwvOd=CWKnrY_T8vP4a-KXkz-V57dFqk+6FC_krm=pVAVibyg@mail.gmail.com>
 <your-ad-here.call-01581450834-ext-0583@work.hours>
In-Reply-To: <your-ad-here.call-01581450834-ext-0583@work.hours>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 11 Feb 2020 20:12:33 +0000
Message-ID: <CAKwvOdk_6kOVPMWOuZ1r2HyAQ9MhE1=n56GhrO49bzghw3724g@mail.gmail.com>
Subject: Re: [PATCH] s390/time: Fix clk type in get_tod_clock
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Tue, Feb 11, 2020 at 11:54 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> On Tue, Feb 11, 2020 at 05:30:24PM +0000, Nick Desaulniers wrote:
> > On Tue, Feb 11, 2020 at 5:12 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> > > Applied, thanks.
> >
> > Hi Vasily, is this the expected tree+branch that the patch will be
> > pushed to? (I'm trying to track when+where our patches land).
> > https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
> >
> Hi Nick,
> yes, this is correct. There might be some delay due to ci runs. But
> this particular patch is now landed on that fixes branch.
>

Ah, yeah now I see it, thanks. The aggressive patch tracking helps us
figure out what landed where so that we can better backport patches to
LTS (hence the Fixes tags you've seen on other patches).
-- 
Thanks,
~Nick Desaulniers
