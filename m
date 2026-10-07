Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1D3D300E;
	Wed,  7 Oct 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404341; cv=none; b=KffU8DFPIzmrIfGqVVr6kAfErahN6I9DKwC6rBJ4Le8J+D/DlPjEpC6jxOnUpne5WeidXbFFXLMR4EzYljWfwZ4tJx1dtulhIR+t541AjDJz3JOK92pEff0OAIDolxiHuBG5rqS6tWrud+jJM+ihFfo+RK3aN7X9lcKxxHCCw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404341; c=relaxed/simple;
	bh=jaGjbCX30IP5gcZuGZBSN6s16ZJT+L28jz5NfrXrq10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2NdDwpUv90jTFFifv7EgsH6kASto9s0S4scPjj+7tTg41pVT7N+fAiXBlpTi+B5zFkbRfv37o+79zaQBRLAj3dX31ubFoJkTBYRJ4aZh9ri5TIQoOoW4TiIrv8Gh3EWIPlRowmBebabf3UFWO63W+gGTEdYWIzyyquM3KjKgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IJ2A46Gr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IJ2A46Gr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697IZneP2078525;
	Wed, 7 Oct 2026 20:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F/w4Ei
	7m1ijZDtGV38HNzmkRzX9bVVn03kEKk6+et2k=; b=IJ2A46GrFJd7H2DOb8ebNs
	lc+daCxsTUkstT2jpyk9n7EYk6vd6F+3Y/dp3erZFX36MsMh6qZizP7SOuywqw3/
	8JrM7fOBBQVZc8cwCnmISLotos7xx8v11OJ5D5LYVxVeQp9chwDuCbcWpYH7qBUa
	zB+AM9mS7kYDk/BHTHwo6iMfvBkrgHWZvI0o9YzTgquxXCOosl26wJb9sazUqMiW
	TGYsw9GNB1wM/t0AdOEfPoFrPms7DYxfarpx1MuZPfbt+OiE5gKC6txt42XiK2NY
	unsbEFpN5yTf1t03oVyjphFk8laUyeWitnHXv8ccMD7PhbzpWOctQYEqSMyyoSvw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4g6uvw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 20:18:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697IHapf2245375;
	Wed, 7 Oct 2026 20:18:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5mhhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 20:18:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697KIi4Y66585066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 20:18:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 353B55804B;
	Wed,  7 Oct 2026 20:18:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4472E58063;
	Wed,  7 Oct 2026 20:18:43 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 20:18:43 +0000 (GMT)
Message-ID: <694c1e08-820f-4275-988e-2be331070766@linux.ibm.com>
Date: Wed, 7 Oct 2026 16:18:42 -0400
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
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-8-akrowiak@linux.ibm.com>
 <20260807223752.4A6F21F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807223752.4A6F21F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac6a925 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=c9lllFr1qAdO0OxGiBcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MCBTYWx0ZWRfX7/HVTDstNQiy
 dOdaP2yZDuDjPYr1nKsXL2u8+tZ+YKCEgHPaItzMNw5fx7qMEJw/gt99YvHaNWOF7vM03RfzYrd
 LCGX3p8C3rOOhYva17x6+J21y4R2EBAWUbCrD33VWSa832ws2fOpk4DrExe3PVMrhx1i0I3E7rM
 Z0hXPSrdtbT4NHbRu9RtgeNq2egVH7BX2er1CtwJU38gihWxSDZ0qD94C131zdNhocfcRBRomc0
 yYSwaOiLq42hmUq2JkybNLulV7jcC/gbJzuTkyDqGosyKZOrgdf+D3MeEff9Fr1b+5CaRDxPOBh
 VlKOiN9mMhhWXokZ8ayuQYKG6iKacx/lgwAFDv4zrbVEpsbP8whJc1kLz/5l+v8GdpBAJ1EIYxU
 wVIwS1mGNhb/Eeb+IyA7aGTDw+lzCgg5i/5mvblbpPjZyxGRmDTaT2D36TgCoiwk4VY1wBvwfQO
 7HhFvpHzSawLkm4I0Bw==
X-Proofpoint-GUID: 0KAoQC5oYcB86BVxjRotqwTvFp24cF5A
X-Proofpoint-ORIG-GUID: 0KAoQC5oYcB86BVxjRotqwTvFp24cF5A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MCBTYWx0ZWRfXzvQqT/SDDPoe
 yytbFJRbkrhD7MbUNHs/HePQDJ/1x2TeHxbcbyyN+ncnHakzjOCOGRN0p54qFM3YfYJta2sedT5
 3/aH0N8a0pwFz/LNe/d3AVfou93f9Ow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070080



On 8/7/26 6:37 PM, sashiko-bot@kernel.org wrote:

All three findings were consequences of the lock-drop around 
|vfio_ap_store_queue_info()|and the 
unlock-before-|copy_to_user()|pattern, both of which were removed.

>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index de693b308925d..50781b61f7f18 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c

All three findings below are consequences of the lock-drop around
vfio_ap_store_queue_info() and the unlock before copy_to_user()
pattern. The mdevs_lock will be held for the duration of the
vfio_ap_stop_copy_read() function in the next version of
the series.

> [ ... ]
>> @@ -150,6 +144,279 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
>>   	return 0;
>>   }
> [ ... ]
>> +static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
>> +{
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
>
>> +		return -EFAULT;
>> +
>> +	return len;
>> +}

