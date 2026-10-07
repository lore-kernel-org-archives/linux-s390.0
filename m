Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE43D6690;
	Wed,  7 Oct 2026 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409802; cv=none; b=nOqAPf3WAuw46qDxe6LiQUQ0ZwXckNvWfqIUyBidOdTJ6g5oqNILEcGL55L5pgEgEa5vG5Bb9Vhe26AFAC23iVb2pLumTUBeqnW+yOU6Zw94kF6cLxqG1kd/wTS3bNSdjpYKZWMgf8lzsOIln2GmYBLu7H8k/xL8EyLY2ddn7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409802; c=relaxed/simple;
	bh=/GC6QauhpyYqXDU3b3DCofG+sF1iN/cvT2by7GGEi9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZvhAC/DWGbAsL1zTT/NXOSKa2wWVbbLBOhF0y/dt8GPFgyyxJfY9PyOZz1ZDK7gMPtsFJ8i83cPCt/CZEpUe8qOZpM5y3My4ZCXTX1VzzOtGqBVbmBz7fjkJzWtVdKRstAmqiwNgJajtg7bVV8iUwNrRq3IuoHR7D1360FpIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cZeIDxDd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cZeIDxDd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697LZUjZ3628784;
	Wed, 7 Oct 2026 21:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UcX2zV
	kYeiN/yci9+ngSsc7wJ65G2UirwwZaxntU2pQ=; b=cZeIDxDdmpVCeyL+zDud3f
	ZlwAN1LIpV034efm2BR1BGvAgzz+qpADrjsGW536sWe6LKjuM31san5qH4BY/JH7
	UnYmjh96Wb2QfldXFfmZu9eA2nZSmX09sOUVyJ2m1HH6duqCPUH9VY4KU9tZRiVr
	k4dprLZlD3oQFn7lVzxHKGLHns62sq1yqp78WRpdzzSDj4Ehi9YjatsqaXhsOXvi
	1QRJ6d7psNOsdyMB4SNsYzhKs/at/AiJNusfHI5XtwWPxoRFrVVE7LReFxfXl54P
	AuUeEhjT09bY/707knHccSVga+MHIgF648hJ6baq4pSnhE8b00AWI/imCUTV9tzw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5r2y7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 21:49:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697LlOLF2476247;
	Wed, 7 Oct 2026 21:49:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s34s95y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 21:49:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Lnvi37144442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 21:49:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1E6C58055;
	Wed,  7 Oct 2026 21:49:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21E095804B;
	Wed,  7 Oct 2026 21:49:57 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 21:49:57 +0000 (GMT)
Message-ID: <14a9fc54-d1be-47dc-8f60-5e99c44f8ddf@linux.ibm.com>
Date: Wed, 7 Oct 2026 17:49:56 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-4-akrowiak@linux.ibm.com>
 <20260807223840.4FCA41F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807223840.4FCA41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4NiBTYWx0ZWRfX3AKLNrHhPTON
 QtQsUFczSqz8Mg63HWPYmHBkQLfQ+4QUfVwlCIOEx3nSiA2GnLH4WDJ8fNhPpFng6dq1fyBfDhW
 sFEKlGe/63R2KRICdte6ea4g9SZ2Yck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4NiBTYWx0ZWRfX1xvg8OaFZGX/
 OYk1e1d/jnQ1mNKfIhLLqtRbGS4CM4NJZbIbxfyZ7q4jmBFl5Lo51UFSb1miK5Rus8Vyo8I8p3V
 4gYgcS+tZp2Dx77ZEy1v01tU/58zogaGRFQm60g8monJ3gX3if5QkNFr7V/ZgNQKNV2874d4ZxP
 N8WA55nqMVcTuoprODFH7C0bDul6L3jAXO7mWAujoFfcorrb15HlhXqGsjBG/7nvmyhXlc/gqRO
 A0+4RJG+KbcDoUmpU+YjLv/t9Uzqhb3gqeu77WaFg5c6KwEYwRbDNGinwnGx0wrXcz812R+f8ol
 734mI54GOh+roYFNFowG4Wmsxkhy6aaAnfOHen6oewKZ2gmM/H901OjAexJZZGomao38BoRW+J7
 Q64n2ni0Rmvgi4GiyEFOsM0GXZbnqXFkdU/SlEGxAy8WBL/he1sWU0vWSmAoPJTxLjTVJRg6eJ3
 ez6WSq0yCaca8qePbsQ==
X-Proofpoint-GUID: iTXmfkd1I1UQyNPAUkABhtlxNnRUmvD7
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac6be87 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=uomwIFa1Vr5aimEL9vgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iTXmfkd1I1UQyNPAUkABhtlxNnRUmvD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070086



