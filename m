Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgEEMS3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 08:18:29 -0400
Subject: Re: [PATCH] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
References: <20200505073525.2287-1-borntraeger@de.ibm.com>
 <20200505095332.528254e5.cohuck@redhat.com>
 <f3512a63-91dc-ab9a-a9ab-3e2a6e24fea3@de.ibm.com>
 <59f1b90c-47d6-2661-0e99-548a53c9bcd6@redhat.com>
 <480b0bff-8eb5-f75c-a3ce-2555e38917ee@de.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <1ef464b8-bba7-4ec6-558f-7f76c6690fb2@linux.ibm.com>
Date: Tue, 5 May 2020 14:18:21 +0200
MIME-Version: 1.0
In-Reply-To: <480b0bff-8eb5-f75c-a3ce-2555e38917ee@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Qian Cai <cailca@icloud.com>, Tony Krowiak <akrowiak@linux.ibm.com>



On 2020-05-05 10:27, Christian Borntraeger wrote:
> 
> 
> On 05.05.20 10:04, David Hildenbrand wrote:
>> On 05.05.20 09:55, Christian Borntraeger wrote:
>>>
>>>
>>> On 05.05.20 09:53, Cornelia Huck wrote:
>>>> On Tue,  5 May 2020 09:35:25 +0200
>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>
>>>>> In LPAR we will only get an intercept for FC==3 for the PQAP
>>>>> instruction. Running nested under z/VM can result in other intercepts as
>>>>> well, for example PQAP(QCI). So the WARN_ON_ONCE is not right. Let
>>>>> us simply remove it.
>>>>
>>>> While I agree with removing the WARN_ON_ONCE, I'm wondering why z/VM
>>>> gives us intercepts for those fcs... is that just a result of nesting
>>>> (or the z/VM implementation), or is there anything we might want to do?
>>>
>>> Yes nesting.
>>> The ECA bit for interpretion is an effective one. So if the ECA bit is off
>>> in z/VM (no crypto cards) our ECA bit is basically ignored as these bits
>>> are ANDed.
>>> I asked Tony to ask the z/VM team if that is the case here.
>>>
>>
>> So we can't detect if we have support for ECA_APIE, because there is no
>> explicit feature bit, right? Rings a bell. Still an ugly
>> hardware/firmware specification.

Sorry to be late but you were really too fast for me. :)

AFAIK we detect if we have AP instructions enabled by ECA_APIE for the 
host by probing with a PQAP(TESTQ) during the boot.
If the hypervizor accept this instruction it is supposed to work as if 
it has set APIE present for the Linux host.
If the instruction is rejected we do not enable AP instructions for the 
guest

We also detect if we can use QCI by testing the facility bit and 
propagate only the facility bits we have earned or emulate don't we?

So here I am curious why we got an interception.

Did we give false information to the guest?
Is the guest right to issue the instruction intercepted?
Did z/VM provide the host with false facility information?
Did z/VM dynamically change the virtualization scheme after the boot?

I did not find evidence of the first assumption which would have been a 
legitimate warning.
The next 3 are, IMHO, misbehavior from the guest or z/VM, and do not 
justify a warning there so I find right to remove it.

consider it as a "late" reviewed-by.

Regards,
Pierre


> 
> Yes, no matter if this is the case here, we cannot rely on ECA_APIE to not
> trigger intercepts. So we must remove the WARN_ON.




> 
> cc stable?
> 
>>
>> Seems to be the right thing to do
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>

-- 
Pierre Morel
IBM Lab Boeblingen
