Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290708;
	b=huRkb5UE13KF6SD9GdpLXULBhNg05Dj8sGIrsCVxzdW3tFfI9VV1tslttenAcINchD8w
	 htXpo7EVRJfuDlHi7+yQeSi/wHtytVTnL9r3lEfbh/DOxiRhUSGGvyULrr0jE7DdfZNEG
	 meqikkWW4In/QJLlTc6ZrSqcfAXYEUbOjvx+dc6eUYCKojCEArib0JNAJ+pWyiVZcOYlk
	 0xrs2bEeAZfvRHbqJVLuDGAcQWwDAfcHITFPd8PpdrMfI9rHlH8sMn3DuLOGUoYSry0hN
	 rs4pznRl7RC6N9OLmChZs/gWmpTYSY/noQxprnlUgrlg3vh/4C+cR2otH9pKI+xVZEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290708;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sE6TXU8DF0x29+qLwqb4lLvSfELEbkAzHuSPiHIPvSw=;
	b=SV7n6Bp2vlwiDX6LtQkTZM30NzRIcPBUEGre03mx7Hi12MWK+jM+iJFsGjqEYGUflac5
	 Z7cwGzX4VxnXeT7jwcz7frZK/Eb1rbQFNRmvsNnU03vewVSci5fipOlzwJsXi90zaFalg
	 Arcd1+j/Wy+fZGV6Ice/uCLZYyGCUd+eh3ply4DwDR9QIAV+XXl1tQZT6I3Y12f07/v3W
	 lwY/1zWhw7MP1ZDMJphAo8XHZIjlaLQQp0jUifErnnAMm+/8TzX8fmv520bk6GEQ7yDPy
	 AkMXZVWtzKNuwPtFLlEUg3H/C9x1ituDXObvfbih5+QTdizROr47wSAAWqHSYxIruBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qLs1QSFO;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC3606A31A;
	Thu, 29 Oct 2026 16:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEEC3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qLs1QSFO
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGEHhI409730;
	Thu, 29 Oct 2026 16:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sE6TXU
	8DF0x29+qLwqb4lLvSfELEbkAzHuSPiHIPvSw=; b=qLs1QSFOiSq7FssQ6GR/PC
	a3TdCmJE8UexvdHbXO7WfbfFxXBJGAMoBEzyfgImlTmTYzZIPt2q40GrNq2Xv3Rj
	G5kkYwEBGVeIRf/KtnOixnxw7f7DNja2N3lY8zwGvjwgZeudDHm/OLpPkD+R7JQf
	SH656awtoXj5KVMVrB/BqQcQmCCsZ6/3jKetIuTCoRGNpYyoqGvSbaT5MJekid0s
	QsO5qiJcLlnhP0rInVHgReOJrU5G6W7/Y2dbUDt6HtHb7w0EBpLhsVajZk3/Kd7s
	i6gHAwTG1VyqXBhtwGIK3h41DHIxxGvfN0Gw+qqoomAHscLzsBeyjfaDx4zE6jIA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mkgsc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:18:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TD4ppF3175154;
	Thu, 29 Oct 2026 16:18:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pfs0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:18:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TGIJXk34603592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 16:18:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E4E5805E;
	Thu, 29 Oct 2026 16:18:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E5D358051;
	Thu, 29 Oct 2026 16:18:18 +0000 (GMT)
Received: from [9.61.101.238] (unknown [9.61.101.238])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 16:18:18 +0000 (GMT)
Message-ID: <948eb3f3-8583-4813-93dc-c2044036cf64@linux.ibm.com>
Date: Thu, 29 Oct 2026 12:18:18 -0400
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
Subject: Re: [PATCH v10 10/15] s390/vfio-ap: File ops called to resume the
 vfio device migration
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-11-akrowiak@linux.ibm.com>
 <sashiko-outbox-183055@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-183055@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MyBTYWx0ZWRfX/Lg9MQX99+Cj
 FKgTCVYmKFQKAstHmyTl1I63YFx6lS+K+gKOYPc/A3M6Zr9NAvD2yZ1bjjDQ05psr6er46pwoSP
 4hBrhSlymYQY75eB0lUiDJOstOfSqWg=
