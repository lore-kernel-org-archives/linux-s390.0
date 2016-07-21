From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: PREVIEW: [GIT PULL 0/2] KVM: s390: Feature and fix for kvm/next
 (4.8) part 4
Date: Thu, 21 Jul 2016 15:07:18 +0200
Message-ID: <20160721130717.GA2317@potion>
References: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

2016-07-20 14:39+0200, Christian Borntraeger:
> Paolo, Radim,
> 
> hopefully the last update for s390 for 4.8.
> Please note the CAP number conflicts with kvmarm, when merging the one
> or the other first. You might also need to adopt the number in
> Documentation/virtual/kvm/api.txt in case arm has something in here as well.

Merged, thanks.  Capability 130 is KVM_CAP_S390_USER_INSTR0.
