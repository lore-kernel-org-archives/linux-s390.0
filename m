From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: s390: vsie: Consolidate CRYCB validation
Date: Wed, 22 Aug 2018 10:44:36 +0200
Message-ID: <f5261c1a-58f6-68f2-1736-eb13dce863b6@redhat.com>
References: <1534925337-18380-1-git-send-email-pmorel@linux.ibm.com>
 <c410ab24-1f83-21f3-1996-7328aeb3f408@redhat.com>
 <7de5e991-764e-dec8-648b-6acc42c141e6@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7de5e991-764e-dec8-648b-6acc42c141e6@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 22.08.2018 10:41, Pierre Morel wrote:
> On 22/08/2018 10:25, David Hildenbrand wrote:
>> On 22.08.2018 10:08, Pierre Morel wrote:
>>> Currently when shadowing the CRYCB on SIE entrance, the validation
>>> tests the following:
>>> - accept only FORMAT1 or FORMAT2
>>> - test if MSAext facility (76) is installed
>>> - accept the CRYCB if no keys are used
>>> - verifies that the CRYCB format1 is inside a page
>>> - verifies that the CRYCB origin is not 0
>>>
>>> This is not following the architecture.
>> I have to trust you on that :)
>>
>>> On SIE entrance, the CRYCB must be validated before accepting
>>> any of its entries.
>>>
>>> Let's do the validation in the right order and also verify
>>> correctly the FORMAT2 CRYCB.
>> With which facility was FORMAT2 introduced?
> With APXA.
> KVM initialization setup CRYCB format according to the presence
> of APXA for FORMAT2 or FORMAT1

As our guest does not see APXA, why should it be allowed to make use of
FORMAT2 here already?

In my opinion, the size check you are adding is in the current state not
correct.


-- 

Thanks,

David / dhildenb
