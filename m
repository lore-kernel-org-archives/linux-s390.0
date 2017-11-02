From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [RFC 19/19] s390/facilities: enable AP facilities needed by guest
Date: Thu, 2 Nov 2017 13:23:42 +0100
Message-ID: <8517636b-f95f-7747-e161-92abf1b244e1@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-20-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171016112510.39e9c330@mschwideX1>
 <3e836f59-3ef1-57d8-d6df-b66011c173c4@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <3e836f59-3ef1-57d8-d6df-b66011c173c4@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com
List-ID: <linux-s390.vger.kernel.org>



On 11/02/2017 01:08 PM, Christian Borntraeger wrote:
> 
> 
> On 10/16/2017 11:25 AM, Martin Schwidefsky wrote:
>> On Fri, 13 Oct 2017 13:39:04 -0400
>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>
>>> Sets up the following facilities bits to enable the specified AP
>>> facilities for the guest VM:
>>>     * STFLE.12: Enables the AP Query Configuration Information
>>>                 facility. The AP bus running in the guest uses
>>>                 the information returned from this instruction
>>>                 to configure AP adapters and domains for the
>>>                 guest machine.
>>>     * STFLE.15: Indicates the AP facilities test is available.
>>>                 The AP bus running in the guest uses the
>>>                 information.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>>>  arch/s390/tools/gen_facilities.c |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>>> index 70dd8f1..eeaa7db 100644
>>> --- a/arch/s390/tools/gen_facilities.c
>>> +++ b/arch/s390/tools/gen_facilities.c
>>> @@ -74,8 +74,10 @@ struct facility_def {
>>>  			8,  /* enhanced-DAT 1 */
>>>  			9,  /* sense-running-status */
>>>  			10, /* conditional sske */
>>> +			12, /* AP query configuration */
>>>  			13, /* ipte-range */
>>>  			14, /* nonquiescing key-setting */
>>> +			15, /* AP special-command facility */
>>>  			73, /* transactional execution */
>>>  			75, /* access-exception-fetch/store indication */
>>>  			76, /* msa extension 3 */
>>
>> With this all KVM guests will always have the AP instructions available, no?
>> In principles I like this approach, but it differs from the way z/VM does things,
>> there the guest will get an exception if it tries to execute an AP instruction
>> if there are no AP devices assigned to the guest. I wonder if there is a reason
>> why z/VM does it the way it does.
> 
> A good question. For LPAR it seems that you have AP instructions even if you have
> no crypto cards.
> 

I've tried to figure these things out last week but I've failed.

Right at the beginning of  AR-10334-03-POK we have this text:
"An adjunct processor (AP) facility consists of the three AP
instructions, and one to sixty-four APs.". This reads like if we
have AP facility we have to have at least one AP.

But when I've tried to get a better understanding how the
presence/absence of the AP facility is indicated and what facility
bits do we have in this context I got confused.

Tony, could you please give us a detailed summary on this (best with
references, and focusing on the (guest) program perspective)?

Regards,
Halil
