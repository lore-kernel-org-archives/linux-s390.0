From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] KVM: add kvm_arch_cpu_kick
Date: Fri, 17 Feb 2017 17:42:31 +0100
Message-ID: <6f3d1415-b337-ecff-e56a-02017ea44658@de.ibm.com>
References: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
 <1487337007-91063-2-git-send-email-borntraeger@de.ibm.com>
 <20170217151227.GA27770@potion>
 <e55d4aba-6c0b-f188-1632-d7293c857deb@de.ibm.com>
 <b1df82b4-dc77-d152-ca0a-c97741df20dd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <b1df82b4-dc77-d152-ca0a-c97741df20dd@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/17/2017 05:23 PM, Paolo Bonzini wrote:
> 
> 
> On 17/02/2017 16:46, Christian Borntraeger wrote:
>> Looks good. The kick does not have to be synchronous and its ok if we
>> reenter the guest as long as we execute the request in a timely manner,
>> correct?
>>
>> e.g. 
>> - kick vcpu
>> - vcpu enters SIE
>> - vcpu exits SIE immediately
>> - vcpu handles request
>> - vcpu enters SIE
>>
>> would be perfectly fine?
> 
> Yes, it would.  There's some parallel with QEMU's qemu_cpu_kick, where
> the signal would be processed immediately after entering KVM_RUN.

Something like 

---snip-----
        struct kvm_s390_sie_block *scb = READ_ONCE(vcpu->arch.vsie_block);

	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
        if (scb)
		atomic_or(CPUSTAT_STOP_INT, &scb->cpuflags);
---snip-----

or 
---snip-----
	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
	kvm_s390_vsie_kick(vcpu);
---snip-----

should be enough then. The code will either delete that stop request when
processing interrupts, but then the requests will be handled afterwards,
or we enter the guest once, exit and process then the requests in the next
loop iteration.

As I am on my way into the weekend this needs double checking.
