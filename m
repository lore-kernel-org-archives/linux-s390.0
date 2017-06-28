From: David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 7/9] KVM: s390: Backup the guest's machine check info
Date: Wed, 28 Jun 2017 21:46:07 +0200
Message-ID: <2659ff50-b264-b0cb-ce61-e604653b6e90@redhat.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
 <1498671044-81240-8-git-send-email-borntraeger@de.ibm.com>
 <b335c89d-f954-0bad-6a56-e4f599804c69@redhat.com>
 <c1c85f4e-62b9-82ea-a669-6ecf1380189f@de.ibm.com>
 <5d3bbee4-b3cf-ad98-828c-779624c3a138@redhat.com>
 <58cf662e-a7c0-2c4f-8d60-402ab9b9edfe@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <58cf662e-a7c0-2c4f-8d60-402ab9b9edfe@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

> No. Several guest registers are shared with host registers and reloaded lazily.
> For example if the floating point registers are invalid, they will be invalid 
> for the host (but the registers contain the guest values).
> From a KVM perspective we can always turn off valid bits in case of doubts 
> (overindicate errors). So the current variant is certainly not perfect, but it
> at least will not claim correct registers when they are incorrect.
> We can certainly improve the handling in a future patch. (e.g. turn on validity
> for control registers), I will have a look.
> 

As far as I understand, that would then mean, enabling all validity
flags for registers that are not shared. Makes sense.


-- 

Thanks,

David
