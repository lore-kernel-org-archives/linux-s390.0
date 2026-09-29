Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082F3A7F7E;
	Tue, 29 Sep 2026 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682100; cv=none; b=cmafat3mW3s5O5bhZnKkbkO1fbqnpAzvb77eoQPTdFPw7Aj7YAOJ3nAd5oMkeF2NgYjA+a/2yrQf59G0zOLeDn5G7WnPGhDYZxweDY21w9cLjTsGeCfKI70ROjtf0U7Wn/0sX0FL220lABhlIXeT0D7ICLTd5BZ5+enj7Aqzbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682100; c=relaxed/simple;
	bh=I8MJcxFshaLmToebzEiE/AfqRYtZfgOkccDv/SdZVOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5vGu8S4wtiGpiklFD5hRlNtNacKB9E/cYhz6wYMNL/6t6oLn4l2o/d1J2B8a1HJ1yFmq/ihLobFuOpXEvVaRCigoz9cVUwI1Y+FlbZbx2IPtBTx8NhcBKYsuIy9ZfeB3OwsD+YHxo0NQYTYfDUgg5X0NxmCenk60PsLNDMU/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SR3PkMks; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SR3PkMks"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5Ybb3836658;
	Tue, 29 Sep 2026 11:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aDEwa2
	bobXQiAvTNgfL86JTzNGxU3hs1hVTUlK5JvVM=; b=SR3PkMksBtEgDMjILBWtd4
	nLLqA9BuIU5tLmxwY1HxAyl6SbcCPkpckGzFvrd6CjAGbl1UYsdMxyxuFNdH9EJH
	Fnscs7tqORjqe9vVFNoYeVWutdGrIhLPAJ+M3YP+2xHsmUnM3ki/chTxqjsGmuwE
	268/BDAB/d54cxu42vuF5+n/QNL80X4xZ+LnClbKHfDHec5xN6/KC/HEsSZ00WYD
	EMZ2Y4S73dSg8BYQDF4cINVP53Kz9nHRuBe9MswmWe+ASgzNN6hIslA1UwEV00r9
	zhoHY8ET9qkx0wvdZprv4qPkG4Lwlwn/7O8ruyiMX/0v6jAhXHCy6oRNxrzTu2bg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk6d2v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:41:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlhrD1608057;
	Tue, 29 Sep 2026 11:41:36 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck9gnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:41:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBfZwB14811648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:41:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DE5158056;
	Tue, 29 Sep 2026 11:41:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1121758054;
	Tue, 29 Sep 2026 11:41:34 +0000 (GMT)
Received: from [9.61.24.130] (unknown [9.61.24.130])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:41:33 +0000 (GMT)
Message-ID: <e4807f54-f443-49df-b6cb-e77d4986dcd9@linux.ibm.com>
Date: Tue, 29 Sep 2026 07:41:33 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] s390/vfio-ap: fix queue state leakage to guest and
 host
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-6-akrowiak@linux.ibm.com>
 <20260925130308.D988B1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260925130308.D988B1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: anjZi5culZ2WQg-bF3bzwydA-fVWITrX
X-Proofpoint-GUID: anjZi5culZ2WQg-bF3bzwydA-fVWITrX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NiBTYWx0ZWRfX6mhn8SBq1qOW
 olGyi/WcNZ8T8Q8whWnatKO3zWrLdTAqRFVDjfb5cKN2HOXLllWXw6fuki88Ynvue8w490ejpXZ
 pSH+mOoxK+IZh7v90OmDmHvm+HO6hAQ=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abba3f1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=af_09KNe_OGDYySOq_oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NiBTYWx0ZWRfX1uxjwkhkOZZX
 bOGPwIZxLW653jawrcfd/LzHPhgFuxb28ESzUvKvJsUwp3PQXA1TgBd4sV97qwXu2yObTvGL3jl
 i3Jvfrfdcx1intE+YssioYFkTngP3Fo/3AQ1x5DbBodY6yfHGU5ldTNBPAH87Rp0u9olIU7x1pJ
 6dJjrMaqfRbDUBIAyx+6hI9A697D3qdwPoRwHmQ3f0d7kIkabkw2zanYLGslLVdWiqSJC6p7HIP
 a+5rQsaqO2oFOnKZh0UudtQLtiJK/C8vcJ4sLoEAezQKaG8IWZ/TAFqd/j8+3rCooB9Nr0a0sHG
 9iuHEB3DBclLyvpOYGQ9zyXnqq02f2yWiFywba9YaYqJCHPtra1jslKeF+q8nf/Tf/sakntBUZ4
 s0UuYY2/liTO/OiYTD35oQ/PeSD3QT3+Z6nitqqmW4e6eJPXNKX05zCGk6YFG3GhnhTBGLg0d7r
 HKXdo/nEQH8jEImqgyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290046



On 9/25/26 9:03 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] crypto: vfio: Use-After-Free of vfio_ap_queue in vfio_ap_on_qstate_transition
> - [High] crypto: vfio: TOCTOU on q->matrix_mdev leads to unprotected KVM state updates and deadlocks
> - [Low] crypto: vfio: Incorrect comment for __drv_notify_qstate_transitioned
> --
>
> commit 6964322bafaab43ec603a04a262b5d1370b6779d
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: fix queue state leakage to guest and host
>
> This patch limits the wait for a queue reset to complete and prevents the
> leakage of queue state to a guest. It introduces an on_qstate_transition
> callback to track queue state changes and restricts queue passability to
> fully zeroized states.
>
> Cc: stable@vger.kernel.org
>
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index d82df5b4e2db3..a53cfad3543eb 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
> [ ... ]
>> @@ -1979,6 +1979,28 @@ static inline void notify_scan_complete(void)
>>   			 __drv_notify_scan_complete);
>>   }
>>   
>> +/* Helper function for notify_config_changed */
>> +static int __drv_notify_qstate_transitioned(struct device_driver *drv, void *data)
> [Severity: Low]
> Is this comment accurate? It states this is a helper function for
> notify_config_changed, but the function name and usage indicate it is a
> helper for notify_qstate_transitioned.

