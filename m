Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB888C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 21:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C319B60EB1
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 21:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhGWUnw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:43:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232375AbhGWUnv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Jul 2021 16:43:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NL6XS7053296;
        Fri, 23 Jul 2021 17:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vU/t4TdhyiYzzwIVRwC+ebGskfo8x+qQ1+tCbtuAwoM=;
 b=SGb9HfgC1HNaYLg0npyc919nZtC/+5ymDqbVAADJ6+GT2xOAklE+AB0km8cRUyAc/t6R
 f56PQPknN9YD2gcU3b4/ZrfoGarK/reE1nEDROSrY8MGYRal92yO1sOznEekhCbvfGP1
 gYZgJAJLhSb3UKbYHYToQkL3+IRd2qA2YHcRvXKW4bwWu8ae8bEqILjH0P3J2kcDXUeV
 my105GfG3A84LxSbIrID4GBH/np/LfKYUTLsp3dlClJFou89GiEhvDdFrJAnVdg+Dhak
 mI0h+BZrfVz8b0UwuTFzwn3dFFJV4DtAMVGswpSr9RmgBDnkpel4Ipst49oIhswHKP2B qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a02e6ckhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 17:24:22 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16NL8nXF064774;
        Fri, 23 Jul 2021 17:24:21 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a02e6ckh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 17:24:21 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16NLH05s000907;
        Fri, 23 Jul 2021 21:24:20 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 39upuerhyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 21:24:20 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16NLOJmq17433060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 21:24:19 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 672196A047;
        Fri, 23 Jul 2021 21:24:19 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D6216A058;
        Fri, 23 Jul 2021 21:24:17 +0000 (GMT)
Received: from [9.85.184.30] (unknown [9.85.184.30])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jul 2021 21:24:17 +0000 (GMT)
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-3-akrowiak@linux.ibm.com>
 <20210721164550.5402fe1c.pasic@linux.ibm.com>
 <c3b80f79-6795-61ce-2dd1-f4cc7110e417@linux.ibm.com>
 <20210723162625.59cead27.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <5380652f-e68f-bbd0-10c0-c7d541065843@linux.ibm.com>
