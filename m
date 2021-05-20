Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB2EC433ED
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 01:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CC66112F
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 01:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhETBJk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 21:09:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhETBJk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 21:09:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14K13tjv142299;
        Wed, 19 May 2021 21:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ViF5ID7v0FSHlZkrsE99JOw5q/lrc83c06vxWeYP4nk=;
 b=g/2RTNtn3I7ZKuTdxYL5Yb5U2oZJQH6DOsYjRFacsVoAgs6GqhK7/wb+LUJ8VKOXBBux
 fhWjL8WnjAJUbjMLCcr0Su+gmMDI+CVaMlORnC0fSOag4alTyhcgJYUslEOFPjSlxxE6
 T88hG1C65dOR+uWetZx5rti8H2P5U6+wzbOQB8HdAkWvXKZbsWI5nr6oGfopWPWu+T5H
 Nap9efYc5YNHfgCoDIbz5emETmFINAsaCG+w1REQoh7zci9sYg6duUNl4PJjeBlE90rA
 iN7j2eiexrM6ul3CvbgFtB1dHbDwr8uX8crs7sLgyYF9OCDhuGtef2qpdcjgF00tgHex Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ncwbhebf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 21:08:18 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14K143n2142786;
        Wed, 19 May 2021 21:08:17 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ncwbheav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 21:08:17 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14K0krVP015196;
        Thu, 20 May 2021 01:08:16 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 38j7tbb0qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 01:08:16 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14K18FMu33751374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 01:08:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B018CAC05B;
        Thu, 20 May 2021 01:08:15 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54A61AC059;
        Thu, 20 May 2021 01:08:15 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 May 2021 01:08:15 +0000 (GMT)
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
Message-ID: <330f099c-3d5e-c552-3047-4b462b1c9fa9@linux.ibm.com>
Date:   Wed, 19 May 2021 21:08:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519232202.GV1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SNdOclHyrrv3SdaFBtX8n9884M9CuDxz
X-Proofpoint-ORIG-GUID: hvVtej5VqwB6fjnEQGeSHd2Wf83eptB7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_10:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200002
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/19/21 7:22 PM, Jason Gunthorpe wrote:
> On Wed, May 19, 2021 at 07:04:46PM -0400, Tony Krowiak wrote:
>>
>> On 5/19/21 12:16 PM, Jason Gunthorpe wrote:
>>> On Wed, May 19, 2021 at 11:39:21AM -0400, Tony Krowiak wrote:
>>>
>>>> @@ -287,13 +289,17 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>    	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
>>>>    		return -EOPNOTSUPP;
>>>> -	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
>>>> -	mutex_lock(&matrix_dev->lock);
>>>> +	rcu_read_lock();
>>>> +	pqap_module_hook = rcu_dereference(vcpu->kvm->arch.crypto.pqap_hook);
>>>> +	if (!pqap_module_hook) {
>>>> +		rcu_read_unlock();
>>>> +		goto set_status;
>>>> +	}
>>>> -	if (!vcpu->kvm->arch.crypto.pqap_hook)
>>>> -		goto out_unlock;
>>>> -	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
>>>> -				   struct ap_matrix_mdev, pqap_hook);
>>>> +	matrix_mdev = pqap_module_hook->data;
>>>> +	rcu_read_unlock();
>>>> +	mutex_lock(&matrix_dev->lock);
>>> The matrix_mdev pointer was extracted from the pqap_module_hook,
>>> but now there is nothing protecting it since the rcu was dropped and
>>> it gets freed in vfio_ap_mdev_remove.
>> Therein lies the rub. We can't hold the rcu_read_lock across the
>> entire time that the interception is being processed because of
>> wait conditions in the interception handler. Regardless of whether
>> the pointer to the matrix_mdev is retrieved as the container of
>> or extracted from the pqap_hook, there is nothing protecting it
>> and there appears to be no way to do so using RCU.
> RCU is a lock that should only be used for highly performance
> sensitive read work loads. It eliminates one atomic from a lock, but
> if you go on to immediately do something like try_module_get, which
> has an atomic inside, the whole thing is pointless (assuming
> try_module_get was even the right thing to do)
>
> Use a simple sleepable rwsem around the whole thing and forget about
> the module_get. Hold the write side when NULL'ing the pointer.
>
>>> And, again, module locking doesn't prevent vfio_ap_mdev_remove() from
>>> being called. None of these patches should be combining module locking
>>> with RCU.
>> Is there any other way besides user interaction with the mdev's
>> sysfs remove interface for the remove callback to get invoked?
> There are more options after my re-organizing series.
>
> But I'm not sure why you ask in response to my point about module
> locking? Module locking is not really related to sysfs.

