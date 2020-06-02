Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgFBKZD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jun 2020 06:25:03 -0400
Date: Tue, 2 Jun 2020 12:24:31 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH RESEND] lib: fix bitmap_parse() on 64-bit big endian archs
Message-ID: <20200602102430.GA17703@oc3871087118.ibm.com>
References: <1589798090-11136-1-git-send-email-agordeev@linux.ibm.com>
 <CAHp75VdM2yrpd2d3pK2RkmbhF3yiM4=fiTXL4i3yu3AxV3wY-A@mail.gmail.com>
 <20200518115059.GA19150@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518115059.GA19150@oc3871087118.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stable <stable@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Amritha Nambiar <amritha.nambiar@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Klassert <steffen.klassert@secunet.com>, "Tobin C . Harding" <tobin@kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>, Willem de Bruijn <willemb@google.com>

On Mon, May 18, 2020 at 01:50:59PM +0200, Alexander Gordeev wrote:
> On Mon, May 18, 2020 at 02:33:43PM +0300, Andy Shevchenko wrote:
> > On Mon, May 18, 2020 at 1:40 PM Alexander Gordeev
> > <agordeev@linux.ibm.com> wrote:
> > >
> > > Commit 2d6261583be0 ("lib: rework bitmap_parse()") does
> > > not take into account order of halfwords on 64-bit big
> > > endian architectures.
> > 
> > Thanks for report and the patch!
> > 
> > Did it work before? Can we have a test case for that that we will see
> > the failure?
> 
> The test exists and enabled with CONFIG_TEST_BITMAP.
> It does not appear ever passed before on 64 BE.
> It does not fail on 64 LE for me either.

Hi Andy et al,

Any feedback on the fix? Does it work on 64 LE for you?

Thanks!

> Thanks!
> 
> [...]
> 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
