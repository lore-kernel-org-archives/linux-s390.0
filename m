Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD104A2E21;
	Tue,  4 Aug 2026 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873110; cv=none; b=KtPzz0IRzmX+SzddTm0hbsVdGjwke7UB86OsbO1pEMqdMcy1YuUjiRrCIVmU8kRsJecxbfVrZuYihyMs6YqE8s8tPP6yzmv7Y+WZNrDnh3uDjOhh0cWeus1LRbwVsYBU+f/Qr0qzEN+zKtqEYmYRvp+L+ZmjAgHqBtesL1/jtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873110; c=relaxed/simple;
	bh=1Uuuk+S8hoMjS9Iw/nDVc7ox5NoV9V6599gs3OplepI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKUPpAYTubRyA7CgPxdxqjAbfd5uynIHjrOB4W21GnKx3E7tpb4VhlzvvOhadAg47P69xhz81LoWPRdOZZ5SM5eKcNiJqZHN5pyS6+yBL9RZgNq4Bfj1rYmUjgZDqsVqvtr74FJfWM096/tQYiaHlf0sQiwUeN86abxa6Iuk0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pbsbVDU+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pbsbVDU+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Jml3T1773571;
	Tue, 4 Aug 2026 19:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M3f69J
	vm8627cjJ5qEDX922ZbHZwoJMW1aPYDX1oHTg=; b=pbsbVDU+WMUoCXhuR4F0ob
	/iE5pW10WYY29NxIeyNDn6Oe5SQzQOWqXg0eCF5W85lvztkTdiy+L2LWNAF5Tphx
	JN0CspTi3bdZlhS35CFzfus14BbYNHByJG6U3ceoN9sBfruLg594OyIxGSc/nfCM
	kI5gTz/fL+3eEst7+XOjLRSBwmWJmyCQMHbQZ11adJ1AFAmbz43yIA77B+xpnzMn
	JTcmN5woixB3N6hM5h35trSUpk4+UYrwD50MXKPGCAKhx2ZLNKBPWL3jIhV/wZVJ
	Z4wHkocL3rah5aakjj9tBnEQweeHLui2z7VyKcbcNsAK+XvZ721Llja1KiHuLQpQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3yqex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 19:51:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674Jfr5k005472;
	Tue, 4 Aug 2026 19:51:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyk9k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 19:51:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674Jpjw317367802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 19:51:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7005E58058;
	Tue,  4 Aug 2026 19:51:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA8C158057;
	Tue,  4 Aug 2026 19:51:44 +0000 (GMT)
Received: from [9.61.89.119] (unknown [9.61.89.119])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 19:51:44 +0000 (GMT)
Message-ID: <06a98578-0e90-45e3-95a2-a12438fc87f3@linux.ibm.com>
Date: Tue, 4 Aug 2026 15:51:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-4-akrowiak@linux.ibm.com>
 <20260727174809.30A0A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727174809.30A0A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7242d4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=z82NC1E6CsTnWYpM1UEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S9SE49wtygmooSvXR1ol8r9tiGt9IhE6
X-Proofpoint-GUID: S9SE49wtygmooSvXR1ol8r9tiGt9IhE6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MCBTYWx0ZWRfX22Igr0u+gwdT
 S4VpjfMkgQ0BOfKVJ4u24j/PZxz1LJKgP9oTkV17LF+N2I5qa6NpANoR5JCi0Prz5ca7YmVg64i
 nwKsslMQeUrHHkUcgPYwtrW7z+os/I8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MCBTYWx0ZWRfX4uka+z/sOvd/
 45V8dJcUydTLUgVBx2fO413z/JFpMxrEnoN3TmCdmZLYswndG6AVuVpxg+2Yf9bVshNHMa+rapG
 6YcC+vR+gje5Sa4Yxy4KH4QXhhBBkzwAO+YF5+mBMDdm1tqMFMDYt+ldvyNrbpr9+eQ+GAfOH7+
 NLylV2i6EeaLEbONfKUvSkFyLyJEZBJJRx1By9C9fQGXxuj95tBefmhKYs29YsLNl77jImH9yeh
 I0Xt9emlpr8DFWLz+pfmbc7/gc7nYHNjKzPlEt+xPCW9JaY77YvECTHcn3U+5/r49uhsG18/nIr
 7b0sC2WwTS1ta9UsihgeWS2y+vyeDDStsEVo9xtIRgnYsmH4rV0EwwYexIfRYGOET/4ZncgbP/W
 RwmrO5GvnMMDWmPPJYm6mCaoO8a6eIhMm8KLU9DdhSGOfaGSgFAv3Zwj+krzTnTzk9vXJpM3n97
 ejzYe89p4dYa1oru86Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040160



