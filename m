Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 18 Nov 2009 18:34:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [-next Nov 17] s390 build
 break(arch/s390/kernel/compat_wrapper.S)
Message-ID: <20091118183400.0cd6b177@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <1258560177.6446.19.camel@dhcp231-106.rdu.redhat.com>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au>
	<4B0291BB.3090005@in.ibm.com>
	<20091117125201.GB5124@osiris.boeblingen.de.ibm.com>
	<1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com>
	<20091117135525.GF5124@osiris.boeblingen.de.ibm.com>
	<1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com>
	<20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
	<1258560177.6446.19.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20091118173400.bX28QUFJ7k161I-nIueourpcaEyXb7ZgAqaRD3m4hgc@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Eric Paris <eparis@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 18 Nov 2009 11:02:57 -0500
Eric Paris <eparis@redhat.com> wrote:

> On Wed, 2009-11-18 at 08:04 +0100, Heiko Carstens wrote:
> > Oh wait, I have to correct myself:
> > 
> > With
> > 
> > long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
> >      	 	       int fd, const char  __user *pathname,
> >                        u64 mask);
> > 
> > we have a 64 bit type as 5th argument. That doesn't work for syscalls
> > on 32 bit s390.
> > I just simplify the reason for this: on 32 bit long longs will be passed via
> > two consecutive registers _unless_ the first register would be r6 (which is
> > the case here). In that case the whole 64 bits would be passed on the stack.
> > Our glibc syscall code will always put the contents of the first parameter
> > stack slot into register r7, so we have six registers for parameter passing
> > (r2-r7). So with the 64 bit value put into two stack slots we would miss
> > the second part of the 5th argument.
> 
> asmlinkage long sys_fallocate(int fd, int mode, loff_t offset, loff_t len);
> 
> sys_fallocate_wrapper:
>         lgfr    %r2,%r2                 # int
>         lgfr    %r3,%r3                 # int
>         sllg    %r4,%r4,32              # get high word of 64bit loff_t
>         lr      %r4,%r5                 # get low word of 64bit loff_t
>         sllg    %r5,%r6,32              # get high word of 64bit loff_t
>         l       %r5,164(%r15)           # get low word of 64bit loff_t
>         jg      sys_fallocate
> 
> Does this work?  It's basically the same thing, right?  I'm willing to
> hear "that's fine you are clueless"   Just saw it and hoping that we
> have everything right....

Ok, we need the full version of the story..
The 32 bit ELF ABI specifies that the 32 bit registers %r2 to %r6 are
used for parameter passing. 64 bit values are passed as registers pairs
with the first register an even numbered register. The effect of that
rule is that parameter registers may be skipped or that the whole 64 bit
value is passed on the stack. Examples:

fn(int a, int b, long long c)
a is passed in %r2, b is passed in %r3, c is passed in %r4/%r5.

fn(int a, long long b, int c)
a is passed in %r2, b is passed in %r4/%r5, c is passed in %r6, %r3 is
skipped.

fn(int a, int b, int c, int d, long long e)
a is passed in %r2, b is passed in %r3, c is passed in %r4, d is passed
in %r5, e is passed on the stack, %r6 is skipped.

The second fact to understand is how the system call arguments are
passed. The original system call ABI used the same calling conventions
as the ELF ABI. That is only registers %r2 to %r6 are used. Now futex
came along with 6 parameters. We did not want to use the user process
stack to pass the parameters because that would require a
copy_from_user which is expensive. Instead we tricked a little bit. The
6th parameter is passed by glue code in glibc in register %r7 (no user
copy). The code in entry.S stores %r7 to the beginning of the pt_regs
structure:

struct pt_regs
{
        unsigned long args[1];
	...
};

The C function that implements a system call with 6 32-bit parameters
expects 5 parameters in registers, the 6th is located on the stack. The
args element of pt_regs "happens" to be at the same offset where the C
function is looking for the first overflow argument (= the 6th
parameter).

Now consider a system call with an overflowing 64 bit parameter. The
glue code in glibc could be hacked in a way that the 64 bit value is
split into %r6 and %r7. But the system call function is just a C
function. It follows the ELF ABI and expects the 64 bit argument on the
stack. It would take two 32 bit overflow registers in pt_regs to make
one 64 bit parameter. With the current code that won't work. We would
need a wrapper function in the kernel to untangle this parameter mess.

The avoid all this all 64 bit parameter have to be placed at positions
where no register is skipped because of the even/odd rule and where it
is not affected by the %r7 trick (= may not be the last parameter).
Easy, no?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
