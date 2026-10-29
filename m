Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285804;
	b=oaxM/P9lHl3DLJEYaIlYdHJMpPJL06sKWq3M3HBCy4+V+TNJZhk6t/pgkfDotBQVjYO5
	 UK6enngAnjvaVJyDFZRMT6aVayU6T1zPMhEGmXdTIkfBLc81CZ6qOBepCp8aMWCTd6aM9
	 d46C6ALDyNqUDDK7aeXuWh1r27AdaZodkZQhP6Ys5VwltA1shbaBjbc6idA/VcZqUwAtH
	 a6o78knJ6vC/cQPLFZu/lDQFjIIlwY+npZqn8fkPJWTIocL+5a3h/cKPc2wCqjXhfWNKW
	 lqTbLHcjj7Fo8PS1cjP2aLcanqICUIWmiSqFcuxIUGrx+Jx8yRQPBPwz+zUJtEyc3Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285804;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GHgvV6rzEEa0plcFuAOk8oPHdGIYn1CeqwTmGhSiL/k=;
	b=xZTaFuMg6PsdVLxysqHTV7pGObIX1F3INxr7kzrQ4ZQWZWIUYxbO4gx0irhO6h9g3K46
	 hLPhgIF+4mVXdfzQVVvbATpYhxv8vLelp4Mvsv7fKevN7a5u0VmsWRDozuw9rXPZOw/vW
	 kV0QlEEQzRYGPpaN43aPKOyof9IIcHOB3GTzR0c4TGFi99VdhFWrcPf/S4QDPv0iMMq28
	 orQde8hCEwYheSfam3FNWRfNLZNvhr1xA3ytFt8aHMVh8wk4rDE1m90uo9E984dJfhso4
	 QPZqrnSh8kpleNcTg37TFC10ECNxGMiXciqYHYDNkkN6NKcV5lILrWD+0D2yMhn0Ztw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ASfxCxQ7;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F67606A31C;
	Thu, 29 Oct 2026 14:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63F67606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ASfxCxQ7
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCi9Yn4142674;
	Thu, 29 Oct 2026 14:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GHgvV6
	rzEEa0plcFuAOk8oPHdGIYn1CeqwTmGhSiL/k=; b=ASfxCxQ7RQPWCD5kKYOHZA
	R5SBzGT/zeqrzDfqePWJ0Pv0cvPB1Uo32CYdNPcqepSZXlQ7UehjmCtDdLXvvm8O
	CpH9K6LgReh8NbTWyYs7CPOgDtQBV5VoQaEi8jrexiPNLNQg6VK4hsStZ4hKSFV+
	cyVXydB7ONA3/4/vjI3kXCnEgtxYmbRTsJdWSqGYZEfsq60GLK/oc8xEvJ226iQP
	na/gTVtEl3MOC/Ih6WO/fMpbULcAu9NTDvptwy1Hq9UQdj6S7b8ZleNnF/yPV1ON
	ZTORQTcTuJ5m70zEbPJF73b09uWJTw8ewVz+6P7hrTw31LbtMy10AyULfXOuXayw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mk1yq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 14:56:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCntAe1967902;
	Thu, 29 Oct 2026 14:56:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010rp8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 14:56:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TEudle32506480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 14:56:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD8D58070;
	Thu, 29 Oct 2026 14:56:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C015B58060;
	Thu, 29 Oct 2026 14:56:38 +0000 (GMT)
Received: from [9.61.101.238] (unknown [9.61.101.238])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 14:56:38 +0000 (GMT)
Message-ID: <f040a2b7-59eb-418d-b8c8-239acee73eb9@linux.ibm.com>
Date: Thu, 29 Oct 2026 10:56:38 -0400
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
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-8-akrowiak@linux.ibm.com>
 <sashiko-outbox-183048@kernel.org>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-183048@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1NyBTYWx0ZWRfX7mhOHVUYbVFi
 3nt7w/QOIqPzotF+6wz1VkqZdrgg0hyWG67VCcfkCJP12AdaECv2BYsfMH7UX4TB81S0Z0KS7TX
 knrr9pZPDvMrkhSKMJLH5OjA2Mlg4fY=
X-Proofpoint-ORIG-GUID: YFynBK0IxjQGS2R-naA5rVEPFav2hWw2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1NyBTYWx0ZWRfXwTLmGnmYCEOY
 9B+isGQWWPDUrzzGbWypTK/lribJNaJbAnIujnALRvdUaayUFnld1Xlc/yWq9jYDP/KkTZVbAhI
 V/+2GmdfoN37UQmgBaTiZSdo5tSTfoDIOAja7rd/XGpGoWr/2EmQEIyU3fiyRU27nuG+LXv4WxM
 s0zysLyNwnq3HkzxETSpJfnKvP2Q8YBPIvDz8MTtsXlDB9zcADBOo5zxpp+N263vYlDiWx/1q7y
 5ojKszu1mwPawJJsHe6Wcyx3v7Z/nPlcIUR5k8KzmajsC6yxuhcN4CByjz4wxU1pl8Rmzd3Ep5D
 7YFsmEcUunc6tQ2iP5XswCwn1LFM808OFeo0iCBnbIVeTUaj7KA7YJydgdHERkzthInnpdvh/Et
 bgnzOFI5GH0c73bDRLtCdYFg1UM14dyhTtvh0mmTjeFZsaTXPIGkN74ObwJlATjqt7SA65UDKfw
 LU6hzwmw0CzO++YEjYA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae35eaa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=s6wHbzJGuloGhX0a5BcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YFynBK0IxjQGS2R-naA5rVEPFav2hWw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290057



