From: Michael Mueller <mimu@linux.ibm.com>
Date: Wed, 28 Nov 2018 12:29:17 +0000
Subject: Re: [PATCH v3 11/12] KVM: s390: start using the GIB
Message-Id: <5a59325e-9dd1-89e6-c172-02779ec682e4@linux.ibm.com>
In-Reply-To: <20181128113100.16925683.cohuck@redhat.com>
References: <20181128113100.16925683.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 28.11.18 11:31, Cornelia Huck wrote:
> On Wed, 28 Nov 2018 11:19:42 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> By initializing the GIB, it will be used by the kvm host.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 283c51362ca8..9b20017dda29 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -428,6 +428,10 @@ int kvm_arch_init(void *opaque)
>>   		goto out_unreg;
>>   	}
>>   
>> +	rc = kvm_s390_gib_init(GAL_ISC);
>> +	if (rc)
>> +		goto out_unreg;
>> +
>>   	kvm_s390_cpu_feat_init();
>>   
>>   	/* Register floating interrupt controller interface. */
> 
> Aren't you missing a call to kvm_s390_gib_destroy() in the out_unreg
> case (if registering the flic fails)?

Details... ;)

> 
