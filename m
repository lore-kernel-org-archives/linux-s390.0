From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/7] KVM: s390: reenable LPP facility
Date: Wed, 04 Feb 2015 15:59:07 +0100
Message-ID: <54D233BB.70401@de.ibm.com>
References: <1423043092-34044-1-git-send-email-borntraeger@de.ibm.com> <1423043092-34044-3-git-send-email-borntraeger@de.ibm.com> <54D2173D.4070108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <54D2173D.4070108@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Am 04.02.2015 um 13:57 schrieb Paolo Bonzini:
> 
> 
> On 04/02/2015 10:44, Christian Borntraeger wrote:
>> commit 7be81a46695d ("KVM: s390/facilities: allow TOD-CLOCK steering
>> facility bit") accidentially disabled the "load program parameter"
>> facility bit during rebase for upstream submission (my fault).
>>
>> Re-add that bit.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
>> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> Fixes: 7be81a46695d ("KVM: s390/facilities: allow TOD-CLOCK steering")
> 
> Cc: stable?

Its mostly about the LPP instruction which is right now only used by
KVM itself for tagging guests for hardware based sampling that perf uses
on s390 (see 
http://www-01.ibm.com/support/docview.wss?uid=isg26fcd1cc32246f4c8852574ce0044734a ) 
As KVM on s390 does not yet run  nested not doing stable should be fine as all 
others users I am aware of are lab-only.

Christian


> 
> Paolo
> 
>> ---
>>  arch/s390/kvm/kvm-s390.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index b2371c0..57f5538 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2073,7 +2073,7 @@ static int __init kvm_s390_init(void)
>>  		return -ENOMEM;
>>  	}
>>  	memcpy(vfacilities, S390_lowcore.stfle_fac_list, 16);
>> -	vfacilities[0] &= 0xff82fffbf47c2000UL;
>> +	vfacilities[0] &= 0xff82fffbf4fc2000UL;
>>  	vfacilities[1] &= 0x005c000000000000UL;
>>  	return 0;
>>  }
>>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
