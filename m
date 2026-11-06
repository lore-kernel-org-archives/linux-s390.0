Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977594;
	b=p+LbCYw4nknGo+tFYWmH9Rjx8DhxuOEg0vjmY0CqMMzcrJYfmUPClp746sM51iWnF+mI
	 OklNRmin7DKlcuYC+eY5GfoVryb+Yukbpc/sadPq9CCl+f6W5rMNXjV8ib5qMMOBHNK25
	 OhpH903jdbrHpYKEYLKHbh0qlPiGwcXUjsXFdwzJmOGO/zhJdfZYytwj9ZFR0xUoE8btT
	 YEE+6D+DHUGyau8qAwj9JwIZazxIP3wcxd8HH5N/n0jYwSZCmIBG4L33Xb9BzWKeJHv4d
	 ci41gdmg/ax14B5wIm0tBjsRQ7FS/pSPqjdz5ovpL0GKRJ75btG1TgtiRN7mUUyvI/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977594;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=h/qASaZAydHfwmtwiOmKkvJD0tKwZc3ntygvyoTm3zE=;
	b=vlNe0GSDZieugfHWij1LngR3OlYCxPvQBS+jeyw44kLv+dRTHWllUnOqhQ5+i+fOgfsG
	 NIt2Fs9cEzFwz9CutYplD4SHmzt3zcTCj70GvpacWSOYZdJ1gO42odmLGfoQAl5OMhJZ3
	 NJyZ6/EvW6ttCw0i7E8ISeU93b5RjwUakMT+WDHCpZ6eZbyiCyZijo3aTgD2OvSklRwyV
	 TzskTcn/W6dV7oa+rdGUEGK6D7sfOA2KSs44Xl7B3HA9BELyobf+TvzufgMLrzutok9Zg
	 APwo+jFVWC9hHPGIYTYO28XrqR3jgN0ZJDWq0iZ6sV0wMdLO138W+PJ0sKvTB4Td3+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UI2gqx+Y;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A4606A32C;
	Fri,  6 Nov 2026 15:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 601A4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UI2gqx+Y
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6EiFQl2589279;
	Fri, 6 Nov 2026 15:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h/qASa
	ZAydHfwmtwiOmKkvJD0tKwZc3ntygvyoTm3zE=; b=UI2gqx+Yf2mZ1UD6n4KQUT
	e++CvS/x0m2iqUjPzeNhi8L2+s3K7k7SkmXupMK/fE26seWJHk1urcEtKg43hFu/
	0n1QuL7TqYIZ7wtLt4ql0Dk/HLNj4tX8LfLvQhIOg3k4av4pYv8AaJQQFRCCKmF9
	I5p/bSPZfgjs8OWxl8n47NSIg1jCC3/SulidLa1wgFHbQKHa2Who5VM1kTONfTkS
	ekldEpDjpy9szxquTfo6W51Hxqcnl8oInW2LaymHHI2qCFAcfVgc97pvwtQh1Ddj
	W9lqRgIRYHZx4YKu4YV6pW6DIQR4EvyfepnEOPGQGP+lndoAAsuzkyhABDmH+oxg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc50b7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:06:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4sLn3476011;
	Fri, 6 Nov 2026 15:06:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrescef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:06:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6F6Vwd22872682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:06:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 557985805A;
	Fri,  6 Nov 2026 15:06:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A515C5803F;
	Fri,  6 Nov 2026 15:06:30 +0000 (GMT)
Received: from [9.61.114.69] (unknown [9.61.114.69])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:06:30 +0000 (GMT)
Message-ID: <7ac085b9-4289-4ca3-8626-ca600cb21130@linux.ibm.com>
Date: Fri, 6 Nov 2026 10:06:30 -0500
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
Subject: Re: [PATCH v11 12/14] s390/vfio-ap: Set up for vfio-ap device
 migration
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-13-akrowiak@linux.ibm.com>
 <sashiko-outbox-193886@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-193886@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OCBTYWx0ZWRfXy3tFJkdfUPU/
 r2/5cczwGCAFvShfSKq1oKjIsQnvlP07Wbz9gOh+E+PSEF3lQcTHavakNRpOucgEHpE5iMClt5P
 Xoc4kicaIiUKMeSzomdeM7PpTVEeY38=
