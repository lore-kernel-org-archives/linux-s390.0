Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A115BC2B9F4
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 12:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8192F61003
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 12:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhFQMZu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 08:25:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56942 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232806AbhFQMZu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Jun 2021 08:25:50 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HC3rDY119493;
        Thu, 17 Jun 2021 08:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8DYHt3VzSL2WAPks3Uh1iMF9OqT7VGrzc0uy53hiDBs=;
 b=mZ76Tdp3L9qvJOwnsci48jHw4LpaK997fIYTplokMnBl8qeFZlWIgd8ZK3ovJwGQLyIC
 2OpB7mF8NCB8Z0uOU6rwfDRbWjgtB8PyCqefQXEsr0qJlU/33r7w+zUm7YPqZ1yx6+gw
 UBHJqUoY025PcBf3BgOydWkxo+ptxOvdf98pDR6ifkZ0v3OILxoCLFxqO/7hPUR1Ly32
 jUHdBEBnrKuzp6wG7lMJwg6nyjf6MYl7WooOnVCSdEbIRT2pQopIZeid11DiCdc8/07S
 tfvR2NwxxrUwmh899ndEXGg2qCF7bczhicYu7QtogdhuQvgdVvyqoNoEd9qI4jqfIVBp pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3984w8348n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 08:23:40 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15HC44DO121441;
        Thu, 17 Jun 2021 08:23:39 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3984w8347y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 08:23:39 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15HCCLDr031817;
        Thu, 17 Jun 2021 12:23:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 394mj8hgb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 12:23:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15HCNYC618546948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 12:23:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A28625205A;
        Thu, 17 Jun 2021 12:23:34 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.46.143])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CDE7452050;
        Thu, 17 Jun 2021 12:23:33 +0000 (GMT)
Subject: Re: [PATCH v5 2/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210616141618.938494-1-akrowiak@linux.ibm.com>
 <20210616141618.938494-3-akrowiak@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <82462c00-46da-fbbe-7a8f-d52286cfc7db@de.ibm.com>
Date:   Thu, 17 Jun 2021 14:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616141618.938494-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SIBhfp5W6VWPw9tRWIZCB1Y7vuVhZVqI
X-Proofpoint-ORIG-GUID: g8hhtZa6tYYHgVJRdHOKszBQEDBfuWbr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_05:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106170079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 16.06.21 16:16, Tony Krowiak wrote:
> The function pointer to the interception handler for the PQAP instruction
> can get changed during the interception process. Let's add a
> semaphore to struct kvm_s390_crypto to control read/write access to the
> function pointer contained therein.
> 
> The semaphore must be locked for write access by the vfio_ap device driver
> when notified that the KVM pointer has been set or cleared. It must be
> locked for read access by the interception framework when the PQAP
> instruction is intercepted.
> 

The locking looks so much nicer now. One (optional) thing.

> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |  6 +++---
>   arch/s390/kvm/kvm-s390.c              |  1 +
>   arch/s390/kvm/priv.c                  |  6 +++---
>   drivers/s390/crypto/vfio_ap_ops.c     | 21 ++++++++++++++++-----
>   drivers/s390/crypto/vfio_ap_private.h |  2 +-
>   5 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 8925f3969478..58edaa3f9602 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -803,14 +803,14 @@ struct kvm_s390_cpu_model {
>   	unsigned short ibc;
>   };
>   
> -struct kvm_s390_module_hook {
> +struct kvm_s390_crypto_hook {
>   	int (*hook)(struct kvm_vcpu *vcpu);
> -	struct module *owner;
>   };

Can we actually get rid of the structure and use
    	int (*pqap_hook)(struct kvm_vcpu *vcpu);
>   
>   struct kvm_s390_crypto {
>   	struct kvm_s390_crypto_cb *crycb;
> -	struct kvm_s390_module_hook *pqap_hook;
> +	struct rw_semaphore pqap_hook_rwsem;
> +	struct kvm_s390_crypto_hook *pqap_hook;

here and below

>   	__u32 crycbd;
>   	__u8 aes_kw;
>   	__u8 dea_kw;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1296fc10f80c..418d910df569 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2606,6 +2606,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
>   {
>   	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>   	kvm_s390_set_crycb_format(kvm);
> +	init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
>   
>   	if (!test_kvm_facility(kvm, 76))
>   		return;
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 9928f785c677..bbbd84ffe239 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -657,15 +657,15 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>   	 * Verify that the hook callback is registered, lock the owner
>   	 * and call the hook.
>   	 */
> +	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>   	if (vcpu->kvm->arch.crypto.pqap_hook) {
> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> -			return -EOPNOTSUPP;
>   		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
    		ret = vcpu->kvm->arch.crypto.pqap_hook(vcpu);
					
> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>   		if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
>   			kvm_s390_set_psw_cc(vcpu, 3);
> +		up_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>   		return ret;
>   	}
> +	up_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>   	/*
>   	 * A vfio_driver must register a hook.
>   	 * No hook means no driver to enable the SIE CRYCB and no queues.
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 122c85c22469..d8abe5a11e49 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -353,7 +353,6 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
>   	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
>   	mdev_set_drvdata(mdev, matrix_mdev);
>   	matrix_mdev->pqap_hook.hook = handle_pqap;
> -	matrix_mdev->pqap_hook.owner = THIS_MODULE;
>   	mutex_lock(&matrix_dev->lock);
>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>   	mutex_unlock(&matrix_dev->lock);
> @@ -1115,15 +1114,20 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>   		}
>   
>   		kvm_get_kvm(kvm);
> +		matrix_mdev->kvm = kvm;
>   		matrix_mdev->kvm_busy = true;
>   		mutex_unlock(&matrix_dev->lock);
> +
> +		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> +		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
> +		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> +
>   		kvm_arch_crypto_set_masks(kvm,
>   					  matrix_mdev->matrix.apm,
>   					  matrix_mdev->matrix.aqm,
>   					  matrix_mdev->matrix.adm);
> +
>   		mutex_lock(&matrix_dev->lock);
> -		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
> -		matrix_mdev->kvm = kvm;
>   		matrix_mdev->kvm_busy = false;
>   		wake_up_all(&matrix_mdev->wait_for_kvm);
>   	}
> @@ -1189,10 +1193,17 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>   	if (matrix_mdev->kvm) {
>   		matrix_mdev->kvm_busy = true;
>   		mutex_unlock(&matrix_dev->lock);
> -		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> +
> +		if (matrix_mdev->kvm->arch.crypto.crycbd) {
> +			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> +			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> +			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
> +
> +			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> +		}
> +
>   		mutex_lock(&matrix_dev->lock);
>   		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> -		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>   		kvm_put_kvm(matrix_mdev->kvm);
>   		matrix_mdev->kvm = NULL;
>   		matrix_mdev->kvm_busy = false;
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index f82a6396acae..5d4fe6efbc73 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -86,7 +86,7 @@ struct ap_matrix_mdev {
>   	bool kvm_busy;
>   	wait_queue_head_t wait_for_kvm;
>   	struct kvm *kvm;
> -	struct kvm_s390_module_hook pqap_hook;

and here?

> +	struct kvm_s390_crypto_hook pqap_hook;
>   	struct mdev_device *mdev;
>   };
>   
> 
