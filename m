Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967730;
	b=wlLl2Kb008CFMPcuq5/nW0PxbmVnocRjpUEnlDNwjbiBK3NCKR4nsiYkEjKM3JOy2Moo
	 UAbODJ9wgki0+T+NFlgEZ98CH6FZ5jzcyU+0gtaecN6MvJkUxvPUK+rSOOCo2aCbgZ67y
	 NUq4e0lb7svfMyQ5KH3pDOijhbCrJg/uqIaTc3mlvLJF08VxOQ+TJ4Yi7DzRW9RaMyJR2
	 zO32ocjkL+IUpgDk9C0hkY6tXbfr06nCJD3gMiSSo89dvRCPBkEOym8VtHU6C97+THV/U
	 5mpyuoo1L1f1p1XXtO6/4I2R3DmaTPjCOhOR3+rQ00HTwYHG3hl2s83ymVxMxc62hKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=E1rl3judMwh4NCuA8Q2TpYWz2Xe36Oft1aV/AQOjl1U=;
	b=OMuQo78mA6YKTWom0kcLHGAZJ4eu2/KH1jOZYbHh72XzuNIEonSicAFc9bnegi9wMjmB
	 uZfXtMY70c/HVshlsjx8lTeMU08GYnfT44Xfq2qZjIYZHhyUCvE9pO4N9WVVGAKNnRbLj
	 sXgiwfQ5/Dl9OJaWeERGwNeqVXgEPGGDnrm7b+OfZArU30lWK2zMm5YwAXRHK57Lfc/RS
	 5cy0GggC/pEjmWfrP/n7V37PFeSRfU/e1VTw5rwsi6eIb/dNhDtSFx9ALMkHShMInKfCt
	 EfhVwJml90vv8N1YuPljkS8Z0rhkClhusxL0Gg9Pi73qAJXLxv9z2jYILKKugprYd+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZREk9yJQ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA01606A326;
	Fri,  6 Nov 2026 12:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EA01606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZREk9yJQ
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ai8DM2143121;
	Fri, 6 Nov 2026 12:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E1rl3j
	udMwh4NCuA8Q2TpYWz2Xe36Oft1aV/AQOjl1U=; b=ZREk9yJQr9cKKFK9D7R4Rv
	D1M5uf15DLZYDAHmn15ERR21JRk/zwc4/HFF3aI9BBdYliETczeNFoL/ir7WV/Gp
	pGFNwkzZnJg7VYCVLwqDiXZLWtyQN4yZaLJ7C5G5xj0YIcXnRcSLEuY3j3IOxulv
	U1raOUaoYoPMuH+8IaKgoQ7/hjX9t7Hbt+hYyFU25E6IIZTqz+FVowupGO3I94Mj
	p9GH+o3L4mohDObPtG0B7aNzU2EjO5KmOXqj16s/Jzn3lBk7JmPPPdLnAiBS/NEP
	mAEnMIEGcEUL+C3gLgOM9YAdAOuLBqG/DFA3Pgen1c1G8LNMyztI1Gt2ho2CCHBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9440h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:22:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYwtP3302142;
	Fri, 6 Nov 2026 12:22:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7td5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:22:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6CM74k44827128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 12:22:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3150258052;
	Fri,  6 Nov 2026 12:22:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 817C25805A;
	Fri,  6 Nov 2026 12:22:06 +0000 (GMT)
Received: from [9.61.114.69] (unknown [9.61.114.69])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 12:22:06 +0000 (GMT)
Message-ID: <9dd62e39-e29f-491b-b318-eaaf710e3b2f@linux.ibm.com>
Date: Fri, 6 Nov 2026 07:22:06 -0500
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/14] s390/vfio-ap: File ops called to save the vfio
 device migration state
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-8-akrowiak@linux.ibm.com>
 <sashiko-outbox-193752@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-193752@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedc671 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=MQBArR_1JbrQinpI1mcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XpsGyzBq4-nvkaRpmRL7STXK8tx5skFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfX+dCUeTUlDL25
 kCL3zGaeEmFsbIe6gQ+Wd0TOZbm4UQN7LuNYJO9ZdbKFcP2efe0OCMDmdWZ8E36yKxEh0Apg0C8
 nVRVI31Rq3x8ILu0XAkn0Fnb8WyHvDX6jfKDB1RftUj1cVPq+Vusq7fbec3twLGSFaMqqOD5GEr
 clNXMcdiZpC68lCTN+8RhwweyoFKMrUBqEILkvblAB+Rd5EhKg70Kqncwfd3z0n8HLjYGHtRagh
 MDb+/8rBTNnzYJy9CwGd7wMj/Jd1VqWznjmaJ9D8qoiT8CJF3gPyEmyc9GZk1p3zZjPlfbs/KgA
 bS0DI/Hn0DEQ46noHeJgIMEa1K1jJT/MZk4Sc6nTdCg7AomC23eXtApeEwzq1ORcUjn5imeKs1M
 w+F5+ggFM8uIsURgAMH6aLT/PhO9+8he4kXzHEWOoj44k+SJTwSTq55yC0Ie0bQKe7EAEdqjad4
 ZvkxI8uWpQOvDPw/Ipw==
X-Proofpoint-GUID: XpsGyzBq4-nvkaRpmRL7STXK8tx5skFi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfX9mKGhSDxDNx7
 Vu87sbkQVK6ByGLx5l/sxMN0Bgz4fovPCWFI6heip0Lr3uLYJxrUTrjV40YOaHALwR/DPuMvxhV
 CcGxaZ0c41ABQ4IH5nYQ54gMWsWKTIE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060048



