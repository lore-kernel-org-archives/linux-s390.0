Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727872AbgIOR1H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 13:27:07 -0400
Date: Tue, 15 Sep 2020 18:49:09 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Message-ID: <20200915164909.GB11180@osiris>
References: <20200915154340.4215-1-hca@linux.ibm.com>
 <20200915154340.4215-5-hca@linux.ibm.com>
 <20200915160243.GB22056@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915160243.GB22056@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

On Tue, Sep 15, 2020 at 06:02:43PM +0200, Christoph Hellwig wrote:
> >  	int oldval = 0, newval, ret;
> > -	mm_segment_t old_fs;
> > +	bool old;
> >  
> > -	old_fs = enable_sacf_uaccess();
> > +	old = enable_sacf_uaccess();
> >  	switch (op) {
> >  	case FUTEX_OP_SET:
> >  		__futex_atomic_op("lr %2,%5\n",
> > @@ -53,7 +53,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
> >  	default:
> >  		ret = -ENOSYS;
> >  	}
> > -	disable_sacf_uaccess(old_fs);
> > +	disable_sacf_uaccess(old);
> 
> Do we need to return the old value here?  The way I understand it
> this is context switched with the thread, and given that only small
> isolated code bases now use it, sacf use can't nest, can it?

Right, that should not happen. I think I'll change both functions to
void and add a WARN_ON_ONCE() to both of them, so that nested calls
will be catched.

> > @@ -116,7 +114,7 @@ struct thread_struct {
> >  	unsigned long hardirq_timer;	/* task cputime in hardirq context */
> >  	unsigned long softirq_timer;	/* task cputime in softirq context */
> >  	unsigned long sys_call_table;	/* system call table address */
> > -	mm_segment_t mm_segment;
> > +	bool sacf_uaccess;		/* uaccess with sacf enabled */
> 
> Isn't there a flags field somewhere where this could be folded into?

Hmm, a TIF flag will probably do.

> > -void set_fs_fixup(void)
> > -{
> > -	struct pt_regs *regs = current_pt_regs();
> > -	static bool warned;
> > -
> > -	set_fs(USER_DS);
> > -	if (warned)
> > -		return;
> > -	WARN(1, "Unbalanced set_fs - int code: 0x%x\n", regs->int_code);
> > -	show_registers(regs);
> > -	warned = true;
> 
> Would a warning about an unbalanced sacf flag still make sense?  Or
> just objtool for compile time checks similar to the unsafe uaccess
> routines on x86?

Yes, I was not sure to keep it or drop it. But now that you ask for
it, I'll add it back. FWIW, there is no objtool for s390 (yet).

> >  EXPORT_SYMBOL(enable_sacf_uaccess);
> 
> Neither enable_sacf_uaccess nor disable_sacf_uaccess appear to be
> used in modular code, so these exports can probably be dropped.

Ah, I wanted to check, and forgot that.
