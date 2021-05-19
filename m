Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC41C433B4
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 23:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CB061363
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 23:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhESXQB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 19:16:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63538 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhESXQB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 19:16:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JN41cp091011;
        Wed, 19 May 2021 19:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VbzR1/Qd1gf6bzpGX5r+yDEh56yXYt4kKBOdIBterIU=;
 b=b0UiSwDshobjKe8zBr2o2H6K3UFmzKuvgmqT9SKIgg0vh3jk983G9DSO1ayQKCIgI4mc
 XLcFkupOT9g51rQRD20FFQmWabRpjfaUDOWwRbQEMSfOXcPx92Mi8bqyu+uzeb/oFHT7
 uHMndGRNh5P1zMTGXtB2fiERy5FNMOcdqOiL7BxGoMVZnXJ1pCyT3A3qlnYTUpVOm+Hw
 D0zenImfn7S/hy4T0OQVYiX9GqNR2rR2fLh3ie/MF0UDbo9nUulPHDfoQDymCxpxHJzG
 WF17f2pvNf5agqYXM2DQbz1JG+ZEzmy8KXj9sxSzjLdCNa/NBeCCi8lbLCI5eOKbDFA3 eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nb1n1mt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 19:14:39 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14JNBSsF120253;
        Wed, 19 May 2021 19:14:38 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nb1n1msr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 19:14:38 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JNCY5i026095;
        Wed, 19 May 2021 23:14:38 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 38j5x9jvh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 23:14:38 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JNEbYU29884860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 23:14:37 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4D73AC062;
        Wed, 19 May 2021 23:14:37 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D113AC059;
        Wed, 19 May 2021 23:14:37 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 19 May 2021 23:14:37 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
 <20210519153921.804887-3-akrowiak@linux.ibm.com>
 <20210519192147.2362fe1b.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <0b0dd666-174a-281d-d630-148a0a6eaa76@linux.ibm.com>
