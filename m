Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8540EC4338F
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 13:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AF86113D
	for <linux-s390@archiver.kernel.org>; Thu, 19 Aug 2021 13:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhHSNVM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:21:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239300AbhHSNVL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Aug 2021 09:21:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JD4BSr162653;
        Thu, 19 Aug 2021 09:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VlwW+a51ub2iWUfyBK8/YBny3TS9/ko8KkFDRDd38QE=;
 b=QSwzW36/xXHhdhCNIWGFQQffRhkmpBLX+BxGuKiyJtXRgJADv/LcjB1svoTaItaxIfcJ
 45aCBg/y8epxyqv8B827UqEvrNuCb4eHhVBUAVWeGFwE9gTwn4MJvg6S7avXoQsefgDo
 /95Ei3eZIfc0DQqtxzeFTKoobtio8x168p/VkxtLen+nar71Eb6CMGtSuoGUQKheY8mt
 R4vZzQYToTT+wlmJMnCIVD7h0GXoDr/huoTnInNKxZ5ZAtYbb1LPfUIFRBKfDfjsOQIj
 6J51WwDxnnsI05ieasjDNo9ODIrSf8bqjkK3Mg0UlwSXgQSJKEQPaYzxDTupoZI6fRjQ uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3agp20nuu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:20:32 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JD4hog165385;
        Thu, 19 Aug 2021 09:20:32 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3agp20nutv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:20:32 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JDD35g014471;
        Thu, 19 Aug 2021 13:20:31 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3ae5few5fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 13:20:31 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JDKTis36831678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 13:20:30 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D321C136051;
        Thu, 19 Aug 2021 13:20:29 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6C5F13605D;
        Thu, 19 Aug 2021 13:20:28 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Aug 2021 13:20:28 +0000 (GMT)
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        david@redhat.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-2-akrowiak@linux.ibm.com>
 <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
Date:   Thu, 19 Aug 2021 09:20:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xTmhhGfkG7U8zthCjgEiQ-CNfrXXCDRO
X-Proofpoint-GUID: 7A2t7QY2dNm3kSq70Z-s2T4UM_DMVPtr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_04:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190076
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 8/18/21 1:03 PM, Christian Borntraeger wrote:
> On 19.07.21 21:35, Tony Krowiak wrote:
>> The function pointer to the interception handler for the PQAP 
>> instruction
>> can get changed during the interception process. Let's add a
>> semaphore to struct kvm_s390_crypto to control read/write access to the
>> function pointer contained therein.
>>
>> The semaphore must be locked for write access by the vfio_ap device 
>> driver
>> when notified that the KVM pointer has been set or cleared. It must be
>> locked for read access by the interception framework when the PQAP
>> instruction is intercepted.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h      |  8 +++-----
>>   arch/s390/kvm/kvm-s390.c              |  1 +
>>   arch/s390/kvm/priv.c                  | 10 ++++++----
>>   drivers/s390/crypto/vfio_ap_ops.c     | 23 +++++++++++++++++------
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +-
>>   5 files changed, 28 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index 9b4473f76e56..f18849d259e6 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -798,14 +798,12 @@ struct kvm_s390_cpu_model {
>>       unsigned short ibc;
>>   };
>>   -struct kvm_s390_module_hook {
>> -    int (*hook)(struct kvm_vcpu *vcpu);
>> -    struct module *owner;
>> -};
>> +typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
>>     struct kvm_s390_crypto {
>>       struct kvm_s390_crypto_cb *crycb;
>> -    struct kvm_s390_module_hook *pqap_hook;
>> +    struct rw_semaphore pqap_hook_rwsem;
>> +    crypto_hook *pqap_hook;
>>       __u32 crycbd;
>>       __u8 aes_kw;
>>       __u8 dea_kw;
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index b655a7d82bf0..a08f242a9f27 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2630,6 +2630,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
>>   {
>>       kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>>       kvm_s390_set_crycb_format(kvm);
>> +    init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
>>         if (!test_kvm_facility(kvm, 76))
>>           return;
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 9928f785c677..6bed9406c1f3 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -610,6 +610,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>   static int handle_pqap(struct kvm_vcpu *vcpu)
>>   {
>>       struct ap_queue_status status = {};
>> +    crypto_hook pqap_hook;
>>       unsigned long reg0;
>>       int ret;
>>       uint8_t fc;
>> @@ -657,15 +658,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>        * Verify that the hook callback is registered, lock the owner
>>        * and call the hook.
>>        */
>> + down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>>       if (vcpu->kvm->arch.crypto.pqap_hook) {
>> -        if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
>> -            return -EOPNOTSUPP;
>> -        ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
>> - module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>> +        pqap_hook = *vcpu->kvm->arch.crypto.pqap_hook;
>
> Dont we have to check for NULL here? If not can you add a comment why?

Take a look above the removed lines: if (vcpu->kvm->arch.crypto.pqap_hook)

>
> Otherwise this looks good.

Also, in the cover letter I said this patch was already queued and was
included here because it pre-reqs the second patch. Is this patch not
already in Alex's tree?

>
>
>> +        ret = pqap_hook(vcpu);
> [...]

