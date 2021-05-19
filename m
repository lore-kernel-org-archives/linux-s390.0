Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA9DC433ED
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 17:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724D460FDA
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 17:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355582AbhESRXX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 13:23:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347711AbhESRXX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 13:23:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JH47jA173742;
        Wed, 19 May 2021 13:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=RLUYVCl6UqR7jybSe9wcb3PZE54RKTdmp54pMz7T1aU=;
 b=J9F8903RjEHszV8h8Pj/BOAByrrQG0GfV3jE/Y9g5Kf//PGxHKOQEkYwfh3x6ztlDJ/h
 w9g7ah1bUed9Ln74L+WDQHJtOnSNqf1IL7Bw8GSyek5wfITAVwENbEb8FVAhxiSpN7Ef
 ZA/m4gs61QHHrZiXXoa8WgNhCRTiIR0Qc3vyKc05FFes1ehdMT7O/NzPOXG98+Y1c4XG
 QElS2Pvn9cC/iX60Xq5h9R7RgYPzklhkq3VOp83HMxPKr9uZEnySJbLemtSTUPwSzCk8
 ywJOjm6frZ/1MwaHZhIdFMiHaqgv4vXtP1kjpsDIInoFN//C18heVTm8FLn4V46FHGMd LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38n5rfk5qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 13:22:01 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14JH4Lkp174805;
        Wed, 19 May 2021 13:22:01 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38n5rfk5py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 13:22:01 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JHLxfO023782;
        Wed, 19 May 2021 17:21:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 38mceh8fbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 17:21:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JHLtaC66322794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 17:21:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B56C6A4059;
        Wed, 19 May 2021 17:21:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02C4BA4055;
        Wed, 19 May 2021 17:21:55 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.63.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 19 May 2021 17:21:54 +0000 (GMT)
Date:   Wed, 19 May 2021 19:21:47 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210519192147.2362fe1b.pasic@linux.ibm.com>
In-Reply-To: <20210519153921.804887-3-akrowiak@linux.ibm.com>
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
        <20210519153921.804887-3-akrowiak@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -PRNNJmLBNwoqv4OHR2ak9XZ6wmh_1RB
