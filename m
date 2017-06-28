From: David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 7/9] KVM: s390: Backup the guest's machine check info
Date: Wed, 28 Jun 2017 20:56:45 +0200
Message-ID: <5d3bbee4-b3cf-ad98-828c-779624c3a138@redhat.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
 <1498671044-81240-8-git-send-email-borntraeger@de.ibm.com>
 <b335c89d-f954-0bad-6a56-e4f599804c69@redhat.com>
 <c1c85f4e-62b9-82ea-a669-6ecf1380189f@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <c1c85f4e-62b9-82ea-a669-6ecf1380189f@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 28.06.2017 20:37, Christian Borntraeger wrote:
> On 06/28/2017 08:20 PM, David Hildenbrand wrote:
>> On 28.06.2017 19:30, Christian Borntraeger wrote:
>>> From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>>>
>>> When a machine check happens in the guest, related mcck info (mcic,
>>> external damage code, ...) is stored in the vcpu's lowcore on the host.
>>> Then the machine check handler's low-level part is executed, followed
>>> by the high-level part.
>>>
>>> If the high-level part's execution is interrupted by a new machine check
>>> happening on the same vcpu on the host, the mcck info in the lowcore is
>>> overwritten with the new machine check's data.
>>>
>>> If the high-level part's execution is scheduled to a different cpu,
>>> the mcck info in the lowcore is uncertain.
>>>
>>> Therefore, for both cases, the further reinjection to the guest will use
>>> the wrong data.
>>> Let's backup the mcck info in the lowcore to the sie page
>>> for further reinjection, so that the right data will be used.
>>>
>>> Add new member into struct sie_page to store related machine check's
>>> info of mcic, failing storage address and external damage code.
>>>
>>
>>
>> When this happens while the guest is running, there will be some
>> registers written into the low core save area (gprs, cr etc.) during the
>> machine check. Are these always host registers? Or can these be guest
>> registers?
> 
> Always host registers (the machine will exit SIE before presenting the machine
> check).
>>
>> Also, do the "valid" flags always refer to guest or host bits?
> 
> The host bits.

Okay, then why is mcic extracted from the real machine check and passed
on to the guest (almost unmodified)?

Wouldn't all guest registers than have to be always valid?

Also, if the guest does not have vector registers enabled, but the host
does, and there is a machine check, the guest would suddenly have the
vector registers valid flag indicated, which is strange.

For ordinary crw machine checks, we properly take care of that (QEMU
build_channel_report_mcic()).


-- 

Thanks,

David
