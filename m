Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194642ED141;
	Wed, 12 Aug 2026 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538143; cv=none; b=IW7Q88zICyz5soJLKeJGu5hPskQjrx9na68aRikDoWOoW/1sQ5vDNMIp5sO4TzU460Vps2dLnZGws4QdIIdmPP8sBrDOmLHzQEjHbkADFWGbFmeCpjwWW4Nig7Jr3kBL8Uken9LDCJZyuGi+sT7N5gJ8SQa+Kejv5CCFS4ebsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538143; c=relaxed/simple;
	bh=zRHowdmKzD4WRK1QJgRSsPSX7OOAN9vH/+rpQC+WnW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sl6PajNxi7AUYqtcI0e+oaESnvXgmKCJ1ol2DjtoSonZNZUnCiuDTf1uOF+gOvzYU8QK6SWFh6YOuJVsK5UOPCGsgHBdmBzh/um5gj7+ug8V3YKhdlnfGqcEekfT/rHhJ8yFKf8XADGpDQfPmbR/lgy98R3WYv3OvTh4F4fin9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VVW9kaY/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VVW9kaY/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3WLB3334208;
	Wed, 12 Aug 2026 12:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XKPe0T
	L6ORosxcSQE3OJ8cJLXmYgGasgvnub9hK4GnU=; b=VVW9kaY/4VheJXPQBuvq7X
	Q72PWeAeyItpeb3Ytsora+xRw+7O10/gnDiFkMnKOJ4BrAApi095c4mER7kyIuf5
	zzwBdkhpz05Kgj6XFmk/IcDGVL4zcDFsv4jvSnETszpAs0Zf1+CGAq6oktxCSyPz
	lp49FuoipDxGs/AAutcOipg2LbDqBOzYSbNMIKoToTnV8erF5YLI/UN6fKr1k4Dq
	7Z5vLf/uedJ+1/CNYs+0DUQaTqf47Rq070ACF4DfxJFgP9rd5OZAJPxCSsFgiSC/
	RZ0fyZ/vMelmMGnnDFebXRCXZeafrnm062WmpyvFwCjSSrqWVttbDX1hOgkRTmkg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw9k2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 12:35:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CCQGQT026375;
	Wed, 12 Aug 2026 12:35:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy5rpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 12:35:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CCZb9Z17760818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 12:35:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0A8F58056;
	Wed, 12 Aug 2026 12:35:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E286358052;
	Wed, 12 Aug 2026 12:35:36 +0000 (GMT)
Received: from [9.61.9.29] (unknown [9.61.9.29])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 12:35:36 +0000 (GMT)
Message-ID: <d81b9dd2-9cd3-44a3-99c1-b5fb395cc00f@linux.ibm.com>
Date: Wed, 12 Aug 2026 08:35:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-8-akrowiak@linux.ibm.com>
 <20260807223752.4A6F21F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807223752.4A6F21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c689c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4yvAY2ebU2nt4NgkF2QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kIVN9rqTG6JGkM-S4JTOam-gikl0eAfz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMiBTYWx0ZWRfXxqSQE5Ft9fqf
 HZVSTG4YUDjzq14GvtQPui/hixskXvyoh21TwbGG3DCS/9zdXGQd8hQRzAlUVunTQkZHR+MnA3W
 XOfa7euU23Kn0e8b7HByOYGfv5f4nOw8iw1/PefIUslRm7riP2f2pyTqVrJCyfyxuW7MFSXnUh9
 w6yArZ+acD3e/1OiTw0OG5TO603v7/OaLggcPmBGvg3c1IfL90GJi9rAfIsO9C7t0xZIP8oy2ox
 6UVhUxweGyeRdMXZhXfUMVmV+5B+nDBGp2Gs4FrcB0sMqGMyk9FO0VEOnNthbJQUx9iRvBL/3CI
 08YqYTLUtz/cpXfYKIv7fc/iXzWlewMJw6qMNd0dtmc/xjEAqA/cR2g8k9sCgc7qVHjQ9Kdu9k7
 rGRKyglaPjL3PnJq5Lix8Y2Txq/a7xTAzgyz126VInmbkkxwI1hHKReAP41kMtAlrbPuTKAiRQs
 ubMGzhOrxSKXftY3O7A==
