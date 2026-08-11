Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4937F8BA;
	Tue, 11 Aug 2026 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472968; cv=none; b=iw+Pr3FNxzP+pcC2/1VZVA2c1H+qFRBibnnDr1PNuyBBxLRBQomgGM/zSUcrh8QxH00JU5hADV1/UiU9o9rihJ7WAsUYKNeeIlprQkMZhy6LSxyMb/SfEy8bLWchFBSubPl6NMkv2kdHoUtcBtQFXP2ZlMEM7SmWCdlC0S8RfQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472968; c=relaxed/simple;
	bh=yXxD06+8js+oRtqW9RBBG5AHWINYnFR+f9xpLsXGhjM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HtHeNi9nFKA156A5U72zZxiZsNxO14wxnnRdj5TdAqZSj4g8H/OnRug8X2lGl/CIRi2CPExk8rZXuikVGmq28b5UjMBU+b88jNZizNVidut2YRNLOwUVgEz1eVzFZ/6qnOURLUUUm4U/J5197kAk35qKBrCuTxqyVJFfAHkrbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K2rclZl2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K2rclZl2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGWALD965285;
	Tue, 11 Aug 2026 18:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qgK3dw
	gYpUh6VBAMtnEP0A9d/vE2uxuCKuX/dQ7u1bo=; b=K2rclZl2/QwCWcazjtSOxy
	4hGa1xpnaXOrDv/zTKXX0aqAMLwreqTSySBVYd+gJUjjJEglbMR2L5cUxjtZqEvR
	LGkoFJKaZiRgcxcWlNfeaGknk+0G3U8x576cMYsjEpguZL52s2YJrkfwU5B8asSg
	GlzfgPYjM5qCmMcLCCJn4Ih0qYP7JZ3VBaGOnYv0oJWkhQhGUdZ577XgKYnmNPlH
	PcDOo8o1Y/ArFblPS/bv/Lh+1GJ0pVafpPhAbUIPq7QABMNUdQWRkXV33kzLHGpt
	v+55kKrk2Q4fn/IRHhCyBO2emx4lTBse0KTJSd6wJTzzlIm/CLtxJAqYU7g7xt9Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw5sb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:29:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIQKPs022722;
	Tue, 11 Aug 2026 18:29:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjt7yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:29:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BITMEE27722294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:29:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFE1D58056;
	Tue, 11 Aug 2026 18:29:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AE7158052;
	Tue, 11 Aug 2026 18:29:22 +0000 (GMT)
Received: from [9.61.58.252] (unknown [9.61.58.252])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:29:22 +0000 (GMT)
Message-ID: <dae1b841-143c-4608-9b0c-1535e0cce3c0@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:29:22 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v7 10/15] s390/vfio-ap: File ops called to resume the vfio
 device migration
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-11-akrowiak@linux.ibm.com>
 <20260807223030.D808E1F000E9@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260807223030.D808E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b6a05 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ty3Ky8OSm3sCUs7UeLUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: srpyn7dnigyaOnEu9DwBbxuDy2DVLY7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfXyj48YBtU/c+t
 ywCvTeLSiSuG94IbAZ+BfdhJY9+f+EwOveY2z9Vo0rNFU2ce7No6fa6KdjMQkx7Zir7btMbdSm5
 8kxrAzL0+eZHvly0pEjbnxq9j1JA7BAYftcL4d2LDI9lDtdK+u7JKzF1ZPRXpq9ssBn3uvEAvkx
 H9UPIglJs8gsASxVHVOIMcwxuhbCf8ud6p3y6aECnQlLyvW1dsJIzRoJUQLiGEjdbg9s5cnZG4x
 MMGJLqdVujTE+dQdlnB71uegjb7NrlkGJCOGXspgZWbEXJ/Dqu3siIjMmgkSyrVfzTM6GrYSeHM
 rC8VQalkhonbx2D/4wu3LopIv+rz8BUzRMtXY+wZPoqUU6o71RrabDcKMVyFB4mYacNaLKqe6nT
 TKpH9J8bwq9+ij/84kbRn8EamvUIFkR4jFsDaxyQ0FRogmZZR9Agr842sAMvTCpFXBcatB780dB
 VvArnml9Rd1z/KRecKA==
