Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D437F336;
	Tue,  4 Aug 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863297; cv=none; b=PSBHK1VUUPR+J+1t4yKKQCkVHaskxgN1LgtclhRe+X6gDEbpuM0rX/7Uu1CgbSMVHQJ1noOQySbVsTx091EZx/KCPI0BzjdcOqaEKap5MYiC8Dp8MA3P6AzGax5w1c0F1G2BEjOQf+oYflMiMNKF8OY1k6HNAe3obp0ug/kmOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863297; c=relaxed/simple;
	bh=QYDs3FCujOPc3ofDnEDVCR6OjQ2DJk8EsA94um9Ge2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y11fdUhBsYl8JDDh9nYadwdJtlMKAgV5zwg6ITrfXJOui7cB6ko95KWj2tXmBjI0/wVI3RwxtdLEOq/HPF52OKbYGTq5XNePXUYs5t8g//iq1xJq9fYnbVh79glXJwj2AbS1ZS9lVW7gneZkQcMJRORjAblFGqiBYbV6qoabT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mlOQqcNL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mlOQqcNL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Fm5Nq1193100;
	Tue, 4 Aug 2026 17:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9gc2Ma
	VtBO57GG9GMh77oi1nLpgmIX0qwzp2NA8MFq0=; b=mlOQqcNL2s9CLxjYMMl+kf
	e3MWUHC2I55QV8gOBVWaSdmeD3cGWLor/VZQe6aB/47crTqqOU14aU/35JN76JSq
	LQgtJM/RU8QbYWfHp0JQdyVhVCKC8JWOGcP1gSXO35N7eDfs/0ePFllYL8SNLkbN
	ibTcul8aqT74qJgSSrYbZTTXFCkhHbn18bhcPz8B7q0zA0i+t4MNlX7aob3hM4jR
	8LYKQZJcn+e6/SISvxf48H+JFvqSqwPTJhVzumYi9csrzKbCeIt0jBz4LNbx/bAF
	4pubEklKs3rLFjBHU2ZCPNoqVazvX1v6wCLnI5tXpWel7FVknAKa7FqzJSCQuWhA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hpuy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 17:07:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GuFjl022714;
	Tue, 4 Aug 2026 17:07:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgaq79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 17:07:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674H7lSh15794816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 17:07:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A9A358058;
	Tue,  4 Aug 2026 17:07:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FB2758059;
	Tue,  4 Aug 2026 17:07:46 +0000 (GMT)
Received: from [9.61.89.119] (unknown [9.61.89.119])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 17:07:46 +0000 (GMT)
Message-ID: <cf112813-28dd-4663-9bf0-6f8eb61f0d05@linux.ibm.com>
Date: Tue, 4 Aug 2026 13:07:45 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, kvm@vger.kernel.org,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-8-akrowiak@linux.ibm.com>
 <20260727180224.027021F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727180224.027021F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzNSBTYWx0ZWRfX+5Blgt/gSRRK
 8pJmx31rK+KosOAo/AErFDt/hkP+kN73FTkZPCUe6NnhzyRp21OiE5FRrF4dTlqXFw9cz6ONiP4
 oMkM3cmt0mr1T0tQzRWbv5NCPVwJWGQ=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a721c65 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_Y9SaUapGFypnFrhP8gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzNSBTYWx0ZWRfX1Fg97TXDg1QD
 uLksmS4v06OqfT4pYHw0V7CAIA3V8rV7BavSRoeUdXUHoS8p5MrfTJ+o4fh/YcWciEbkKNwMv3U
 7c4JRQr+877debLs8GqmQtnJ6cR6XRD3p9jwTlV9lotjQJXEx2UWvCAoV7n4DRAam9HbFRVk0jt
 kbPrLJ5ZTSUmAhaNoVGByfkDEIsLu1paKNH79XLCeYmu0ycPf1KJRgqxfbzOgV/YpyHprp99prD
 ANO4AgVMC4/AtKrZsg7OtUxfM8ogGtMRhKK/4ExaqT7DQPcuEvvkJ8fGzCCYk17eqC6qYRNghlV
 mdQV6/OByFHhB7qwq6HfcK16ECEPJxGto8TXco3zSOSUmPdz2TZ+dSJ2Jye3V/dIR3pKMpyeNLX
 hHCVJHvAWmGPcscBiPQdGoBEQyuq5lWwigo5RpPMeWfJS6bjiyHGhgkkCLq4B3DXGkFzXO25pC5
 WWReB8Tr9Kav5gTbXWw==
