Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E83B38B9;
	Tue, 29 Sep 2026 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689107; cv=none; b=F4RFuw2sfc+4cZQkkXbSq5KCmx0droGYVb1cp/hqw1eJHvwBQQvJS1eP28ipkMgkbGUqRd3DFZkbDg32YR6HWjfIRUATGXG1FdccoKcOs81h0/sh1POcyJED/9QSb4qKyWPucZQwp4toys5eIlfrrftO0SgEZV3J98FemzOcVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689107; c=relaxed/simple;
	bh=LiTZ2CqzUEmT2+U5pU37fEvQKbAwfuMhEfoTh3UgvII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tI/xR7BHXZ2IEFcUyiClZI6ecQEJF5tAf5Y4QErqi43TWjptpn6ajidgfkd80YTFM6f5+52aEGbLWs0Uhu89YAd6z/qoOmwBOZQCnEJ6DM8Z01NucvE2JPacE8mMNUPCARNDszP1Yka/G786H7jLYqeIJjiO8x9/Dwncd5RPK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NqA+B+IL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NqA+B+IL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5YUE2187974;
	Tue, 29 Sep 2026 13:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+x5SJn
	easI6AK27aTC2+v3wSsY8o47SiNhlvYQVxad0=; b=NqA+B+ILRAk0qDlfE8GnXJ
	PPHsVt4DB2fZ33maZpsz7yhIPwmKvdtQYLXExfYlzVXT+byJ27bIvLDcSFVTELen
	/QoQ4pqxGASD/hZwpYz01iIAzqVrST80xTxGDowwy+AhQav8GrN4o6o3HzxbzOny
	o1lozP/v6xh1aYEbbn7WLgzlJmt+JUJbxMAfm++y5JuSg0XwuBI2wzfXdHdnc6jj
	dR5h8AsBZnFdo49TKDeMzWCm9S9eqlppEyh52W2dqXwKOlWwWfteKQZxqTLt6Tn2
	jgoOljnjw0aIYE/ehqzS2C1zIYCBgggGMCDrh7z6i2+nvuaqzPGTaCHgFHVhg5Hg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr788k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 13:38:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAm2fl1617536;
	Tue, 29 Sep 2026 13:38:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrwa1fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 13:38:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TDcM6E26804852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 13:38:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21DA658056;
	Tue, 29 Sep 2026 13:38:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8718D5803F;
	Tue, 29 Sep 2026 13:38:21 +0000 (GMT)
Received: from [9.61.162.12] (unknown [9.61.162.12])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 13:38:21 +0000 (GMT)
Message-ID: <23656c81-a31b-408c-9f1f-d066a58c6192@linux.ibm.com>
Date: Tue, 29 Sep 2026 09:38:21 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/6] s390/vfio-ap: Fix leaks of pinned NIB and
 registered GISC
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
 <20260929121837.2715710-2-akrowiak@linux.ibm.com>
 <20260929123327.D24FE1F0089A@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260929123327.D24FE1F0089A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX3fZS5wgC8vZa
 OpBr5xKnclaInC+f0wlolUccxZ+zeW8mtbgQtEksahOn9NzgxY9pNa579DQY3J9dm/D7JaC8JWo
 OScr6hYhDzSH3PMb7BUf/xFP/FxNk+/fkNwRCW1GahR1hsfUtvMp5wZiaeRhzUvU+rUTyy+9HNM
 YwB6vcxP5Ut/JSuen912ngaA1i6EI/NJC7nqg47GwyxB8oPX/+MoTQOndbut9tgdhcmvrEW6O+q
 rHvC4diTx6m02wJwoXifqUXcooJASqwmR+ZWVHnD5WZomhXDWmw3G77BRwy5mqHnNBRcuNE2pQk
 ShXb7+CqFUv8fuP1afd+WmtxMCVMyS7+8S/iNjrhscWO6lbZtScqMDOmC6ov4JrZBfsGJQPrfIX
 etgrnOYno1TpLHYw4q3zKjbYQhmDdD4lwMPfwYpgDZPdR8muGVvHUHG9ozwSCcmXlhr8Li02AiK
 v8aNtMxf08Np8EzQwGw==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abbbf50 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rORQQuJ1QDlRwYwXYLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LI-rj9vcVDm8Zrs-3UCkTbKFMHbJ-pVe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfXxlrgQX3+CFvK
 Szz8gHjs2JkmqJWXUhdPEvFILKYqfM37d1hr20/z2jYSRZTSe/zSvHbWYq8epq22ecGFUYUw6CO
 g6mM/jdBDjEMc6rlchk8TZJ9qIg3TnA=