X-Proofpoint-ORIG-GUID: srpyn7dnigyaOnEu9DwBbxuDy2DVLY7B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfX3rQahMd3Fv8O
 lp/RgJJFWdXAVmT9fy2lzXdvfEj7d5bYDMtgxekPHgVk2PCTCagyWiaR9qZBHbIoH3wBU7OX0nY
 WrHbor9hjWR0fhAM77OAH7jFERigeVM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110151



On 8/7/26 6:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] Heap buffer overflow in vfio_ap_resuming_write when processing the initial chunk of migration data.
> - [High] Memory leak of the dynamically allocated temporary ap_config buffer in vfio_ap_resuming_write on copy_from_user failure.
> - [High] Use-After-Free condition in set_new_ap_configuration due to a TOCTOU race when the migration session is concurrently replaced.
> - [Medium] Missing validation of migration magic and version fields when the entire configuration payload is submitted in a single write.
> --
>
> --- Patch [10]: [PATCH v7 10/15] s390/vfio-ap: File ops called to resume the vfio device migration ---
> commit 1f7d34b59709567819d8ff6eb6bf255fe0360e1b
> Author: Anthony Krowiak<akrowiak@linux.ibm.com>
> Subject: s390/vfio-ap: File ops called to resume the vfio device migration
>
> This commit implements the write callback for the file stream created to
> restore the vfio-ap device state during the RESUMING phase of migration.
> It parses chunks of user data into a vfio_ap_config structure and sets
> up the new device configuration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index e2e7ae8515e55..4dd7373c3d9d9 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>> @@ -451,11 +539,916 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
>>   	return filp;
>>   }
>>   
>> +static int validate_resuming_write_parms(struct file *filp,
>> +					 size_t len, loff_t *pos)
>> +{
> [ ... ]
>> +	/*
>> +	 * If the vfio_ap_config object has been allocated, then the 'config_sz'
>> +	 * field indicates the total size allocated. If the write operation
>> +	 * will exceed the allocation, return an I/O error.
>> +	 */
>> +	if (resuming_mig_file.ap_config) {
>> +		if (resuming_mig_file.ap_config->magic != VFIO_AP_MIG_MAGIC ||
>> +		    resuming_mig_file.ap_config->version != VFIO_AP_MIG_VERSION)
>> +			return -EINVAL;
>> +
>> +		if (*pos + len > resuming_mig_file.config_sz)
>> +			return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
> [Severity: Medium]
> Does this miss validating the magic and version fields if userspace writes
> the entire configuration in a single chunk? The validation here is skipped
> if the configuration buffer is not yet allocated. If all data arrives at
> once, it appears to be allocated and processed in do_post_copy_processing()
> without the magic or version ever being verified against the expected
> values.

The magic/version check will be added to the do_post_copy_validation
function

> [ ... ]
>> +static int set_new_ap_configuration(struct ap_matrix_mdev *matrix_mdev,
>> +				    struct vfio_ap_config *ap_config,
>> +				    size_t cfg_sz)
>> +{
>> +	struct vfio_ap_config *cur_ap_config;
>> +
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +	/*
>> +	 * Re-read mig_data under the lock; the device could have been closed
>> +	 * concurrently while the lock was dropped for copy_from_user().
>> +	 */
>> +	if (!matrix_mdev->mig_data) {
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	cur_ap_config = matrix_mdev->mig_data->resuming_mig_file.ap_config;
>> +	if (cur_ap_config)
>> +		memcpy(cur_ap_config, ap_config, cfg_sz);
>> +	else
>> +		matrix_mdev->mig_data->resuming_mig_file.ap_config = ap_config;
> [Severity: High]
> Can a concurrent state change cause a use-after-free here? The mdevs_lock is
> dropped prior to the copy_from_user() call in vfio_ap_resuming_write(). If
> the migration state is cleared during that window, the original ap_config
> pointer would be freed and cur_ap_config will be NULL upon reacquiring the
> lock. This path then assigns the temporary ap_config to resuming_mig_file.
> However, if the write was a continuation (!new_allocation), the temporary
> ap_config is unconditionally freed at the end of vfio_ap_resuming_write(),
> which would leave a dangling pointer in the active migration session.

The comment is correct — there are two distinct use-after-free windows
in the original code.

Window 1: during copy_from_user()

mdevs_lock was dropped before calling copy_from_user(). A concurrent
vfio_ap_reset_migration_state() could acquire the lock during that
window, call vfio_ap_release_resuming_file() to free and NULL
resuming_mig_file.ap_config, and return — leaving mig_data intact
but with a NULL ap_config. On the !new_allocation path,
set_new_ap_configuration() would then re-acquire the lock, see
cur_ap_config == NULL, store the temporary ap_config pointer into
resuming_mig_file, and return 0 — causing the caller to immediately
kvfree() the pointer that was just stored there.

Window 2: during do_post_copy_processing()

Even if copy_from_user() completes cleanly,
do_post_copy_processing() drops mdevs_lock internally for slow
hardware TAPQ calls. With the original code storing ap_config into
resuming_mig_file before that call, the same concurrent reset could
free the buffer while do_post_copy_validation() is still reading
through the local pointer parameter.

Fix

Hold mdevs_lock across copy_from_user(). The migration
data is small in practice (a handful of queues → a few hundred bytes
for any real guest), and mdevs_lock is a sleeping mutex so holding
it across a potential page fault is legal.

Keep ap_config as a purely local allocation throughout and store
into resuming_mig_file do_post_copy_processing() returns.

>
> [ ... ]
>> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
> [ ... ]
>> +	/*
>> +	 * If ap_config is a new allocation, then the contents of the
>> +	 * 'magic', 'version' and 'num_queues' fields will already have
>> +	 * been copied in; so the write_pos must be set to the location
>> +	 * following the 'num_queues' field and the length to be written must be
>> +	 * adjusted accordingly.
>> +	 */
>> +	if (new_allocation) {
>> +		size_t nbytes_already_copied = VFIO_AP_CONFIG_BUF_SIZE - *pos;
>> +
>> +		write_pos = VFIO_AP_CONFIG_BUF_SIZE;
>> +		write_len = len - nbytes_already_copied;
>> +		buf += nbytes_already_copied;
>> +	} else {
>> +		write_pos = *pos;
>> +		write_len = len;
>> +	}
>> +
>> +	*pos += len;
>> +
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	if (copy_from_user((char *)ap_config + write_pos, buf, write_len)) {
> [Severity: Critical]
> Is there a missing bounds check on the user-supplied len parameter here?
> When allocating a new ap_config, the driver calculates cfg_sz based on the
> num_queues field. However, the calculation for write_len uses the unmodified
> user input len, which is not verified against cfg_sz. If a userspace process
> provides a len that exceeds the dynamically calculated cfg_sz, it seems this
> copy_from_user() will write past the allocated heap buffer bounds.

This is not a bug. The bounds check is performed by
validate_resuming_write_parms(), called unconditionally at the top of
vfio_ap_resuming_write() before any of this code is reached. For
continuation writes (!new_allocation), line 584 enforces:

if (*pos + len > resuming_mig_file.config_sz)
     return -EIO;

For the new_allocation path, resuming_mig_file.ap_config is NULL at
that point (the fresh buffer has not yet been stored there), so that
check does not fire. However, an overrun is still impossible:
write_len = len - nbytes_already_copied writes starting at
write_pos = VFIO_AP_CONFIG_BUF_SIZE, and every subsequent write is
bounded by the same config_sz check above. The total bytes written
across all calls cannot exceed cfg_sz.

>
> [Severity: High]
> Does this leak the dynamically allocated temporary ap_config buffer when a
> continuation write fails? During a continuation write (!new_allocation),
> the ap_config buffer is freshly allocated via kvzalloc(). If the subsequent
> copy_from_user() fails, this error path explicitly skips the kvfree()
> because new_allocation is false, leaving the temporary buffer permanently
> leaked.

This is not a bug. The copy_from_user error path
calls kvfree(ap_config) unconditionally — the new_allocation flag
is not checked there at all.

The temporary buffer allocated on the !new_allocation path is freed
on this error path exactly the same as the new_allocation buffer.
There is no leak.

>
>> +		if (new_allocation)
>> +			kvfree(ap_config);
>> +		ret = -EFAULT;
>> +		goto out_clear_write_in_progress;
>> +	}
>> +
>> +	/* Check if we've completed writing the entire configuration */
>> +	if (write_pos + write_len == cfg_sz) {
>> +		ret = do_post_copy_processing(matrix_mdev, ap_config);
>> +
>> +		if (ret) {
>> +			kvfree(ap_config);
>> +			goto out_clear_write_in_progress;
>> +		}
>> +	}