X-Proofpoint-ORIG-GUID: _CW--dFuk-DQyptLxHtppA2MQ4HhomlM
X-Proofpoint-GUID: _CW--dFuk-DQyptLxHtppA2MQ4HhomlM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040135



On 7/27/26 2:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Critical] Pointer casting a 64-bit uninitialized `unsigned long` to a 32-bit `int *` on a big-endian architecture leaves the lower 32 bits uninitialized, leading to massive buffer overflows or a `__counted_by` trap.
> - [High] Dropping `mdevs_lock` before `copy_to_user()` opens a TOCTOU race window that allows concurrent freeing of the `ap_config` buffer and `mig_data`, causing a double Use-After-Free.
> - [High] The global `mdevs_lock` is held across potentially tens of thousands of slow hardware instructions, explicitly contradicting documented subsystem design and risking host soft lockups.
> - [High] The `.read` callback unconditionally rejects all standard read operations because it erroneously assumes the `pos` pointer is NULL.
> --
>
> --- Patch [7]: [PATCH v6 07/15] s390/vfio-ap: File ops called to save the vfio device migration state ---
> commit 6828e02e20841803a7c3d24379ed9d9979222d55
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: File ops called to save the vfio device migration state
>
> This commit implements the read callback function for the vfio-ap device
> migration state file. It copies the guest's AP configuration and hardware
> queue information to userspace when the device transitions to the STOP_COPY
> state.
>
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> +static int vfio_ap_store_queue_info(const char *mdev_name,
>> +				    struct vfio_ap_config *ap_config)
>> +{
>> +	struct ap_tapq_hwinfo source_hwinfo;
>> +	unsigned long num_queues;
>> +	int ret;
>> +
>> +	/*
>> +	 * ap_tapq() is a hardware instruction that may take time to complete.
>> +	 * It must be called without mdevs_lock held to avoid blocking other
>> +	 * mdevs. The apqn list was already snapshotted into ap_config->qinfo[]
>> +	 * by the caller under the lock.
>> +	 */
>> +	for (num_queues = 0; num_queues < ap_config->num_queues; num_queues++) {
>> +		ret = get_hardware_info_for_queue(mdev_name, &source_hwinfo,
>> +						  ap_config->qinfo[num_queues].apqn);
> [Severity: High]
> Does this loop actually execute with the mdevs_lock held, despite the
> comment?
>
> Looking at the call chain, vfio_ap_stop_copy_read() acquires
> matrix_dev->mdevs_lock and calls vfio_ap_get_config(), which asserts
> the lock is held and then calls vfio_ap_store_queue_info().
>
> Since the lock is never dropped in this chain, will executing PQAP(TAPQ)
> in a loop for potentially many queues block other mdev operations across
> the host?

The mdevs_lock will be dropped prior by the caller of this function.

>
> [ ... ]stream_open is used by subsystems that want stream-like file descriptors.
>   * Such file descriptors are not seekable and don't have notion of position
>   * (file.f_pos is always 0 and ppos passed to .read()/.write() is always NULL)
>
>> +static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	unsigned long *apm, *aqm, apid, apqi, num_queues;
>> +	struct vfio_ap_config *ap_configuration;
>> +	const char *mdev_name;
>> +	size_t ap_config_size;
>> +	int ret;
>> +
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	ap_config_size = vfio_ap_config_size(matrix_mdev, (int *)&num_queues);
>> +
>> +	ap_configuration = kzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
>> +	if (!ap_configuration)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * num_queues must be set before writing qinfo[] elements; the
>> +	 * __counted_by(num_queues) annotation on qinfo[] causes the compiler to
>> +	 * insert bounds checks that evaluate against ap_configuration->num_queues.
>> +	 * Writing through qinfo[i] with num_queues still 0 would trap.
>> +	 */
>> +	ap_configuration->num_queues = num_queues;
> [Severity: Critical]
> Can casting the uninitialized 8-byte unsigned long num_queues to an
> int pointer cause uninitialized memory issues on big-endian systems?

The cast of num_queues to (int * ) needs to be removed.
The vfio_ap_config_size signature takes int *num_queues, and the variable
is already int. On big-endian s390x, &num_queues now points directly to
the correctly-sized storage that vfio_ap_config_size writes into.

>
> On s390x, writing a 32-bit integer to an 8-byte address only initializes
> the most significant 4 bytes, leaving the least significant 4 bytes as
> stack garbage.
>
> When ap_configuration->num_queues (a u32) is assigned num_queues, will it
> truncate the 8-byte value, completely discarding the initialized high
> bytes and storing the uninitialized garbage data? Could this lead to
> out-of-bounds accesses in the array bounds checks?
>
> [ ... ]
>
>> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
>> +	struct vfio_ap_migration_file *mig_file;
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +	loff_t read_pos;
>> +	ssize_t ret;
>> +
>> +	/*
>> +	 * When userspace calls read() with an explicit offset (pread), pos is
>> +	 * non-NULL and the function rejects it with -ESPIPE (illegal seek). For
>> +	 * normal read() calls, pos is NULL, so we'll use the file's internal
>> +	 * position filp->f_pos
>> +	 */
>> +	if (pos)
>> +		return -ESPIPE;
> [Severity: High]
> Is the assumption that pos is NULL for normal read() calls correct?
>
> The VFS layer unconditionally passes a valid, non-NULL loff_t pointer
> (pointing to a local stack variable) to the .read callback for standard
> reads. Will this check unconditionally reject all standard read operations
> on the migration state file?

The vfio_ap_open_file_stream calls the stream_open function to open
the file stream which is passed into the vfio_ap_stop_copy_read
function. The function comments for stream_open state:

"streamopen is used by subsystems that want stream-like file
descriptors. Such file descriptors are not seekable and don't have
notion of position (file.f_pos is always 0 and ppos passed to
.read()/.write() is always NULL.

>
> [ ... ]
>
>> +	/*
>> +	 * Drop the lock only for the copy_to_user().  The ap_config buffer is
>> +	 * stable: it is allocated once in vfio_ap_get_config() and freed only
>> +	 * in vfio_ap_release_mig_files() / vfio_ap_release_stop_copy_file(),
>> +	 * both of which require mdevs_lock.  Since we already advanced *pos
>> +	 * above, no other thread will compute an overlapping region.
>> +	 */
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
>> +		return -EFAULT;
>> +
>> +	return len;
>> +}
> [Severity: High]
> Could dropping mdevs_lock here open a race condition that leads to a
> use-after-free?
>
> If a concurrent thread triggers a device close or reset (for example,
> via VFIO_DEVICE_RESET) while this thread is at the copy_to_user() call,
> the reset path could acquire mdevs_lock and free both the ap_config
> buffer and the mig_data struct.
>
> Since mig_file is a pointer into mig_data, will dereferencing it here to
> access ap_config cause a double use-after-free, copying freed memory to
> userspace?

The use-after-free cannot occur because all paths that free ap_config or
mig_data require mdevs_lock, and the lock is held for the entire window
except the copy_to_user. mig_data itself (which mig_file is embedded
in) is also only freed under the lock, so the mig_file pointer remains
valid across the unlock.

>

