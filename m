Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967538;
	b=RRfesCgySZLxvH0ofcsNEzQvuQkdiWVJzYHwg7cdoibiirKdUSvrKYoA83Zv1jaLII/4
	 BcAeowhCXa5ISDofwN9Za6z1aexvZL/QluVJva99yKa6yJ0G+1bGbcQ+FtyGlE1wNN0wb
	 jwlF/qPgPAk9jD798cYBui5oqiXYch49hrsmY4Wj9R1ykI8zWLRgA05AUJPm2p0ruLAwQ
	 mGZ0OUsQZrv1ZYKiFB1i9lRqVdAzcaEMrkIX+qeBQH8DOvNKWlTS3+mFWQ+mA2W6abcac
	 2aWWtE+vstGc3bmd9mKkCgyo9VsGPtpH7XKxOHCZw7JLbDN2gzr6b9j1qOGu485RqxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967538;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iTscXFXBGIVLgfQac82+XNMjRYEuQtS4u9qgBzQzzM0=;
	b=roaPp4egVIrkJoxmUm7Q8gVYWzx8oC+85IlUzu8YuYeSQxpaPtyMyNmGNZVxyJRr/rmZ
	 WmOzpPGrCxxO9FYJCMwwUpPpyLrouV+TjNpz5sDDvH85BBPJ0PPzUSSjM3n2WMtA4TriF
	 qLhY+aB7qKwpFiUtbDQB5zElbu7bMfoCqJ7N0TMO5PxQ0CUDg4IxW2J8GVf7V7R0ymt+2
	 XWvBeKsQGzh1pXqb7HtdYnw6issasbnXjBAOqeD90FXRFv+pJB7RS38p7TBmLY4NZz0N5
	 1OuTe05g8dBugtEMdTuw3DqWoF2M3n35KuIC9/yTyp31gQuIfStjXjneKCd1LRU4kRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iIhcQVmp;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0E606A326;
	Fri,  6 Nov 2026 12:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81B0E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iIhcQVmp
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AiPjI528967;
	Fri, 6 Nov 2026 12:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iTscXF
	XBGIVLgfQac82+XNMjRYEuQtS4u9qgBzQzzM0=; b=iIhcQVmpQUlxZUdV/dCk03
	KEsOPKTnCcQHx4UjxLBUkZ4lMGPD7M3JqRaoMGXGc7aortW2ZU6DGHlLjaDqMhC1
	KQAJuYH2QGohhnWTElOGZHi/ZjRER7MhC73uRbEcEuqWwsAd+a4Y1eaZU4M8qSJb
	KoStlDPSJJqLlNLtFuXlv2J/bTravInPhrahPBRW3LFsxuYkOyU8hGJ1qZtQ0Znk
	Jv5pmAu3nY8Ox4KEyY8MliSMCC6Z6V2gwXON4afDl7R4xAESRctLt4RA9iDCDR80
	A/X1NNCeyXE6jJ1tIMNTPpkJs2Zb6tk8YOiu8Kx+/F8/dXMm+t7omlgHb30ETRRg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rav4ka-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:18:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AZ3ms3159733;
	Fri, 6 Nov 2026 12:18:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrerjga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 12:18:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6CIti240501714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 12:18:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27FDC5805A;
	Fri,  6 Nov 2026 12:18:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 763F658052;
	Fri,  6 Nov 2026 12:18:54 +0000 (GMT)
Received: from [9.61.114.69] (unknown [9.61.114.69])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 12:18:54 +0000 (GMT)
Message-ID: <4e4db9e5-3e84-4285-8231-b252e090632b@linux.ibm.com>
Date: Fri, 6 Nov 2026 07:18:54 -0500
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
Subject: Re: [PATCH v11 08/14] s390/vfio-ap: Transition device migration state
 from STOP to RESUMING
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-9-akrowiak@linux.ibm.com>
 <sashiko-outbox-193762@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-193762@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aedc5b1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2jQNAoJRB0-FS9Fpoi4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rGHwXvO-L2ZQNuwC-nLIf9lFN0gS7bsT
X-Proofpoint-ORIG-GUID: rGHwXvO-L2ZQNuwC-nLIf9lFN0gS7bsT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfX24WriJh+hgzQ
 v3SjT5+t4xquy0t4csXGFG5JXijjfo+NECyr9oGoXzoxnSBU4JzpEH9anOdY0JSnpeiVCnVuu7u
 N2+Zl7uVboCbUKp2cZqb+QNr7eOM8/I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfX6wAFkU5Sx0Sc
 t9/uNI4iZ8paiYl3FGOx4Po/6frcOQp8vWM9EXv3spPMbWr1q63gjabonIXRpH23dgTkOFvEJT3
 AXON6P/umnmHvpBfnV0A6y02AQhmCakCwulqGKW3779XQSm8UuANkMhdhXIMwWMKqq6KUCVo57q
 KhgnCtK07U6k/WaSi69gHeGRAMuCDIJx1Ht7nDI3hE84FOzPoYHtLbyKklPLv7OabGJHu5rsGcy
 510f/42U1CDAGI6N1EiyF0iqAxejNmf9j+2xnQJ4JAdBVdLlOQaj8hT32OXCt3RHCya+BLQd3fX
 t87ZFdvUXv5vGaeSo2ccLPb5IBscGkAAmm6ZIM+r2Enmd3Tswkh+nWjzEoQhlGw+yhnkKSWbQVD
 I90nC0X1+0h60qclXj3w/o4KomgwMyorz+ShgbrANaToGyvwHC41122sQEK9yaoFpp8KA4UNV5p
 B7Juugha6HcytaltdNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060048



