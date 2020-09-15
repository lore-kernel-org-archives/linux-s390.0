Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:48387 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbgIOQTy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 12:19:54 -0400
Date: Tue, 15 Sep 2020 18:02:43 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Message-ID: <20200915160243.GB22056@lst.de>
References: <20200915154340.4215-1-hca@linux.ibm.com> <20200915154340.4215-5-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915154340.4215-5-hca@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

On Tue, Sep 15, 2020 at 05:43:40PM +0200, Heiko Carstens wrote:
> Address spaces still have to switched/changed for machines without the
> mvcos instructions and especially for instructions like e.g. compare
> and swap (-> futex) which must be executed in kernel address space but
> access user address space. For such instructions enable_sacf_uaccess()
> and disable_sacf_uaccess() must be used like before.

That logic always confused me and still keeps confusing me,
dumb questions below:

>  	int oldval = 0, newval, ret;
> -	mm_segment_t old_fs;
> +	bool old;
>  
> -	old_fs = enable_sacf_uaccess();
> +	old = enable_sacf_uaccess();
>  	switch (op) {
>  	case FUTEX_OP_SET:
>  		__futex_atomic_op("lr %2,%5\n",
> @@ -53,7 +53,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
>  	default:
>  		ret = -ENOSYS;
>  	}
> -	disable_sacf_uaccess(old_fs);
> +	disable_sacf_uaccess(old);

Do we need to return the old value here?  The way I understand it
this is context switched with the thread, and given that only small
isolated code bases now use it, sacf use can't nest, can it?

> @@ -116,7 +114,7 @@ struct thread_struct {
>  	unsigned long hardirq_timer;	/* task cputime in hardirq context */
>  	unsigned long softirq_timer;	/* task cputime in softirq context */
>  	unsigned long sys_call_table;	/* system call table address */
> -	mm_segment_t mm_segment;
> +	bool sacf_uaccess;		/* uaccess with sacf enabled */

Isn't there a flags field somewhere where this could be folded into?

> -void set_fs_fixup(void)
> -{
> -	struct pt_regs *regs = current_pt_regs();
> -	static bool warned;
> -
> -	set_fs(USER_DS);
> -	if (warned)
> -		return;
> -	WARN(1, "Unbalanced set_fs - int code: 0x%x\n", regs->int_code);
> -	show_registers(regs);
> -	warned = true;

Would a warning about an unbalanced sacf flag still make sense?  Or
just objtool for compile time checks similar to the unsafe uaccess
routines on x86?

> +bool enable_sacf_uaccess(void)

Maybe add a little comment documenting when to use the function

>  }
>  EXPORT_SYMBOL(enable_sacf_uaccess);

Neither enable_sacf_uaccess nor disable_sacf_uaccess appear to be
used in modular code, so these exports can probably be dropped.
