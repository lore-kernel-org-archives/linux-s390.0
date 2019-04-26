Return-Path: <SRS0=JTmC=S4=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH] KVM: s390: vsie: Return correct values for Invalid CRYCB
 format
References: <1556269201-22918-1-git-send-email-pmorel@linux.ibm.com>
 <3b17dd58-77d9-65c1-335b-17ecba902f9f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 26 Apr 2019 11:03:07 +0200
MIME-Version: 1.0
In-Reply-To: <3b17dd58-77d9-65c1-335b-17ecba902f9f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <38c40ea1-9a7f-d720-a994-74c5bcee8e22@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 26.04.19 11:01, David Hildenbrand wrote:
> On 26.04.19 11:00, Pierre Morel wrote:
>> Let's use the correct validity number.
>>
>> Fixes: 55ded154b43 "KVM: s390: vsie: Allow CRYCB FORMAT-2"
> 
>  LANG=c git show 55ded154b43
> fatal: ambiguous argument '55ded154b43': unknown revision or path not in
> the working tree.
> Use '--' to separate paths from revisions, like this:
> 

I think this should be 
56019f9aca2266edc7f304d91e4e772023b7aa14

> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/vsie.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index ac411e9..076090f 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -344,7 +344,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>  end:
>>  	switch (ret) {
>>  	case -EINVAL:
>> -		return set_validity_icpt(scb_s, 0x0020U);
>> +		return set_validity_icpt(scb_s, 0x0022U);
>>  	case -EFAULT:
>>  		return set_validity_icpt(scb_s, 0x0035U);
>>  	case -EACCES:
>>
> 
> 