X-Proofpoint-ORIG-GUID: kIVN9rqTG6JGkM-S4JTOam-gikl0eAfz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMiBTYWx0ZWRfX/PQ9Hf9TOfQt
 a1P5h0+bHTTFa6kqBoPAbhT1g9uAlYYDMVdp6h/ZfoIR4QmxJBvbbZH9wyfiU71KP+IltF00eH3
 ZWhewdCTG3S5K5GjBbLwoazee16RjqM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120102



On 8/7/26 6:37 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] Dropping `mdevs_lock` before `copy_to_user()` in `vfio_ap_stop_copy_read` exposes `mig_data` and its `ap_config` buffer to concurrent frees, leading to a Use-After-Free and kernel memory leak.
> - [High] Concurrent reads from the stop_copy file race to initialize `ap_config` because `mdevs_lock` is temporarily dropped in `vfio_ap_get_config()`, causing memory leaks of dynamically allocated configuration buffers.
> - [High] Caching the local `mig_file` pointer before dropping `mdevs_lock` in `vfio_ap_get_config()` leads to a Use-After-Free if `mig_data` is reallocated.
> --
>
> --- Patch [7]: [PATCH v7 07/15] s390/vfio-ap: File ops called to save the vfio device migration state ---
> commit 373ad9ea7be2af5d58b1a74f7797578d1528e3b7
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: File ops called to save the vfio device migration state
>
> This patch implements the read callback for the vfio-ap device migration
> state file. It copies the guest's AP configuration and hardware information
> to userspace when the migration state transitions to STOP_COPY. This state
> data will then be transferred to the destination host.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index de693b308925d..50781b61f7f18 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>> @@ -150,6 +144,279 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
>>   	return 0;
>>   }
> [ ... ]
>> +static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
>> +{The scenario requires two read() calls to simultaneously observe ap_config == NULL and both enter vfio_ap_get_config(). This cannot happen because:
>>
>> The fd is opened with stream_open(), which serializes read calls on the same fd.
>> Even if two independent fds existed (they don't — one fd per STOP_COPY transition), both callers still serialize on mdevs_lock. The second to acquire the lock will find ap_config already populated and skip the allocation.
> [ ... ]
>> +	ap_configuration = kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
>> +	if (!ap_configuration)
>> +		return -ENOMEM;
> [ ... ]
>> +	/*
>> +	 * Unlock the mdevs_lock so other mdevs are not precluded from being
>> +	 * accessed while a potentially long running operation is performed.
>> +	 */
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +	ret = vfio_ap_store_queue_info(mdev_name, ap_configuration);
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +	if (ret) {
>> +		kvfree(ap_configuration);
>> +		return ret;
>> +	}
>> +
>> +	if (!matrix_mdev->mig_data) {
>> +		kvfree(ap_configuration);
>> +		return -ENODEV;
>> +	}
>> +
>> +	matrix_mdev->mig_data->stop_copy_mig_file.ap_config = ap_configuration;
> [Severity: High]
> Can two concurrent reads cause a memory leak here?
>
> Since mdevs_lock is temporarily dropped above, both threads might observe
> that ap_config is NULL in vfio_ap_stop_copy_read(), and both would allocate
> an ap_configuration buffer.
>
> When they reacquire the lock here, they will both blindly overwrite
> matrix_mdev->mig_data->stop_copy_mig_file.ap_config with their respective
> allocations, permanently leaking the buffer allocated by the first thread.

The scenario requires two read() calls to simultaneously observe
ap_config == NULL and both enter vfio_ap_get_config(). This cannot happen
because:

1. The fd is opened with stream_open(), which serializes read calls on the
    same fd.
2. Even if two independent fds existed (they don't — one fd per
    STOP_COPY transition), both callers still serialize on mdevs_lock. The
    second to acquire the lock will find ap_config already populated and
    skip the allocation.

>
>> +	matrix_mdev->mig_data->stop_copy_mig_file.config_sz = ap_config_size;
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
> [ ... ]
>> +	matrix_mdev = filp->private_data;
>> +	mig_file = &matrix_mdev->mig_data->stop_copy_mig_file;
>> +
>> +	if (!mig_file->ap_config) {
>> +		ret = vfio_ap_get_config(matrix_mdev);
> [Severity: High]
> Could the cached mig_file pointer become stale and cause a use-after-free?
>
> Because vfio_ap_get_config() temporarily drops mdevs_lock, a concurrent
> thread could potentially free and reallocate the mig_data structure. When
> vfio_ap_get_config() returns, the stack-cached mig_file pointer might still
> point to the old, freed mig_data structure.

The concern that mig_data is freed while the lock is dropped inside
vfio_ap_get_config(), making the pointer stale when
vfio_ap_stop_copy_read() uses it afterward is unfounded:

1. All callers that free or NULL out mig_data —
    vfio_ap_release_migration_data() and vfio_ap_reset_migration_state() -
    hold mdevs_lock, same as the unlock/relock pair inside
    vfio_ap_get_config().

2. vfio_ap_get_config() already re-checks matrix_mdev->mig_data after
    re-acquiring the lock and returns -ENODEV before touching anything if it
    was freed. That return propagates up to vfio_ap_stop_copy_read(), which
    exits before the stale mig_file is accessed.

>
>> +		if (ret) {
>> +			mutex_unlock(&matrix_dev->mdevs_lock);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Compute the offset and clamped length fully under the lock so that
>> +	 * concurrent read()s on this stream file each see a consistent view of
>> +	 * the current position.  *pos is advanced here while we still hold the
>> +	 * lock; copy_to_user() then uses the snapshot read_pos.  This prevents
>> +	 * two threads from calculating the same offset and both copying the
>> +	 * same region (or one reading past the end of the buffer).
>> +	 */
>> +	if (*pos >= mig_file->config_sz) {
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>> +		return 0;
>> +	}
>> +
>> +	len = min_t(size_t, mig_file->config_sz - *pos, len);
>> +	if (len == 0) {
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>> +		return 0;
>> +	}
>> +
>> +	read_pos = *pos;
>> +	*pos += len;
>> +
>> +	/*
>> +	 * Drop the lock only for the copy_to_user().  The ap_config buffer is
>> +	 * stable: it is allocated once in vfio_ap_get_config() and freed only
>> +	 * in vfio_ap_release_stop_copy_file() which requires mdevs_lock.
>> +	 * Since we already advanced *pos above, no other thread will compute an
>> +	 * overlapping region.
>> +	 */
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
> [Severity: Critical]
> Is it safe to access mig_file and its ap_config here without the lock?
>
> Once mdevs_lock is dropped, a concurrent thread could close the VFIO device
> or issue a reset, which acquires mdevs_lock and frees both the ap_config
> buffer and the mig_data struct.
>
> If that happens before or during copy_to_user(), it could result in reading
> freed kernel memory and leaking it to userspace, or crashing the kernel.

The code dropped mdevs_lock before copy_to_user(), but
vfio_ap_reset_migration_state() (e.g. triggered by VFIO_DEVICE_RESET while
the stop-copy fd is still open) calls vfio_ap_release_stop_copy_file()
under the lock, which kvfree()s the buffer. A concurrent copy_to_user()
outside the lock would then read freed kernel memory.

Since the ap_config data is at most a few KB for any realistic AP
configuration, the fix would be to hold the lock while the
copy_from_user is executing. This is safe to do under a sleeping mutex.

>
>> +		return -EFAULT;
>> +
>> +	return len;
>> +}

