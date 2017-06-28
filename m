From: David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 7/9] KVM: s390: Backup the guest's machine check info
Date: Wed, 28 Jun 2017 20:20:49 +0200
Message-ID: <b335c89d-f954-0bad-6a56-e4f599804c69@redhat.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
 <1498671044-81240-8-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1498671044-81240-8-git-send-email-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 28.06.2017 19:30, Christian Borntraeger wrote:
> From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> 
> When a machine check happens in the guest, related mcck info (mcic,
> external damage code, ...) is stored in the vcpu's lowcore on the host.
> Then the machine check handler's low-level part is executed, followed
> by the high-level part.
> 
> If the high-level part's execution is interrupted by a new machine check
> happening on the same vcpu on the host, the mcck info in the lowcore is
> overwritten with the new machine check's data.
> 
> If the high-level part's execution is scheduled to a different cpu,
> the mcck info in the lowcore is uncertain.
> 
> Therefore, for both cases, the further reinjection to the guest will use
> the wrong data.
> Let's backup the mcck info in the lowcore to the sie page
> for further reinjection, so that the right data will be used.
> 
> Add new member into struct sie_page to store related machine check's
> info of mcic, failing storage address and external damage code.
> 


When this happens while the guest is running, there will be some
registers written into the low core save area (gprs, cr etc.) during the
machine check. Are these always host registers? Or can these be guest
registers?

Also, do the "valid" flags always refer to guest or host bits?

If they can be guest bits, I think we would have to do more translation.
And most likely treat vSIE special.

Or will something like that always lead to a host crash and real machine
errors will still take the host down, and not the guest?


-- 

Thanks,

David
