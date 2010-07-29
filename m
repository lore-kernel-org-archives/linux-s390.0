From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 29 Jul 2010 13:41:43 +0000
Subject: Re: [patch 1/3] S390-HWBKPT v5: S390 architecture specific
Message-Id: <20100729134143.GA2189@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20100729003112.GA13088@nowhere>
References: <20100729003112.GA13088@nowhere>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 29, 2010 at 02:31:15AM +0200, Frederic Weisbecker wrote:
> On Wed, Jul 28, 2010 at 10:56:05AM +0200, Heiko Carstens wrote:
> > > +/*
> > > + * Check for virtual address in kernel space.
> > > + */
> > > +int arch_check_bp_in_kernelspace(struct perf_event *bp)
> > > +{
> > > +	unsigned long hbp_len;
> > > +	unsigned long va;
> > > +
> > > +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > > +
> > > +	va = info->address;
> > > +	hbp_len = info->len;
> > > +
> > > +	if (kernel_text_address(va))
> > > +		return kernel_text_address(va + hbp_len - 1);
> > > +
> > > +	return 0;
> > > +}
> > 
> > How is this supposed to work on s390? By just passing an address it is
> > impossible to tell if it is user space or kernel space. s390 has distinct
> > address spaces for kernel/user space where in each space the accessible
> > addresses are in the range from 0x-0xffff...... The same is true for
> > other architectures (e.g. powerpc and sparc, if I remember correctly).
> 
> So it's something I was really not aware of. It basically means one
> address can have two different meanings, one in userspace and one
> in kernelspace?

Exactly.

> Ok, I'm trying to understand how your copy_from_user() works, but
> I gave up on the asm in copy_from_user_std() :)

The (over-)simplified explanation how this works on s390:
we have two control registers. One points to the page table of the kernel
address space the second one to the page table of the user address space.
The user address space is _not_ part of the kernel address space.
If the kernel wants to access user space addresses it has to use special
priviledged instructions.

> Then yeah, s390 breakpoints must always be either exclude_kernel or
> exclude_user for the necessary disambiguation.
> 
> Having 0 on both must end in -EINVAL.

Ok, that should work.

Thanks!
