Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E523515C9;
	Tue,  4 Aug 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857598; cv=none; b=uq8oW3kThs3MYZp4Zxmqj76t7R122HzFfuDNPm7h9YzxxLInc8KVqbg99z1JMhRHlPigycFj/fw32qI57Z0Dp7bgwfRNiJBiv1cUDivSJABLj9QERIyX6gQN5M35B/0+hzA3El3SRyxw2Ppkn3UDZSffO/JdVgpdQUANnzzIZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857598; c=relaxed/simple;
	bh=dYq9jW2R3qmMFaWjd7MbN/kTfJNrAFA9BJigKH6JfpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ba5vsCbDXTnVDX/XklfZA/t0su1KjX1x+3jd0ewuqa1MM2bUxUCX8NZgXEXnuz7EyDE2yu2Q0dY23vkp9+qbHHSB9aq7o4Ra4mtOED6o80lmT3OUQiIkyTDEMaqKXZax/byGnpLgQVJvvBZqf41nLwP/+vl1OIvCzmunlDA2BBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rSgnqMk5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rSgnqMk5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674ClfEO3207664;
	Tue, 4 Aug 2026 15:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XE02UJ
	Romip4iJZkmfQ5moAwMXSOmCInqtS3WWhoUzM=; b=rSgnqMk5T2C2DGjhWYZhe3
	7vNiDTx7M/pX+Ivykv8fJx9R8QJF2afOk0dnQDtbbI0b3y0Ilywu7XBEjrFi3wqI
	mbxaohIst24XFl38RlMJyH9iOpDcDjYi1kKtXksD6vxe0KWKGitiGFUTZEd7XmIV
	5a0bV45V0le01IblmChgOgkzrRAsd5dB1ll6AKlzEq/wN95CO7btP2AScQVITxQ7
	sy6QdfKA8POEqv5DjqberuTSz3qf3wvtbRgdGCNI8dEwnBS4iJIWuUfxYoEmc3zF
	6dxBiOn1Pf6UsitJ+GWtdNAaJRc7V3wlPnIDASHgbMnw1d7t80oLW1wfp7SFmwDA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqpgx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 15:33:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674FQEJS010608;
	Tue, 4 Aug 2026 15:33:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgab60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 15:33:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674FX5sC40763654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 15:33:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FB9C58057;
	Tue,  4 Aug 2026 15:33:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5930C58062;
	Tue,  4 Aug 2026 15:33:04 +0000 (GMT)
Received: from [9.61.89.119] (unknown [9.61.89.119])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 15:33:04 +0000 (GMT)
Message-ID: <45a47180-06c5-4e0e-90df-1e7f396f0a52@linux.ibm.com>
Date: Tue, 4 Aug 2026 11:33:03 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/15] s390/vfio-ap: File ops called to resume the vfio
 device migration
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-11-akrowiak@linux.ibm.com>
 <20260727181221.355E61F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727181221.355E61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WSecPqoCJy3oRlmhObPKEhvvELTskCB_
X-Proofpoint-ORIG-GUID: WSecPqoCJy3oRlmhObPKEhvvELTskCB_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfXywTYg6/F/hJj
 VrFOajy8jg593p635Y3bLXZKfSzOaFSZGhy4vzUlPNEuoSXhsqhypb6ZrDQGUCRoMm2h1ntD6bN
 A3ywu7mn0hPUfv3/agp/EEYOprYNMnE=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a720634 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ydTiwiBtxl0LLes2vgoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfX7qIA4qGuPeTI
 VbP6TfqwoqBfHdgBpDiv93p5fFGDb47YPOj1DCaogr8SD7YTIfLHook2FSKRxUdbPurNJUPZVVW
 2Q0Tyo62oN4QvysolefRCVvbnQnvi/7RRkYbVPypKIKK+dy5a+/zZREouTdz2EW9X/CDQ0+GbKi
 iZf7anbeY6G3AaNzr0wyvHHFYxQiHbU0db0ua/YaY36RBK2yb8TgKSKSkquoCXyK351hJgtIEoU
 eXX8eUx8LcCf7Xqj55YUKZmW1HQ/9XrdlAmvPqq2KsC3mUVPA0VYWsw5gBDKiqPKD0gr3Rmearf
 TfHoguKPGTTJ4BPnm/VC2hG1VEhs04yTUFUPP1EBkxZAqrhvCJKwcglIoNiL1PkTK4ZZWdszTaF
 MXZF6LP2jVUQNwepKq5DL16A6jtOLT95JnMHqUxaS2hbiVI7CCMSXBLaOMxkV1U43WEpX7JB/4Y
 mjsKL3DKuAckFB9CBWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040123



