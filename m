Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47258 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728288AbgDFNWv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 09:22:51 -0400
Subject: Re: [PATCH v1 2/5] KVM: s390: vsie: Fix delivery of addressing
 exceptions
References: <20200402184819.34215-1-david@redhat.com>
 <20200402184819.34215-3-david@redhat.com>
 <0cd2822e-8486-d386-6c00-faadaa573e5e@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <527f7bdf-d8f9-59b4-e70a-54e358ee9e26@redhat.com>
Date: Mon, 6 Apr 2020 15:22:42 +0200
MIME-Version: 1.0
In-Reply-To: <0cd2822e-8486-d386-6c00-faadaa573e5e@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, stable@vger.kernel.org

On 06.04.20 15:17, Christian Borntraeger wrote:
> 
> 
> On 02.04.20 20:48, David Hildenbrand wrote:
>> Whenever we get an -EFAULT, we failed to read in guest 2 physical
>> address space. Such addressing exceptions are reported via a program
>> intercept to the nested hypervisor.
>>
>> We faked the intercept, we have to return to guest 2. Instead, right
>> now we would be returning -EFAULT from the intercept handler, eventually
>> crashing the VM.
>>
>> Addressing exceptions can only happen if the g2->g3 page tables
>> reference invalid g2 addresses (say, either a table or the final page is
>> not accessible - so something that basically never happens in sane
>> environments.
>>
>> Identified by manual code inspection.
>>
>> Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
>> Cc: <stable@vger.kernel.org> # v4.8+
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/s390/kvm/vsie.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index 076090f9e666..4f6c22d72072 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -1202,6 +1202,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>  		scb_s->iprcc = PGM_ADDRESSING;
>>  		scb_s->pgmilc = 4;
>>  		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
>> +		rc = 1;
> 
> 
> kvm_s390_handle_vsie has 
> 
>  return rc < 0 ? rc : 0;
> 
> 
> so rc = 0 would result in the same behaviour, correct?

yes

> Since we DO handle everything as we should, why rc = 1 ?

rc == 1 is the internal representation of "we have to go back into g2".
rc == 0, in contrast, means "we can go back into g2 (via a NULL
intercept) or continue executing g3". Returning rc == 1 instead of rc ==
0 at this point is just consistency.

-- 
Thanks,

David / dhildenb
