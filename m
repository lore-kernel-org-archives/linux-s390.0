Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727144AbfFYUPy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Jun 2019 16:15:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PKD6wu115380
        for <linux-s390@vger.kernel.org>; Tue, 25 Jun 2019 16:15:53 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbs7jk2ur-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Jun 2019 16:15:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Jun 2019 21:15:50 +0100
Subject: Re: [PATCH v9 4/4] s390: ap: kvm: Enable PQAP/AQIC facility for the
 guest
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <1558452877-27822-1-git-send-email-pmorel@linux.ibm.com>
 <1558452877-27822-5-git-send-email-pmorel@linux.ibm.com>
 <69ca50bd-3f5c-98b1-3b39-04af75151baf@de.ibm.com>
Date: Tue, 25 Jun 2019 22:15:34 +0200
MIME-Version: 1.0
In-Reply-To: <69ca50bd-3f5c-98b1-3b39-04af75151baf@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <25a9ff69-47f0-fcba-e1fe-f0cc9914acba@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com



On 25.06.19 22:13, Christian Borntraeger wrote:
> 
> 
> On 21.05.19 17:34, Pierre Morel wrote:
>> AP Queue Interruption Control (AQIC) facility gives
>> the guest the possibility to control interruption for
>> the Cryptographic Adjunct Processor queues.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>  arch/s390/tools/gen_facilities.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>> index 61ce5b5..aed14fc 100644
>> --- a/arch/s390/tools/gen_facilities.c
>> +++ b/arch/s390/tools/gen_facilities.c
>> @@ -114,6 +114,7 @@ static struct facility_def facility_defs[] = {
>>  		.bits = (int[]){
>>  			12, /* AP Query Configuration Information */
>>  			15, /* AP Facilities Test */
>> +			65, /* AP Queue Interruption Control */
>>  			156, /* etoken facility */
>>  			-1  /* END */
>>  		}
>>
> 
> I think we should only set stfle.65 if we have the aiv facility (Because we do not
> have a GISA otherwise)
> 
> So something like this instead?
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 28ebd64..1501cd6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2461,6 +2461,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>                 set_kvm_facility(kvm->arch.model.fac_list, 147);
>         }
>  
> +       if (css_general_characteristics.aiv)
> +               set_kvm_facility(kvm->arch.model.fac_mask, 65);
> +       
>         kvm->arch.model.cpuid = kvm_s390_get_initial_cpuid();
>         kvm->arch.model.ibc = sclp.ibc & 0x0fff;
>  
> 

Maybe even just piggyback on gisa init (it will bail out early).

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9dde4d7..9182a04 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3100,6 +3100,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
        gi->timer.function = gisa_vcpu_kicker;
        memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
        gi->origin->next_alert = (u32)(u64)gi->origin;
+       set_kvm_facility(kvm->arch.model.fac_mask, 65);
        VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
 }
 
