From: "Serge E. Hallyn" <serue@us.ibm.com>
Date: Fri, 13 Nov 2009 15:56:47 +0000
Subject: Re: [PATCH linux-cr] implement s390 eclone syscall
Message-Id: <20091113155647.GA22321@us.ibm.com>
In-Reply-To: <20091113084730.GA4839@osiris.boeblingen.de.ibm.com>
References: <20091113084730.GA4839@osiris.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Quoting Heiko Carstens (heiko.carstens@de.ibm.com):
> On Thu, Nov 12, 2009 at 11:21:20PM -0600, serue@us.ibm.com wrote:
> > +asmlinkage long sys32_eclone(void)
> > +{
> > +	int rc;
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +	int args_size;
> > +	struct clone_args kca;
> > +	unsigned long flags;
> > +	int __user *parent_tid_ptr;
> > +	int __user *child_tid_ptr;
> > +	unsigned long __user child_stack;
> > +	unsigned long stack_size;
> > +	unsigned int flags_low;
> > +	struct clone_args __user *uca;
> > +	pid_t __user *pids;
> 
> Would you mind converting this to a syscall which takes its parameters via
> registers?
> You might have a look at git commit 2d70ca23f86647e076e3a8b64b3a90e583b894d5
> "[S390] Convert sys_clone to function with parameters."

Thanks!  That does end up looking much nicer.

New version attached.

> > +	flags_low = regs->orig_gpr2 & 0xffffffffUL;
> > +	uca = compat_ptr(regs->gprs[3]);
> > +	args_size = regs->gprs[4] & 0xffffffffUL;
> > +	pids = compat_ptr(regs->gprs[5]);
> > +
> > +	rc = fetch_clone_args_from_user(uca, args_size, &kca);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (kca.clone_flags_high)
> > +		return -EINVAL;
> > +	flags = flags_low;
> > +	parent_tid_ptr = (int __user *) kca.parent_tid_ptr;
> > +	child_tid_ptr =  (int __user *) kca.child_tid_ptr;
> 
> _If_ the kernel uses these two pointers to access user space then the most
> significant bit of the pointer values must be cleared by using compat_ptr().

It does, but IIUC I no longer need that compat function at all, since
I'm now using a simple sys_eclone_wrapper in
arch/s390/kernel/compat_wrapper.S.

thanks,
-serge
