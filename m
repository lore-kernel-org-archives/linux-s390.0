From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [-next Nov 17] s390 build
	break(arch/s390/kernel/compat_wrapper.S)
Date: Wed, 18 Nov 2009 09:27:27 +0000
Message-ID: <20091118092727.GA17267@flint.arm.linux.org.uk>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au> <4B0291BB.3090005@in.ibm.com> <20091117125201.GB5124@osiris.boeblingen.de.ibm.com> <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com> <20091117135525.GF5124@osiris.boeblingen.de.ibm.com> <1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com> <20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Eric Paris <eparis@redhat.com>, Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 18, 2009 at 08:04:18AM +0100, Heiko Carstens wrote:
> On Tue, Nov 17, 2009 at 10:23:56AM -0500, Eric Paris wrote:
> With
> 
> long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
>      	 	       int fd, const char  __user *pathname,
>                        u64 mask);
> 
> we have a 64 bit type as 5th argument. That doesn't work for syscalls
> on 32 bit s390.

Note that the above works on ARM, since we end up with the following
register allocation:

r0: fanotify_fd
r1: flags
r2: fd
r3: pathname
r4,r5: mask

since 'mask' is an even,odd pair, and the arguments all fit within r0 - r5
inclusive.

> Please note that other architectures (I think at least arm and powerpc) put
> 64 bit values into even/odd register pairs and add padding if the first free
> available register is an odd one. So any of the following interfaces should
> work for all architectures:

Indeed.

Since we're going around the loop of re-organizing the argument order of
syscalls, the question which needs asking is: what's happening with HPA's
idea of having a set of per-arch rules and generating the interfaces
according to those rules?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