X-Proofpoint-ORIG-GUID: -UH8OJBAFZ6Imro0zu-IKAOAvs8kmZ2c
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_07:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105190103
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 19 May 2021 11:39:21 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> There is currently nothing that controls access to the structure that
> contains the function pointer to the handler that processes interception of
> the PQAP(AQIC) instruction. If the mdev is removed while the PQAP(AQIC)
> instruction is being intercepted, there is a possibility that the function
> pointer to the handler can get wiped out prior to the attempt to call it.
> 
> This patch utilizes RCU to synchronize access to the kvm_s390_module_hook
> structure used to process interception of the PQAP(AQIC) instruction.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h  |  1 +
>  arch/s390/kvm/priv.c              | 47 ++++++++++++++++-----------
>  drivers/s390/crypto/vfio_ap_ops.c | 54 ++++++++++++++++++++++++-------
>  3 files changed, 73 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 8925f3969478..4987e82d6116 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -806,6 +806,7 @@ struct kvm_s390_cpu_model {
>  struct kvm_s390_module_hook {
>  	int (*hook)(struct kvm_vcpu *vcpu);
>  	struct module *owner;
> +	void *data;

I guess you need this, because you stopped using the member of struct
ap_mdev_matrix and instead you kzalloc() a new object. Yet I don't
understand why do you do so?

>  };
>  
>  struct kvm_s390_crypto {
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 9928f785c677..2d330dfbdb61 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -610,8 +610,11 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>  static int handle_pqap(struct kvm_vcpu *vcpu)
>  {
>  	struct ap_queue_status status = {};
> +	struct kvm_s390_module_hook *pqap_module_hook;
> +	int (*pqap_hook)(struct kvm_vcpu *vcpu);
> +	struct module *owner;
>  	unsigned long reg0;
> -	int ret;
> +	int ret = 0;
>  	uint8_t fc;
>  
>  	/* Verify that the AP instruction are available */
> @@ -657,24 +660,32 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>  	 * Verify that the hook callback is registered, lock the owner
>  	 * and call the hook.
>  	 */
> -	if (vcpu->kvm->arch.crypto.pqap_hook) {
> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> -			return -EOPNOTSUPP;
> -		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> -		if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
> -			kvm_s390_set_psw_cc(vcpu, 3);
> -		return ret;
> +	rcu_read_lock();
> +	pqap_module_hook = rcu_dereference(vcpu->kvm->arch.crypto.pqap_hook);
> +	if (pqap_module_hook) {
> +		pqap_hook = pqap_module_hook->hook;
> +		owner = pqap_module_hook->owner;
> +		rcu_read_unlock();
> +		if (!try_module_get(owner)) {

Why do this outside the rcu_read lock?

What guarantees that the module ain't gone by this time? I don't think
try_module_get() is guaranteed to give you false if passed in a pointer
that points to some memory that ain't a struct module any more
(use-after-free).

> +			ret = -EOPNOTSUPP;
> +		} else {
> +			ret = pqap_hook(vcpu);
> +			module_put(owner);
> +			if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
> +				kvm_s390_set_psw_cc(vcpu, 3);
> +		}
> +	} else {
> +		rcu_read_unlock();
> +		/*
> +		 * A vfio_driver must register a hook.
> +		 * No hook means no driver to enable the SIE CRYCB and no
> +		 * queues. We send this response to the guest.
> +		 */
> +		status.response_code = 0x01;
> +		memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
> +		kvm_s390_set_psw_cc(vcpu, 3);
>  	}
> -	/*
> -	 * A vfio_driver must register a hook.
> -	 * No hook means no driver to enable the SIE CRYCB and no queues.
> -	 * We send this response to the guest.
> -	 */
> -	status.response_code = 0x01;
> -	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
> -	kvm_s390_set_psw_cc(vcpu, 3);
> -	return 0;
> +	return ret;
>  }
>  
>  static int handle_stfl(struct kvm_vcpu *vcpu)
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index f90c9103dac2..a6aa3f753ac4 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -16,6 +16,7 @@
>  #include <linux/bitops.h>
>  #include <linux/kvm_host.h>
>  #include <linux/module.h>
> +#include <linux/rcupdate.h>
>  #include <asm/kvm.h>
>  #include <asm/zcrypt.h>
>  
> @@ -279,6 +280,7 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>  	uint64_t status;
>  	uint16_t apqn;
>  	struct vfio_ap_queue *q;
> +	struct kvm_s390_module_hook *pqap_module_hook;
>  	struct ap_queue_status qstatus = {
>  			       .response_code = AP_RESPONSE_Q_NOT_AVAIL, };
>  	struct ap_matrix_mdev *matrix_mdev;
> @@ -287,13 +289,17 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>  	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
>  		return -EOPNOTSUPP;
>  
> -	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> -	mutex_lock(&matrix_dev->lock);
> +	rcu_read_lock();
> +	pqap_module_hook = rcu_dereference(vcpu->kvm->arch.crypto.pqap_hook);
> +	if (!pqap_module_hook) {
> +		rcu_read_unlock();
> +		goto set_status;
> +	}
>  
> -	if (!vcpu->kvm->arch.crypto.pqap_hook)
> -		goto out_unlock;
> -	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
> -				   struct ap_matrix_mdev, pqap_hook);
> +	matrix_mdev = pqap_module_hook->data;
> +	rcu_read_unlock();
> +	mutex_lock(&matrix_dev->lock);

I agree with Jason's assessment. At this point the matrix_dev pointer
may point to garbage.

Above, I think we can use the pqap_hook function pointer local to
handle_pqap, because we know that as long as the module is there
the callback will sit at the same address and won't go away. And
we do the try_module_get() to ensure that the module stays loaded.


> +	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
>  
>  	/*
>  	 * If the KVM pointer is in the process of being set, wait until the
> @@ -322,9 +328,10 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>  		qstatus = vfio_ap_irq_disable(q);
>  
>  out_unlock:
> +	mutex_unlock(&matrix_dev->lock);
> +set_status:
>  	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
>  	vcpu->run->s.regs.gprs[1] >>= 32;
> -	mutex_unlock(&matrix_dev->lock);
>  	return 0;
>  }
>  
> @@ -353,8 +360,6 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
>  	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>  	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
>  	mdev_set_drvdata(mdev, matrix_mdev);
> -	matrix_mdev->pqap_hook.hook = handle_pqap;
> -	matrix_mdev->pqap_hook.owner = THIS_MODULE;

I guess the member of struct ap_matrix_mdev is still around, it will
remain all zero. Is this somehow intentional?


>  	mutex_lock(&matrix_dev->lock);
>  	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>  	mutex_unlock(&matrix_dev->lock);
> @@ -1085,6 +1090,22 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>  	NULL
>  };
>  
> +static int vfio_ap_mdev_set_pqap_hook(struct ap_matrix_mdev *matrix_mdev,
> +				       struct kvm *kvm)
> +{
> +	struct kvm_s390_module_hook *pqap_hook;
> +
> +	pqap_hook = kmalloc(sizeof(*kvm->arch.crypto.pqap_hook), GFP_KERNEL);

What is the extra allocation supposed to buy us?

> +	if (!pqap_hook)
> +		return -ENOMEM;
> +	pqap_hook->data = matrix_mdev;
> +	pqap_hook->hook = handle_pqap;
> +	pqap_hook->owner = THIS_MODULE;
> +	rcu_assign_pointer(kvm->arch.crypto.pqap_hook, pqap_hook);
> +
> +	return 0;
> +}
> +
>  /**
>   * vfio_ap_mdev_set_kvm
>   *
> @@ -1107,6 +1128,7 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>  static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>  				struct kvm *kvm)
>  {
> +	int ret;
>  	struct ap_matrix_mdev *m;
>  
>  	if (kvm->arch.crypto.crycbd) {
> @@ -1115,6 +1137,10 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>  				return -EPERM;
>  		}
>  
> +		ret = vfio_ap_mdev_set_pqap_hook(matrix_mdev, kvm);
> +		if (ret)
> +			return ret;
> +
>  		kvm_get_kvm(kvm);
>  		matrix_mdev->kvm_busy = true;
>  		mutex_unlock(&matrix_dev->lock);
> @@ -1123,7 +1149,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>  					  matrix_mdev->matrix.aqm,
>  					  matrix_mdev->matrix.adm);
>  		mutex_lock(&matrix_dev->lock);
> -		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>  		matrix_mdev->kvm = kvm;
>  		matrix_mdev->kvm_busy = false;
>  		wake_up_all(&matrix_mdev->wait_for_kvm);
> @@ -1161,6 +1186,13 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> +static void vfio_ap_mdev_unset_pqap_hook(struct kvm *kvm)
> +{
> +	rcu_assign_pointer(kvm->arch.crypto.pqap_hook, NULL);
> +	synchronize_rcu();
> +	kfree(kvm->arch.crypto.pqap_hook);
> +}
> +
>  /**
>   * vfio_ap_mdev_unset_kvm
>   *
> @@ -1189,11 +1221,11 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>  
>  	if (matrix_mdev->kvm) {
>  		matrix_mdev->kvm_busy = true;
> +		vfio_ap_mdev_unset_pqap_hook(matrix_mdev->kvm);
>  		mutex_unlock(&matrix_dev->lock);
>  		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>  		mutex_lock(&matrix_dev->lock);
>  		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> -		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>  		kvm_put_kvm(matrix_mdev->kvm);
>  		matrix_mdev->kvm = NULL;
>  		matrix_mdev->kvm_busy = false;