Date:   Wed, 19 May 2021 19:14:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519192147.2362fe1b.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b0hOS423Dual1yJb0TwxRzGRHDzpr9kf
X-Proofpoint-ORIG-GUID: 9KoJWQa2ZGYIejAiCFJwpJIhh52_CeQO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_10:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190143
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/19/21 1:21 PM, Halil Pasic wrote:
> On Wed, 19 May 2021 11:39:21 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> There is currently nothing that controls access to the structure that
>> contains the function pointer to the handler that processes interception of
>> the PQAP(AQIC) instruction. If the mdev is removed while the PQAP(AQIC)
>> instruction is being intercepted, there is a possibility that the function
>> pointer to the handler can get wiped out prior to the attempt to call it.
>>
>> This patch utilizes RCU to synchronize access to the kvm_s390_module_hook
>> structure used to process interception of the PQAP(AQIC) instruction.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h  |  1 +
>>   arch/s390/kvm/priv.c              | 47 ++++++++++++++++-----------
>>   drivers/s390/crypto/vfio_ap_ops.c | 54 ++++++++++++++++++++++++-------
>>   3 files changed, 73 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 8925f3969478..4987e82d6116 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -806,6 +806,7 @@ struct kvm_s390_cpu_model {
>>   struct kvm_s390_module_hook {
>>   	int (*hook)(struct kvm_vcpu *vcpu);
>>   	struct module *owner;
>> +	void *data;
> I guess you need this, because you stopped using the member of struct
> ap_mdev_matrix and instead you kzalloc() a new object. Yet I don't
> understand why do you do so?

I did so because the mdev remove callback frees the matrix_mdev
and I thought I could protect against accessing freed storage by
storing the pointer in the pqap_hook structure; however, since we
can't hold the rcu_read_lock while the handle_pqap is executing - due
to wait conditions - this turns out to be a bad idea. I'm not sure at
this point that we can use RCU for this because the freeing of the
matrix_mdev is independent of pqap processing.

>
>>   };
>>   
>>   struct kvm_s390_crypto {
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 9928f785c677..2d330dfbdb61 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -610,8 +610,11 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>   static int handle_pqap(struct kvm_vcpu *vcpu)
>>   {
>>   	struct ap_queue_status status = {};
>> +	struct kvm_s390_module_hook *pqap_module_hook;
>> +	int (*pqap_hook)(struct kvm_vcpu *vcpu);
>> +	struct module *owner;
>>   	unsigned long reg0;
>> -	int ret;
>> +	int ret = 0;
>>   	uint8_t fc;
>>   
>>   	/* Verify that the AP instruction are available */
>> @@ -657,24 +660,32 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>   	 * Verify that the hook callback is registered, lock the owner
>>   	 * and call the hook.
>>   	 */
>> -	if (vcpu->kvm->arch.crypto.pqap_hook) {
>> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
>> -			return -EOPNOTSUPP;
>> -		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
>> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>> -		if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
>> -			kvm_s390_set_psw_cc(vcpu, 3);
>> -		return ret;
>> +	rcu_read_lock();
>> +	pqap_module_hook = rcu_dereference(vcpu->kvm->arch.crypto.pqap_hook);
>> +	if (pqap_module_hook) {
>> +		pqap_hook = pqap_module_hook->hook;
>> +		owner = pqap_module_hook->owner;
>> +		rcu_read_unlock();
>> +		if (!try_module_get(owner)) {
> Why do this outside the rcu_read lock?

It should be done inside the lock.

>
> What guarantees that the module ain't gone by this time? I don't think
> try_module_get() is guaranteed to give you false if passed in a pointer
> that points to some memory that ain't a struct module any more
> (use-after-free).

That needs to be inside the lock.

>
>> +			ret = -EOPNOTSUPP;
>> +		} else {
>> +			ret = pqap_hook(vcpu);
>> +			module_put(owner);
>> +			if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
>> +				kvm_s390_set_psw_cc(vcpu, 3);
>> +		}
>> +	} else {
>> +		rcu_read_unlock();
>> +		/*
>> +		 * A vfio_driver must register a hook.
>> +		 * No hook means no driver to enable the SIE CRYCB and no
>> +		 * queues. We send this response to the guest.
>> +		 */
>> +		status.response_code = 0x01;
>> +		memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
>> +		kvm_s390_set_psw_cc(vcpu, 3);
>>   	}
>> -	/*
>> -	 * A vfio_driver must register a hook.
>> -	 * No hook means no driver to enable the SIE CRYCB and no queues.
>> -	 * We send this response to the guest.
>> -	 */
>> -	status.response_code = 0x01;
>> -	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
>> -	kvm_s390_set_psw_cc(vcpu, 3);
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static int handle_stfl(struct kvm_vcpu *vcpu)
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index f90c9103dac2..a6aa3f753ac4 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/bitops.h>
>>   #include <linux/kvm_host.h>
>>   #include <linux/module.h>
>> +#include <linux/rcupdate.h>
>>   #include <asm/kvm.h>
>>   #include <asm/zcrypt.h>
>>   
>> @@ -279,6 +280,7 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>   	uint64_t status;
>>   	uint16_t apqn;
>>   	struct vfio_ap_queue *q;
>> +	struct kvm_s390_module_hook *pqap_module_hook;
>>   	struct ap_queue_status qstatus = {
>>   			       .response_code = AP_RESPONSE_Q_NOT_AVAIL, };
>>   	struct ap_matrix_mdev *matrix_mdev;
>> @@ -287,13 +289,17 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>   	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
>>   		return -EOPNOTSUPP;
>>   
>> -	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
>> -	mutex_lock(&matrix_dev->lock);
>> +	rcu_read_lock();
>> +	pqap_module_hook = rcu_dereference(vcpu->kvm->arch.crypto.pqap_hook);
>> +	if (!pqap_module_hook) {
>> +		rcu_read_unlock();
>> +		goto set_status;
>> +	}
>>   
>> -	if (!vcpu->kvm->arch.crypto.pqap_hook)
>> -		goto out_unlock;
>> -	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
>> -				   struct ap_matrix_mdev, pqap_hook);
>> +	matrix_mdev = pqap_module_hook->data;
>> +	rcu_read_unlock();
>> +	mutex_lock(&matrix_dev->lock);
> I agree with Jason's assessment. At this point the matrix_dev pointer
> may point to garbage.
>
> Above, I think we can use the pqap_hook function pointer local to
> handle_pqap, because we know that as long as the module is there
> the callback will sit at the same address and won't go away. And
> we do the try_module_get() to ensure that the module stays loaded.

I'll take your word that is true. If so, then I think I can replace
the way we get the matrix_mdev in the pqap handler which
can be done under the matrix_dev->lock. I can write a function
to get the matrix from the list of mdevs in matrix_dev. If the
matrix_mdev has been removed, then we can bail out of the
handle_pqap function. Maybe the RCU can be used after all.

>
>
>> +	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
>>   
>>   	/*
>>   	 * If the KVM pointer is in the process of being set, wait until the
>> @@ -322,9 +328,10 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>   		qstatus = vfio_ap_irq_disable(q);
>>   
>>   out_unlock:
>> +	mutex_unlock(&matrix_dev->lock);
>> +set_status:
>>   	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
>>   	vcpu->run->s.regs.gprs[1] >>= 32;
>> -	mutex_unlock(&matrix_dev->lock);
>>   	return 0;
>>   }
>>   
>> @@ -353,8 +360,6 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
>>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>>   	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
>>   	mdev_set_drvdata(mdev, matrix_mdev);
>> -	matrix_mdev->pqap_hook.hook = handle_pqap;
>> -	matrix_mdev->pqap_hook.owner = THIS_MODULE;
> I guess the member of struct ap_matrix_mdev is still around, it will
> remain all zero. Is this somehow intentional?
>
>
>>   	mutex_lock(&matrix_dev->lock);
>>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>>   	mutex_unlock(&matrix_dev->lock);
>> @@ -1085,6 +1090,22 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>>   	NULL
>>   };
>>   
>> +static int vfio_ap_mdev_set_pqap_hook(struct ap_matrix_mdev *matrix_mdev,
>> +				       struct kvm *kvm)
>> +{
>> +	struct kvm_s390_module_hook *pqap_hook;
>> +
>> +	pqap_hook = kmalloc(sizeof(*kvm->arch.crypto.pqap_hook), GFP_KERNEL);
> What is the extra allocation supposed to buy us?
>
>> +	if (!pqap_hook)
>> +		return -ENOMEM;
>> +	pqap_hook->data = matrix_mdev;
>> +	pqap_hook->hook = handle_pqap;
>> +	pqap_hook->owner = THIS_MODULE;
>> +	rcu_assign_pointer(kvm->arch.crypto.pqap_hook, pqap_hook);
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * vfio_ap_mdev_set_kvm
>>    *
>> @@ -1107,6 +1128,7 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>>   static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>>   				struct kvm *kvm)
>>   {
>> +	int ret;
>>   	struct ap_matrix_mdev *m;
>>   
>>   	if (kvm->arch.crypto.crycbd) {
>> @@ -1115,6 +1137,10 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>>   				return -EPERM;
>>   		}
>>   
>> +		ret = vfio_ap_mdev_set_pqap_hook(matrix_mdev, kvm);
>> +		if (ret)
>> +			return ret;
>> +
>>   		kvm_get_kvm(kvm);
>>   		matrix_mdev->kvm_busy = true;
>>   		mutex_unlock(&matrix_dev->lock);
>> @@ -1123,7 +1149,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>>   					  matrix_mdev->matrix.aqm,
>>   					  matrix_mdev->matrix.adm);
>>   		mutex_lock(&matrix_dev->lock);
>> -		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>>   		matrix_mdev->kvm = kvm;
>>   		matrix_mdev->kvm_busy = false;
>>   		wake_up_all(&matrix_mdev->wait_for_kvm);
>> @@ -1161,6 +1186,13 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>>   	return NOTIFY_DONE;
>>   }
>>   
>> +static void vfio_ap_mdev_unset_pqap_hook(struct kvm *kvm)
>> +{
>> +	rcu_assign_pointer(kvm->arch.crypto.pqap_hook, NULL);
>> +	synchronize_rcu();
>> +	kfree(kvm->arch.crypto.pqap_hook);
>> +}
>> +
>>   /**
>>    * vfio_ap_mdev_unset_kvm
>>    *
>> @@ -1189,11 +1221,11 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>>   
>>   	if (matrix_mdev->kvm) {
>>   		matrix_mdev->kvm_busy = true;
>> +		vfio_ap_mdev_unset_pqap_hook(matrix_mdev->kvm);
>>   		mutex_unlock(&matrix_dev->lock);
>>   		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>   		mutex_lock(&matrix_dev->lock);
>>   		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
>> -		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>   		kvm_put_kvm(matrix_mdev->kvm);
>>   		matrix_mdev->kvm = NULL;
>>   		matrix_mdev->kvm_busy = false;