X-Proofpoint-GUID: LI-rj9vcVDm8Zrs-3UCkTbKFMHbJ-pVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290054



On 9/29/26 8:33 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] vfio_ap: Use-After-Free of vfio_device on AQIC resource release
> - [High] vfio_ap: ABA pointer aliasing causes unintended KVM GISC unregistration
> - [High] vfio_ap: Host panic due to VFIO BUG_ON when queue reset fails during unmap
> - [Medium] vfio_ap: KVM GISC alert reference leak on dynamic queue unplug
> --
>
> commit 83f84bb0e3c067b95ee373106f589b768094e294
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> Subject: s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
>
> Several code paths in the vfio_ap driver failed to free the AQIC resources,
> specifically the pinned guest NIB page and the registered guest ISC used to
> enable interrupts for a queue. This commit adds fixes to handle response
> codes and prevent memory exhaustion and depletion of KVM interrupt subclass
> registrations during dynamic AP reconfiguration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 4db878c18f41c..e178b657faa8f 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -254,90 +276,231 @@ static void vfio_ap_wait_for_irqclear(int apqn)
> [ ... ]
>>   static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
>>   {
>>   	if (!q)
>>   		return;
>> -	if (q->saved_isc != VFIO_AP_ISC_INVALID) {
>> -		if (!WARN_ON(!q->matrix_mdev) && q->matrix_mdev->kvm)
>> -			kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
>> -		q->saved_isc = VFIO_AP_ISC_INVALID;
>> +
>> +	if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID) {
>> +		if (q->aqic_resources.kvm &&
>> +		    q->matrix_mdev && q->aqic_resources.kvm == q->matrix_mdev->kvm) {
>> +			kvm_s390_gisc_unregister(q->aqic_resources.kvm, q->aqic_resources.isc);
> [Severity: High]
> Can this equality check fall victim to an ABA problem? If the original guest's
> struct kvm is freed and a new guest's struct kvm is allocated at the exact
> same memory address, could this evaluate to true and mistakenly unregister
> the new guest's GISC, silently stopping its AP interrupts?

Not valid. `vfio_ap_mdev_set_kvm()` takes a `kvm_get_kvm()`
reference before storing the pointer, so the struct cannot be
freed while the mdev holds it. `vfio_ap_mdev_unset_kvm()` sets
`matrix_mdev->kvm = NULL` before dropping the ref, so by the
time the struct could be freed the comparison cannot be true.

>
> [Severity: Medium]
> If a queue is hot-unplugged from a running guest via sysfs and the reset
> fails, the AQIC resources are intentionally leaked and q->matrix_mdev is set
> to NULL. If the queue recovers later, will bypassing
> kvm_s390_gisc_unregister() permanently leak the KVM GISA alert reference for
> the still-running guest?

Not valid. `kvm_s390_gisa_destroy()` zeroes `gi->alert.mask`
and sets `gi->origin = NULL` on guest teardown. After that,
`kvm_s390_gisc_unregister()` returns -ENODEV harmlessly. The
KVM teardown path cleans up the GISC registration regardless
of whether vfio-ap explicitly calls unregister.

>
>> +		} else {
>> +			report_gisc_unregister_failure(q);
>> +		}
>> +		q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
>> +		q->aqic_resources.kvm = NULL;
>>   	}
>> -	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
>> -		vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
>> -		q->saved_iova = 0;
>> +
>> +	if (q->aqic_resources.iova) {
>> +		if (q->aqic_resources.vdev)
>> +			vfio_unpin_pages(q->aqic_resources.vdev, q->aqic_resources.iova, 1);
> [Severity: Critical]
> Is it possible for the q->aqic_resources.vdev pointer to become dangling here
> if the original matrix_mdev was destroyed? If a queue reset failed previously
> and the resources were kept leaked, the queue would retain the unreferenced
> vdev pointer while the matrix_mdev is freed. Could a subsequent reset or
> reassignment trigger a use-after-free when dereferencing it for
> vfio_unpin_pages()?

Not valid in practice. `vfio_ap_mdev_remove()` flushes all
reset work before calling `vfio_put_device()`, so
`vfio_ap_free_aqic_resources()` — the only site that
dereferences `vdev` — always completes before `matrix_mdev`
is freed. No reachable path calls it on a detached queue.

>
>> +		else
>> +			pr_warn_ratelimited("APQN %02x.%04x: Failed to unpin NIB page at %pad\n",
>> +					    AP_QID_CARD(q->apqn),
>> +					    AP_QID_QUEUE(q->apqn),
>> +					    &q->aqic_resources.iova);
>> +		q->aqic_resources.iova = 0;
>> +		q->aqic_resources.vdev = NULL;
>>   	}
>>   }
> [ ... ]
>> @@ -489,27 +658,48 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>>   	status = ap_aqic(q->apqn, aqic_gisa, h_nib);
>>   	switch (status.response_code) {
>>   	case AP_RESPONSE_NORMAL:
> [ ... ]
>>   		vfio_ap_free_aqic_resources(q);
>> -		q->saved_iova = nib;
>> -		q->saved_isc = isc;
>> +		q->aqic_resources.iova = nib;
>> +		q->aqic_resources.isc  = isc;
>> +		q->aqic_resources.vdev = &q->matrix_mdev->vdev;
> [Severity: Critical]
> Does this code need to acquire a lifecycle reference to the vdev pointer
> before storing it here? Snapshooting the embedded pointer from matrix_mdev
> without taking a reference appears to expose the use-after-free discussed
> above if the mediated device goes away.

Not valid in practice, same reason as Comment 3. Taking a
vfio ref would also be wrong: `vdev` is embedded in
`matrix_mdev`, so holding a ref while resources are
intentionally leaked would prevent the mdev from ever being
freed — introducing a new leak.

>
>> +		q->aqic_resources.kvm  = q->matrix_mdev->kvm;
>>   		break;
> [ ... ]
>> @@ -1857,8 +2046,29 @@ static void unmap_iova(struct ap_matrix_mdev *matrix_mdev, u64 iova, u64 length)
>>   	int loop_cursor;
>>   
>>   	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
>> -		if (q->saved_iova >= iova && q->saved_iova < iova + length)
>> +		if (q->aqic_resources.iova >= iova && q->aqic_resources.iova < iova + length) {
>>   			vfio_ap_irq_disable(q);
>> +			/*
>> +			 * If AQIC disable was unable to confirm that interrupts were
>> +			 * disabled (IR=0), q->aqic_res.iova remains non-zero. VFIO
>> +			 * core requires the mapped pages to be unpinned during DMA
>> +			 * unmap notifications (or type1 IOMMU will BUG_ON after 10
>> +			 * retries).
>> +			 *
>> +			 * To satisfy VFIO core safely, fall back to a queue reset via
>> +			 * ZAPQ. ZAPQ wipes the queue state and clears the hardware's
>> +			 * internal NIB address register, neutralizing pending DMA.
>> +			 *
>> +			 * Flush the reset worker. If the reset completes, the worker
>> +			 * frees the AQIC resources (unpinning the NIB). If the reset
>> +			 * times out or fails with an error, the resources are kept
>> +			 * leaked to guard against wild DMA writes.
>> +			 */
>> +			if (q->aqic_resources.iova) {
>> +				vfio_ap_mdev_reset_queue(q);
>> +				flush_work(&q->reset_work);
>> +			}
> [Severity: High]
> If the queue reset times out or fails with an error, the NIB page is kept
> leaked and remains pinned. Since the VFIO core requires all mapped pages to
> be unpinned during an unmap notifier, could returning to the VFIO core from
> unmap_iova() without unpinning the page trigger a BUG_ON or WARN_ON and panic
> the host kernel?

Valid. If both `vfio_ap_irq_disable()` and the ZAPQ fallback
fail, `unmap_iova()` returns with `aqic_resources.iova`
non-zero. `vfio_iommu_type1.c:1522` hits
`BUG_ON(++retries > 10)` — a real host panic. Fix: add a
last-resort forced unpin with a `pr_crit` after `flush_work()`
when the ZAPQ also fails to release the NIB.

>
>> +		}
>>   	}
>>   }