On 11/2/26 11:32 AM, sashiko-bot@kernel.org wrote:
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 48028b12b26f9..b64ce092a41b1 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -167,6 +160,269 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * validate_stop_copy_read_parms: Validate the input parameters to the
>> + *                                vfio_ap_stop_copy_read function
>> + *
>> + * @mig_file:	Pointer to the object used for storing the vfio-ap device state
>> + * @filp:	File stream to which to write source guest's AP configuration
>> + * @len:	The length of the data to be read
>> + *
>> + * Verify the following:
>> + * - @filp is the instance opened when state transitioned from STOP to STOP_COPY
>> + * - @filp->f_pos + @len does not cause integer overflow
>> + * - @mig_file->matrix_mdev is not NULL
>> + * - @mig_file->matrix_mdev->mig_data is not NULL
>> + *
>> + * Returns: 0 if the parameters pass validation; otherwise returns an error
>> + */
>> +static int validate_stop_copy_read_parms(struct vfio_ap_migration_file *mig_file,
>> +					 struct file *filp,
>> +					 size_t len)
>> +{
>> +	loff_t total_len;
>> +
>> +	lockdep_assert_held(&mig_file->lock);
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	if (filp != mig_file->filp)
>> +		return -EINVAL;
>> +
>> +	if (check_add_overflow((loff_t)len, filp->f_pos, &total_len))
>> +		return -EIO;
>> +
>> +	if (!mig_file->matrix_mdev || !mig_file->matrix_mdev->mig_data)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
> [ ... ]
>
>> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
>> +	struct vfio_ap_migration_file *mig_file;
>> +	void *bounce;
>> +	ssize_t ret;
>> +
>> +	/*
>> +	 * This file was opened with stream_open(), so pos should be NULL for
>> +	 * sequential read() calls; a non-NULL pointer will be passed only
>> +	 * for positional pread() calls in which case we return an error
>> +	 * indicating broken pipe/illegal seek on a non-seekable file
>> +	 */
>> +	if (pos)
>> +		return -ESPIPE;
>> +
>> +	/*
>> +	 * mig_file is guaranteed live here: vfio_ap_open_file_stream() took
>> +	 * a vfio_device registration reference that is held until
>> +	 * vfio_ap_release_mig_file() runs, so the embedding mig_file cannot
>> +	 * be freed while this file descriptor is open.
>> +	 */
>> +	mig_file = filp->private_data;
>> +	mutex_lock(&mig_file->lock);
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +
>> +	ret = validate_stop_copy_read_parms(mig_file, filp, len);
>> +	if (ret) {
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>> +		mutex_unlock(&mig_file->lock);
>> +		return ret;
>> +	}
> [ ... ]
>
>> +	memcpy(bounce, (char *)mig_file->ap_config + *pos, len);
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	if (copy_to_user(buf, bounce, len)) {
>> +		kfree(bounce);
>> +		mutex_unlock(&mig_file->lock);
>> +		return -EFAULT;
>> +	}
>> +
>> +	*pos += len;
>> +	mutex_unlock(&mig_file->lock);
>> +	kfree(bounce);
>> +	return len;
>> +}
> [Severity: Critical]
> As reported by Sashiko on v6 [1], can closing the vfio device file descriptor
> while the migration file descriptor remains open cause a use-after-free of
> mig_file in vfio_ap_stop_copy_read() and vfio_ap_release_mig_file()?
>
> The comment in vfio_ap_stop_copy_read() notes that vfio_ap_open_file_stream()
> takes a vfio_device registration reference via
> vfio_device_try_get_registration() until vfio_ap_release_mig_file() runs.
> However, that reference only keeps matrix_mdev alive; stop_copy_mig_file is
> embedded inside struct vfio_ap_migration_data (matrix_mdev->mig_data), which
> is allocated separately in vfio_ap_init_migration_data().
>
> When userspace closes the vfio device file descriptor,
> vfio_ap_mdev_close_device() -> vfio_ap_release_migration_data() runs under
> matrix_dev->mdevs_lock:
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_migration_data() {
> 	if (!matrix_mdev->mig_data)
> 		return;
>
> 	vfio_ap_release_mig_files(matrix_mdev);
> 	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
> 	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
> 	kfree(matrix_mdev->mig_data);
> 	matrix_mdev->mig_data = NULL;
> }
>
> Because filp->private_data on the still-open migration file descriptor points
> to &mig_data->stop_copy_mig_file, freeing matrix_mdev->mig_data frees
> mig_file itself:
>
> 1. If vfio_ap_stop_copy_read() runs after vfio_ap_mdev_close_device(),
>     mig_file = filp->private_data points into freed memory.
>     mutex_lock(&mig_file->lock) operates on a destroyed mutex in freed slab
>     memory, and validate_stop_copy_read_parms() dereferences mig_file->filp and
>     mig_file->matrix_mdev from freed memory before checking
>     !mig_file->matrix_mdev->mig_data.
>
> 2. If vfio_ap_stop_copy_read() is already in progress and drops
>     matrix_dev->mdevs_lock before copy_to_user() while holding mig_file->lock
>     (or is waiting to acquire matrix_dev->mdevs_lock after locking
>     mig_file->lock), a concurrent vfio_ap_mdev_close_device() ->
>     vfio_ap_release_migration_data() will destroy mig_file->lock while it is
>     locked and kfree(matrix_mdev->mig_data), causing the subsequent
>     mutex_unlock(&mig_file->lock) in vfio_ap_stop_copy_read() to write to freed
>     memory.
>
> 3. When the migration file descriptor is later closed,
>     vfio_ap_release_mig_file() dereferences mig_file->matrix_mdev from the
>     freed mig_data structure.

Confirmed. This is the read/file-ops aspect of the same mig_data lifetime
issue noted on patches 03/14, 06/14, and 08/14.

In v12, this is resolved by decoupling mig_data deallocation from device 
close