X-Proofpoint-GUID: rW8Ykr1PZf44zQvwFVO815PgpMR3BIRo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OCBTYWx0ZWRfXxOwPfTWiyZYB
 o1jB2fYGuLHU6yullOtSmgmgxgnwsQukioSos5syvGnG77yUPf9qEhLuZmkp1FFvqKfrPJ7RzzG
 nI3MsPIWUgZejFKFqTb+wrUbj0B4bPj1lK/m7w9Sn+Ak8fKlm+aQAMddnxqd70MXdxrJFwRir/y
 uFhr6NhVMrXOXKczBwmLGC7lWxso0oQ/OZ0KCuVCQEnW8z8sXiGsOiscc3PCVNGvR72mhxTlSte
 yUuGn8P3LqJNrkGPo23DLsVnSOADnU9UdtEeqa5xXAhMwbG4bJIa4uACGj81yJF9bkk3aLq60/+
 ZS12MnQTwtyoREAnGMFf19im0WBKWH5SknOsVqGpmQGleIF+XBUHTtl9Xig6mPKInowGgWD/J6Y
 AzTse1DCbwPQ/s4UKgFroUY3zaJtO7BTqIHczf1FQUPorN2ZqQQUMOlB+71QxIZxNxPKPoCRNLn
 bQrHU1H6CJ09bcFniHg==
X-Proofpoint-ORIG-GUID: rW8Ykr1PZf44zQvwFVO815PgpMR3BIRo
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedecf9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Id4b1z9nps-4RKgSzxYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060058



