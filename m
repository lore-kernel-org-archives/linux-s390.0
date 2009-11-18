Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 18 Nov 2009 17:22:33 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next Nov 17] s390 build
 break(arch/s390/kernel/compat_wrapper.S)
Message-ID: <20091118162232.GA3973@osiris.boeblingen.de.ibm.com>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au>
 <4B0291BB.3090005@in.ibm.com>
 <20091117125201.GB5124@osiris.boeblingen.de.ibm.com>
 <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com>
 <20091117135525.GF5124@osiris.boeblingen.de.ibm.com>
 <1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com>
 <20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
 <1258560177.6446.19.camel@dhcp231-106.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258560177.6446.19.camel@dhcp231-106.rdu.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20091118162233.BSpfS7b2cZW7iKDFg4qCF0cQNbLw-kAoov2S3FjOGjg@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Eric Paris <eparis@redhat.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 18, 2009 at 11:02:57AM -0500, Eric Paris wrote:
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

It works, because for 32 bit s390 it's not the interface above but this one:
(see arch/s390/kernel/sys_s390.c):

/*
 * This is a wrapper to call sys_fallocate(). For 31 bit s390 the last
 * 64 bit argument "len" is split into the upper and lower 32 bits. The
 * system call wrapper in the user space loads the value to %r6/%r7.
 * The code in entry.S keeps the values in %r2 - %r6 where they are and
 * stores %r7 to 96(%r15). But the standard C linkage requires that
 * the whole 64 bit value for len is stored on the stack and doesn't
 * use %r6 at all. So s390_fallocate has to convert the arguments from
 *   %r2: fd, %r3: mode, %r4/%r5: offset, %r6/96(%r15)-99(%r15): len
 * to
 *   %r2: fd, %r3: mode, %r4/%r5: offset, 96(%r15)-103(%r15): len
 */
SYSCALL_DEFINE(s390_fallocate)(int fd, int mode, loff_t offset,
			       u32 len_high, u32 len_low)
{
	return sys_fallocate(fd, mode, offset, ((u64)len_high << 32) | len_low);
}
#ifdef CONFIG_HAVE_SYSCALL_WRAPPERS
asmlinkage long SyS_s390_fallocate(long fd, long mode, loff_t offset,
				   long len_high, long len_low)
{
	return SYSC_s390_fallocate((int) fd, (int) mode, offset,
				   (u32) len_high, (u32) len_low);
}
SYSCALL_ALIAS(sys_s390_fallocate, SyS_s390_fallocate);
#endif

We (or better: Martin ;) had to define a special s390 fallocate system call
because the "real" system call interface doesn't work on s390 for the same
reason like your proposed system call.
