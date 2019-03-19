From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Tue, 19 Mar 2019 15:54:21 +0100
Message-ID: <20190319155421.0f0e51c2@oc2783563651>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
        <20190315112032.13b259c2.cohuck@redhat.com>
        <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
        <20190315182839.4f7c0a73@oc2783563651>
        <0351d631-b756-dd22-0848-6f30747dc5e2@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0351d631-b756-dd22-0848-6f30747dc5e2@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 19 Mar 2019 11:01:44 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 15/03/2019 18:28, Halil Pasic wrote:

[..]

> > 
> > Things get complicated when one considers that ECA.28 is an effective
> > control.
> 
> I don't think so, ECA_28 is not really a problem.
> We do not propagate ECA_AIV in VSIE and ECA_AIV is tested in the vfio 
> driver to support GISA.
> So that the guest 3 will not support interrupt.
> 

That was not my concern, but while we are at it... I guess you refer to
the check in handle_pqap(). That seems to do -EOPNOTSUPP, i.e. got to
userspace, i.e. with today's QEMU operation exception. Which does not
seem right.

My concern was the following. Let assume 
ECA.28 == 1 and EECA.28 == 0 != 1
and guest issues a PQAP (for simplicity AQIC).

Currently I guess we take a 0x04 interception and go to userspace, which
may or may not be the best thing to do.

With this patch we would take a 0x04, but (opposed to before) if guest
does not have facility 65 we go with a specification exception.
Operation exception should however take priority over this kind of
specification exception. So basically everything except PQAP/AQIC would
give you and operation exception (with current QEMU), but PQAP/AQIC would
give you a specification exception. Which is wrong!

AFAICT there is no way to tell if we got a 04 interception because
EECA.28 != 1 (and ECA.28 == 1) and FW won't interpret the AP
instructions for us, or because it PQAP/AQIC is a mandatory intercept.
In other words I don't see a way to tell if EECA.28 is 1 when
interpreting PQAP/AQIC.

Do you agree?

[..]

> 
> Yes, the alternative is:
> 
> 1) We do things right but this mean we change the ABI (SPECIFICATION 
> instead of OPERATION)
> 
> I thing this is the best thing to do, it is the implementation
> proposed by this patch where all is done in Kernel, so that we are
> right what ever the userland user is (QEMU or other).
> 
> 2) We want to preserve the old ABI for old QEMU
> Then I proposed the implementation here under.
> 
> 
> My personal opinion, is that we should change the ABI and do things 
> right now.

I tend to agree. Giving an operation exception instead of a specification
exception is a bug. If it is a kernel or qemu bug it ain't clear to me
at the moment. 

> We should also do it right for TAPQ with t bit set. I remember
> Christian already warned about this but we did not implement it.
> 

Yes, I have some blurry memories of something similar myself. I wonder
if there was a reason, or did we just forget to address this issue.

Regards,
Halil