On 8/7/26 6:38 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review fosund 4 potential issue(s) to consider:
>
> New issues:
> - [High] The patch exposes the VFIO_MIGRATION_STOP_COPY capability to userspace before the actual migration data transfer logic is implemented, causing silent migration failures.
> - [High] An open migration FD can access a newly allocated migration session if the VFIO device is closed and reopened, bypassing the intended `NULL` check.
>
> Pre-existing issues:
> - [High] Unconditional NULL assignments to `req_trigger` and `cfg_chg_trigger` in `probe` can overwrite valid eventfd contexts set by concurrent ioctls, causing a memory leak and breaking interrupts.
> - [High] The mediated device is exposed to userspace before it is fully initialized and added to the driver's tracking lists, allowing multiple mdevs to attach to the same KVM guest.
> --
>
> --- Patch [3]: [PATCH v7 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data ---
> commit 04c1b466fec62cf9e53c2d6610cde9ecbf5fefad
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Functions to initialize/release vfio device migration data
>
> This commit provides the initialization and release functions for the data
> structures used during live guest migration of vfio-ap devices. It introduces
> stubs for the migration operations that will be fully implemented in
> subsequent patches.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 374d3a67cb214..cf303d228a0a5 100644s
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
>> +				      enum vfio_device_mig_state  new_state)
>> +{
>> +	return NULL;
>> +}
> [ ... ]
>> +void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	if (ap_is_se_guest())
>> +		return;
>> +
>> +	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
>> +	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
>> +}
> [Severity: High]
> Will advertising the VFIO_MIGRATION_STOP_COPY capability to userspace before
> the actual migration data transfer logic is implemented cause silent failures?
>
> If vfio_ap_set_state() returns NULL for the VFIO_DEVICE_STATE_STOP_COPY
> transition, won't the VFIO core interpret this as a successful transition
> that does not require a data stream? This could cause QEMU to silently
> succeed on the source side without transferring any device state, leaving
> the AP subsystem broken for the guest on the target side.

This is just one of a series of 15 patches that implement VFIO migration of
vfio-ap devices. The rest of the series fills in the blanks.

>
>> +/**
>> + * vfio_ap_release_mig_files:
>> + *
>> + * Free the ap_config buffers for any open migration FDs. Although a
>> + * migration FD may still be held open by userspace, it is safe to free
>> + * mig_data here because:
>> + *
>> + *   1. matrix_mdev remains valid for the lifetime of any open migration
>> + *      FD via the vfio_device registration reference taken in
>> + *      vfio_ap_open_file_stream() and dropped in
>> + *      vfio_ap_release_mig_file().
>> + *
>> + *   2. mig_data is only accessed by the migration file ops
>> + *      (vfio_ap_stop_copy_read, vfio_ap_resuming_write) under
>> + *      mdevs_lock. Once mig_data is set to NULL by the caller, those
>> + *      paths will see NULL and return -ENODEV before dereferencing it.
>> + *
> [Severity: High]
> Does this lifecycle design handle the case where the VFIO device is closed
> and reopened while a migration FD is kept open?
>
> If userspace keeps the migration FD open, closes the VFIO device, and then
> reopens it, vfio_ap_mdev_open_device() will allocate a new mig_data. When the
> old migration FD subsequently performs read or write operations, won't it
> bypass the NULL check and incorrectly access the mig_data belonging to the
> new session?

This patch (03/15) introduces the initialization and teardown functions
for the migration lifecycle, while subsequent patches in the series
implement the full data streaming operations and validation checks:

- Patch 07/15 ("s390/vfio-ap: File ops called to save the vfio device
   state") implements validate_stop_copy_read_parms().
- Patch 10/15 ("s390/vfio-ap: File ops called to resume the vfio device
   state") implements validate_resuming_write_parms().

In those handlers, both read and write operations verify under mdevs_lock
that the passed struct file * matches the active migration stream
pointer for the current session (mig_data->stop_copy_mig_file.filp or
mig_data->resuming_mig_file.filp).

When the device is closed and reopened, open_device allocates a fresh
mig_data with NULL file pointers. If a stale migration FD from a
previous session attempts to perform read or write operations, the
equality check against the current session's filp fails (-EINVAL or
-ENXIO), safely preventing access to the new session's mig_data.

>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 36786d70a88f5..90b0fce0123b5 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -797,13 +809,28 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
>>   	if (IS_ERR(matrix_mdev))
>>   		return PTR_ERR(matrix_mdev);
>>   
>> +	/*
>> +	 * Migration capabilities must be initialized before calling
>> +	 * vfio_register_emulated_iommu_dev; otherwise, the VFIO core
>> +	 * will see mig_ops as NULL during the registration. This could
>> +	 * prevent the VFIO core from properly setting up migration
>> +	 * infrastructure like debugfs entries.
>> +	 *
>> +	 * This must be done before acquiring mdevs_lock to avoid an ABBA
>> +	 * deadlock: vfio_register_emulated_iommu_dev() acquires dev_set->lock
>> +	 * internally, while vfio_ap_mdev_open_device() is called by the VFIO
>> +	 * core with dev_set->lock already held and then acquires mdevs_lock.
>> +	 */
>> +	vfio_ap_init_migration_capabilities(matrix_mdev);
>> +
>>   	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
>>   	if (ret)
>>   		goto err_put_vdev;
>> +
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>>   	matrix_mdev->req_trigger = NULL;
>>   	matrix_mdev->cfg_chg_trigger = NULL;
> [Severity: High]
> This is a pre-existing issue, but does exposing the device to userspace
> before setting these triggers to NULL introduce a race condition?
>
> If userspace immediately opens the device after
> vfio_register_emulated_iommu_dev() and configures interrupts, it will
> allocate and set valid eventfd contexts for req_trigger and cfg_chg_trigger.
> When the probe thread continues and overwrites these with NULL, won't it leak
> the eventfd contexts and break guest interrupts?

This was fixed with commit 7fa61c29850d in response to this same comment
in another review. 7fa61c29850d

>
>>   	dev_set_drvdata(&mdev->dev, matrix_mdev);
>> -	mutex_lock(&matrix_dev->mdevs_lock);
>>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
> [Severity: High]
> This is also a pre-existing issue, but does calling
> vfio_register_emulated_iommu_dev() before list_add() allow multiple mediated
> devices to attach to the same KVM guest?
>
> If two mdevs are probed and opened concurrently before they are added to
> mdev_list, won't they bypass the conflict detection logic in
> vfio_ap_mdev_set_kvm() and violate KVM uniqueness invariants?

This will be fixed with a standalone patch since it is not related to this
series.

>

