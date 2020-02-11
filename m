Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46336 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgBKRah (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Feb 2020 12:30:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so5794322pfp.13
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 09:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20200208140858.47970-1-natechancellor@gmail.com> <your-ad-here.call-01581426728-ext-3459@work.hours>
In-Reply-To: <your-ad-here.call-01581426728-ext-3459@work.hours>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 11 Feb 2020 17:30:24 +0000
Message-ID: <CAKwvOd=CWKnrY_T8vP4a-KXkz-V57dFqk+6FC_krm=pVAVibyg@mail.gmail.com>
Subject: Re: [PATCH] s390/time: Fix clk type in get_tod_clock
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Tue, Feb 11, 2020 at 5:12 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> Applied, thanks.

Hi Vasily, is this the expected tree+branch that the patch will be
pushed to? (I'm trying to track when+where our patches land).
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes

-- 
Thanks,
~Nick Desaulniers
