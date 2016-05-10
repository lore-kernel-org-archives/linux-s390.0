From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 10 May 2016 15:54:40 +0200
Message-ID: <5731E820.1020601@redhat.com>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
 <CANRm+Cx6LXcr-PUYQZAV0TB13K-VW-=jwQF_ZM6F=COxQFoM0Q@mail.gmail.com>
 <57284C99.6090307@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <57284C99.6090307@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Wanpeng Li <kernellwp@gmail.com>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 03/05/2016 09:00, Christian Borntraeger wrote:
>>> >> +       vcpu_reset_wakeup(vcpu);
>> > 
>> > Why mark the next wakeup as a non-sucessful poll?
> It is basically only used for s390 and used as a mean to implement the "default off,
> only on for selected cases". But yes, if somebody else wants to use it this might 
> need to be changed.
> So what about changing this into
> kvm_arch_vcpu_block_finish(vcpu)
> which is a reset on s390 and a no for others?

I think this is okay as is.

Paolo
