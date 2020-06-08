Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgFHTNT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 15:13:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9307EC08C5C3
        for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2020 12:13:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so21907241ljh.13
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2020 12:13:17 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 22sm3871329lju.5.2020.06.08.12.13.14
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:13:14 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id n23so21931460ljh.7
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2020 12:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01591630479-ext-3636@work.hours> <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jun 2020 12:12:57 -0700
Message-ID: <CAHk-=whnntptk9j7KgtPQY5yNEkL5J64mAsqZgdV_4FLtiFboQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 5.8 merge window
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>

On Mon, Jun 8, 2020 at 12:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jun 8, 2020 at 8:35 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> >
> > Please note 2 minor merge conflict resolutions below:
>
> There was a third because of the iommu tree I merged today.

Oh, and please don't post the whole patch in your pull request.

That's ok for small "fixes" pulls, but it's absolutely the wrong thing
to do with thousands of lines, nobody is going to review that anyway
when the review is supposed to happen on the individual patches.

I'm surprised it even made it to lkml at almost 200k in size.

              Linus
