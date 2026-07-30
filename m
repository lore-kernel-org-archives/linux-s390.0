Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F44418D7;
	Thu, 30 Jul 2026 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424084; cv=none; b=US8I1obPIGZ13YgPKmV5249djLA2iMAss5hAjrmoKvnIizNvpW+hMQkzoqYjcG3F4hvn2Nyn76U0qQ1vCVoFeFAMY+HeyjpK9M9zBuVJ0TY7bD+zggdZm6bWs1mH/X7Ps7NoBkPNr2f7Fz9cSJbmX7vyz/W0UkZhTfYRLhLKwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424084; c=relaxed/simple;
	bh=KZ5fGIi/ct0u55woCy4dTuVhCotKeYjJSm3AvY24S2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tc09Ai7OIGU9zZwwRXARMfWWhKeCE/faMtWCvUZhRxWJWfm7LphtBxxEEUARTlPjVYKT+2fdExFv1unw08R0zTxYSDEeXe0NFXNtUEWA9eu06KMTwdDnUHyXfyUdxN43B8+EahKfD4CkFiOh26Zk83Ch7Sf+5SFpNr80bSGnMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hgstc5wB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hgstc5wB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHdFM3091356;
	Thu, 30 Jul 2026 15:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=va1LMl
	kkG9vfwyPgpRDGpJCBngVEnhhYzy9Ab2oJKp8=; b=hgstc5wBr3bJ03rc5k6p8O
	0+psU/XuEo7rqUOWdOKtFeuE4fU3KhJgQHe9PsUZHn6QX1tP1m3LTWG/piZBoz+0
	tdHsk/ED1DUj4OTN/LHXMMjQFY8vc2YNnYJQyQ4HWmWfFOGxwQenNPR6d/ISfXYr
	nB5g5Br3o3NrbHbYzEDCphS3L21i+1q6bNbUJAthztP7/XplScHDm6pzMdg0WEA1
	5xB36cowP1ZUN35aPBZKUZAEoi+BnKv/KfqQRAK125D74jI8tmI5ZnFqpVSxCt05
	Nl+Tw7//YbseDqss0bd9oY42ahJ6hVTrI+wnpYOxLE9i3PrMWFbOjQj79RknlFng
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7rdb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 15:07:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEuL2P005698;
	Thu, 30 Jul 2026 15:07:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwc10q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 15:07:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UF7rXj18875134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 15:07:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7BFF58056;
	Thu, 30 Jul 2026 15:07:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C55C05803F;
	Thu, 30 Jul 2026 15:07:52 +0000 (GMT)
Received: from [9.61.176.239] (unknown [9.61.176.239])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 15:07:52 +0000 (GMT)
Message-ID: <98d60643-cf6c-4142-83dc-3612cc1f213c@linux.ibm.com>
Date: Thu, 30 Jul 2026 11:07:52 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/vfio-ap: fix stale pqap_hook pointer on error in
 vfio_ap_mdev_set_kvm()
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex@shazbot.org>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260728162705.2631004-1-akrowiak@linux.ibm.com>
 <20260728164105.4AAC01F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260728164105.4AAC01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XwrEpglIy1-KtR9J6OBO4fwvwd8KgYbE
X-Proofpoint-ORIG-GUID: XwrEpglIy1-KtR9J6OBO4fwvwd8KgYbE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDExMiBTYWx0ZWRfX5uNkmWnnQBDQ
 LCg7WtIRxxMh7lOe32F4mTtkETqK72qsa9prEpYHwdtzw83WTAKS26FW1flWuhbyCTc3cI8IEn2
 U6sx6CAky4L2AcLSnPzCXlgHtm5UYu92jIKmHcn4PCD4R5ASrRiYKBtjzYDx9Iy7lRDVWGGIrUh
 jqXO20oDSk7is1w6DbyZPVRZ4ABbAzIjtpr5ahBltVC333iMdB+tw6mM/9kasYz4GS/cBOGRlTj
 pidm7fWWlzJ5gH6Arvnfs0DQFd6kZ6jtEB/NaX2kLqU9QHAlIPREgflphI2yWdKDEpWPbGZq/81
 WlysGqMCjhPx1HklJcuKdV8qsHuVy9DNY9HSLX9ziili6Mj+F5UGh6s3ZD17aqeZIFhXBXiO1gd
 +EHOv0nqoqRdAxgtLqCc04UXkYt6s5QNA+UJEZQ2q/u7j/+Ryg5EbKpdsKwQvFQ9QAqObf5bjIL
 RMCILfS8XME5TupCTKg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b68cc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SnmR3V4DJBMBAkIxd3wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDExMiBTYWx0ZWRfX8TEztlwVsNPp
 rgae/VSpZJpXCdelEo+WvmsqHk+F8kKitc6ES+VLfn8bi4Wm4Y37TuQPcG/FgvLo0ZXGRSHgjWj
 u3uaLqg/Jma3weH7Xf+6toSs9O2kpzQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300112



