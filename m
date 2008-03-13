Return-Path: <linux-kernel-owner+w=401wt.eu-S1757528AbYCMWmQ@vger.kernel.org>
Date: Thu, 13 Mar 2008 23:40:53 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 06/10] cpu topology support for s390.
Message-ID: <20080313224053.GA5836@osiris.boeblingen.de.ibm.com>
References: <20080312173155.703966894@de.ibm.com> <20080312173217.505558934@de.ibm.com> <20080312161137.63bdfa67.akpm@linux-foundation.org> <1205411307.26537.64.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1205411307.26537.64.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 13, 2008 at 01:28:27PM +0100, Martin Schwidefsky wrote:
> On Wed, 2008-03-12 at 16:11 -0700, Andrew Morton wrote:
> > > +#define CPU_BITS 64
> > > +
> > > +struct tl_cpu {
> > > +	unsigned char reserved[6];
> > > +	unsigned short origin;
> > > +	unsigned long mask[CPU_BITS / BITS_PER_LONG];
> > > +};
> > 
> > mask[] will be too small for CPU_BITS=65 ;)
> 
> We could add the +(BITS_PER_LONG - 1) logic but what for? The CPU_BITS
> is defined right above and it will be increased in steps of 64.

It will always be 64 and won't be increased. For more than 64 cpus "origin"
in the hardware structure above will be > 0 and each bit in the mask
would represent cpu "origin + bit number".

> > > +	end = (union tl_entry *)((unsigned long)info + info->length);
> > 
> > I'd suggest that you take a look at all the pointer arith games which are
> > being played in this code and see if it can be done better with a more
> > appropriate use of the C type system.  Before someone dies.
> 
> The only thing that I can see that we could do is to get rid of the
> unions and do the pointer arithmetic with the tl_cpu / tl_container
> structs by hand. The data stored by ptf is structured in a way that
> makes it rather hard to write decent C code.

Please leave as is. I did have a few different implementations but they
all looked even worse than this one. If you read the hardware specs then
the current code should be rather easily understandable.
And since the whole documentation is publically availabe in the meantime
I could even add some comments ;)
