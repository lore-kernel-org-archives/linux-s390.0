Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793919987;
	b=SJGfJpKIMbdxKnAQEhNwKM9eP/OhwpH20/KRa2xjnzTNc9iuzM+1IWK7d6NAZXUJ7YxA
	 300w2r/61eT85iRD1pD1Y2rO7KFV0WXQruhByhYRuKa/BGVwGgCK1VpdGIlIt+wuFkYLB
	 o5PtYyoUYZ1TSC/8k0P+CHeQcXFjoA/RE9PDTn6VGuUputH3ysBOp/e75/UvhR/cIFjS9
	 Si/DuxLpmk8MnyjknbFNNZh4po5rxOc+Fkdt8wbwMK5n4XQwXIPehVbIq3w9/UTC/I1o+
	 HNaDeSW8ZZvZ1xCRKngNiOANMxqNTIR9E52xwytQrpXXroxFxBLS4yDDUsy/VhFIjHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919987;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=A50TGhglsRdL+CT+10ZYns/8Bqm+RgIe+07yNUEH2gI=;
	b=Dmzh56ozYX+GbCMQevHzvIOy0rmj2DHqth2xWsiImiocPZy7Gl/rJGKBYMFwIK7ARo8Z
	 NI3Et5Z88RMqCoob4YUlteU766i7P/f44zbcOCF0QFtUNrLtCnZtyD5sgAXlDRth4MFfb
	 LERYkcwt6WZ1dFQGkLhL2tdnliuz1ZrJFKcyySnu7nHZW6me0zXCmTJ+OVrxyW5vSTti2
	 vcZ5UXX/KX2SiWJ5o2SFM31DI40rYJOaKBJPP664kXs5BE6zaIlSyAni8bkB9mXLLeAk5
	 hdPsmqQGHjKYUb6Jfe6FgYD1kqA6/+P4tfdrek3qHYntuMg8gv1p5s75b+0zgZSbnug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AHqOd9rk;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB65606A31B
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 23:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB65606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AHqOd9rk
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5LEjtE3455299
	for <linux-s390@vger.kernel.org>; Thu, 5 Nov 2026 23:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A50TGh
	glsRdL+CT+10ZYns/8Bqm+RgIe+07yNUEH2gI=; b=AHqOd9rkooN9OsbG1sFYQS
	nkp2+57KGjhPy6v028ejtdgInKWZgOMSlxguIwg7WEOIhIWVBFMqT6BSmcXRSBnI
	bgpPA42dUv8CJO0JElbgzhc3QNSGbSdbIoGrc11QMt+Lbbuf6dtQ+t4jSC54U6Hk
	mTyX28KQT+wyjG0ALdXsJgbvyExSNoDQrDJ50YYYTR26SdcZ1oo8nYDialzPvOyY
	1vCiAL3cE/R11q4MKHbbTifDvK5VQJFUnqxKFK+sBwgDHLJozf8WgXInZ3bWdN56
	JK/5tp7YK28ko9mMIuwJLvIfLrUlqPPm7Ieq088m6NiPQ9VnwJWJOciz5Nx1EIqA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdn06x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 23:06:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5L5uBU2298547
	for <linux-s390@vger.kernel.org>; Thu, 5 Nov 2026 23:06:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7p8g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 23:06:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5N6LNp29753722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 23:06:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E62620040;
	Thu,  5 Nov 2026 23:06:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 010A920049;
	Thu,  5 Nov 2026 23:06:21 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.51.231])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 23:06:20 +0000 (GMT)
Message-ID: <97ebb3cb-ce2f-4695-b4bd-8da2dcecf873@linux.ibm.com>
Date: Fri, 6 Nov 2026 00:06:20 +0100
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
Subject: Re: [PATCH v5] s390/diag204: Add common diag204 interface with
 caching
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20261104-diag204ioctl-v5-1-87a96638d58a@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261104-diag204ioctl-v5-1-87a96638d58a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pevK3_UqIjmHFKM8furVHq53iXWh25l7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA5MCBTYWx0ZWRfX/8siL3V2+p+J
 Fo0Jod2Hb6xySb/YkJNX58KBVHWjjrh2t56XT8ZcMgLUAR6Qx3xrVOBE9u7P+z9uWpA1W6Rp2sJ
 PT9LI1MAatltxxjVwIBz0tzB8VSUGO+MfqpPvFuPw0K1iCbI50aGnDkFR+b27W9ognBgzwhlWEp
 SJZ2dZjLkBbzTgM+0sbO9EPyusZCpehMne9I/WRXUwnzNGl5bW+AvRZviElSFHqFK/+n1S0sdbZ
 Q9sHYu8385/rETq/hZvo3gAte61FNQC20JdjNaS9UVGtg+d2LHcISoCm7vDWgjQr5lpQ0v7Lu/6
 JD5zUXwxoGGCCZRkSLfa0n8uyLgzOPvOnkMoZ7/stR6qb9g6pFXRsV8IvXOUY4XJvTdNnCf13Iq
 RP8Uww1o6cJhv5QXrpkhwi5xO6sWZkqyUvL2JHAu8vZi07YkyKsNGcm17kQJSMi6GRsory3T8UF
 1aqQQfY6YVG5xSlhr2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA5MCBTYWx0ZWRfX23in3NWHvqSS
 DWi0jFm5Usg9cI+fM4C3fT3UZQ7AgCCaBcBtYBbDQ6XuD6SMfcsWJOH+vve0RXL6YLOx+ujfslb
 5SyYjORwd3z5dCpS+2M/Dr97mnKI24Y=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aed0bf1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=-GcjcKohFsg8jfPHN3EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pevK3_UqIjmHFKM8furVHq53iXWh25l7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050090



