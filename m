Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQMYx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 08:24:53 -0400
Date: Wed, 17 Jun 2020 14:24:50 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [v3 PATCH 1/2] lockdep: Split header file into lockdep and
 lockdep_types
Message-ID: <20200617122449.GX31238@alley>
References: <20200617071524.GA3055@gondor.apana.org.au>
 <E1jlSJz-0003hE-8g@fornost.hmeau.com>
 <20200617082459.GC2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617082459.GC2531@hirez.programming.kicks-ass.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Wed 2020-06-17 10:24:59, Peter Zijlstra wrote:
> On Wed, Jun 17, 2020 at 05:17:19PM +1000, Herbert Xu wrote:
> > There is a header file inclusion loop between asm-generic/bug.h
> > and linux/kernel.h.  This causes potential compile failurs depending
> > on the which file is included first.  One way of breaking this loop
> > is to stop spinlock_types.h from including lockdep.h.  This patch
> > splits lockdep.h into two files for this purpose.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Acked-by: Petr Mladek <pmladek@suse.com>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Looks good.
> 
> Petr, how about I stick this in tip/locking/header for us both to share?

Sure. Sounds good to me.

Best Regards,
Petr
