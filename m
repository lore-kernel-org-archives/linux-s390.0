From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 3 May 2016 10:00:26 +0200
Message-ID: <57285A9A.2020106@de.ibm.com>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
 <CANRm+Cw40QqHMjfEaqmDb5WC6xokotTATM6-5HNTJ4LwKAe3Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CANRm+Cw40QqHMjfEaqmDb5WC6xokotTATM6-5HNTJ4LwKAe3Cg@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 05/03/2016 09:50 AM, Wanpeng Li wrote:
> 2016-05-02 18:42 GMT+08:00 Christian Borntraeger <borntraeger@de.ibm.com>:
> [...]
>> Some wakeups should not be considered a sucessful poll. For example on
>> s390 I/O interrupts are usually floating, which means that _ALL_ CPUs
>> would be considered runnable - letting all vCPUs poll all the time for
>> transactional like workload, even if one vCPU would be enough.
>> This can result in huge CPU usage for large guests.
>> This patch lets architectures provide a way to qualify wakeups if they
>> should be considered a good/bad wakeups in regard to polls.
>>
>> For s390 the implementation will fence of halt polling for anything but
>> known good, single vCPU events. The s390 implementation for floating
>> interrupts does a wakeup for one vCPU, but the interrupt will be delivered
>> by whatever CPU comes first. To limit the halt polling we only mark the
> 
> If the floating interrupt means that the 'CPU comes first' will
> deliver the interrupt to all vCPUs?

No. All CPUs do the normal vcpu_run loop. And before entering the guest
every CPU will try to deliver pending interrupts

static int __vcpu_run(struct kvm_vcpu *vcpu)
{
[...]
        do {
                rc = vcpu_pre_run(vcpu);   ---------------------+
                if (rc)						|
                        break;					|
[...]								|
                exit_reason = sie64a(vcpu->arch.sie_block,	|
                                     vcpu->run->s.regs.gprs);	|
[...]								|
}								|
								|
static int vcpu_pre_run(struct kvm_vcpu *vcpu)		<-------+
{
[...]
        if (!kvm_is_ucontrol(vcpu->kvm)) {
                rc = kvm_s390_deliver_pending_interrupts(vcpu); <----
                if (rc)
                        return rc;
[...]
}



and whichever comes first, will dequeue that interrupt and deliver it
by doing the PSW swap (jumping to the interrupt handler address)

(other CPUs will then not deliver this interrupt as it is already dequeued)