On 11/2/26 11:42 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] s390/vfio-ap: use-after-free of mig_file in vfio_ap_release_mig_file()
> --
>
> commit 8958f5c47ab29cef8a0a38994bae03335dbb5b69
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Transition device migration state from STOP to RESUMING
>
> This commit implements the transition from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_RESUMING in vfio_ap_transition_to_state() by pre-allocating
> the receive buffer for the guest's AP configuration and opening a write-only
> anonymous inode file stream for the resuming migration data.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index b64ce092a41b1..526d83e8590d9 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -456,6 +466,67 @@ static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *mig_
>>   	return filp;
>>   }
>>   
>> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
>> +	/* TODO */
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static const struct file_operations vfio_ap_resume_fops = {
>> +	.owner = THIS_MODULE,
>> +	.write = vfio_ap_resuming_write,
>> +	.release = vfio_ap_release_mig_file,
>> +};
> [ ... ]
>
>> +static struct file *vfio_ap_resuming_init(struct vfio_ap_migration_file *mig_file)
>> +{
>> +	struct vfio_ap_config *ap_config;
>> +	struct file *filp;
>> +
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	ap_config = kvzalloc(VFIO_AP_CONFIG_MAX_SIZE, GFP_KERNEL_ACCOUNT);
>> +	if (!ap_config)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ap_config->num_queues = MAX_AP_QUEUES;
>> +
>> +	filp = vfio_ap_open_file_stream(mig_file, &vfio_ap_resume_fops, O_WRONLY);
>> +
>> +	if (IS_ERR(filp)) {
>> +		kvfree(ap_config);
>> +		return filp;
>> +	}
>> +
>> +	mig_file->ap_config = ap_config;
>> +	mig_file->config_sz = VFIO_AP_CONFIG_MAX_SIZE;
>> +	mig_file->filp = filp;
>> +
>> +	return filp;
>> +}
>> +
>>   static struct file *
>>   vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>>   			    enum vfio_device_mig_state new_state)
>> @@ -488,10 +559,19 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>>   		return filp;
>>   	}
>>   
>> +	/*
>> +	 * Begins the process of restoring the vfio device state by creating and
>> +	 * returning a streaming data_fd to be used to read in the internal
>> +	 * state of the vfio-ap device on the destination host.
>> +	 */
>>   	if (cur_state == VFIO_DEVICE_STATE_STOP &&
>>   	    new_state == VFIO_DEVICE_STATE_RESUMING) {
>> -		/* TODO */
>> -		return ERR_PTR(-EOPNOTSUPP);
>> +		struct file *filp = vfio_ap_resuming_init(&mig_data->resuming_mig_file);
>> +
>> +		if (IS_ERR(filp))
>> +			return ERR_CAST(filp);
>> +
>> +		return filp;
>>   	}
> [Severity: Critical]
> Can closing the VFIO device file descriptor before the migration stream file
> descriptor trigger a use-after-free in vfio_ap_release_mig_file()?
>
> In vfio_ap_transition_to_state(), vfio_ap_resuming_init() passes
> &mig_data->resuming_mig_file (and the STOP_COPY path similarly passes
> &mig_data->stop_copy_mig_file) to vfio_ap_open_file_stream(), which stores
> mig_file in filp->private_data and pins the vfio_device registration:
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_open_file_stream() {
> 	if (!vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev))
> 		return ERR_PTR(-ENODEV);
>
> 	filp = anon_inode_getfile("vfio_ap_mig_file", fops, mig_file, flags);
> }
>
> Pinning the registration keeps matrix_mdev alive, but resuming_mig_file and
> stop_copy_mig_file are embedded in struct vfio_ap_migration_data
> (matrix_mdev->mig_data), which is dynamically allocated when the VFIO device
> file descriptor is opened and freed when it is closed via
> vfio_ap_mdev_close_device() -> vfio_ap_release_migration_data():
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
> If the VFIO device file descriptor is closed while the migration stream file
> descriptor is still open (for example, if a userspace VMM exits or crashes
> during migration and close_files() closes descriptors in ascending order),
> matrix_mdev->mig_data is freed while filp->private_data still points into it.
>
> When the migration stream file descriptor is subsequently accessed or closed,
> vfio_ap_release_mig_file() dereferences mig_file->matrix_mdev from the freed
> mig_data allocation:
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_mig_file() {
> 	struct vfio_ap_migration_file *mig_file = filp->private_data;
> 	...
> 	vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
> 	return 0;
> }
>
> And any concurrent or subsequent read/write on that migration file descriptor
> will also lock the destroyed and freed mig_file->lock.
>
> Should mig_data (or the vfio_ap_migration_file structures) be embedded in
> struct ap_matrix_mdev or otherwise tied to the lifetime of the open migration
> file descriptors?

Confirmed. This is the RESUMING side of the same mig_data lifetime issue 
noted
on patches 03/14 and 06/14.

In v12, mig_data will be tied to the lifetime of the vfio_device 
registration

>

