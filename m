From: Michael Mueller <mimu@linux.ibm.com>
Date: Tue, 20 Nov 2018 08:25:32 +0000
Subject: Re: [PATCH v2 06/12] KVM: s390: add function unlink_gib_alert_list()
Message-Id: <191fe3f9-87f9-a7b7-e530-0f9a2d046f72@linux.ibm.com>
In-Reply-To: <20181119194707.GB3793@osiris>
References: <20181119194707.GB3793@osiris>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 19.11.18 20:47, Heiko Carstens wrote:
> On Mon, Nov 19, 2018 at 06:25:30PM +0100, Michael Mueller wrote:
>> The function atomically returns the address of the first
>> GISA of this list and stores a zero address in the origin
>> list field of the GIB instead.
>>
>> The GIB alert list contains all GISAs that have pending
>> adapter interruptions.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ...
>> +static struct kvm_s390_gisa __maybe_unused *unlink_gib_alert_list(void)
>> +{
>> +	u32 gisa;
>> +
>> +	if (!gib)
>> +		return NULL;
>> +
> 
> ...
> 
>> +	do {
>> +		gisa = READ_ONCE(gib->alert_list_origin);
>> +	} while (cmpxchg(&gib->alert_list_origin, gisa, 0) != gisa);
>> +
>> +	return (void *)(u64) gisa;
>> +}
> 
> Please make this shorter:
> 
> 	return (void *)(u64) xchg(&gib->alert_list_origin, gisa, 0);
> 

Unbelievable... just one macro further down. Thanks for pointing me to.
