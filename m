Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64873C07E99
	for <linux-s390@archiver.kernel.org>; Mon, 12 Jul 2021 13:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAAD60FE7
	for <linux-s390@archiver.kernel.org>; Mon, 12 Jul 2021 13:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhGLNpI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:45:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232020AbhGLNpH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Jul 2021 09:45:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CDXwLp162718;
        Mon, 12 Jul 2021 09:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=32MFLb12ydEQ/sUCivFTZ48e/tC5S+L0+t5Z8ACS07M=;
 b=pcBlCh1Ck5kJ2CCEEPMoUc2SHbiRiPT87CupWK2SrfAuBzIvBZV8cvHtDIXWCjUOrY0e
 7i3Z6au4RXYnJxlmE83+b8JWAn03Qu3ck8X1zT+I9BWQ2lgmOItOURAAZoaW2f5zGWx+
 NBkIx9GEDWNuxGrlDfBBaNFJMWJgK21hewZe/IkEmIeLd6YE+2rPZiY8ClmCcuyLkZe0
 5OvcTO4kRk9oIsTAcLhlCK6fMo4m2ZscDMLhs9Jh/SynKukvLY4DfffAW2dqFohXXjBy
 T2nqec/SbVdq1hioZIxdtL7lj8cr5B4Yq5QpDgeipxAWypmaur0+nAA2u9dmQErE045a wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qs2v2djp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 09:42:17 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16CDXw3W162716;
        Mon, 12 Jul 2021 09:42:17 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qs2v2dj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 09:42:16 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16CDWQ5B022494;
        Mon, 12 Jul 2021 13:42:16 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 39q36afswt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 13:42:15 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16CDgEOI15467238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 13:42:14 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AE1C136067;
        Mon, 12 Jul 2021 13:42:14 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA625136068;
        Mon, 12 Jul 2021 13:42:12 +0000 (GMT)
Received: from [9.85.184.30] (unknown [9.85.184.30])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jul 2021 13:42:12 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
Message-ID: <aee9dceb-db9c-f610-1d00-9993b1b81b8a@linux.ibm.com>
Date:   Mon, 12 Jul 2021 09:42:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210707154156.297139-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2MHTKhA_alRGFIpB8ChXxGBO1WsCYAd4
X-Proofpoint-GUID: tmDaXst8s0c5WuKfFvm6LnZGgifuJwwu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_08:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120107
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Ping!

