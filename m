Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbgIPRVy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Sep 2020 13:21:54 -0400
Date: Wed, 16 Sep 2020 14:36:03 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Message-ID: <20200916123603.GC7076@osiris>
References: <20200915154340.4215-1-hca@linux.ibm.com>
 <20200915154340.4215-5-hca@linux.ibm.com>
 <20200915160243.GB22056@lst.de>
 <20200915193755.GA8528@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915193755.GA8528@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

On Tue, Sep 15, 2020 at 09:37:55PM +0200, Heiko Carstens wrote:
> On Tue, Sep 15, 2020 at 06:02:43PM +0200, Christoph Hellwig wrote:
> > That logic always confused me and still keeps confusing me,
> > dumb questions below:
...
> > > +	bool old;
> > >  
> > > -	old_fs = enable_sacf_uaccess();
> > > +	old = enable_sacf_uaccess();
> > >  	switch (op) {
> > >  	case FUTEX_OP_SET:
> > >  		__futex_atomic_op("lr %2,%5\n",
> > > @@ -53,7 +53,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
> > >  	default:
> > >  		ret = -ENOSYS;
> > >  	}
> > > -	disable_sacf_uaccess(old_fs);
> > > +	disable_sacf_uaccess(old);
> > 
> > Do we need to return the old value here?  The way I understand it
> > this is context switched with the thread, and given that only small
> > isolated code bases now use it, sacf use can't nest, can it?
> 
> I just realized that this is broken for uaccess in irq context
> (e.g. copy_from_user_nofault()). With set_fs() removal the calls to
> force_uaccess_begin()/end() will do nothing, while before
> set_fs(USER_DS) actually enforced that control registers on s390 were
> setup correctly.
> This wouldn't be the case anymore now. If e.g. a code sequence within
> enable_sacf_uaccess() would be interrupted, and from within interrupt
> context copy_from_user_nofault() would be executed, this would read
> from kernel space instead from user space.
> 
> Needs fix.

So, I can think of several ways to fix this (or better: make this
robust). However given that I will be away the next two weeks this is
not going to happen for the upcoming merge window. I really don't want
to rush this, since this has potential for severe subtle bugs... like
we had them already several times with our address space and dynamic
page table upgrade handling in the past (and like I nearly introduced
at least one bug with this patch).

Therefore the first three patches of this series are scheduled for the
upcoming merge window, while the final set_fs() removal should come
one merge later.