On 7/27/26 2:12 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] Double fetch vulnerability in the resuming write path allows out-of-bounds kernel reads.
> - [Critical] Use-After-Free during concurrent device teardown while executing copy_from_user.
> - [High] Lack of rate limiting in validation error paths allows userspace to flood the kernel log and cause a Denial of Service.
> - [High] Unsynchronized concurrent writes can trigger premature configuration validation on uninitialized memory.
> --
>
> --- Patch [10]: [PATCH v6 10/15] s390/vfio-ap: File ops called to resume the vfio device migration ---
> commit 56776518d352cfe0d799d4f95bc7d9c8703337bf
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> Subject: s390/vfio-ap: File ops called to resume the vfio device migration
>
> This commit implements the write callback for the vfio-ap device migration
> file stream. It restores the source guest's AP configuration by validating
> and hot-plugging it into the destination guest.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index c7fecad0b6769..c12ba82ec5277 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -881,14 +881,20 @@
>>   static void report_qinfo_incompatibilities(const char *mdev_name,
>>   					   unsigned long apqn,
>>   					   struct ap_tapq_hwinfo *src_hwinfo,
>>   					   struct ap_tapq_hwinfo *target_hwinfo)
>>   {
>> +	pr_err("vfio_ap_mdev %s: Migration failed: Source and target queue (%02lx.%04lx) not compatible\n",
>> +	       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
> [Severity: High]
> Is it possible for userspace to flood the kernel log here?
>
> If a configuration with a large number of incompatible queues is provided,
> verify_ap_configs_are_compatible() continues processing rather than aborting.
>
> Since report_qinfo_incompatibilities() and its helpers issue unconditional
> pr_err() calls for each mismatch, could this cause CPU stalls or a denial
> of service?

While it is highly unlikely for this to happen since it would require 
that the
system have an inordinate number of incompatible queue devices, the
pr_err calls will be replaced with pr_err_ratelimited calls.

>
>> +
>> +	report_facilities_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
>> +	report_mode_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
> [ ... ]
>
>> @@ -1071,61 +1071,80 @@
>>   static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>>   				      size_t len, loff_t *pos)
>>   {
> [ ... ]
>
>> +	/*
>> +	 * Snapshot and advance *pos under the lock before dropping it for
>> +	 * copy_from_user().  This prevents concurrent write()s on the same
>> +	 * stream file from computing the same destination offset and clobbering
>> +	 * each other's data or racing to reassign mig_data->resuming_mig_file.
>> +	 */
>> +	write_pos = *pos;
>> +	*pos += len;
>> +
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	if (copy_from_user((char *)ap_config + write_pos, buf, len)) {
>> +		if (new_allocation)
>> +			kvfree(ap_config);
>> +		return -EIO;
>> +	}
> [Severity: Critical]
> Can a concurrent device teardown cause a use-after-free here?
>
> The mdevs_lock is dropped to perform copy_from_user(). If a concurrent
> thread closes the VFIO device, vfio_ap_release_mig_files() will call
> kvfree(mig_data->resuming_mig_file.ap_config). Would this result in
> copy_from_user() writing into freed kernel memory?

The vfio_ap_open_file_stream calls vfio_device_try_get_registration()
(see patch 06/15) which pins the vfio_device reference until
vfio_ap_release_mig_file() runs — and release only runs when the file
descriptor is closed. The file descriptor cannot be closed while a write()
is in progress on it. So matrix_mdev and its mig_data remain valid for
the lifetime of the write call.

>
> [Severity: Critical]
> Could this sequence introduce a double-fetch vulnerability?
>
> The first fetch in allocate_ap_config() reads num_queues to determine the
> allocation size. The lock is then dropped, and this second copy_from_user()
> overwrites the entire buffer, including the num_queues field.
>
> If userspace modifies num_queues between these fetches, could it inflate
> ap_config->num_queues beyond the allocated size, causing out-of-bounds
> reads in queues_available() when it loops over source_config->num_queues?

A fix will be provided for this in the next patch series.

>
>> +
>> +	/* Check if we've completed writing the entire configuration */
>> +	if (write_pos + len == cfg_sz) {
>> +		/*
>> +		 * do_post_copy_validation() calls ap_tapq() which is a slow
>> +		 * hardware instruction.  Run it before acquiring the update
>> +		 * locks to avoid holding guests_lock, kvm->lock, and
>> +		 * mdevs_lock across the hardware calls.
>> +		 */
>> +		ret = do_post_copy_validation(mdev_name, ap_config);
> [Severity: High]
> Does this completion check safely handle concurrent writes?
>
> If userspace issues asynchronous write() syscalls for different chunks of
> the payload, they might execute copy_from_user() concurrently. If the
> thread writing the final chunk completes its copy before threads writing
> earlier chunks finish theirs, could do_post_copy_validation() be called
> on a buffer that still contains uninitialized data?

The completion check could theoretically fire early if concurrent writes
are issued, but in that case the validation in do_post_copy_validation
would catch any resulting inconsistency and return an error — the worst
outcome is a failed migration, not a security vulnerability or kernel
corruption.

However, a write_in_progress flag will be added to vfio_ap_migration_data
that will be set when the vfio_ap_resuming_write function is called, unless
the flag has already been set, in which case the function will return 
-EBUSY.write_in_progress

>
>> +		if (ret < 0) {
>> +			if (new_allocation)
>> +				kvfree(ap_config);
>> +			return ret;
>> +		}
> [ ... ]
>

