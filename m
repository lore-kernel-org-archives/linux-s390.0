From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [GIT PULL 1/2] KVM: s390: allow user space to handle instr 0x0000
Date: Wed, 20 Jul 2016 18:47:22 +0100
Message-ID: <578FB92A.5030806@arm.com>
References: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com>
 <1469018400-8397-2-git-send-email-borntraeger@de.ibm.com>
 <578F8C45.6060505@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <578F8C45.6060505@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, cdall@cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

On 20/07/16 15:35, Christian Borntraeger wrote:
> Marc, Christoffer,
> FYI/FYA
> the CAP number will conflict with your kvmarm changes.
> I assume Paolo/Radim will resolve this when merging.

Yea, that's usually the case.

> Seems that you have no hit in api.txt, correct?

There is a small update for the KVM_CAP_SIGNAL_MSI API, but we don't
seem to step on each other's toes over there.

Thanks for the heads up!

	M.
-- 
Jazz is not dead. It just smells funny...
