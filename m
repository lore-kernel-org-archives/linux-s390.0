From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 3 May 2016 11:19:59 +0200
Message-ID: <20160503111959.3e88458b.cornelia.huck@de.ibm.com>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
	<CANRm+Cx6LXcr-PUYQZAV0TB13K-VW-=jwQF_ZM6F=COxQFoM0Q@mail.gmail.com>
	<57284C99.6090307@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <57284C99.6090307@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 3 May 2016 09:00:41 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 05/03/2016 07:42 AM, Wanpeng Li wrote:
> > 2016-05-02 18:42 GMT+08:00 Christian Borntraeger <borntraeger@de.ibm.com>:
> > [...]
> >> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> >> index 9102ae1..d63ea60 100644
> >> --- a/virt/kvm/kvm_main.c
> >> +++ b/virt/kvm/kvm_main.c
> >> @@ -2008,7 +2008,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
> >>                          * arrives.
> >>                          */
> >>                         if (kvm_vcpu_check_block(vcpu) < 0) {
> >> -                               ++vcpu->stat.halt_successful_poll;
> >> +                               if (vcpu_valid_wakeup(vcpu))
> >> +                                       ++vcpu->stat.halt_successful_poll;
> >>                                 goto out;
> >>                         }
> >>                         cur = ktime_get();
> >> @@ -2038,14 +2039,16 @@ out:
> >>                 if (block_ns <= vcpu->halt_poll_ns)
> >>                         ;
> >>                 /* we had a long block, shrink polling */
> >> -               else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
> >> +               else if (!vcpu_valid_wakeup(vcpu) ||
> >> +                       (vcpu->halt_poll_ns && block_ns > halt_poll_ns))
> >>                         shrink_halt_poll_ns(vcpu);
> >>                 /* we had a short halt and our poll time is too small */
> >>                 else if (vcpu->halt_poll_ns < halt_poll_ns &&
> >> -                       block_ns < halt_poll_ns)
> >> +                       block_ns < halt_poll_ns && vcpu_valid_wakeup(vcpu))
> >>                         grow_halt_poll_ns(vcpu);
> >>         } else
> >>                 vcpu->halt_poll_ns = 0;
> >> +       vcpu_reset_wakeup(vcpu);
> > 
> > Why mark the next wakeup as a non-sucessful poll?
> 
> It is basically only used for s390 and used as a mean to implement the "default off,
> only on for selected cases". But yes, if somebody else wants to use it this might 
> need to be changed.
> So what about changing this into
> kvm_arch_vcpu_block_finish(vcpu)
> which is a reset on s390 and a no for others?

I like that idea.
