Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Tue, 27 Aug 2019 06:25:12 +0800
From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 03/11] asm-generic: add generic dwarf definition
Message-ID: <20190826222510.6m2k3puwflnr52b7@mail.google.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
 <20190825132330.5015-4-changbin.du@gmail.com>
 <20190826074215.GL2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826074215.GL2369@hirez.programming.kicks-ass.net>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Changbin Du <changbin.du@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org

Hi, Peter,

On Mon, Aug 26, 2019 at 09:42:15AM +0200, Peter Zijlstra wrote:
> On Sun, Aug 25, 2019 at 09:23:22PM +0800, Changbin Du wrote:
> > Add generic DWARF constant definitions. We will use it later.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  include/asm-generic/dwarf.h | 199 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 199 insertions(+)
> >  create mode 100644 include/asm-generic/dwarf.h
> > 
> > diff --git a/include/asm-generic/dwarf.h b/include/asm-generic/dwarf.h
> > new file mode 100644
> > index 000000000000..c705633c2a8f
> > --- /dev/null
> > +++ b/include/asm-generic/dwarf.h
> > @@ -0,0 +1,199 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Architecture independent definitions of DWARF.
> > + *
> > + * Copyright (C) 2019 Changbin Du <changbin.du@gmail.com>
> 
> You're claiming copyright on dwarf definitions? ;-)
> 
> I'm thinking only Oracle was daft enough to think stuff like that was
> copyrightable.
> 
ok, let me remove copyright line. I think SPDX claim is okay, right?

> Also; I think it would be very good to not use/depend on DWARF for this.
>
It only includes the DWARF expersion opcodes, not all of dwarf stuffs.

> You really don't need all of DWARF; I'm thikning you only need a few
> types; for location we already have regs_get_kernel_argument() which
> has all the logic to find the n-th argument.
> 
regs_get_kernel_argument() can handle most cases, but if the size of one paramater
exceeds 64bit (it is rare in kernel), we must recalculate the locations. So I think
dwarf location descriptor is the most accurate one.

-- 
Cheers,
Changbin Du
