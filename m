Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6314 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732690AbgGaLwp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 07:52:45 -0400
Date: Fri, 31 Jul 2020 13:52:26 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390/test_unwind: fix possible memleak in test_unwind()
Message-ID: <20200731115226.GD11581@osiris>
References: <20200730063602.31581-1-wanghai38@huawei.com>
 <247044acbf1dbae8e3b48c2dcc1457cd2e59cfef.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247044acbf1dbae8e3b48c2dcc1457cd2e59cfef.camel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Wang Hai <wanghai38@huawei.com>, gor@linux.ibm.com, borntraeger@de.ibm.com, colin.king@canonical.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:35:15AM +0200, Ilya Leoshkevich wrote:
> On Thu, 2020-07-30 at 14:36 +0800, Wang Hai wrote:
> > test_unwind() misses to call kfree(bt) in an error path.
> > Add the missed function call to fix it.
> > 
> > Fixes: 0610154650f1 ("s390/test_unwind: print verbose unwinding
> > results")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > ---
> >  arch/s390/lib/test_unwind.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/s390/lib/test_unwind.c
> > b/arch/s390/lib/test_unwind.c
> > index 32b7a30b2485..b0b12b46bc57 100644
> > --- a/arch/s390/lib/test_unwind.c
> > +++ b/arch/s390/lib/test_unwind.c
> > @@ -63,6 +63,7 @@ static noinline int test_unwind(struct task_struct
> > *task, struct pt_regs *regs,
> >  			break;
> >  		if (state.reliable && !addr) {
> >  			pr_err("unwind state reliable but addr is
> > 0\n");
> > +			kfree(bt);
> >  			return -EINVAL;
> >  		}
> >  		sprint_symbol(sym, addr);
> 
> Looks good to me, thanks!
> 
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!
