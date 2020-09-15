Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728014AbgIOTiI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 15:38:08 -0400
Date: Tue, 15 Sep 2020 21:37:55 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
Message-ID: <20200915193755.GA8528@osiris>
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
> On Tue, Sep 15, 2020 at 05:43:40PM +0200, Heiko Carstens wrote:
> > Address spaces still have to switched/changed for machines without the
> > mvcos instructions and especially for instructions like e.g. compare
> > and swap (-> futex) which must be executed in kernel address space but
> > access user address space. For such instructions enable_sacf_uaccess()
> > and disable_sacf_uaccess() must be used like before.
> 
> That logic always confused me and still keeps confusing me,
> dumb questions below:
> 
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

I just realized that this is broken for uaccess in irq context
(e.g. copy_from_user_nofault()). With set_fs() removal the calls to
force_uaccess_begin()/end() will do nothing, while before
set_fs(USER_DS) actually enforced that control registers on s390 were
setup correctly.
This wouldn't be the case anymore now. If e.g. a code sequence within
enable_sacf_uaccess() would be interrupted, and from within interrupt
context copy_from_user_nofault() would be executed, this would read
from kernel space instead from user space.

Needs fix.