X-Proofpoint-ORIG-GUID: jvXSTfEqXYf0FjTdY97WnFbssKbsaDUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MyBTYWx0ZWRfX9KTG8Oj4Rbbj
 se51kq4wAygr+y/u+zDs8p9ZnOVpIYqC/PnkLmLSlgMN1037xu844w93H8UDQaF7IL7OeFiKu61
 D/yDchE68VbQshZPTbQ9npxbGBuqkHI75Mx/2ciGjPbR4aiZ+eVBDHLhLwxwml6PTtE/xhgxTVh
 wEhJvLmK4VdMrzXUCmZP9jpGw3AFHYjpbMy0IVUGSctkLQNSJnl8pfDBKqU2DBTUpLH5QgOrEit
 1x+HSZnQe2VlB1wKVhKDqN2ehOnyuPKOPIKaMbabee1yai4lPqhFPEjN15WlFOKQhUhbxN5JQZ1
 /TqvpOjAicRIgvSNTfYDP4ZmZ3JjKcDbM1DX0L3WmqIK/AxXDG5KUlbUFAN0vT3j8ppy1QjnMoW
 NbCgxtvaCqe+MC4UMMrDhZWAw5k8IDNzY6lRcQ2DwTg2N52wg6LsuT2lwhek3iYl/ut0CNoTXUm
 S60ELEDzE4De5cLlCbA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae371cd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2cFd44nW4mLJl96LBREA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jvXSTfEqXYf0FjTdY97WnFbssKbsaDUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290063



