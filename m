Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGPRFM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jul 2020 13:05:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB6DC061755
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2020 10:05:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w17so4123364ply.11
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2020 10:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
 <20200716112840.GC8484@osiris>
In-Reply-To: <20200716112840.GC8484@osiris>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 16 Jul 2020 10:05:00 -0700
Message-ID: <CAKwvOd=_JL3+L7dY0W8LDTSer3iWvcwSqWoLN=_gR6zc86hDvw@mail.gmail.com>
Subject: Re: linux plumbers + clang + s390 virtualized testing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>

On Thu, Jul 16, 2020 at 4:28 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Hi Nick,
>
> > We were very excited to see your patches going by for enabling Clang
> > support for s390.  Since then, we've added s390 builds to our
> > continuous integration setup.
> >
> > We've been running into a few issues with doing virtualized boot tests
> > of our kernels on s390.
> >
> > I was curious if you'll both be attending Linux plumbers conf?  If we
> > carve out time for an s390+clang talk, would this be of interest to
> > you to attend?
>
> I will not attend, however cannot speak for Vasily. He will have to
> answer as soon as he returns - besides that enabling Clang support for
> s390 was done by Vasily anyway :)

Hey,
Thanks for following up; I got a bounce back from your previous email
address.  I had just noticed your update to .mailmap+MAINTAINERS last
night.  You beat me to the punch.

No worries.

-- 
Thanks,
~Nick Desaulniers
