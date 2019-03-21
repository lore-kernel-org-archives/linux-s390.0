From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Thu, 21 Mar 2019 15:05:37 +0100
Message-ID: <268c46f2-4c30-adfd-25a4-29330aa89b35@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
 <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
 <20190315112032.13b259c2.cohuck@redhat.com>
 <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
 <20190315182839.4f7c0a73@oc2783563651>
 <0351d631-b756-dd22-0848-6f30747dc5e2@linux.ibm.com>
 <20190319155421.0f0e51c2@oc2783563651>
 <9c114f56-70bd-cc9e-3751-f62494407246@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9c114f56-70bd-cc9e-3751-f62494407246@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 19/03/2019 18:07, Pierre Morel wrote:
> On 19/03/2019 15:54, Halil Pasic wrote:
>> On Tue, 19 Mar 2019 11:01:44 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 15/03/2019 18:28, Halil Pasic wrote:
>>

...snip...

>>
>>> We should also do it right for TAPQ with t bit set. I remember
>>> Christian already warned about this but we did not implement it.
>>>
>>
>> Yes, I have some blurry memories of something similar myself. I wonder
>> if there was a reason, or did we just forget to address this issue.
> 
> 
> I will integrate it in the next iteration too, even it is not IRQ, the 
> PQAP hook patch can be more general.

After all, I will not do this, I remember the reason why we did not do 
it once: simply it is not intercepted until we enable it.

So we will handle it when we enable the TAPQ-t interception

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
