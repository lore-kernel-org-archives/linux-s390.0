Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C50BC4707A
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 18:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EE3610A8
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 18:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhEUS0B (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 May 2021 14:26:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54748 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233289AbhEUS0B (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 May 2021 14:26:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LI3C6Q115187;
        Fri, 21 May 2021 14:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fpgL+g7r4C+9FXGgSN+poS6kyf70qviv190qVQcDhLM=;
 b=B3fQ0iOKB40rT+yOpxPwITyxwX1Pvp5uO2Z2cSAnQQSHtuDv6GaRm39E43BWkwojT6w0
 b+y483WHn82m1rw0w0H6wdBUp5F7lTgRU0HqpjjtAYtNfyvygO1HkuICga5nCBZEmZWx
 uyRNfvOnNmB0JFHcv39o6+FpYcNUX96aw47rgefNx4em7Yapv56yAnK0/EHtckxCmTCf
 j5OXdwrV+EtAvJCgt25/r1FTZ8p2blQziVZxvFveCbFuhD7YHJZtml+qryX5vioXMUZx
 K3Vj2Hc1sp10QdGtiyHBZkEkybY0Jiu7UioUSgl6sj4dmvmXvUf2m0O0Ex9w45R6FHu+ 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38phc8h5a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 14:24:36 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14LI3H6d115643;
        Fri, 21 May 2021 14:24:36 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38phc8h5a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 14:24:36 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LICW2i003826;
        Fri, 21 May 2021 18:24:35 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 38j5x9sssc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 18:24:35 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LIOZBx38797804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 18:24:35 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22BA2AC05E;
        Fri, 21 May 2021 18:24:35 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A376AC05B;
        Fri, 21 May 2021 18:24:33 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 May 2021 18:24:33 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
 <20210519153921.804887-3-akrowiak@linux.ibm.com>
 <20210519161610.GO1002214@nvidia.com>
 <8c93c29a-e223-ac9a-5b54-7329587084c9@linux.ibm.com>
 <20210519232202.GV1002214@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <07dfdf17-f56e-6dd1-8011-eacfbe741e9e@linux.ibm.com>
Date:   Fri, 21 May 2021 14:24:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519232202.GV1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KBboVuGKkqRvjJX0TdTwd1YIQf_gH-b-
X-Proofpoint-ORIG-GUID: J052NDOuwYuhqFC7fbP5cJ6m9CzxPfmA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_08:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210094
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


> The simple solution in sketch is just this:

The code below results in a lockdep WARN_ON for the
reasons documented in my comments interspersed in
the code.

After trying several different permutations using RCU and
an rw_semaphore, I came to the conclusion that setting and
clearing the hook pointer while the mdev fd is being open
and closed or when the mdev is being removed unnecessarily
complicates things. There is no good reason to set/clear the
function pointer at this time, nor is there any compelling
reason to store the function pointer in a satellite structure
of the kvm struct. Since the hook function's lifespan coincides
with the lifespan of the vfio_ap module, why not store it
when the module is loaded and clear it when the module is
unloaded? Access to the function pointer can be controlled by a lock
that is independent of the matrix_dev->lock, thus avoiding
potential lock dependencies. Access to the mdev is controlled by
the matrix_dev lock, so if the mdev is retrieved from the
matrix_dev->mdev_list in the hook function, then we are assured
that the mdev will never be accessed after it is freed; problem solved.

>
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 9928f785c6773a..f70386452367dd 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -657,13 +657,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>   	 * Verify that the hook callback is registered, lock the owner
>   	 * and call the hook.
>   	 */
> -	if (vcpu->kvm->arch.crypto.pqap_hook) {
> -		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> -			return -EOPNOTSUPP;
> +	if (down_read_trylock(&vcpu->kvm->arch.crypto.rwsem) &&
> +	    vcpu->kvm->arch.crypto.pqap_hook) {
>   		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);

So, the hook function (handle_pqap in vfio_ap_ops.c) is executed while
holding the rwsem lock. The hook function tries to lock the matrix_dev->lock
mutex.

> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>   		if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
>   			kvm_s390_set_psw_cc(vcpu, 3);
> +		up_read(&vcpu->kv->arch.crypto.rwsem);
>   		return ret;
>   	}
>   	/*
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index b2c7e10dfdcdcf..64c89f6a711e94 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -352,8 +352,7 @@ static int vfio_ap_mdev_create(struct mdev_device *mdev)
>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>   	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
>   	mdev_set_drvdata(mdev, matrix_mdev);
> -	matrix_mdev->pqap_hook.hook = handle_pqap;
> -	matrix_mdev->pqap_hook.owner = THIS_MODULE;
> +	down_write(&&vcpu->kvm->arch.crypto.rwsem);
>   	mutex_lock(&matrix_dev->lock);
>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>   	mutex_unlock(&matrix_dev->lock);
> @@ -1132,7 +1131,9 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>   					  matrix_mdev->matrix.aqm,
>   					  matrix_mdev->matrix.adm);
>   		mutex_lock(&matrix_dev->lock);

Locks the matrix_dev->lock mutex, then tries to lock rwsem
to store the pqap_hook under the rwsem lock. During testing,
this occurred while the interception of the PQAP instruction
was taking place, so the read lock was already taken and the
hook function was waiting on the matrix_dev->lock taken above.
All of the test cases ran successfully to completion, so there
didn't appear to be a deadlock of any sort, but lockdep apparently
detected a problem.

I was able to get around this by doing the down_write and setting
the hook vfio_ap_mdev_group_notifier function before calling
this function (above) and before taking the matrix_dev->lock,
but that circumvents the protection against accessing a matrix_dev
that's already been freed.


> +		down_write(&kvm->arch.crypto.rwsem);
>   		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
> +		up_write(&kvm->arch.crypto.rwsem);
>   		matrix_mdev->kvm = kvm;
>   		matrix_mdev->kvm_busy = false;
>   		wake_up_all(&matrix_mdev->wait_for_kvm);
> @@ -1202,7 +1203,9 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>   		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>   		mutex_lock(&matrix_dev->lock);
>   		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> +		down_write(&matrix_mdev->kvm->arch.crypto.rwsem);

Same scenario here.

>   		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> +		up_write(&matrix_mdev->kvm->arch.crypto.rwsem);
>   		kvm_put_kvm(matrix_mdev->kvm);
>   		matrix_mdev->kvm = NULL;
>   		matrix_mdev->kvm_busy = false;
>
>
> Jason

