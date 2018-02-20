From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Feb 2018 15:56:42 +0000
Subject: Re: [PATCH RFC 4/6] KVM: s390: consider epoch index on TOD clock syncs
Message-Id: <eb90741f-cbc0-d61b-4645-5fba492f7253@de.ibm.com>
In-Reply-To: <b25f6e5e-a5e6-54fc-910e-ad2e6e83bbb1@redhat.com>
References: <b25f6e5e-a5e6-54fc-910e-ad2e6e83bbb1@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 02/20/2018 04:41 PM, David Hildenbrand wrote:
> On 20.02.2018 16:36, Christian Borntraeger wrote:
>>
>>
>> On 02/07/2018 12:46 PM, David Hildenbrand wrote:
>>> For now, we don't take care of over/underflows. Especially underflows
>>> are critical:
>>>
>>> Assume the epoch is currently 0 and we get a sync request for delta=1,
>>> meaning the TOD is moved forward by 1 and we have to fix it up by
>>> subtracting 1 from the epoch. Right now, this will leave the epoch
>>> index untouched, resulting in epoch=-1, epoch_idx=0, which is wrong.
>>>
>>> We have to take care of over and underflows, also for the VSIE case. So
>>> let's factor out calculation into a separate function.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  arch/s390/kvm/kvm-s390.c | 32 +++++++++++++++++++++++++++++---
>>>  1 file changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index d007b737cd4d..c2b62379049e 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -179,6 +179,28 @@ int kvm_arch_hardware_enable(void)
>>>  static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
>>>  			      unsigned long end);
>>>
>>> +static void kvm_clock_sync_scb(struct kvm_s390_sie_block *scb, u64 delta)
>>> +{
>>> +	u64 delta_idx = 0;
>>
>> we only add it to epdx, so should it be u8?
> 
> Indeed, this should be u8.
> 
>>> +
>>> +	/*
>>> +	 * The TOD jumps by delta, we have to compensate this by adding
>>> +	 * -delta to the epoch.
>>> +	 */
>>> +	delta = -delta;
>>> +
>>> +	/* sign-extension - we're adding to signed values below */
>>> +	if ((s64)delta < 0)
>>> +		delta_idx = 0xff;
>>
>> 		and -1 then here?
> 
> Yes, thanks!

with that 
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

applied and changed to u8. 

In plan to submit patch 1,3 and 4 for 4.16
