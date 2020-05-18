Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgERLfV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 May 2020 07:35:21 -0400
MIME-Version: 1.0
References: <1589798090-11136-1-git-send-email-agordeev@linux.ibm.com> <CAHp75VdM2yrpd2d3pK2RkmbhF3yiM4=fiTXL4i3yu3AxV3wY-A@mail.gmail.com>
In-Reply-To: <CAHp75VdM2yrpd2d3pK2RkmbhF3yiM4=fiTXL4i3yu3AxV3wY-A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 May 2020 14:35:09 +0300
Message-ID: <CAHp75VcLu738ktasiUsgbKNyW-5vENpK2n9_OD5oFmhOzfCG6Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] lib: fix bitmap_parse() on 64-bit big endian archs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stable <stable@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Amritha Nambiar <amritha.nambiar@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Klassert <steffen.klassert@secunet.com>, "Tobin C . Harding" <tobin@kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>, Willem de Bruijn <willemb@google.com>

On Mon, May 18, 2020 at 2:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, May 18, 2020 at 1:40 PM Alexander Gordeev
> <agordeev@linux.ibm.com> wrote:
> >
> > Commit 2d6261583be0 ("lib: rework bitmap_parse()") does
> > not take into account order of halfwords on 64-bit big
> > endian architectures.
>
> Thanks for report and the patch!
>
> Did it work before? Can we have a test case for that that we will see
> the failure?

Sorry, I wasn't clear enough. I meant a test case that is
arch-independent for this very issue (so, that I can run it on LE 64
machine and see a problem).

-- 
With Best Regards,
Andy Shevchenko
