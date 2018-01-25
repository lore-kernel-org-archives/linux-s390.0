From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 05/12] s390/css: expose the AIV facility
Date: Thu, 25 Jan 2018 13:04:42 +0100
Message-ID: <c44a76c6-4573-7325-d3b2-0f4177daba2e@de.ibm.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-6-borntraeger@de.ibm.com>
 <29f77b94-a5e1-178d-2364-9dcf77dc9096@redhat.com>
 <dbfae6e1-ceda-880c-3908-b03193c7d714@linux.vnet.ibm.com>
 <20180118185400.34533a23.cohuck@redhat.com>
 <13254019-23b0-5bad-27c8-3874400288a1@de.ibm.com>
 <20180125130036.19e68a82.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125130036.19e68a82.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Mueller <mimu@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/25/2018 01:00 PM, Cornelia Huck wrote:
> On Thu, 25 Jan 2018 12:42:28 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 01/18/2018 06:54 PM, Cornelia Huck wrote:
>>> On Thu, 18 Jan 2018 13:02:45 +0100
>>> Michael Mueller <mimu@linux.vnet.ibm.com> wrote:
>>>   
>>>> On 17.01.18 16:19, David Hildenbrand wrote:  
>>>>> On 16.01.2018 21:02, Christian Borntraeger wrote:    
>>>>>> From: Michael Mueller <mimu@linux.vnet.ibm.com>
>>>>>>
>>>>>> The patch exposes the Adapter Interruption Virtualization facility (AIV)
>>>>>> of the general channel subsystem characteristics.
>>>>>>
>>>>>> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
>>>>>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>>> ---
>>>>>>   arch/s390/include/asm/css_chars.h | 4 +++-
>>>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/s390/include/asm/css_chars.h b/arch/s390/include/asm/css_chars.h
>>>>>> index a478eb61aaf7..fb56fa3283a2 100644
>>>>>> --- a/arch/s390/include/asm/css_chars.h
>>>>>> +++ b/arch/s390/include/asm/css_chars.h
>>>>>> @@ -20,7 +20,9 @@ struct css_general_char {
>>>>>>   	u32 aif_tdd : 1; /* bit 56 */
>>>>>>   	u32 : 1;
>>>>>>   	u32 qebsm : 1;	 /* bit 58 */
>>>>>> -	u32 : 8;
>>>>>> +	u32 : 2;
>>>>>> +	u32 aiv : 1;     /* bit 61 */
>>>>>> +	u32 : 5;
>>>>>>   	u32 aif_osa : 1; /* bit 67 */
>>>>>>   	u32 : 12;
>>>>>>   	u32 eadm_rf : 1; /* bit 80 */
>>>>>>    
>>>>> "Expose" sounds like actually forwarding something / enabling a bit.    
>>>> Expose here basically means to make sth. visible what was already available.  
>>>>> Wonder if this can be squashed with another patch?
>>>>>
>>>>> Or rename to something like "define" ...    
>>>> I don't plan to change anything.  
>>>
>>> I'd prefer to simply squash this with the next patch, where the bit is
>>> actually checked.  
>>
>> Its a separate code (not KVM) so I keep it separate.
> 
> I would just have collected an ack from the relevant maintainers, but
> fair enough.

I need that anyway and its easier if I just have this hunk.

Heiko Martin, can any of you ack

this patch ([PATCH 05/12] s390/css: expose the AIV facility)
as well as
[PATCH 03/12] s390/bitops: add test_and_clear_bit_inv()
and
[PATCH 11/12] s390/sclp: expose the GISA format facility

for handling these patches via the KVM tree.


>>
>>
>> s390/css: indicate the availability of the AIV facility
>>   
>> The patch adds an indication for the presence Adapter Interruption
>> Virtualization facility (AIV) of the general channel subsystem
>> characteristics.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> [change wording]
>>
> 
> Also works for me.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
Thanks.