On 11/2/26 12:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] s390/vfio-ap: use-after-free of mig_file in vfio_ap_release_mig_file()
> - [High] s390/vfio-ap: fortify_panic() on chunked writes in vfio_ap_resuming_write()
> --
>
> commit 8f5bd5cbf7956f3cc86d039dd21c5869a7e36482
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Set up for vfio-ap device migration
>
> This commit plugs in the vfio_migration_ops callbacks and sets the
> VFIO_MIGRATION_STOP_COPY migration flag during vfio-ap mediated device probe
> when not running in an SE guest.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 7c282d396f502..57cfaafec4d97 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -217,6 +217,30 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
>>   	return 0;
>>   }
>>   
>> +static const struct vfio_migration_ops vfio_ap_migration_ops;
>> +
>> +/**
>> + * vfio_ap_setup_vfio_device_migration:
>> + *
>> + * Plug the object containing the function pointers to the migration callbacks
>> + * used to facilitate migration into the vfio device and set the flags
>> + * indicating migration states STOP, STOP_COPY and RESUMING are supported.
>> + *
>> + * @matrix_mdev: pointer to object containing the vfio device (vdev)
>> + */
>> +void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	/*
>> +	 * Live guest migration is not supported for SE guests, so there is no
>> +	 * need to initialize the migration capabilities.
>> +	 */
>> +	if (ap_is_se_guest())
>> +		return;
>> +
>> +	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
>> +	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
>> +}
> [Severity: Critical]
> As reported by Sashiko on v5 [1], now that vfio_ap_migration_ops is wired up,
> can closing the VFIO device file descriptor while a migration file descriptor
> remains open trigger a use-after-free of matrix_mdev->mig_data and its
> embedded mig_file structs?
>
> In drivers/s390/crypto/vfio_ap_migration.c, resuming_mig_file and
> stop_copy_mig_file are embedded inside the heap-allocated struct
> vfio_ap_migration_data (matrix_mdev->mig_data) rather than inside struct
> ap_matrix_mdev:
>
> struct vfio_ap_migration_data {
> 	enum vfio_device_mig_state	mig_state;
> 	bool				resuming_mig_data_complete;
> 	struct vfio_ap_migration_file	resuming_mig_file;
> 	struct vfio_ap_migration_file	stop_copy_mig_file;
> };
>
> When transitioning to VFIO_DEVICE_STATE_STOP_COPY or
> VFIO_DEVICE_STATE_RESUMING, vfio_ap_open_file_stream() takes a registration
> reference via vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev)
> and sets filp->private_data to mig_file. That registration reference keeps
> struct ap_matrix_mdev alive, but it does not prevent the VFIO device FD from
> being closed.
>
> If the VFIO device FD is closed before the migration FD (for example, by
> userspace or during process exit when close_files() closes a lower-numbered
> VFIO device FD before a higher-numbered migration FD),
> vfio_ap_mdev_close_device() -> vfio_ap_release_migration_data() destroys the
> mig_file mutexes and frees matrix_mdev->mig_data:
>
> void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
> {
> 	lockdep_assert_held(&matrix_dev->mdevs_lock);
>
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
> Once matrix_mdev->mig_data is freed while the migration FD is still open:
>
> 1. Closing the migration FD afterwards invokes vfio_ap_release_mig_file(),
>     which dereferences mig_file->matrix_mdev in freed memory:
>
> static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
> {
> 	struct vfio_ap_migration_file *mig_file = filp->private_data;
>
> 	vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
> 	return 0;
> }
>
> 2. Any subsequent or concurrent vfio_ap_stop_copy_read() or
>     vfio_ap_resuming_write() on the open migration FD accesses
>     filp->private_data (mig_file) and locks or unlocks mig_file->lock after
>     mig_data has been destroyed and freed (or while vfio_ap_stop_copy_read()
>     holds mig_file->lock across copy_to_user() after dropping
>     matrix_dev->mdevs_lock).

Asked and answered in previous reviews. Will be fixed in v12.

>
> [Severity: High]
> With vfio_ap_migration_ops exposed to userspace, can chunked writes to the
> RESUMING migration file descriptor trigger a fortify_panic() in
> vfio_ap_resuming_write() under CONFIG_FORTIFY_SOURCE?
>
> In drivers/s390/crypto/vfio_ap_migration.c, struct vfio_ap_config annotates
> its flexible array member with __counted_by(num_queues):
>
> struct vfio_ap_config {
> 	u32				magic;
> 	u32				version;
> 	u32				num_queues;
> 	u8				reserved[4];
> 	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
> 	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
> };
>
> Although vfio_ap_resuming_init() initializes ap_config->num_queues to
> MAX_AP_QUEUES when allocating the VFIO_AP_CONFIG_MAX_SIZE buffer,
> vfio_ap_resuming_write() copies each incoming chunk directly into ap_config
> before validating expected_sz:
>
> 	ap_config = mig_file->ap_config;
> 	memcpy((char *)ap_config + *pos, kbuf, len);
> 	*pos += len;
>
> 	if (*pos >= offsetofend(struct vfio_ap_config, num_queues)) {
> 		size_t expected_sz;
>
> 		if (ap_config->num_queues > MAX_AP_QUEUES) {
> 			ret = -EINVAL;
> 			goto out_unlock;
> 		}
>
> 		expected_sz = sizeof(struct vfio_ap_config) +
> 			      ap_config->num_queues *
> 			      sizeof(struct vfio_ap_queue_info);
>
> 		if (*pos > (loff_t)expected_sz) {
> 			ret = -EINVAL;
> 			goto out_unlock;
> 		}
>
> When CONFIG_FORTIFY_SOURCE is enabled, memcpy((char *)ap_config + *pos, kbuf,
> len) evaluates __builtin_dynamic_object_size() using the current in-memory
> value of ap_config->num_queues before copying:
>
> 1. If an earlier write chunk sets ap_config->num_queues to a smaller value N
>     (where N < MAX_AP_QUEUES) and a subsequent write chunk writes past
>     expected_sz (while still within VFIO_AP_CONFIG_MAX_SIZE), the fortified
>     memcpy() sees the smaller object size derived from ap_config->num_queues ==
>     N and calls fortify_panic() before reaching the *pos > expected_sz check.
>
> 2. Because s390x is big-endian, MAX_AP_QUEUES (0x00010000) has bytes
>     {0x00, 0x01, 0x00, 0x00} at offsets 8..11. For any valid migration stream
>     with num_queues < 65536 (where the upper two bytes are 0x00, 0x00), if a
>     chunked write splits across the num_queues field after its second or third
>     byte, ap_config->num_queues in memory temporarily becomes 0. If the next
>     write chunk copies the rest of the header and any queue info entries, the
>     fortified memcpy() evaluates ap_config->num_queues == 0 before copying the
>     remaining bytes of num_queues and triggers fortify_panic().

Asked and answered in previous reviews; will be fixed in v12

>
> [1] https://lore.kernel.org/r/20260724182949.EA9C51F000E9@smtp.kernel.org
>

