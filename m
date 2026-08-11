Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298144471C
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459403; cv=none; b=N2g92L3P7Sp5u0lZ0lyQo4GpgLjN0HEKdLRW9LrHx/4rd8BKSEYqw3aFugyZpXjvFwst793fVhJFJeRezKo4YBw/hZ0NAfohKUnTVDzuUmS4O/Zs/MGEiYbBxyAJY1L7+C7SCrRzL+pB5YU0wo6PPclMwEoWZCFwxlLPXuGIYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459403; c=relaxed/simple;
	bh=5p2dT7dgQQ8zkYIsHQXI3h4vq/PNdGz+zwFByTfWyzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzcAdGo3C2+cVZ0+O+fwtXUNfFxDExjGwpcJNXwkVlXQE0Lj6qWVaFfPwpSWWyz98Pjzac0apSx/sN7pgV3JLJVdPGzce4/efJ6RBYVpxznmv+IahaFH3XA03sNCdvQOqVWUf3He2x8H0VTPnMLuHAmHC3uQ6e3Hj/dH7LzvYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WUZxn17c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WUZxn17c"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX0un2865450
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kqpHvNMk/ViNBBx2jV6bwl9B4uaKQA
	K+L7VrxYs4GA8=; b=WUZxn17cHniOdiwwhR50NapXG4MfP6nb7xWB2PG5MCmYgP
	wTByi15XKpIXZ42DW9YWSnfyb8JjbpiEiuGodZA11zvx+XcFreOaoXAtRsUE+dh+
	dxcFwOOlAqFcPZoi748RCqS1oILA+4Ndu3jv8UCRyPGSjzoHPf05AoWmLgn8dX+i
	a7opw2q6b2noaJvuiqoYicmisl71ISzO/ecXRmEDAFxtGzXs1W/8VbUQJIFDJVlj
	hUiai1BLM4683PvVkGMw9Xk+GV4IVByCJanFmcae5Uu1otpLye9F73WMLmrZFWTd
	uSQK7a/FBFkK+g/+uZY3fcKDQ07XCRbB8Fz3MR3w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjywecv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:43:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfFoC005352
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:43:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjsbsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:43:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BEhG8k35258812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:43:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF2820043;
	Tue, 11 Aug 2026 14:43:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF32C20040;
	Tue, 11 Aug 2026 14:43:15 +0000 (GMT)
Received: from osiris (unknown [9.87.143.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Aug 2026 14:43:15 +0000 (GMT)
Date: Tue, 11 Aug 2026 16:43:14 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, japo@linux.ibm.com,
        agordeev@linux.ibm.com, iii@linux.ibm.com,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3] s390/cpum_cf: Handle CPU hotplug via prepare/dead
 callbacks
Message-ID: <20260811144314.12308Eea-hca@linux.ibm.com>
References: <20260811133901.3765063-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811133901.3765063-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX/OEOYHLZ2UZg
 wojukBBrH6jEg8HX5XvVtVi5mCeA6mGeX/JleY/Wzl0+oUb4djrIblgYcr8n0xipAWsV/04Q9Cg
 b6NRfMfinxCLUsnPDGyf4miDV3LZ+RJ0h4JDcU6R5amEyUBOR5zmaEIGhwxm/rDjx+YNA4Mw8c1
 mDN71X9zieZBBMosqXhnyVWe8fRx+Dzem9lAkJMXLfSDWTnGb1h7jBNZkItjbYO4FsrUeLpwtDd
 HNx5z13e8MNeyc7em2Dy7DVDTEl5suAcg3ctTGeLqL0+fnFNUese2fvY7IN5gm3PAwdRCjvdXhx
 F//pqOdib+ygKrWCF+O6NbNjVT9piYYSnmzOWoN3d2qRndta/2dKF3ddN34vMdEv3NptRmSkQ/L
 Ga+u8VFuBTyhnI9TqdnqsksN4i/z/g3r6sJuwQ+fL1/jxIj5Zu1zb65WsyAh1sJ5C/Tvbh4TtXx
 ww14PFn7JXVsNMOBYvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX2KLYTA2Zgpiu
 IXOwrW0pqvmz5ee/ImDjNT2eToStagQaEiFB4mGCSR0wt2MNOErxtKtcg4goGL8I7p8BwLXJ2kx
 GjdadXIIGgX9hKWcJIzar0nZza9tzA0=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b3509 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SVoRsXcwFpO9loE_4oYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: L7cJTXfRZkrfY-te-m-fM86gSwlUI2_I
X-Proofpoint-ORIG-GUID: L7cJTXfRZkrfY-te-m-fM86gSwlUI2_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110121

On Tue, Aug 11, 2026 at 03:39:01PM +0200, Thomas Richter wrote:
> The command 'perf stat -e cycles -- <command>' crashes the kernel
> when CPUs are hotplug added during that run.
...
> Fixes: 9b9cf3c77e7e ("s390/cpum_cf: rework PER_CPU_DEFINE of struct cpu_cf_events")
> Cc: <stable@vger.kernel.org> # v6.5+
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  arch/s390/kernel/perf_cpum_cf.c | 215 +++++++++++++++++++++-----------
>  1 file changed, 142 insertions(+), 73 deletions(-)
...
> @@ -167,12 +170,14 @@ static void cpum_cf_reset_cpu(void *flags)
>  }
>  
>  /* Free per CPU data when the last event is removed. */
> -static void cpum_cf_free_root(void)
> +static void cpum_cf_free_root(unsigned int num)
>  {
> -	if (!refcount_dec_and_test(&cpu_cf_root.refcnt))
> +	struct cpu_cf_ptr __percpu *p = cpu_cf_root.cfptr;
> +
> +	if (!refcount_sub_and_test(num, &cpu_cf_root.refcnt))
>  		return;
> -	free_percpu(cpu_cf_root.cfptr);
>  	cpu_cf_root.cfptr = NULL;
> +	free_percpu(p);

This appears to be an unrelated fix. But anyway:

Acked-by: Heiko Carstens <hca@linux.ibm.com>