On 10/23/26 2:10 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] s390/vfio-ap: f_pos corruption on -EFAULT in vfio_ap_stop_copy_read()
> - [Medium] s390/vfio-ap: high-order kmalloc() in vfio_ap_stop_copy_read()
> --
>
> commit 244125b3df6e4802b043acebf35691558c6264c3
> Author: Anthony Krowiak<akrowiak@linux.ibm.com>
>
> s390/vfio-ap: File ops called to save the vfio device migration state
>
> This commit implements the vfio_ap_stop_copy_read() callback for the
> migration file created when transitioning from stop to stop-copy state,
> copying the guest's AP configuration and queue hardware information to
> userspace.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index bc216c51a1a79..f9b00fb89410f 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -162,6 +155,269 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
> [ ... ]
>
>> +static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	struct vfio_ap_config *ap_configuration;
>> +	unsigned long *apm, *aqm, apid, apqi;
>> +	unsigned int num_queues;
>> +	const char *mdev_name;
>> +	size_t ap_config_size;
>> +	int ret, qindex;
>> +
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	ap_config_size = vfio_ap_config_size(matrix_mdev, &num_queues);
>> +
>> +	ap_configuration = kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
>> +	if (!ap_configuration)
>> +		return -ENOMEM;
> [ ... ]
>
>> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *buf,
>> +				      size_t len, loff_t *pos)
>> +{
>> +	struct vfio_ap_migration_file *mig_file;
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +	void *bounce;
>> +	ssize_t ret;
> [ ... ]
>
>> +	/*
>> +	 * Don't read past the end of the AP configuration data. Limit len to
>> +	 * the number of bytes remaining.
>> +	 */
>> +	len = min_t(size_t, mig_file->config_sz - *pos, len);
>> +	if (len == 0) {
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Copy into a bounce buffer under mdevs_lock and advance *pos, then
>> +	 * perform copy_to_user() outside the lock. This avoids stalling
>> +	 * all host mdev operations if userspace passes a buffer that faults.
>> +	 */
>> +	bounce = kmalloc(len, GFP_KERNEL);
>> +	if (!bounce) {
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>> +		return -ENOMEM;
>> +	}
> [Severity: Medium]
> In drivers/s390/crypto/vfio_ap_migration.c, vfio_ap_get_config() allocates
> ap_configuration using kvzalloc() with GFP_KERNEL_ACCOUNT because a guest's
> configuration can hold up to 65,536 queues, making mig_file->config_sz up to
> 1,048,624 bytes:
>
> 	ap_config_size = vfio_ap_config_size(matrix_mdev, &num_queues);
>
> 	ap_configuration = kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
>
> In vfio_ap_stop_copy_read(), len is clamped only to mig_file->config_sz - *pos
> and passed directly to kmalloc(). When userspace reads the full migration
> blob in a single read() call for a guest with a large queue configuration,
> this requests up to an order-9 (2 MiB) physically contiguous allocation
> without vmalloc fallback or memcg accounting, which can fail and trigger page
> allocation warnings on fragmented hosts.
>
> Should vfio_ap_stop_copy_read() allocate bounce with kvmalloc() using
> GFP_KERNEL_ACCOUNT and free it with kvfree() instead of kmalloc() and
> kfree()?

The maximum migration blob size is bounded: 65,536 queues *
16 bytes/queue + 48 bytes of header = 1,048,624 bytes (~1 MiB).
KMALLOC_MAX_SIZE on a 4K-page kernel is 4 MiB (order-10), so
a worst-case single read() of the full blob is well within what
kmalloc() can satisfy without vmalloc fallback or a page
allocation warning.

The bounce buffer's lifetime is also strictly local to
vfio_ap_stop_copy_read() — allocated, memcpy'd, copy_to_user'd,
and freed within a single call. There is no accumulation.
kvzalloc() in vfio_ap_get_config() is appropriate there because
ap_configuration is a long-lived, variable-size allocation;
that rationale does not apply to a transient bounce buffer.

No change needed.

>> +
>> +	memcpy(bounce, (char *)mig_file->ap_config + *pos, len);
>> +	*pos += len;
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	if (copy_to_user(buf, bounce, len)) {
>> +		kfree(bounce);
>> +		return -EFAULT;
>> +	}
> [Severity: Medium]
> What happens to filp->f_pos if copy_to_user() fails in
> vfio_ap_stop_copy_read()?
>
> In drivers/s390/crypto/vfio_ap_migration.c, vfio_ap_stop_copy_read() sets
> pos = &filp->f_pos, advances *pos += len, and drops matrix_dev->mdevs_lock
> before calling copy_to_user(). If copy_to_user() faults and returns non-zero,
> the function returns an error while leaving filp->f_pos permanently advanced
> past the unread bytes.
>
> Because vfio_ap_open_file_stream() opens the migration file with
> stream_open(), seeking and pread() are rejected, so userspace cannot rewind
> the stream. Any subsequent read() will silently skip those len bytes or
> observe end-of-file prematurely, corrupting or truncating the saved migration
> state. In addition, because stream_open() clears atomic position locking on
> filp->f_mode, dropping matrix_dev->mdevs_lock after advancing *pos but before
> copy_to_user() allows concurrent readers to advance *pos further, preventing
> a safe rollback and allowing out-of-order stream delivery.
>
> Can *pos be updated only after copy_to_user() succeeds (or only by the number
> of bytes actually copied), while keeping concurrent reads serialized?

This is a valid concern.
The problem will be fixed by introducing mig_file->lock, a new
mutex embedded in struct vfio_ap_migration_file. mig_file->lock
is acquired before mdevs_lock and held for the full duration of
the read — across the copy_to_user() call — so only one read
proceeds at a time. *pos will be advanced only after
copy_to_user() succeeds. If the copy fails, f_pos is left
unchanged and the caller can retry.

>

