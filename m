Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbfJBKpp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 06:45:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x92Afp7R131397
        for <linux-s390@vger.kernel.org>; Wed, 2 Oct 2019 06:45:43 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcr2vmdeg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 06:45:42 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 2 Oct 2019 11:45:41 +0100
Subject: Re: [PATCH] KVM: s390: Cleanup kvm_arch_init error path
References: <20191002075627.3582-1-frankja@linux.ibm.com>
 <b758d2ec-3857-9fe0-b9d3-a9b6e70b6d14@redhat.com>
 <22a388be-a1e1-e57f-1677-18470ed09f65@redhat.com>
 <48e9dab7-03be-9acc-836b-e9e2700ca260@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 2 Oct 2019 12:45:37 +0200
MIME-Version: 1.0
In-Reply-To: <48e9dab7-03be-9acc-836b-e9e2700ca260@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f48dca29-d2c1-09bd-918c-755516b2f76e@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org



On 02.10.19 10:20, David Hildenbrand wrote:
> On 02.10.19 10:07, Thomas Huth wrote:
>> On 02/10/2019 10.01, David Hildenbrand wrote:
>>> On 02.10.19 09:56, Janosch Frank wrote:
>>>> Both kvm_s390_gib_destroy and debug_unregister test if the needed
>>>> pointers are not NULL and hence can be called unconditionally.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  arch/s390/kvm/kvm-s390.c | 18 +++++++-----------
>>>>  1 file changed, 7 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>> index 895fb2006c0d..66720d69cd24 100644
>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>> @@ -458,16 +458,14 @@ static void kvm_s390_cpu_feat_init(void)
>>>>  
>>>>  int kvm_arch_init(void *opaque)
>>>>  {
>>>> -	int rc;
>>>> +	int rc = -ENOMEM;
>>>>  
>>>>  	kvm_s390_dbf = debug_register("kvm-trace", 32, 1, 7 * sizeof(long));
>>>>  	if (!kvm_s390_dbf)
>>>>  		return -ENOMEM;
>>>>  
>>>> -	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view)) {
>>>> -		rc = -ENOMEM;
>>>> -		goto out_debug_unreg;
>>>> -	}
>>>> +	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view))
>>>> +		goto out;
>>>>  
>>>>  	kvm_s390_cpu_feat_init();
>>>>  
>>>> @@ -475,19 +473,17 @@ int kvm_arch_init(void *opaque)
>>>>  	rc = kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
>>>>  	if (rc) {
>>>>  		pr_err("A FLIC registration call failed with rc=%d\n", rc);
>>>> -		goto out_debug_unreg;
>>>> +		goto out;
>>>>  	}
>>>>  
>>>>  	rc = kvm_s390_gib_init(GAL_ISC);
>>>>  	if (rc)
>>>> -		goto out_gib_destroy;
>>>> +		goto out;
>>>>  
>>>>  	return 0;
>>>>  
>>>> -out_gib_destroy:
>>>> -	kvm_s390_gib_destroy();
>>>> -out_debug_unreg:
>>>> -	debug_unregister(kvm_s390_dbf);
>>>> +out:
>>>> +	kvm_arch_exit();
>>>>  	return rc;
>>>>  }
>>>
>>> Wonder why "debug_info_t *kvm_s390_dbf" is not declared as static.
>>
>> Because it is used in the KVM_EVENT macro?
> 
> Ah, makes sense.
> 
>>
>>> Instead of the two manual calls we could also call kvm_arch_exit().
>>
>> Huh, isn't that what this patch is doing here?
> 
> Lol, still tired and thought only the two labels would get removed. Even
> better :)

So I guess we should not take your Reviewed-by: then? ;-)

> 
>>
>> To me, the patch is looking fine, so
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
> 
> 