On 11/4/26 10:24, Mete Durlu wrote:
> diag204 is currently used by hypfs and sthyi, each with its own probe,
> buffer allocation, and store logic. This duplicates the subcode and
> data format selection and lets any caller issue a diag204 whenever it
> likes, which is costly on the hypervisor side.
> 
> Add a common implementation in arch/s390/kernel/diag/diag204.c and
> convert hypfs and sthyi to it.
> 
> The supported subcode (7, 6 or 4) and data format are probed once in an
> arch_initcall. As a consequence, all kernel configurations, including
> those without hypfs, now probe diag204 at boot.
> 
> diag204_store() serves data from a cache that is valid for one second.
> When the cache is stale, only one caller at a time refreshes it by
> issuing diag204. Other callers wait on the mutex and then use the
> fresh data. Within the validity period no new diag204 is issued, which
> limits the rate of diag204 calls. An idle cache is dropped by a delayed
> work after 10 seconds to not hold on to the buffer indefinitely.
> 
> If allow_busy is set, the diag204 busy-indication bit is passed to the
> hypervisor, the updater may return -EBUSY, and concurrent callers
> return -EBUSY immediately instead of waiting. Otherwise callers wait
> on a killable mutex and get -EINTR if interrupted.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

[...]

>   arch/s390/hypfs/hypfs_diag.c    | 131 +++---------------
>   arch/s390/hypfs/hypfs_diag.h    |   5 +-
>   arch/s390/hypfs/hypfs_diag_fs.c |   8 +-
>   arch/s390/include/asm/diag.h    |   7 +
>   arch/s390/kernel/diag/Makefile  |   2 +-
>   arch/s390/kernel/diag/diag204.c | 284 ++++++++++++++++++++++++++++++++++++++++
>   arch/s390/kernel/sthyi.c        |  30 ++---
>   7 files changed, 324 insertions(+), 143 deletions(-)

[...]

> +static void diag204_work_fn(struct work_struct *work)
> +{
> +	mutex_lock(&diag204_mutex);

Consider using guard(mutex)(&diag204_mutex).

> +	if (!diag204_cache_info.buf)
> +		goto unlock;
> +	if (diag204_is_cache_valid())
> +		goto rearm;
> +	diag204_free_buffer(diag204_cache_info.buf);
> +	diag204_cache_info.expires = 0;
> +	diag204_cache_info.buf = NULL;
> +	goto unlock;
> +rearm:
> +	mod_delayed_work(system_dfl_wq, &diag204_work, DIAG204_WORK_DELAY);
> +unlock:
> +	mutex_unlock(&diag204_mutex);
> +}

[...]

> +/**
> + * diag204_store() - Store diag204 data
> + * @buf:             Diag204 data buffer allocated using
> + *                   diag204_allocate_buffer() or a page aligned, zeroed buffer
> + *                   with a size acquired from diag204_get_buf_size().
> + * @allow_busy:      Allow diag204 to return -EBUSY instead of blocking and
> + *                   return early when there is a concurrent updater.
> + *
> + * Diag204 queries CPU utilization data from the hypervisor. Per CPU
> + * utilization information is returned either only for the current guest
> + * or, with authorization for all guests configured.
> + *
> + * Context: diag204_store() can sleep and holds diag204_mutex to serialize
> + *          diag204 cache access.
> + *
> + * Return:
> + * * 0 on success
> + * * -EOPNOTSUPP diag204 is not supported
> + * * -EINVAL if @buf is NULL
> + * * -ENOMEM if the temporary buffer could not be allocated
> + * * -EBUSY if @allow_busy is set and diag204 or a concurrent cache update
> + *    is busy
> + * * -EINTR if interrupted by a signal
> + */
> +int diag204_store(void *buf, bool allow_busy)
> +{
> +	int rc;
> +
> +	if (!diag204_is_available())
> +		return -EOPNOTSUPP;
> +	if (!buf)
> +		return -EINVAL;
> +	rc = 0;
> +	if (allow_busy) {
> +		if (!mutex_trylock(&diag204_mutex))
> +			return -EBUSY;
> +	} else {
> +		if (mutex_lock_killable(&diag204_mutex))
> +			return -EINTR;
> +	}
> +	if (diag204_is_cache_valid())
> +		goto copy;
> +	rc = diag204_update_cache(allow_busy);
> +	if (rc)
> +		goto out;
> +copy:
> +	memcpy(buf, diag204_cache_info.buf, diag204_get_buf_size());

I wonder if it would make sense to return the buffer address and keep
the lock. Most callers should not take more time than memcpy() and would
benefit from simplified buffer management. Others can do memcpy()
themselves. __acquires() and __releases() annotations should help with
keeping such solution maintainable.

[...]
