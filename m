Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD6C11F64
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9874B613E3
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 15:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhGAPPn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:15:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232401AbhGAPPn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jul 2021 11:15:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161F3M3R074080;
        Thu, 1 Jul 2021 11:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=o6sjIctjt7BX/yqIK0J+0FCm/WXAnRnhVUuq1iEhWdc=;
 b=Isz/32a6DWyLYA99YIsNDo9dsf6PIgMtfaHrc8Z+uCGB1fQPBaR86JDeA0uFFJBH3iFz
 LiqfXgIQTj6QuNnlt6jveyKcpc+5xPNBQ8H3D8ojqVrIRHkJjQf9C4QqlX8yGxYf9DaN
 EpMG38Mng4Fng1e5bku2EVpfK4BOlw01XIWvrCeYLTh9EOedj664f7OtM7aAjneuajHZ
 TUzymlz/XTOvfvYQCtY4PrN1TqCOYYRqomBJMOoZkXWTG0NC5RH+bcNPxQoZZpCgrJu1
 /GsiIMhi+oOVeahw59ICc0sNrBGjzSRN70JlIGqbocbdd0xzB9MU5YQvwAB/oDoYfNkf Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39hdyfvnvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:13:10 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161F3UIk074820;
        Thu, 1 Jul 2021 11:13:10 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39hdyfvnvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:13:10 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161FBrS6017718;
        Thu, 1 Jul 2021 15:13:09 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 39duve3p1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 15:13:09 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161FD8we29425928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 15:13:08 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3038E78068;
        Thu,  1 Jul 2021 15:13:08 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C5C778064;
        Thu,  1 Jul 2021 15:13:07 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.163.230])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jul 2021 15:13:06 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210621155714.1198545-1-akrowiak@linux.ibm.com>
 <20210621155714.1198545-3-akrowiak@linux.ibm.com>
Message-ID: <51311ce0-51e5-3d26-a621-afa820cee085@linux.ibm.com>
Date:   Thu, 1 Jul 2021 11:13:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621155714.1198545-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r-a5BFyYvVy4CfPQpuU6rT-iEsS4Mpsr
X-Proofpoint-ORIG-GUID: TxS2Lp52CQyCPvi7BIYsXAcPIugwr9yd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107010092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/21/21 11:57 AM, Tony Krowiak wrote:
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
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: stable@vger.kernel.org
> ---
>   arch/s390/include/asm/kvm_host.h      |  8 +++-----
>   arch/s390/kvm/kvm-s390.c              |  1 +
>   arch/s390/kvm/priv.c                  | 10 ++++++----
>   drivers/s390/crypto/vfio_ap_ops.c     | 23 +++++++++++++++++------
>   drivers/s390/crypto/vfio_ap_private.h |  2 +-
>   5 files changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 8925f3969478..36441669ffba 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -803,14 +803,12 @@ struct kvm_s390_cpu_model {
>   	unsigned short ibc;
>   };
>   
> -struct kvm_s390_module_hook {
> -	int (*hook)(struct kvm_vcpu *vcpu);
> -	struct module *owner;
> -};
> +typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
>   
>   struct kvm_s390_crypto {
>   	struct kvm_s390_crypto_cb *crycb;
> -	struct kvm_s390_module_hook *pqap_hook;
> +	struct rw_semaphore pqap_hook_rwsem;
> +	crypto_hook *pqap_hook;
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
> index 9928f785c677..6bed9406c1f3 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -610,6 +610,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>   static int handle_pqap(struct kvm_vcpu *vcpu)
>   {
>   	struct ap_queue_status status = {};
> +	crypto_hook pqap_hook;
>   	unsigned long reg0;
>   	int ret;
>   	uint8_t fc;
> @@ -657,15 +658,16 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>   	 * Verify that the hook callback is registered, lock the owner
>   	 * and call the hook.
>   	 */
> +	down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
>   	if (vcpu->kvm->arch.crypto.pqap_hook) {
> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> -			return -EOPNOTSUPP;
> -		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> +		pqap_hook = *vcpu->kvm->arch.crypto.pqap_hook;
> +		ret = pqap_hook(vcpu);
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
> index 122c85c22469..742277bc8d1c 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -352,8 +352,7 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>   	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
>   	mdev_set_drvdata(mdev, matrix_mdev);
> -	matrix_mdev->pqap_hook.hook = handle_pqap;
> -	matrix_mdev->pqap_hook.owner = THIS_MODULE;
> +	matrix_mdev->pqap_hook = handle_pqap;
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

Setting the hook using a field in matrix_mdev while not
holding the matrix_dev->lock opens us up to a possible race
condition.

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
> index f82a6396acae..e12218e5a629 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -86,7 +86,7 @@ struct ap_matrix_mdev {
>   	bool kvm_busy;
>   	wait_queue_head_t wait_for_kvm;
>   	struct kvm *kvm;
> -	struct kvm_s390_module_hook pqap_hook;
> +	crypto_hook pqap_hook;
>   	struct mdev_device *mdev;
>   };
>   

