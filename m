Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C7C48BDF
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8196128B
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 18:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFOS5w (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:57:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229749AbhFOS5w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Jun 2021 14:57:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FIXiEF110787;
        Tue, 15 Jun 2021 14:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hREZ/SSWbYHUMgn9yPNRFHQome04tP8Osjmz4FENDkc=;
 b=N7wJQmXgffwN6WznjeeLKf/JI1YmtrF/pVxIGHo0+1umN0a5DN6Xo/7lM/tF10L9ebZX
 lD1pvAbJxvxwiC438cqm9AzqDDE5Klv2KKxzLfk4UNrtIOrJgO2o6NrVpIU7U6eiEVvB
 obGR9/TJFCQOVpzJSBC+hYIG87xeCVJZ2ZdNkOADOg7Q2HFiIFcV1wsTP7iGB/EVS04N
 Vi8C9DNT53Etka3Q9goiBIixFF6uewz3zhuowMVSatONeBHNT6usFAVJCTOGy+fAARvO
 +yPphjJR7/i1qGuWFtdnhkCyqpyjnlQd/Xsj1y95dYSJKSo5ueoCD4fZFnWdXvrtSY36 NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3970pmjdfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 14:55:45 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15FIXwpe111427;
        Tue, 15 Jun 2021 14:55:45 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3970pmjdeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 14:55:45 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15FIlIOb024952;
        Tue, 15 Jun 2021 18:55:43 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 3954gk5sd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 18:55:43 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15FIth0b13500674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 18:55:43 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FD23AE06B;
        Tue, 15 Jun 2021 18:55:43 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 943D8AE08B;
        Tue, 15 Jun 2021 18:55:42 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.128.252])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 15 Jun 2021 18:55:42 +0000 (GMT)
Subject: Re: [PATCH 3/3] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-4-akrowiak@linux.ibm.com>
 <feff8d63-c2e0-73a3-83ae-a6a5e549194a@de.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <29545a2f-cd64-9a89-4ecf-ea9b82bd64c4@linux.ibm.com>
Date:   Tue, 15 Jun 2021 14:55:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <feff8d63-c2e0-73a3-83ae-a6a5e549194a@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m2_XCkQ44i6q9bV1OU9gNUduwfHFX7GD
X-Proofpoint-ORIG-GUID: cyMa5FeRcbmnHyU7Ie0RxSw5baOQP41d
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_07:2021-06-15,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150115
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/15/21 4:55 AM, Christian Borntraeger wrote:
> On 10.06.21 00:46, Tony Krowiak wrote:
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
>
> Given that patch 2 is still  under discussion. Can this patch go 
> without patch 2?

Here's what I think I'm going to do. Patches 1 and 3 are related to the 
patch
I posted to resolve the FIXME in the vfio_ap_mdev_remove() callback in a 
patch
posted by Jason Gunthorpe (Message ID: 
<6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>).
Patch 2 in this series was precipitated by a comment Jason made that was
not directly related to that fix, so I will put a two patch series
with patch 1 and 3, then test them and post them here before proceeding
to resolving the issues in patch 2 which I will post separately.

>> ---
>>   arch/s390/include/asm/kvm_host.h      |  6 +++---
>>   arch/s390/kvm/kvm-s390.c              |  1 +
>>   arch/s390/kvm/priv.c                  |  6 +++---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 14 ++++++++++----
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +-
>>   5 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index 8925f3969478..58edaa3f9602 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -803,14 +803,14 @@ struct kvm_s390_cpu_model {
>>       unsigned short ibc;
>>   };
>>   -struct kvm_s390_module_hook {
>> +struct kvm_s390_crypto_hook {
>>       int (*hook)(struct kvm_vcpu *vcpu);
>> -    struct module *owner;
>>   };
>>     struct kvm_s390_crypto {
>>       struct kvm_s390_crypto_cb *crycb;
>> -    struct kvm_s390_module_hook *pqap_hook;
>> +    struct rw_semaphore pqap_hook_rwsem;
>> +    struct kvm_s390_crypto_hook *pqap_hook;
>>       __u32 crycbd;
>>       __u8 aes_kw;
>>       __u8 dea_kw;
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 1296fc10f80c..418d910df569 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2606,6 +2606,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
>>   {
>>       kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>>       kvm_s390_set_crycb_format(kvm);
>> +    init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
>>         if (!test_kvm_facility(kvm, 76))
>>           return;
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 9928f785c677..bbbd84ffe239 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -657,15 +657,15 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>        * Verify that the hook callback is registered, lock the owner
>>        * and call the hook.
>>        */
>> + down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>>       if (vcpu->kvm->arch.crypto.pqap_hook) {
>> -        if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
>> -            return -EOPNOTSUPP;
>>           ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
>> - module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>>           if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
>>               kvm_s390_set_psw_cc(vcpu, 3);
>> + up_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>>           return ret;
>>       }
>> +    up_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>>       /*
>>        * A vfio_driver must register a hook.
>>        * No hook means no driver to enable the SIE CRYCB and no queues.
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index d65a5728153b..2998c1b53ab9 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -342,7 +342,6 @@ static int vfio_ap_mdev_create(struct mdev_device 
>> *mdev)
>>       init_rwsem(&matrix_mdev->rwsem);
>>       mdev_set_drvdata(mdev, matrix_mdev);
>>       matrix_mdev->pqap_hook.hook = handle_pqap;
>> -    matrix_mdev->pqap_hook.owner = THIS_MODULE;
>>         mutex_lock(&matrix_dev->lock);
>>       list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>> @@ -1063,7 +1062,6 @@ static int vfio_ap_mdev_set_kvm(struct 
>> ap_matrix_mdev *matrix_mdev,
>>       down_write(&matrix_mdev->rwsem);
>>       matrix_mdev->kvm = kvm;
>>       kvm_get_kvm(kvm);
>> -    kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>>       up_write(&matrix_mdev->rwsem);
>>         /*
>> @@ -1071,6 +1069,10 @@ static int vfio_ap_mdev_set_kvm(struct 
>> ap_matrix_mdev *matrix_mdev,
>>        * masks for the KVM guest
>>        */
>>       if (kvm->arch.crypto.crycbd) {
>> + down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>> +        kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>> + up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>> +
>>           down_read(&matrix_mdev->matrix.rwsem);
>>           kvm_arch_crypto_set_masks(kvm,
>>                         matrix_mdev->matrix.apm,
>> @@ -1122,11 +1124,15 @@ static int vfio_ap_mdev_iommu_notifier(struct 
>> notifier_block *nb,
>>   static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>>   {
>>       if (matrix_mdev->kvm) {
>> -        if (matrix_mdev->kvm->arch.crypto.crycbd)
>> +        if (matrix_mdev->kvm->arch.crypto.crycbd) {
>> + down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>> +            matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>> + up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>> +
>>               kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>> +        }
>>             down_write(&matrix_mdev->rwsem);
>> -        matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>           vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
>>           kvm_put_kvm(matrix_mdev->kvm);
>>           matrix_mdev->kvm = NULL;
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index a163ac04ff8a..3d6afd0faaaf 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -90,7 +90,7 @@ struct ap_matrix_mdev {
>>       struct notifier_block iommu_notifier;
>>       struct rw_semaphore rwsem;
>>       struct kvm *kvm;
>> -    struct kvm_s390_module_hook pqap_hook;
>> +    struct kvm_s390_crypto_hook pqap_hook;
>>       struct mdev_device *mdev;
>>   };
>>

