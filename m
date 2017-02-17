From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: add kvm_arch_cpu_kick
Date: Fri, 17 Feb 2017 17:23:55 +0100
Message-ID: <b1df82b4-dc77-d152-ca0a-c97741df20dd@redhat.com>
References: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
 <1487337007-91063-2-git-send-email-borntraeger@de.ibm.com>
 <20170217151227.GA27770@potion>
 <e55d4aba-6c0b-f188-1632-d7293c857deb@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <e55d4aba-6c0b-f188-1632-d7293c857deb@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 17/02/2017 16:46, Christian Borntraeger wrote:
> Looks good. The kick does not have to be synchronous and its ok if we
> reenter the guest as long as we execute the request in a timely manner,
> correct?
> 
> e.g. 
> - kick vcpu
> - vcpu enters SIE
> - vcpu exits SIE immediately
> - vcpu handles request
> - vcpu enters SIE
> 
> would be perfectly fine?

Yes, it would.  There's some parallel with QEMU's qemu_cpu_kick, where
the signal would be processed immediately after entering KVM_RUN.

Paolo
