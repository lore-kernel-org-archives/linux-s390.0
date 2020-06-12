Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgFLNOI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jun 2020 09:14:08 -0400
Date: Fri, 12 Jun 2020 15:14:05 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [v2 PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200612131405.GI4311@linux-b0ei>
References: <20200611125144.GA2506@gondor.apana.org.au>
 <20200612043634.GA30181@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612043634.GA30181@gondor.apana.org.au>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Fri 2020-06-12 14:36:35, Herbert Xu wrote:
> As it stands if you include printk.h by itself it will fail to
> compile because it requires definitions from ratelimit.h.  However,
> simply including ratelimit.h from printk.h does not work due to
> inclusion loops involving sched.h and kernel.h.
> 
> This patch solves this by moving bits from ratelimit.h into a new
> header file which can then be included by printk.h without any
> worries about header loops.
> 
> The build bot then revealed some intriguing failures arising out
> of this patch.  On s390 there is an inclusion loop with asm/bug.h
> and linux/kernel.h that triggers a compile failure, because kernel.h
> will cause asm-generic/bug.h to be included before s390's own
> asm/bug.h has finished processing.  This has been fixed by not
> including kernel.h in arch/s390/include/asm/bug.h.
> 
> A related failure was seen on powerpc where asm/bug.h leads to
> the inclusion of linux/kernel.h via asm-generic/bug.h which then
> prematurely tries to use the very macros defined in asm/bug.h.
> The particular inclusion path which led to this involves lockdep.h.
> I have fixed this moving the type definitions lockdep.h into the
> new lockdep_types.h.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

I am fine with the changes as long as the kernel test robot
does not complain ;-)

Acked-by: Petr Mladek <pmladek@suse.com>

Well, I wonder if PeterZ is fine with the lockdep part. It might make
sense to split it into separate patch as a prerequisite.

Best Regards,
Petr