I don't know why you keep harping on module locking. I didn't
write the original code, so I really have no idea why that was
incorporated. The question wasn't in response to module
locking, it's just something that popped into my head at the
time because based on my observations, the remove callback
did not get invoked in response to a user removing the mdev
via the sysfs interface until the mdev fd was closed by the
guest.


>
>> If I try to remove the mdev using the sysfs interface while the
>> mdev fd is still open by the guest, the remove hangs until the
>> fd is closed.
> Yes, it will wait when the vfio_device is being destroyed.
>
>> That being the case, the mdev release callback will get invoked
>> prior to the remove callback being invoked which renders this whole
>> debate moot. What am I missing here?
> AFAICT the control flow is such that release can immediately move on
> to remove on the same CPU without an additional synchronization. So
> the kfree can still race with the above.

I'd have to look into it more, but my initial thought is that this is
not true. If what I observed is true - i.e., the mdev remove callback
won't get invoked until the mdev fd is closed by the guest - then the
matrix_mdev will never get freed while the pqap_hook is not NULL
because the mdev release callback - invoked when the mdev fd is
closed - nullifies it. That is why I asked whether there is any other
way that the mdev remove callback gets invoked other than
when a user removes it via the sysfs remove attribute. Keep in mind,
the matrix_mdev is removed under the matrix_dev->lock. If retrieve
the matix_mdev in the interception handler from the matrix_dev->mdev_list
under the matrix_dev->lock - instead of from the pqap_hook or the
container_of macro - and exit the handler if it has been removed,
then I think the race issue can be avoided.

>
> But the more I look at this the wonkier it is.. The real issue is not
> the matrix_mdev, it is the whole vcpu->kvm->arch.crypto.pqap_hook

Actually, the matrix_mdev is the issue. If the handle_pqap
callback is invoked after the matrix_mdev is freed, then
because we retrieve it from the pqap_hook structure or
even if we retrieve it from the enclosing container, the
interception handler is screwed.

>
> This is nonesense too:
>
> 	if (vcpu->kvm->arch.crypto.pqap_hook) {
> 		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> 			return -EOPNOTSUPP;
> 		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
>
> It should have a lock around it of some kind, not a
> try_module_get. module_get is not la lock.

As I said earlier, I don't know why the author did this. My best guess
is that he wanted to ensure that the module was still loaded; otherwise,
the data structures contained therein - for example, the pqap_hook
and matrix_mdev that contains it - would be gonzo.

>
> And that lock should interact with loading the hook in the first
> place:
> 		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>
> And of course NULLin'g the hooke should be synchronous with the lock.
>
> There should be no owner for something like this. unregistering the
> function pointer should fully fence all access.
>
> The simple solution in sketch is just this:
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
> -		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>   		if (!ret && vcpu->run->s.regs.gprs[1] & 0x00ff0000)
>   			kvm_s390_set_psw_cc(vcpu, 3);
> +		up_read(&vcpu->kv->arch.crypto.rwsem);
>   		return ret;
>   	}

Since reading the various review comments related to this patch,
I started working on something along the lines of that which
you propose. I will post a new set of patches, probably tomorrow.

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
>   		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> +		up_write(&matrix_mdev->kvm->arch.crypto.rwsem);
>   		kvm_put_kvm(matrix_mdev->kvm);
>   		matrix_mdev->kvm = NULL;
>   		matrix_mdev->kvm_busy = false;
>
>
> Jason

