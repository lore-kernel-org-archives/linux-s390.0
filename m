Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35330 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfGHRRl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jul 2019 13:17:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so11479204lfa.2
        for <linux-s390@vger.kernel.org>; Mon, 08 Jul 2019 10:17:40 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x137sm2873270lff.23.2019.07.08.10.17.38
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 10:17:38 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m8so7234725lji.7
        for <linux-s390@vger.kernel.org>; Mon, 08 Jul 2019 10:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01562573328-ext-8139@work.hours>
In-Reply-To: <your-ad-here.call-01562573328-ext-8139@work.hours>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jul 2019 10:17:22 -0700
Message-ID: <CAHk-=win6P5gsZnE57WZOUNGP12gX2gGri3+7EhQ6uky2fZk_w@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 5.3 merge window
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Mon, Jul 8, 2019 at 1:23 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> please pull s390 fixes and features for 5.3.
> This is my first pull request. My PGP key id is 716A93D7,
> key fingerprint: F397 316C 210A 9C03 1205  6691 467C 8ED2 716A 93D7

Thanks for the heads-up, everything looks fine and I see you have the
proper signatures on that key.

> Please also note the fixup required to avoid s390 build error after you
> pull Greg's driver-core changes for 5.3:
> http://lkml.kernel.org/r/e9889ea3-0286-df1c-864c-ba67a0286855@de.ibm.com

Ok, so I don't have Greg's pull request in my in-box yet, which means
that I may well forget about this by the time I do get it, and I won't
see the build failure because I don't do a s390 cross-build.

I'll _try_ to remember, but apologies in advance if this slips
through. I have the working memory of a slightly retarded chipmunk.

Greg - if you happen to remember and add a reminder to the pull
request when it gets done that would be good, but worst case the s390
people get to call me names.

                Linus