This will be fixed ion the forthcoming v9 patch series

>
>> +{
> [ ... ]
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index ffc2d8715bd96..cd4a436c43194 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -3309,3 +3310,46 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
>>   
>>   	mutex_unlock(&matrix_dev->guests_lock);
>>   }
>> +
>> +/**
>> + * vfio_ap_on_qstate_transition:
>> + *Instead of calling vfio_ap_find_queue() without locks and reading q->matrix_mdev, vfio_ap_on_qstate_transition() now calls get_update_locks_by_apqn(apqn)
>> + * AP bus callback notifying the vfio_ap device driver that the state of a
>> + * queue has transitioned.
>> + *
>> + * @qstate_trans: the object containing a reference to the queue device and the
>> + *		  state to which it transitioned.
>> + */
>> +void vfio_ap_on_qstate_transition(struct ap_qstate_transition *qstate_trans)
>> +{
>> +	struct vfio_ap_queue *q = vfio_ap_find_queue(qstate_trans->queue->qid);
>> +	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>> +
>> +	/*
>> +	 * If the queue is not bound to the vfio_ap device driver, then it won't
>> +	 * be passed through to a guest; so, no need to continue.
>> +	 */
>> +	if (!q)
>> +		return;
>> +
>> +	get_update_locks_for_mdev(q->matrix_mdev);
> [Severity: High]
> Can this dereference a freed pointer?
>
> If vfio_ap_find_queue() reads the device's drvdata and drops the device
> reference before returning, q has no reference count. Because
> vfio_ap_on_qstate_transition() holds no locks, a concurrent sysfs unbind
> can invoke vfio_ap_mdev_remove_queue(), which clears drvdata and calls
> kfree(q).
>
> This would cause a use-after-free when reading q->matrix_mdev.
>
> Additionally, is there a TOCTOU race when reading q->matrix_mdev without
> locks?
>
> If q->matrix_mdev is NULL here, get_update_locks_for_mdev() will skip
> acquiring kvm->lock. If another thread concurrently updates q->matrix_mdev
> to a non-NULL value while waiting on guests_lock, this could lead to issues
> later in the function.

This is a legitimate concern.
Instead of calling vfio_ap_find_queue() without locks and reading 
q->matrix_mdev,
matrix_mdev = get_update_locks_by_apqn(apqn) can be used since the apqn 
can be
obtained from qstate_trans->queue->qid. get_update_locks_by_apqn() 
acquires matrix_dev->guests_lock, searches matrix_dev->mdev_list for the 
mdev that owns the apqn, acquires matrix_mdev->kvm->lock (if attached to 
a guest), and finally acquires matrix_dev->mdevs_lock. Lookup of q via 
vfio_ap_mdev_get_queue() is done entirely under the protection of all 
three locks, completely eliminating the UAF and TOCTOU races.
>
>> +
>> +	switch (qstate_trans->new_state) {
>> +	case AP_QUEUE_CONFIG_ON:
>> +	case AP_QUEUE_CHKSTOP_OFF:
>> +		vfio_ap_mdev_reset_queue(q);
>> +		flush_work(&q->reset_work);
> [Severity: High]
> Does this also cause a use-after-free for the same reason? Passing the
> potentially freed queue object to vfio_ap_mdev_reset_queue(q) and flushing
> its work struct could trigger further memory corruption.

As stated above, using matrix_mdev = get_update_locks_by_apqn(apqn) should
also resolve this issue. If q is retrieved from matrix_mdev under
mdevs_lock, and vfio_ap_mdev_remove_queue() requires mdevs_lock to unlink
and free q, q is guaranteed valid throughout the reset and
flush_work(&q->reset_work) sequence.

>
>> +
>> +		if (q->matrix_mdev) {
>> +			if (vfio_ap_mdev_filter_matrix(q->matrix_mdev, apm_filtered)) {
>> +				vfio_ap_mdev_update_guest_apcb(q->matrix_mdev);
> [Severity: High]
> If q->matrix_mdev changed concurrently after get_update_locks_for_mdev()
> was called, could this update the KVM guest state without having acquired
> the proper KVM locks?

As stated above, using matrix_mdev = get_update_locks_by_apqn(apqn) should
also resolve this issue. If an mdev is attached to a guest
(matrix_mdev->kvm != NULL), kvm->lock is held. All matrix filtering,
APCB updates (vfio_ap_mdev_update_guest_apcb()), and queue resets operate
strictly on the locked matrix_mdev handle, with no unprotected pointer
re-reads.

>
>> +				reset_queues_for_apids(q->matrix_mdev, apm_filtered);
>> +			}
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +Instead of calling vfio_ap_find_queue() without locks and reading q->matrix_mdev, vfio_ap_on_qstate_transition() now calls get_update_locks_by_apqn(apqn)
>> +	release_update_locks_for_mdev(q->matrix_mdev);
> [Severity: High]
> If q->matrix_mdev was modified between the initial acquisition and here,
> would this call mutex_unlock() on a lock it did not acquire, or leave
> an acquired lock perpetually locked?

As stated above, using matrix_mdev = get_update_locks_by_apqn(apqn) should
also resolve this issue. At the exit point, the locks can be freed with
release_update_locks_for_mdev(matrix_mdev), passing the exact same
matrix_mdev that was locked by get_update_locks_by_apqn(). This guarantees
100% symmetry between lock acquisition and release under all execution
paths.

>
>> +}

