Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 18 Nov 2009 08:04:18 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next Nov 17] s390 build
 break(arch/s390/kernel/compat_wrapper.S)
Message-ID: <20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au>
 <4B0291BB.3090005@in.ibm.com>
 <20091117125201.GB5124@osiris.boeblingen.de.ibm.com>
 <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com>
 <20091117135525.GF5124@osiris.boeblingen.de.ibm.com>
 <1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20091118070418.DBf2hazUNDfF-9Tymc3du3TRVk6W2U6ST6Bu523Tqkk@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Eric Paris <eparis@redhat.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 17, 2009 at 10:23:56AM -0500, Eric Paris wrote:
> On Tue, 2009-11-17 at 14:55 +0100, Heiko Carstens wrote:
> 
> > Yes, also some places should have used lgfr instead of llgfr for proper sign
> > extension. But please, just drop the s390 bits from your patch.
> > Its easier and less painful for us to do it ourselves instead of reviewing
> > and fixing these things. (No offence intended!).
> 
> dropped and won't show up in -next tomorrow.
> 
> This what I thought it should be and would love to read if you say it's
> right....
> 

[...]

> +sys32_fanotify_mark_wrapper:
> +	lgfr	%r2,%r2			# int
> +	llgfr	%r3,%r3			# unsigned int
> +	lgfr	%r4,%r4			# int
> +	llgtr	%r5,%r5			# char *
> +	sllg	%r6,%r6,32		# get high word of 64bit mask
> +	l	%r6,164(%r15)		# get low word of 64bit mask
> +	jg	sys_fanotify_mark

Oh wait, I have to correct myself:

With

long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
     	 	       int fd, const char  __user *pathname,
                       u64 mask);

we have a 64 bit type as 5th argument. That doesn't work for syscalls
on 32 bit s390.
I just simplify the reason for this: on 32 bit long longs will be passed via
two consecutive registers _unless_ the first register would be r6 (which is
the case here). In that case the whole 64 bits would be passed on the stack.
Our glibc syscall code will always put the contents of the first parameter
stack slot into register r7, so we have six registers for parameter passing
(r2-r7). So with the 64 bit value put into two stack slots we would miss
the second part of the 5th argument.

Please note that other architectures (I think at least arm and powerpc) put
64 bit values into even/odd register pairs and add padding if the first free
available register is an odd one. So any of the following interfaces should
work for all architectures:

long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
     	 	       int fd, const char  __user *pathname,
                       u32 mask_high, u32 mask_low);

long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
                       u64 mask,
     	 	       int fd, const char  __user *pathname);

long sys_fanotify_mark(u64 mask,
     		       int fanotify_fd, unsigned int flags,
     	 	       int fd, const char  __user *pathname);
