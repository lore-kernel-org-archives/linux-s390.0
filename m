Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47328 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728114AbgEEI3C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 04:29:02 -0400
Date: Tue, 5 May 2020 10:21:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
Message-ID: <20200505101739.137393dc.cohuck@redhat.com>
In-Reply-To: <f3512a63-91dc-ab9a-a9ab-3e2a6e24fea3@de.ibm.com>
References: <20200505073525.2287-1-borntraeger@de.ibm.com>
        <20200505095332.528254e5.cohuck@redhat.com>
        <f3512a63-91dc-ab9a-a9ab-3e2a6e24fea3@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Qian Cai <cailca@icloud.com>, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>

On Tue, 5 May 2020 09:55:36 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 05.05.20 09:53, Cornelia Huck wrote:
> > On Tue,  5 May 2020 09:35:25 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> In LPAR we will only get an intercept for FC==3 for the PQAP
> >> instruction. Running nested under z/VM can result in other intercepts as
> >> well, for example PQAP(QCI). So the WARN_ON_ONCE is not right. Let
> >> us simply remove it.  
> > 
> > While I agree with removing the WARN_ON_ONCE, I'm wondering why z/VM
> > gives us intercepts for those fcs... is that just a result of nesting
> > (or the z/VM implementation), or is there anything we might want to do?  
> 
> Yes nesting. 
> The ECA bit for interpretion is an effective one. So if the ECA bit is off
> in z/VM (no crypto cards) our ECA bit is basically ignored as these bits
> are ANDed.

Ok, that makes sense, even if it is rather ugly.

With the comment tweaked,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>

> I asked Tony to ask the z/VM team if that is the case here.
> 
> >   
> >>
> >> Cc: Pierre Morel <pmorel@linux.ibm.com>
> >> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> >> Reported-by: Qian Cai <cailca@icloud.com>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  arch/s390/kvm/priv.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> >> index 69a824f9ef0b..bbe46c6aedbf 100644
> >> --- a/arch/s390/kvm/priv.c
> >> +++ b/arch/s390/kvm/priv.c
> >> @@ -626,10 +626,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
> >>  	 * available for the guest are AQIC and TAPQ with the t bit set
> >>  	 * since we do not set IC.3 (FIII) we currently will only intercept
> >>  	 * the AQIC function code.
> >> +	 * Note: running nested under z/VM can result in intercepts, e.g.  
> > 
> > s/intercepts/intercepts for other function codes/
> >   
> >> +	 * for PQAP(QCI). We do not support this and bail out.
> >>  	 */
> >>  	reg0 = vcpu->run->s.regs.gprs[0];
> >>  	fc = (reg0 >> 24) & 0xff;
> >> -	if (WARN_ON_ONCE(fc != 0x03))
> >> +	if (fc != 0x03)
> >>  		return -EOPNOTSUPP;
> >>  
> >>  	/* PQAP instruction is allowed for guest kernel only */  
> >   
> 
