Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C5C6377D
	for <linux-s390@archiver.kernel.org>; Thu, 22 Jul 2021 13:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5304461287
	for <linux-s390@archiver.kernel.org>; Thu, 22 Jul 2021 13:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhGVMf4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:35:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37506 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232042AbhGVMfy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Jul 2021 08:35:54 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16MD4Xml170429;
        Thu, 22 Jul 2021 09:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+3M6udf/OqMT+ibxUfA2l2HHXj9sD0CYKoYMahSIlKs=;
 b=MfjLVW3CxbTFzZDNrKrnqYkmefspWtpSAiLxrtGMIFdTpaDiNz+ZY9vj90ODdyMvBy3R
 D7oEjN7OKAejgFE3OLcdPUlOqZZrx4IM48nRiAUsAJOxbSwF9+gUobs9niVO1A8shfYd
 iG1Y1Lf+phV/3RMoBaMOwsm54KekUnTBllqtVm6BWo11DQm7NtxPPT4Mfp6cSQ6VTIvZ
 WrrhkVKno+QMmm65rJYM7DIC69TYO/yzXKfhM+pruPelTGNH6Pb6+XaAgDQwqAN/nIzN
 dcmsXoaPIyUgkTVt51zrLyWrfQBWxft08rtJRfyT0UBquIlfjnev9xp4TrWWZlVG3YqO 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39y82e2ryp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 09:16:24 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16MDFFFE023974;
        Thu, 22 Jul 2021 09:16:24 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39y82e2rxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 09:16:24 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16MDDZks015618;
        Thu, 22 Jul 2021 13:16:23 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 39vuk7pdk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 13:16:23 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16MDGLkc25821668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 13:16:21 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A1CA6A05F;
        Thu, 22 Jul 2021 13:16:21 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 804B46A057;
        Thu, 22 Jul 2021 13:16:20 +0000 (GMT)
Received: from [9.85.184.30] (unknown [9.85.184.30])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 22 Jul 2021 13:16:20 +0000 (GMT)
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     jjherne@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-3-akrowiak@linux.ibm.com>
 <6c7244b5-be7b-1566-f406-4c4c37f06fd7@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <0f03ab0b-2dfd-e1c1-fe43-be2a59030a71@linux.ibm.com>
Date:   Thu, 22 Jul 2021 09:16:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6c7244b5-be7b-1566-f406-4c4c37f06fd7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _iQ5Ehjq5rig3GNlswSjS5LbHggXFuBu
X-Proofpoint-ORIG-GUID: gkWA0EW882j8l2685WtuoNYrTuiaMTem
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-22_07:2021-07-22,2021-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107220087
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/21/21 3:37 PM, Jason J. Herne wrote:
> On 7/19/21 3:35 PM, Tony Krowiak wrote:
>> It was pointed out during an unrelated patch review that locks should 
>> not
>> be open coded - i.e., writing the algorithm of a standard lock in a
>> function instead of using a lock from the standard library. The 
>> setting and
>> testing of a busy flag and sleeping on a wait_event is the same thing
>> a lock does. The open coded locks are invisible to lockdep, so potential
>> locking problems are not detected.
>>
>> This patch removes the open coded locks used during
>> VFIO_GROUP_NOTIFY_SET_KVM notification. The busy flag
>> and wait queue were introduced to resolve a possible circular locking
>> dependency reported by lockdep when starting a secure execution guest
>> configured with AP adapters and domains. Reversing the order in which
>> the kvm->lock mutex and matrix_dev->lock mutex are locked resolves the
>> issue reported by lockdep, thus enabling the removal of the open coded
>> locks.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c              |  27 +++++-
>>   drivers/s390/crypto/vfio_ap_ops.c     | 132 ++++++++------------------
>>   drivers/s390/crypto/vfio_ap_private.h |   2 -
>>   3 files changed, 63 insertions(+), 98 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index a08f242a9f27..4d2ef3a3286e 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2559,12 +2559,24 @@ static void kvm_s390_set_crycb_format(struct 
>> kvm *kvm)
>>           kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>>   }
>>   +/*
>> + * kvm_arch_crypto_set_masks
>> + *
>> + * @kvm: a pointer to the object containing the crypto masks
>
> This should probably say "a pointer to the target guest's KVM struct" 
> or something to that effect. Same comment for the comment above 
> kvm_arch_crypto_clear_masks.

Will do.

>
>> + * @apm: the mask identifying the accessible AP adapters
>> + * @aqm: the mask identifying the accessible AP domains
>> + * @adm: the mask identifying the accessible AP control domains
>> + *
>> + * Set the masks that identify the adapters, domains and control 
>> domains to
>> + * which the KVM guest is granted access.
>> + *
>> + * Note: The kvm->lock mutex must be locked by the caller.
>> + */
>>   void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
>>                      unsigned long *aqm, unsigned long *adm)
>>   {
>>       struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
>>   -    mutex_lock(&kvm->lock);
>>       kvm_s390_vcpu_block_all(kvm);
>>         switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
>> @@ -2595,13 +2607,21 @@ void kvm_arch_crypto_set_masks(struct kvm 
>> *kvm, unsigned long *apm,
>>       /* recreate the shadow crycb for each vcpu */
>>       kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
>>       kvm_s390_vcpu_unblock_all(kvm);
>> -    mutex_unlock(&kvm->lock);
>>   }
>>   EXPORT_SYMBOL_GPL(kvm_arch_crypto_set_masks);
>>   +/*
>> + * kvm_arch_crypto_set_masks
>
> Copy/paste error here. Rename to kvm_arch_crypto_CLEAR_masks

I will fix it.

>
> I did not find anything else in my review. However, I'm still very new 
> to this code, so take that with a grain of salt :).

The grain of salt has been ingested.

>
> Also, I could not apply this to master. If there is a next version do 
> you mind rebasing? Seeing the patch in full context would be helpful.

This was rebased on the latest master branch at the time then re-tested. 
This is something I always
do prior to submitting patches, so is it possible you were using an 
older version of master?

>
>
>