Date:   Fri, 23 Jul 2021 17:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210723162625.59cead27.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Et_5sQkjJGKgvI6g3LjXCFxEKuWoxiPj
X-Proofpoint-GUID: VyHXBvuEJ15sB65w-MJM4lMWbLimRorE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_10:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/23/21 10:26 AM, Halil Pasic wrote:
> On Thu, 22 Jul 2021 09:09:26 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 7/21/21 10:45 AM, Halil Pasic wrote:
>>> On Mon, 19 Jul 2021 15:35:03 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>   
>>>> It was pointed out during an unrelated patch review that locks should not
>>> [..]
>>>   
>>>> -static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>>>> +static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev,
>>>> +				   struct kvm *kvm)
>>>>    {
>>>> -	/*
>>>> -	 * If the KVM pointer is in the process of being set, wait until the
>>>> -	 * process has completed.
>>>> -	 */
>>>> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
>>>> -		       !matrix_mdev->kvm_busy,
>>>> -		       mutex_unlock(&matrix_dev->lock),
>>>> -		       mutex_lock(&matrix_dev->lock));
>>>> -
>>>> -	if (matrix_mdev->kvm) {
>>> We used to check if matrix_mdev->kvm is null, but ...
>>>   
>>>> -		matrix_mdev->kvm_busy = true;
>>>> -		mutex_unlock(&matrix_dev->lock);
>>>> -
>>>> -		if (matrix_mdev->kvm->arch.crypto.crycbd) {
>>>> -			down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>>>> -			matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>>> -			up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>>>> -
>>>> -			kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>> -		}
>>>> +	if (kvm->arch.crypto.crycbd) {
>>> ... now we just try to dereference it. And ..
>> We used to check matrix_mdev->kvm, now the kvm pointer is passed into
>> the function; however, having said that, the pointer passed in should be
>> checked before de-referencing it.
>>
>>>   
>>>> +		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>>>> +		kvm->arch.crypto.pqap_hook = NULL;
>>>> +		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>>>>
>>>> +		mutex_lock(&kvm->lock);
>>>>    		mutex_lock(&matrix_dev->lock);
>>>> +
>>>> +		kvm_arch_crypto_clear_masks(kvm);
>>>>    		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
>>>> -		kvm_put_kvm(matrix_mdev->kvm);
>>>> +		kvm_put_kvm(kvm);
>>>>    		matrix_mdev->kvm = NULL;
>>>> -		matrix_mdev->kvm_busy = false;
>>>> -		wake_up_all(&matrix_mdev->wait_for_kvm);
>>>> +
>>>> +		mutex_unlock(&kvm->lock);
>>>> +		mutex_unlock(&matrix_dev->lock);
>>>>    	}
>>>>    }
>>>>   
>>> [..]
>>>   
>>>> @@ -1363,14 +1323,11 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>>>    {
>>>>    	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>>
>>>> -	mutex_lock(&matrix_dev->lock);
>>>> -	vfio_ap_mdev_unset_kvm(matrix_mdev);
>>>> -	mutex_unlock(&matrix_dev->lock);
>>>> -
>>> .. before access to the matrix_mdev->kvm used to be protected by
>>> the matrix_dev->lock ...
>>>   
>>>>    	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>>>>    				 &matrix_mdev->iommu_notifier);
>>>>    	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>>>    				 &matrix_mdev->group_notifier);
>>>> +	vfio_ap_mdev_unset_kvm(matrix_mdev, matrix_mdev->kvm);
>>> ... but it is not any more. BTW I don't think the code is guaranteed
>>> to fetch ->kvm just once.
>> There are a couple of things to point out here:
>> 1. The vfio_ap_mdev_unset_kvm function() is the only place where the
>>       matrix_mdev->kvm pointer is cleared. That function is called here
>>       as well as by the group notifier callback for VFIO_GROUP_NOTIFY_SET_KVM
>>       events. If you notice in the code above, the group notifier is
>> unregistered
>>       before calling the unset function, so either the notifier will have
>> already
>>       been invoked and the pointer cleared (which is why you are correct
>>       that the KVM pointer passed in needs to get checked in the unset
>> function),
>>       or will get cleared here.
> Hm, vfio_unregister_notifier() indeed seems to guarantee, that by the
> time it returns no notifer is running. I didn't know that. But this
> blocking notifier chain uses an rwsem. So mutual exclusion with
> vfio_ap_mdev_open() is guaranteed, than it is indeed guaranteed. A quick
> glance at the code didn't tell me if vfio/mdev guarantees that.
>
> I mean it would make sense to me to make the init and the cleanup
> mutually exclusive, but I'm reluctant to just assume it is like that.
> Can you please point me into the right direction?

I'm not quite sure what you're asking for here, but I'll give it a
shot. The notifier is registered by the vfio_ap_mdev_open()
callback which is invoked in response to the opening of the mdev fd.
Since mdev fd can't be closed unless and until it's open,
there is no way for the vfio_ap_mdev_release() callback, which
is invoked when the mdev fd is closed, to execute at the same
time as the vfio_ap_mdev_open callback. Since the release
callback unregisters the notifier and both the registration and
unregistration are done under the same rwsem, I don't see how
they can be anything but mutually exclusive. Am I missing something
here?

>
>
>> 2. The release callback is invoked when the mdev fd is closed by userspace.
>>       The remove callback is the only place where the matrix_mdev is
>> freed. The
>>       remove callback is not called until the mdev fd is released, so it
>> is guaranteed
>>       the matrix_mdev will exist when the release callback is invoked.
>> 3. The matrix_dev->lock is then taken in the vfio_ap_mdev_unset_kvm function
>>       before doing any operations that modify the matrix_mdev.
> Yeah but both the reader, and the writer needs to use the same lock to
> have the protected by the lock type of situation. That is why I asked
> about the place where you read matrix_mdev members outside the
> matrix_dev->lock.

With this patch, the matrix_mdev is always written or read with
the matrix_dev->lock mutex locked. By moving the locking of the
kvm->lock mutex out of the functions that set/clear the masks
in the guest's CRYCB, we are now able to lock the kvm->lock
mutex before locking the matrix_dev->lock mutex in both the
vfio_ap_mdev_set_kvm() and vfio_ap_mdev_unset_kvm()
functions. This precludes the need to unlock the
matrix_dev->lock mutex while the masks are being set or
cleared and alleviates the lockdep splat for which the open coded
locks were created.

>
> Regards,
> Halil

