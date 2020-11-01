Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgKAQGM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 1 Nov 2020 11:06:12 -0500
Date: Sun, 1 Nov 2020 17:05:54 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201101160554.GA9375@osiris>
References: <20201028182742.13773-1-cai@redhat.com>
 <20201031183725.GA9529@osiris>
 <1f0ef4b832c67dcec1bcc793407e62c58a97904e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0ef4b832c67dcec1bcc793407e62c58a97904e.camel@redhat.com>
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 07:38:52PM -0400, Qian Cai wrote:
> > > This is avoided by moving the call to rcu_cpu_starting up near the
> > > beginning of the smp_init_secondary() function. Note that the
> > > raw_smp_processor_id() is required in order to avoid calling into
> > > lockdep before RCU has declared the CPU to be watched for readers.
> > > 
> > > Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> > > Signed-off-by: Qian Cai <cai@redhat.com>
> > > ---
> > >  arch/s390/kernel/smp.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Could you provide the config you used? I'm wondering why I can't
> > reproduce this even though I have lot's of debug options enabled.
> https://cailca.coding.net/public/linux/mm/git/files/master/s390.config
> 
> Essentially, I believe it requires CONFIG_PROVE_RCU_LIST=y. Also, it occurs to
> me that this only starts to happen after the commit mentioned in the above link.

Yes, with that enabled I can reprocuce it. Thanks! It depends on
CONFIG_RCU_EXPERT. I can't image why I didn't had that enabled.. :)
