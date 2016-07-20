From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 1/2] KVM: s390: allow user space to handle instr
 0x0000
Date: Wed, 20 Jul 2016 10:43:43 -0400 (EDT)
Message-ID: <483881347.8895659.1469025823642.JavaMail.zimbra@redhat.com>
References: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com> <1469018400-8397-2-git-send-email-borntraeger@de.ibm.com> <578F8C45.6060505@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <578F8C45.6060505@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, marc zyngier <marc.zyngier@arm.com>, cdall@cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

> Marc, Christoffer,
> FYI/FYA
> the CAP number will conflict with your kvmarm changes.
> I assume Paolo/Radim will resolve this when merging.

Yup, we'll handle it.

Paolo