On 10/23/26 2:15 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] s390/vfio-ap: fortify panic in vfio_ap_resuming_write() due to __counted_by
> - [Medium] s390/vfio-ap: corrupt f_pos and completion state in vfio_ap_resuming_write()
> --
>
> commit 1a397bedb442875a3f4830b60abce45f72b37dfd
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: File ops called to resume the vfio device migration
>
> This commit implements the write callback for the resuming migration file
> stream in drivers/s390/crypto/vfio_ap_migration.c, accumulating the source
> guest's AP configuration into a pre-allocated vfio_ap_config buffer and
> validating compatibility against the destination mdev's shadow_apcb and
> hardware capabilities.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 9ed657c7302e9..469fa09ec9087 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -451,11 +506,562 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
>>   	return filp;
>>   }
>>   
> [ ... ]
>
>>   static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>>   				      size_t len, loff_t *pos)
>>   {
>> -	/* TODO */
>> -	return -EOPNOTSUPP;
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +	struct vfio_ap_config *ap_config;
>> +	ssize_t ret;
>> +	void *kbuf;
> [ ... ]
>
>> +	matrix_mdev = filp->private_data;
>> +	mutex_lock(&ap_attr_mutex);
>> +	get_update_locks_for_mdev(matrix_mdev);
>> +	pos = &filp->f_pos;
>> +
>> +	ret = validate_resuming_write_parms(filp, len);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	ap_config = matrix_mdev->mig_data->resuming_mig_file.ap_config;
>> +
>> +	memcpy((char *)ap_config + *pos, kbuf, len);
> [Severity: High]
> Will this memcpy() in vfio_ap_resuming_write() trigger a fortify_panic() when
> built with CONFIG_FORTIFY_SOURCE=y and CONFIG_CC_HAS_COUNTED_BY=y?
>
> In drivers/s390/crypto/vfio_ap_migration.c, struct vfio_ap_config declares its
> flexible array member with __counted_by(num_queues):
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
> When vfio_ap_resuming_init() allocates ap_config via kvzalloc(),
> ap_config->num_queues is zero-initialized. In vfio_ap_resuming_write(),
> fortified memcpy() evaluates __builtin_dynamic_object_size() on
> (char *)ap_config + *pos before copying the bytes from kbuf. Because
> qinfo[] is annotated with __counted_by(num_queues), the compiler computes the
> remaining object size from the current value of ap_config->num_queues:
>
>    sizeof(struct vfio_ap_config) +
>    ap_config->num_queues * sizeof(struct vfio_ap_queue_info) - *pos
>
> When userspace writes a configuration containing one or more queues in a
> single write() call (or a chunk spanning across num_queues into qinfo[]),
> ap_config->num_queues is still 0 when the bounds check runs, so p_size is
> at most sizeof(struct vfio_ap_config) while len is larger, causing
> fortify_memcpy_chk() to call fortify_panic().
>
> Similarly, even if an earlier chunk already populated ap_config->num_queues,
> memcpy() runs before the *pos > (loff_t)expected_sz check below, so a write
> that exceeds expected_sz will also trigger fortify_panic() instead of
> returning -EINVAL.

This is a valid concern.
The fix will set ap_config->num_queues = MAX_AP_QUEUES
immediately after kvzalloc() in vfio_ap_resuming_init(), so
the __counted_by bound covers the full pre-allocated buffer
for the entire receive phase. num_queues will be overwritten
with the correct value when the source guest's AP configuration
data arrives via vfio_ap_resuming_write().

>
>> +	*pos += len;
>> +
>> +	/*
>> +	 * Check whether we have received all the data.  We know the total
>> +	 * expected size once num_queues has arrived, i.e. once *pos is past
>> +	 * the fixed header.  Until then keep accumulating.
>> +	 */
>> +	if (*pos >= offsetofend(struct vfio_ap_config, num_queues)) {
>> +		size_t expected_sz;
>> +
>> +		if (ap_config->num_queues > MAX_AP_QUEUES) {
>> +			ret = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +
>> +		expected_sz = sizeof(struct vfio_ap_config) +
>> +			      ap_config->num_queues *
>> +			      sizeof(struct vfio_ap_queue_info);
>> +
>> +		if (*pos > (loff_t)expected_sz) {
>> +			ret = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +
>> +		if (*pos == (loff_t)expected_sz) {
>> +			ret = do_post_copy_processing(matrix_mdev, ap_config);
>> +			matrix_mdev->mig_data->resuming_mig_data_complete = !ret;
>> +		}
>> +	}
> [Severity: Medium]
> Can advancing *pos and writing into ap_config before validating num_queues
> and expected_sz leave filp->f_pos, ap_config, and resuming_mig_data_complete
> in an inconsistent state on error?

This is intentional. The write path accumulates chunks
progressively into the pre-allocated ap_config buffer; *pos
tracks how many bytes have been deposited. The num_queues and
expected_sz checks can only run once enough bytes have arrived
to read num_queues. On error, the RESUMING state is terminal —
vfio_ap_transition_to_state() returns -EINVAL when
resuming_mig_data_complete is false, the migration fails, and
vfio_ap_release_resuming_file() cleans up ap_config. There is
no retry path from a partially-written or corrupted stream, so
leaving *pos advanced and ap_config containing invalid data on
error is not a problem in practice.

>
> In vfio_ap_resuming_write(), memcpy() and *pos += len execute unconditionally
> before checking ap_config->num_queues > MAX_AP_QUEUES and
> *pos > (loff_t)expected_sz. If either check fails, or if
> do_post_copy_processing() fails, vfio_ap_resuming_write() returns a negative
> errno while leaving filp->f_pos advanced and the invalid data in ap_config.
>
> In addition, if a valid configuration is written completely such that
> *pos == (loff_t)expected_sz and do_post_copy_processing() succeeds,
> matrix_mdev->mig_data->resuming_mig_data_complete is set to true. If a
> subsequent write arrives with extra trailing bytes before the device
> transitions out of VFIO_DEVICE_STATE_RESUMING, vfio_ap_resuming_write()
> returns -EINVAL (or -EIO in validate_resuming_write_parms()) without clearing
> resuming_mig_data_complete, leaving the stream marked complete after a failed
> write.

This is a valid concern.
The fix will add a check in validate_resuming_write_parms()
that returns -EPROTO if resuming_mig_data_complete is already
true, rejecting any write that arrives after the full
configuration has been successfully received.

>

