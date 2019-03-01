From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Fri, 1 Mar 2019 13:03:40 +0100
Message-ID: <3fedbde5-ef83-c67e-6352-fd492f258009@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
 <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
 <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
 <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
 <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
 <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
 <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
 <20190228122251.75b31f62.cohuck@redhat.com>
 <be69498a-c4d3-81e7-b8bf-6931058cee74@linux.ibm.com>
 <20190228145254.2909425e.cohuck@redhat.com>
 <261a1e22-3703-21a4-e33d-e737651e7d89@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <261a1e22-3703-21a4-e33d-e737651e7d89@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 28/02/2019 15:14, Pierre Morel wrote:
> On 28/02/2019 14:52, Cornelia Huck wrote:
>> On Thu, 28 Feb 2019 14:16:09 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 28/02/2019 12:22, Cornelia Huck wrote:
>>
>>>> So, to summarize, the function should do:
>>>> - Is userspace supposed to emulate everything (!ECA_APIE)? Return
>>>>     -EOPNOTSUPP to hand control to it.
>>>> - We are now interpreting the instruction in KVM. Do common checks
>>>>     (PSTATE etc.) and inject exceptions, if needed.
>>>> - Now look at the fc; if there's a handler for it, call that; if not
>>>>     (case does not attempt to call a specific handler, or no handler
>>>>     registered), inject a specification exception. (Do we want 
>>>> pre-checks
>>>>     like for facility 65 here, or in the handler?)
>>>>
>>>> That response code 0x01 thingy probably needs to go into the specific
>>>> handler function, if anywhere (don't know the semantics, sorry).
>>>
>>> What do you mean with specific handler function?
>>>
>>> If you mean a switch around the FC with static function's call, I agree,
>>> if you mean a jump into a hook I do not agree.
>>
>> Ah, ok; so each case (that we want to handle) should call into a
>> subhandler that does
>> {
>>     (... check things like facilities ...)
>>     if (!specific_hook)
>>         inject_specif_excp_and_return();
>>     ret = specific_hook();
>>     if (ret)
>>         set_resp_code_0x01(); // or in specific_hook()?
>> }
>>
>> ?
> 
> Yes something in this direction.

Sorry, after reflection, no, we do not want to change the previous 
behavior so we only handle the AQIC case.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
