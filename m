From: David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 1/2] KVM: s390: handle access registers in the run
 ioctl not in vcpu_put/load
Date: Thu, 1 Dec 2016 13:28:43 +0100
Message-ID: <a03cdb6a-cfcb-e913-a9ae-3c5133a2695e@redhat.com>
References: <1480323998-210045-1-git-send-email-borntraeger@de.ibm.com>
 <1480323998-210045-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1480323998-210045-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 28.11.2016 um 10:06 schrieb Christian Borntraeger:
> Right now we save the host access registers in kvm_arch_vcpu_load
> and load them in kvm_arch_vcpu_put. Vice versa for the guest access
> registers. On schedule this means, that we load/save access registers
> multiple times.

Wasn't the main point about this to also protect from scheduling
another VCPU (maybe even from another VM)? (which in return would have
its own set of access registers and therefore would now use the wrong
set of access registers)

Must likely I am forgetting something very important here :)

-- 

David
