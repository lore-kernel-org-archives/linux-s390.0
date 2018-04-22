From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 03/15] KVM: s390: refactor crypto initialization
Date: Sun, 22 Apr 2018 10:52:55 -0400
Message-ID: <470d8af7-b9f6-0ab7-9bfa-351fbeaa079c@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-4-git-send-email-akrowiak@linux.vnet.ibm.com>
 <4fb50a31-1893-5cfb-0f35-fb2501c2afa8@linux.vnet.ibm.com>
 <OFE3FE11B1.8E1BDDEF-ON00258272.002AEDB1-C1258272.002B06EF@notes.na.collabserv.com>
 <20180417121044.5c8f2182.cohuck@redhat.com>
 <2ac8b862-e2dc-843e-a0b8-906fa32b42f4@linux.vnet.ibm.com>
 <20180417172139.0a2b148b.cohuck@redhat.com>
 <7276785e-2183-3204-ec80-99fba1546364@linux.vnet.ibm.com>
 <20180418094949.0403dcaf.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418094949.0403dcaf.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Harald Freudenberger <FREUDE@de.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, berrange@redhat.com, bjsdjshi@linux.vnet.ibm.com, borntrae@linux.ibm.com, fiuczy@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, kvm@vger.kernel.org, kwankhede@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mjrosato@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, Reinhard Buendgen <BUENDGEN@de.ibm.com>, thuth@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 04/18/2018 03:49 AM, Cornelia Huck wrote:
> On Tue, 17 Apr 2018 14:08:59 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 04/17/2018 11:21 AM, Cornelia Huck wrote:
>>> On Tue, 17 Apr 2018 10:26:57 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>   
>>>> On 04/17/2018 06:10 AM, Cornelia Huck wrote:
>>>>> On Tue, 17 Apr 2018 09:49:58 +0200
>>>>> "Harald Freudenberger" <FREUDE@de.ibm.com> wrote:
>>>>>      
>>>>>> Didn't we say that when APXA is not available there is no Crypto support
>>>>>> for KVM ?
>>>>> [Going by the code, as I don't have access to the architecture]
>>>>>
>>>>> Current status seems to be:
>>>>> - setup crycb if facility 76 is available (that's MSAX3, I guess?)
>>>> The crycb is set up regardless of whether STFLE.76 (MSAX3) is
>>>> installed or not.
>>> Hm, the current code does a quick exit if bit 76 is not set, doesn't
>>> it?
>> I guess that depends upon what you mean by current code. If you are talking
>> about the code as it is distributed today - i.e., before my patch series -
>> then you are correct. This patch changes that; it initializes the
>> kvm->arch.crypto.crycbd to point to the CRYCB, then clears the format bits
>> (kvm->arch.crypto.crycbd &= ~(CRYCB_FORMAT_MASK)) which is the same as
>> setting the CRYCB format to format 0. It is only after this that the
>> check is done to determine whether STFLE.76 is set.
> Ah yes, with "current" I referred to current upstream.
>
>>>   
>>>>> - use format 2 if APXA is available, else use format 1
>>>> Use format 0 if MSAX3 is not available
>>>> Use format 1 if MSAX3 is available but APXA is not
>>>> Use format 2 if MSAX3 and APXA is available
>>>>   
>>>>>    From Tony's patch description, the goal seems to be:
>>>>> - setup crycb even if MSAX3 is not available
>>>> Yes, that is true
>>>>   
>>>>> So my understanding is that we use APXA only to decide on the format of
>>>>> the crycb, but provide it in any case?
>>>> Yes, that is true
>>> With the format selection you outlined above, I guess. Makes sense from
>>> my point of view (just looking at the source code).
>> It also implements what is stated in the architecture doc.
> OK, great.
>
>>>   
>>>>> (Not providing a crycb if APXA is not available would be loss of
>>>>> functionality, I guess? Deciding not to provide vfio-ap if APXA is not
>>>>> available is a different game, of course.)
>>>> This would require a change to enabling the CPU model feature for
>>>> AP.
>>> But would it actually make sense to tie vfio-ap to APXA? This needs to
>>> be answered by folks with access to the architecture :)
>> I don't see any reason to do that from an architectural perspective.
>> One can access AP devices whether APXA is installed or not, it just limits
>> the range of devices that can be addressed
> So I guess we should not introduce a tie-in then (unless it radically
> simplifies the code...)

I'm not clear about what you mean by introducing a tie-in. Can you 
clarify that?

>