On 7/7/21 11:41 AM, Tony Krowiak wrote:
> The fix to resolve a lockdep splat while handling the
> VFIO_GROUP_NOTIFY_SET_KVM event introduced a kvm_busy flag indicating that
> the vfio_ap device driver is busy setting or unsetting the KVM pointer.
> A wait queue was employed to allow functions requiring access to the KVM
> pointer to wait for the kvm_busy flag to be cleared. For the duration of
> the wait period, the mdev lock was unlocked then acquired again after the
> kvm_busy flag was cleared.
>
> It was pointed out during an unrelated patch review that locks should not
> be open coded - i.e., writing the algorithm of a standard lock in a
> function instead of using a lock from the standard library. The setting and
> testing of the kvm_busy flag and sleeping on a wait_event is the same thing
> a lock does. Whatever potential deadlock was found and reported via the
> lockdep splat was not magically removed by going to a wait_queue; it just
> removed the lockdep annotations that would identify the issue early.
>
> To remedy the problem introduced with the open coded locks, this patch
> introduces the following changes:
>
> 1. Removes the the kvm_busy flag and wait queue. These were introduced to
>     prevent functions from accessing the KVM pointer while it was being
>     set because the matrix_dev->lock mutex had to be given up while
>     updating the guest's AP configuration in order to resolve the lockdep
>     splat. Since the functions that set the KVM pointer as well as those
>     that need access to it do so while holding the matrix_dev->lock mutex,
>     it is not necessary to wait for the KVM pointer to be set.
>
> 2. Introduces an rwsem to protect the hook (i.e., function pointer) to the
>     handler that processes interception of the PQAP instruction. A read
>     lock will be taken when the PQAP instruction is intercepted, before
>     calling the handler. A write lock will be taken whenever the KVM
>     pointer is set since the functions that set the KVM pointer also set
>     the hook.
>
> 3. Removes the lock of the matrix_dev->lock mutex from the function that
>     handles interception of the PQAP instruction. Since the functions that
>     set the KVM pointer and the PQAP interception handler hook as well as
>     the function that calls the hook lock the rwsem, it is not necessary
>     to lock the matrix_dev->lock mutex in the handler.
>
> Fixes: 0cc00c8d4050 ("s390/vfio-ap: fix circular lockdep when setting/clearing crypto masks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |   8 +-
>   arch/s390/kvm/kvm-s390.c              |   1 +
>   arch/s390/kvm/priv.c                  |  10 +-
>   drivers/s390/crypto/vfio_ap_ops.c     | 129 +++++++++++---------------
>   drivers/s390/crypto/vfio_ap_private.h |   4 +-
>   5 files changed, 67 insertions(+), 85 deletions(-)
>
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 9b4473f76e56..f18849d259e6 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -798,14 +798,12 @@ struct kvm_s390_cpu_model {
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
> index b655a7d82bf0..339534a0c5a5 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2641,6 +2641,7 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
>   			 sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>   	get_random_bytes(kvm->arch.crypto.crycb->dea_wrapping_key_mask,
>   			 sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
> +	init_rwsem(&kvm->arch.crypto.pqap_hook_rwsem);
>   }
>   
>   static void sca_dispose(struct kvm *kvm)
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 9928f785c677..ec16c2facf7c 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -610,6 +610,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>   static int handle_pqap(struct kvm_vcpu *vcpu)
>   {
>   	struct ap_queue_status status = {};
> +	crypto_hook handle_pqap;
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
> +		handle_pqap = *vcpu->kvm->arch.crypto.pqap_hook;
> +		ret = handle_pqap(vcpu);
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
> index 122c85c22469..d3447f6d83f1 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -270,6 +270,9 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>    * We take the matrix_dev lock to ensure serialization on queues and
>    * mediated device access.
>    *
> + * Note: This function must be called with a read lock held on
> + *	 vcpu->kvm->arch.crypto.pqap_hook_rwsem.
> + *
>    * Return 0 if we could handle the request inside KVM.
>    * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
>    */
> @@ -287,22 +290,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>   		return -EOPNOTSUPP;
>   
>   	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> -	mutex_lock(&matrix_dev->lock);
>   
>   	if (!vcpu->kvm->arch.crypto.pqap_hook)
>   		goto out_unlock;
>   	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
>   				   struct ap_matrix_mdev, pqap_hook);
>   
> -	/*
> -	 * If the KVM pointer is in the process of being set, wait until the
> -	 * process has completed.
> -	 */
> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
> -		       !matrix_mdev->kvm_busy,
> -		       mutex_unlock(&matrix_dev->lock),
> -		       mutex_lock(&matrix_dev->lock));
> -
>   	/* If the there is no guest using the mdev, there is nothing to do */
>   	if (!matrix_mdev->kvm)
>   		goto out_unlock;
> @@ -323,7 +316,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>   out_unlock:
>   	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
>   	vcpu->run->s.regs.gprs[1] >>= 32;
> -	mutex_unlock(&matrix_dev->lock);
>   	return 0;
>   }
>   
> @@ -350,10 +342,8 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
>   
>   	matrix_mdev->mdev = mdev;
>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
> -	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
>   	mdev_set_drvdata(mdev, matrix_mdev);
> -	matrix_mdev->pqap_hook.hook = handle_pqap;
> -	matrix_mdev->pqap_hook.owner = THIS_MODULE;
> +	matrix_mdev->pqap_hook = handle_pqap;
>   	mutex_lock(&matrix_dev->lock);
>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>   	mutex_unlock(&matrix_dev->lock);
> @@ -624,7 +614,7 @@ static ssize_t assign_adapter_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * un-assignment of adapter
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -697,7 +687,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * un-assignment of adapter
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -787,7 +777,7 @@ static ssize_t assign_domain_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * assignment of domain
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -855,7 +845,7 @@ static ssize_t unassign_domain_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * un-assignment of domain
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -909,7 +899,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * assignment of control domain.
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -968,7 +958,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
>   	 * If the KVM pointer is in flux or the guest is running, disallow
>   	 * un-assignment of control domain.
>   	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> +	if (matrix_mdev->kvm) {
>   		ret = -EBUSY;
>   		goto done;
>   	}
> @@ -1108,26 +1098,31 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>   {
>   	struct ap_matrix_mdev *m;
>   
> -	if (kvm->arch.crypto.crycbd) {
> -		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> -			if (m != matrix_mdev && m->kvm == kvm)
> -				return -EPERM;
> -		}
> +	if (!kvm->arch.crypto.crycbd)
> +		return 0;
>   
> -		kvm_get_kvm(kvm);
> -		matrix_mdev->kvm_busy = true;
> -		mutex_unlock(&matrix_dev->lock);
> -		kvm_arch_crypto_set_masks(kvm,
> -					  matrix_mdev->matrix.apm,
> -					  matrix_mdev->matrix.aqm,
> -					  matrix_mdev->matrix.adm);
> -		mutex_lock(&matrix_dev->lock);
> -		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
> -		matrix_mdev->kvm = kvm;
> -		matrix_mdev->kvm_busy = false;
> -		wake_up_all(&matrix_mdev->wait_for_kvm);
> +	down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> +	mutex_lock(&matrix_dev->lock);
> +
> +	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> +		if (m != matrix_mdev && m->kvm == kvm) {
> +			up_read(&kvm->arch.crypto.pqap_hook_rwsem);
> +			mutex_unlock(&matrix_dev->lock);
> +			return -EPERM;
> +		}
>   	}
>   
> +	kvm_get_kvm(kvm);
> +	matrix_mdev->kvm = kvm;
> +	kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	kvm_arch_crypto_set_masks(kvm,
> +				  matrix_mdev->matrix.apm,
> +				  matrix_mdev->matrix.aqm,
> +				  matrix_mdev->matrix.adm);
> +	up_write(&kvm->arch.crypto.pqap_hook_rwsem);
> +
>   	return 0;
>   }
>   
> @@ -1164,6 +1159,7 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>    * vfio_ap_mdev_unset_kvm
>    *
>    * @matrix_mdev: a matrix mediated device
> + * @kvm: the KVM guest state object
>    *
>    * Performs clean-up of resources no longer needed by @matrix_mdev.
>    *
> @@ -1175,29 +1171,30 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>    * done under the @matrix_mdev->lock.
>    *
>    */
> -static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
> +static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev,
> +				   struct kvm *kvm)
>   {
> -	/*
> -	 * If the KVM pointer is in the process of being set, wait until the
> -	 * process has completed.
> -	 */
> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
> -		       !matrix_mdev->kvm_busy,
> -		       mutex_unlock(&matrix_dev->lock),
> -		       mutex_lock(&matrix_dev->lock));
> +	if (!kvm)
> +		return;
>   
> -	if (matrix_mdev->kvm) {
> -		matrix_mdev->kvm_busy = true;
> +	down_write(&kvm->arch.crypto.pqap_hook_rwsem);
> +	mutex_lock(&matrix_dev->lock);
> +	if ((!matrix_mdev->kvm) || (!matrix_mdev->kvm->arch.crypto.crycbd)) {
> +		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>   		mutex_unlock(&matrix_dev->lock);
> -		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> -		mutex_lock(&matrix_dev->lock);
> -		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> -		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> -		kvm_put_kvm(matrix_mdev->kvm);
> -		matrix_mdev->kvm = NULL;
> -		matrix_mdev->kvm_busy = false;
> -		wake_up_all(&matrix_mdev->wait_for_kvm);
> +		return;
>   	}
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	kvm_arch_crypto_clear_masks(kvm);
> +
> +	mutex_lock(&matrix_dev->lock);
> +	vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> +	kvm_put_kvm(kvm);
> +	kvm->arch.crypto.pqap_hook = NULL;
> +	matrix_mdev->kvm = NULL;
> +	mutex_unlock(&matrix_dev->lock);
> +	up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>   }
>   
>   static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
> @@ -1209,16 +1206,13 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>   	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
>   		return NOTIFY_OK;
>   
> -	mutex_lock(&matrix_dev->lock);
>   	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
>   
>   	if (!data)
> -		vfio_ap_mdev_unset_kvm(matrix_mdev);
> +		vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);
>   	else if (vfio_ap_mdev_set_kvm(matrix_mdev, data))
>   		notify_rc = NOTIFY_DONE;
>   
> -	mutex_unlock(&matrix_dev->lock);
> -
>   	return notify_rc;
>   }
>   
> @@ -1352,14 +1346,12 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>   {
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   
> -	mutex_lock(&matrix_dev->lock);
> -	vfio_ap_mdev_unset_kvm(matrix_mdev);
> -	mutex_unlock(&matrix_dev->lock);
> -
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>   				 &matrix_mdev->iommu_notifier);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>   				 &matrix_mdev->group_notifier);
> +
> +	vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);
>   	module_put(THIS_MODULE);
>   }
>   
> @@ -1401,15 +1393,6 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
>   			break;
>   		}
>   
> -		/*
> -		 * If the KVM pointer is in the process of being set, wait until
> -		 * the process has completed.
> -		 */
> -		wait_event_cmd(matrix_mdev->wait_for_kvm,
> -			       !matrix_mdev->kvm_busy,
> -			       mutex_unlock(&matrix_dev->lock),
> -			       mutex_lock(&matrix_dev->lock));
> -
>   		ret = vfio_ap_mdev_reset_queues(mdev);
>   		break;
>   	default:
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index f82a6396acae..22d2e0ca3ae5 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -83,10 +83,8 @@ struct ap_matrix_mdev {
>   	struct ap_matrix matrix;
>   	struct notifier_block group_notifier;
>   	struct notifier_block iommu_notifier;
> -	bool kvm_busy;
> -	wait_queue_head_t wait_for_kvm;
>   	struct kvm *kvm;
> -	struct kvm_s390_module_hook pqap_hook;
> +	crypto_hook pqap_hook;
>   	struct mdev_device *mdev;
>   };
>   

