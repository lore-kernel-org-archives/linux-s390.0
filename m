From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH/RFC 2/3] s390/kvm: Platform specific kvm_arch_vcpu_dont_yield
Date: Fri, 14 Feb 2014 00:32:24 +0100
Message-ID: <52FD5608.2050808@redhat.com>
References: <1392119132-50182-1-git-send-email-borntraeger@de.ibm.com> <1392119132-50182-3-git-send-email-borntraeger@de.ibm.com> <52FD4913.3000107@redhat.com> <52FD4D17.10307@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52FD4D17.10307@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 13/02/2014 23:54, Christian Borntraeger ha scritto:
> We had several variants but in the end we tried to come up with a patch that does not
> influence other architectures. Your proposal would certainly be fine for s390,
> but what impact does it have on x86, arm, arm64? Will it cause performance regressions?

It may also have the same advantages you got on s390.

> So I think that the patch as is is probably the safest choice until we have some
> data from x86, arm, arm64, no?

No, using an existing API is always better than inventing a new one.

If you post the new patch series, and describe the benchmark you were 
using, we can reproduce it on x86.

Paolo