On 7/27/26 1:48 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] The driver prematurely exposes the VFIO migration capability to userspace while only providing stub implementations that silently pretend to succeed.
>
> Pre-existing issues:
> - [High] The eventfd contexts for `req_trigger` and `cfg_chg_trigger` are leaked when the matrix mdev is removed or the device is closed.
> - [Medium] In `vfio_ap_mdev_probe()`, the device is exposed to userspace before `req_trigger` and `cfg_chg_trigger` are initialized, allowing them to be clobbered by a concurrent ioctl.
> --
>
> --- Patch [3]: [PATCH v6 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data ---
> commit faa8a565ea108d20c1807c07fbe1be6336a97435
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Functions to initialize/release vfio device migration data
>      
> Provides the functions that initialize and release the data structures
> used during live guest migration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index fc3b2e154ad8b..ae0bd1f415feb 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
>> +				      enum vfio_device_mig_state  new_state)
>> +{
>> +	return NULL;
>> +}
> [Severity: High]
> Does returning NULL unconditionally here trick the VFIO FSM into believing the
> state transition succeeded immediately without actually transferring any data?

This is only a stub function here because the vfio_ap_migration_ops are set
in the vfio_device mig_ops object in the 
vfio_ap_init_migration_capabilities (below).
This function is fully implemented in patch 05/15. This patch series 
implements
in a stepwise manner to limit the functionality presented in each patch 
to make
it easier to understand and review the patches.

>
> [ ... ]
>
>> +void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	if (ap_is_se_guest())
>> +		return;
>> +
>> +	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
>> +	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
>> +}
> [Severity: High]
> Since the state transition operations like vfio_ap_set_state() currently just
> return NULL, does advertising the VFIO_MIGRATION_STOP_COPY capability here
> prematurely expose an incomplete migration implementation to userspace, which
> could result in broken live migration and guest data corruption?

No. This follows directly from the response above; migration is not possible
until the entire patch series is applied. Setting migration_flags to
VFIO_MIGRATION_STOP_COPY indicates that STOP,  STOP_COPY and RESUMING
are supported which will be the case going forward. As the subject line 
implies,
the purpose of this patch is limited to initializing the vfio device 
migration data.

>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 36786d70a88f5..90b0fce0123b5 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> +static void vfio_ap_mdev_release_dev(struct vfio_device *vdev)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
>> +	vfio_ap_release_migration_data(matrix_mdev);
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +}
> [Severity: High]
> This isn't a bug introduced by this patch, but does vfio_ap_mdev_release_dev()
> fail to put the req_trigger and cfg_chg_trigger eventfd contexts?
>
> If they are also not cleaned up in vfio_ap_mdev_close_device(), could this
> allow a user to systematically leak kernel memory by repeatedly opening the
> device, configuring IRQs, and closing it?

This is a legitimate observation. It will be fixed with an individual 
fix patch
unrelated to this series.

>
> [ ... ]
>
>>   	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
>>   	if (ret)
>>   		goto err_put_vdev;
>> +
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>>   	matrix_mdev->req_trigger = NULL;
>>   	matrix_mdev->cfg_chg_trigger = NULL;
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does assigning NULL to
> req_trigger and cfg_chg_trigger here risk clobbering valid pointers?
>
> If a concurrent ioctl configures the triggers via VFIO_DEVICE_SET_IRQS
> immediately after the device is exposed via vfio_register_emulated_iommu_dev(),
> but before we acquire mdevs_lock here, could we overwrite the initialized
> triggers and leak the eventfd contexts?

The trigger assignments in vfio_ap_set_request_irq and
vfio_ap_set_cfg_change_irq are only reachable via vfio_ap_mdev_ioctl,
which is only callable after open_device succeeds. open_device calls
vfio_ap_init_migration_data which requires the device to be registered
and opened — that open hasn't occurred yet at probe time. The window
between vfio_register_emulated_iommu_dev and the NULL assignments exists
but no ioctl path can reach req_trigger during it. The NULL assignments
are also redundant since vfio_alloc_device (line 759) zero-initialises
the whole matrix_mdev struct, but they are harmless.

>
>>   	dev_set_drvdata(&mdev->dev, matrix_mdev);
>> -	mutex_lock(&matrix_dev->mdevs_lock);
>>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>>   	mutex_unlock(&matrix_dev->mdevs_lock);
>>   	return 0;

