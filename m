Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D6C2B9F4
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA8D613CB
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 19:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFQTOa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 15:14:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230484AbhFQTO3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Jun 2021 15:14:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HJ3Gw7145028;
        Thu, 17 Jun 2021 15:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lMd7X6SZakIhHVTwe8RJU//4TO4ARLQjHJMtmsG9baI=;
 b=sJYvpzAt2upruxwJvp3gFv1xPvX8h7n6L1lE/QUYrd6UVkiV06QJvDA2fXk/H6UDHxAK
 u4dSGf4pb+MUSJGYdfOHpK80sBkCIXaWezXi2eKMCu0sirDVWKL+gntcshHxy39ZHmcK
 3QDfvQGDRDMreLfwH6BifakZWVGLWAfRF7+Ef9+/0VLROR5wje2NxJtf1/MDF+zmMM6i
 iFH29O9Vu2R7Bcn+Bjt0J62fRMAC0nDOgQIlkmv6y4GRccNZgmHZkF8miKMw82eS2q2r
 BxXF/GO3QH6M7nOAc/DzmchC+wR48HyPpXW/EHyR3RErvOPNIue8/sHWWWvbASdnwktj eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398b85j59f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 15:12:18 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15HJ3qVM149927;
        Thu, 17 Jun 2021 15:12:17 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398b85j58g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 15:12:17 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15HIrV92007843;
        Thu, 17 Jun 2021 19:12:16 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3980b9emjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 19:12:16 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15HJCFDi9699638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 19:12:15 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 681FCAE05F;
        Thu, 17 Jun 2021 19:12:15 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2DA0AE063;
        Thu, 17 Jun 2021 19:12:14 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.128.252])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jun 2021 19:12:14 +0000 (GMT)
Subject: Re: [PATCH v5 2/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210616141618.938494-1-akrowiak@linux.ibm.com>
 <20210616141618.938494-3-akrowiak@linux.ibm.com>
 <82462c00-46da-fbbe-7a8f-d52286cfc7db@de.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <2140bcd0-c3a3-1168-ee2c-811a40728caa@linux.ibm.com>
Date:   Thu, 17 Jun 2021 15:12:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <82462c00-46da-fbbe-7a8f-d52286cfc7db@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5ACY7Ndz0juHQnIvcbM8HXd2r5rhJTkV
X-Proofpoint-ORIG-GUID: voz1jgr0MJaie8VlYKJ_LnwUYs-3eYTy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_15:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106170118
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/17/21 8:23 AM, Christian Borntraeger wrote:
>
>
> On 16.06.21 16:16, Tony Krowiak wrote:
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
>
> The locking looks so much nicer now. One (optional) thing.

Unfortunately, we aren't done yet.

>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h      |  6 +++---
>>   arch/s390/kvm/kvm-s390.c              |  1 +
>>   arch/s390/kvm/priv.c                  |  6 +++---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 21 ++++++++++++++++-----
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +-
>>   5 files changed, 24 insertions(+), 12 deletions(-)
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
>
> Can we actually get rid of the structure and use
>        int (*pqap_hook)(struct kvm_vcpu *vcpu);

Yes, we can.

>>     struct kvm_s390_crypto {
>>       struct kvm_s390_crypto_cb *crycb;
>> -    struct kvm_s390_module_hook *pqap_hook;
>> +    struct rw_semaphore pqap_hook_rwsem;
>> +    struct kvm_s390_crypto_hook *pqap_hook;
>
> here and below

Yes

>
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
>            ret = vcpu->kvm->arch.crypto.pqap_hook(vcpu);
>
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
>> index 122c85c22469..d8abe5a11e49 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -353,7 +353,6 @@ static int vfio_ap_mdev_create(struct mdev_device 
>> *mdev)
>>       init_waitqueue_head(&matrix_mdev->wait_for_kvm);
>>       mdev_set_drvdata(mdev, matrix_mdev);
>>       matrix_mdev->pqap_hook.hook = handle_pqap;
>> -    matrix_mdev->pqap_hook.owner = THIS_MODULE;
>>       mutex_lock(&matrix_dev->lock);
>>       list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>>       mutex_unlock(&matrix_dev->lock);
>> @@ -1115,15 +1114,20 @@ static int vfio_ap_mdev_set_kvm(struct 
>> ap_matrix_mdev *matrix_mdev,
>>           }
>>             kvm_get_kvm(kvm);
>> +        matrix_mdev->kvm = kvm;
>>           matrix_mdev->kvm_busy = true;
>>           mutex_unlock(&matrix_dev->lock);
>> +
>> + down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>> +        kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>> + up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>> +
>>           kvm_arch_crypto_set_masks(kvm,
>>                         matrix_mdev->matrix.apm,
>>                         matrix_mdev->matrix.aqm,
>>                         matrix_mdev->matrix.adm);
>> +
>>           mutex_lock(&matrix_dev->lock);
>> -        kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>> -        matrix_mdev->kvm = kvm;
>>           matrix_mdev->kvm_busy = false;
>>           wake_up_all(&matrix_mdev->wait_for_kvm);
>>       }
>> @@ -1189,10 +1193,17 @@ static void vfio_ap_mdev_unset_kvm(struct 
>> ap_matrix_mdev *matrix_mdev)
>>       if (matrix_mdev->kvm) {
>>           matrix_mdev->kvm_busy = true;
>>           mutex_unlock(&matrix_dev->lock);
>> -        kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>> +
>> +        if (matrix_mdev->kvm->arch.crypto.crycbd) {
>> + down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>> +            matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>> + up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>> +
>> +            kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>> +        }
>> +
>>           mutex_lock(&matrix_dev->lock);
>>           vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
>> -        matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>           kvm_put_kvm(matrix_mdev->kvm);
>>           matrix_mdev->kvm = NULL;
>>           matrix_mdev->kvm_busy = false;
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index f82a6396acae..5d4fe6efbc73 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -86,7 +86,7 @@ struct ap_matrix_mdev {
>>       bool kvm_busy;
>>       wait_queue_head_t wait_for_kvm;
>>       struct kvm *kvm;
>> -    struct kvm_s390_module_hook pqap_hook;
>
> and here?

Yep

>
>> +    struct kvm_s390_crypto_hook pqap_hook;
>>       struct mdev_device *mdev;
>>   };
>>