On 7/28/26 12:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the `mdev_list` iteration from within the `update_locks` critical section introduces a Time-Of-Check to Time-Of-Use (TOCTOU) race condition between `vfio_ap_mdev_set_kvm()` and `vfio_ap_mdev_unset_kvm()` that silently clobbers KVM APCB masks for a newly attached mdev.
> --
>
> --- Patch [1]: [PATCH v2] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm() ---
> commit 0834fa20c3fb715cac9e1ff09376e43784d44814
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
>
> This commit changes vfio_ap_mdev_set_kvm() to use pqap_hook to detect
> conflicting assignments instead of iterating mdev_list under the update locks,
> resolving a potential stale pointer dereference.
>
> Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification")
> Cc: stable@vger.kernel.org
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b36..b0a038faa93ac 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -1821,26 +1821,25 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>>   static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>>   				struct kvm *kvm)
>>   {
>> -	struct ap_matrix_mdev *m;
>> -
>>   	if (kvm->arch.crypto.crycbd) {
>> +		/*
>> +		 * Taking the kvm->arch.crypto.pqap_hook_rwsem lock while
>> +		 * holding the update locks (below) could result in a
>> +		 * deadlock condition, so let's hold the rwsem here while we
>> +		 * check and update the pqap_hook.
>> +		 */
>>   		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>> +		if (kvm->arch.crypto.pqap_hook) {
>> +			up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>> +			return -EPERM;
>> +		}
>>   		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>>   		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>>   
>>   		get_update_locks_for_kvm(kvm);
> [Severity: High]
> Can this introduce a race with vfio_ap_mdev_unset_kvm()?

After further review, it looks like this is a legitimate concern. As the 
comment
preceding the the code inside of the 'if' block stated, we needed to 
take the
pqap_hook_rwsem lock outside of the update_locks to avoid a deadlock
situation when the pqap_hook is executed. There is no reason, however, that
we can't take the update_locks while holding the pqap_hook_rwsem. The
same thing will have to also be done in the vfio_ap_mdev_unset_kvm
function also.

>
> By moving the conflict check outside of the update_locks critical section,
> is it possible for the following sequence to occur during concurrent
> hot-plug/unplug operations?
>
> Thread 1 (in vfio_ap_mdev_unset_kvm):
>      down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>      kvm->arch.crypto.pqap_hook = NULL;
>      up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>
> Thread 2 (in vfio_ap_mdev_set_kvm):
>      down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>      // Sees pqap_hook is NULL
>      kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>      up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>      get_update_locks_for_kvm(kvm);
>      vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>      release_update_locks_for_kvm(kvm);
>
> Thread 1 (continuing in vfio_ap_mdev_unset_kvm):
>      get_update_locks_for_kvm(kvm);
>      kvm_arch_crypto_clear_masks(kvm);
>
> If Thread 1 interleaves after Thread 2 sets the guest masks but before Thread
> 1 clears them, would this result in Thread 1 unconditionally clearing the KVM
> APCB masks that Thread 2 just successfully configured, leaving the newly
> attached mdev with inaccessible queues?
>
>> -
>> -		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
>> -			if (m != matrix_mdev && m->kvm == kvm) {
>> -				release_update_locks_for_kvm(kvm);
>> -				return -EPERM;
>> -			}
>> -		}
>> -
>>   		kvm_get_kvm(kvm);
>>   		matrix_mdev->kvm = kvm;
>>   		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>> -
>>   		release_update_locks_for_kvm(kvm);
>>   	}
>>

