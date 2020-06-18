Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbgFROiR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Jun 2020 10:38:17 -0400
Date: Thu, 18 Jun 2020 16:37:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [v3 PATCH 1/2] lockdep: Split header file into lockdep and
 lockdep_types
Message-ID: <20200618143735.GJ576905@hirez.programming.kicks-ass.net>
References: <20200617071524.GA3055@gondor.apana.org.au>
 <E1jlSJz-0003hE-8g@fornost.hmeau.com>
 <20200617082459.GC2531@hirez.programming.kicks-ass.net>
 <20200617122449.GX31238@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617122449.GX31238@alley>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Wed, Jun 17, 2020 at 02:24:50PM +0200, Petr Mladek wrote:
> On Wed 2020-06-17 10:24:59, Peter Zijlstra wrote:
> > On Wed, Jun 17, 2020 at 05:17:19PM +1000, Herbert Xu wrote:
> > > There is a header file inclusion loop between asm-generic/bug.h
> > > and linux/kernel.h.  This causes potential compile failurs depending
> > > on the which file is included first.  One way of breaking this loop
> > > is to stop spinlock_types.h from including lockdep.h.  This patch
> > > splits lockdep.h into two files for this purpose.
> > > 
> > > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > Acked-by: Petr Mladek <pmladek@suse.com>
> > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Looks good.
> > 
> > Petr, how about I stick this in tip/locking/header for us both to share?
> 
> Sure. Sounds good to me.

OK, done. tip/locking/header should contain just this patch, and that
branch also got merged into tip/locking/core.
