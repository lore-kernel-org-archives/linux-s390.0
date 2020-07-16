Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Jul 2020 09:30:49 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH RESEND] lockdep: Move list.h inclusion into lockdep.h
Message-ID: <20200716083049.GA6771@willie-the-truck>
References: <20200716063649.GA23065@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716063649.GA23065@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On Thu, Jul 16, 2020 at 04:36:50PM +1000, Herbert Xu wrote:
> Currently lockdep_types.h includes list.h without actually using any
> of its macros or functions.  All it needs are the type definitions
> which were moved into types.h long ago.  This potentially causes
> inclusion loops because both are included by many core header
> files.
> 
> This patch moves the list.h inclusion into lockdep.h.  Note that
> we could probably remove it completely but that could potentially
> result in compile failures should any end users not include list.h
> directly and also be unlucky enough to not get list.h via some other
> header file.
> 
> Reported-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Will Deacon <will@kernel.org>

Will
