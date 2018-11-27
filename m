From: Michael Mueller <mimu@linux.ibm.com>
Date: Tue, 27 Nov 2018 17:40:05 +0000
Subject: Re: [PATCH v2 12/12] KVM: s390: start using the GIB
Message-Id: <3761cf98-f591-be5c-7eab-9cb49a8d6942@linux.ibm.com>
In-Reply-To: <20181126172310.4c30b0d2.cohuck@redhat.com>
References: <20181126172310.4c30b0d2.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 26.11.18 17:23, Cornelia Huck wrote:
> On Mon, 19 Nov 2018 18:25:36 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> By initializing the GIB, it will we used by the kvm host.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 386f98029a3f..08341be4d0aa 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -417,6 +417,8 @@ static void kvm_s390_cpu_feat_init(void)
>>   
>>   int kvm_arch_init(void *opaque)
>>   {
>> +	int rc;
>> +
>>   	kvm_s390_dbf = debug_register("kvm-trace", 32, 1, 7 * sizeof(long));
>>   	if (!kvm_s390_dbf)
>>   		return -ENOMEM;
>> @@ -426,6 +428,10 @@ int kvm_arch_init(void *opaque)
>>   		return -ENOMEM;
>>   	}
>>   
>> +	rc = kvm_s390_gib_init(GAL_ISC);
>> +	if (rc)
>> +		return rc;
> 
> Is a quick exit the right thing here? Doesn't that leave a memory leak
> because you did not unregister the dbf again?

Yes indeed!

> 
>> +
>>   	kvm_s390_cpu_feat_init();
>>   
>>   	/* Register floating interrupt controller interface. */
> 
> Further below, we'll have the same problem (dbf leak) if registering
> the flic should fail. This is extremely unlikely... but don't we also
> need to clean up the gib again in that case? For all later failure
> cases in kvm init, the exit function is called, but that one may be a
> problem.

Well all this is rather unlikely but not impossible.

I will prepare a separate patch for the flic issue and put it in front.

> 
