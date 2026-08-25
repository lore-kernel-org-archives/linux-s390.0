Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E45370D57
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652959; cv=none; b=ItXYFgrhMe0bgKt+V58RDcU/S+sNUkZR5VooNwQmuK8Iw9mpyDD4bXFRJGqWxSjGlKrSKtZnx2ROG4w/aVDzylmp4ZDcQrzu6APgacnzNSIkjhOHg0FvxGlsJOWfvkfh/9Lg/kgIOQkGox5Syb72/h6uMAMFCq4gtLQuTz5A8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652959; c=relaxed/simple;
	bh=AFfXyrw0u+c8zOR1Ie3jXiQM3ZvOttyieXwuc9a1SDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkP42zd9ScQfB3Auw/vqD4YJvijdpGAwNid1QLNKyXr8oMgOIEK8/1O7Lk3WCGpNwT3nUzMyOspYRccnu+kPhGDHdc/eoJumaentijzObTQQ8l+jO6vTyddxETcYPwxCPDC4o02iWOuYyDcfMbhdpZvd7VAoZvTz5Tv/YLXLu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pVdO5a+n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pVdO5a+n"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8VeAA3390556;
	Tue, 25 Aug 2026 10:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bL7pKJ
	ToSzONcUCVfWgloHCdzknQ/Bt1Z+kffOYYohQ=; b=pVdO5a+nNc5UVx1d6LgPM8
	7FLFGGScR3LWkjlaA2nXmeKlYKv9GPVb3c4QxVbXtr5I1veqaSezbtU2w7Z1BfYE
	bDXFpC1pWso2ss7m7xJzDg/p3iEbkNTMTobAPLQupKWZhKKYiAiO2zoLwPErnuFw
	kC+CYO9C4bg1Cg1CpJK8xjGXCZlRJ4/icXh8l+Lz7tpaZz9+ELPLWxergLynvs2v
	UvUTwi/WL5a9afvKu6UVpcVIWLXgSlaOkmVJaZxu+/WuqPy2cBf1J3zVm0GfI8Se
	TnSGhqd1OAKA9lDJ0NkbmQGT1Y8LLvaZpdtlj6J5/RF7WYFVP5zypqsqkNwkv2UQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726efe0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:15:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PABPvq000844;
	Tue, 25 Aug 2026 10:15:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy3cnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:15:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAFgjo24248956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:15:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A9CC58059;
	Tue, 25 Aug 2026 10:15:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1669B5805B;
	Tue, 25 Aug 2026 10:15:41 +0000 (GMT)
Received: from [9.61.78.161] (unknown [9.61.78.161])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:15:40 +0000 (GMT)
Message-ID: <09380eca-8da0-4342-9a49-f86842d1a0a0@linux.ibm.com>
Date: Tue, 25 Aug 2026 06:15:40 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 06/20] target/s390x: Adjust addressing mode checks for
 sha512 and sha256
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260824083204.40877-1-freude@linux.ibm.com>
 <20260824083204.40877-7-freude@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260824083204.40877-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8d6b50 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=XS7WEkP-FYxO3f8Vb7EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4NSBTYWx0ZWRfX3PzTXbGohIvr
 jV7I4Qn3OT/p0wHPvaipKZczMzmypuhF4ZY40EoAC7bNU1jnsME2Q50PnvpAoLNlEOSmqkBl8u6
 ZYfx48ZTmZuxihVsuHuF1+4T02Cjh4Y=
X-Proofpoint-GUID: eNPxap9JMdGDmLWk9LBYyioQ5gxOOgR9
X-Proofpoint-ORIG-GUID: eNPxap9JMdGDmLWk9LBYyioQ5gxOOgR9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4NSBTYWx0ZWRfX4tnwEgUhfiGF
 aYO4ivssRCBTmjXFndF2vKb4ZM40ANYYoIB/KiQL/xvh66diEpQa7s6M1s+qA9t1XlU6rdyYQ0W
 vOhMzxmAUK1CfOTdN2lOX9WAgPByiy9AwS6bQZMnOjQV1VZXCknT+HcYk+smxSU6rLJfpMRsgHv
 igWL+F/kS7gvdbY7qgexga6nowZ8/pGgbqxj0mehvR3glbBaCKNiCsSuj3xngel/BzsvjALebQn
 3Rjl82Niyi2uvUDQmzTpPD8yj2KFIg8sKGp6JkuDCGWE8h44JmeQHpG5rSouIXknjHN1rzkRx17
 so6Dhouxj3fuePBKSBmNB5X2KSQBZyGdyjSgCqg9T8dlGr6x0ckvXLp6j4U9rvAwJtt/PMW4rmu
 NS7PxuECJoAr51FV+qwUx25LxVHse7s2YxmqQH1fbrfirj9nkzwbUWlxnQV25LHDvWiuHv0/RgY
 lD441LdDr3nseuTUyAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250085



On 8/24/26 4:31 AM, Harald Freudenberger wrote:
> The handling for different addressing modes in the both sha
> implementations cpacf sha256 and sha512 was incomplete. Rework this
> addressing checking to clearly have support for s390 64 bit and 32 bit
> addressing mode but raise an exception otherwise.
> 
> Also bail out early (for KIMD only) if length is 0.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf_sha256.c | 16 +++++++++++++---
>   target/s390x/tcg/cpacf_sha512.c | 16 +++++++++++++---
>   2 files changed, 26 insertions(+), 6 deletions(-)

I was going to ask why this wasn't just included in the first place, but 
I see that sha512 is pre-existing. So, makes sense this way...

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> 
> diff --git a/target/s390x/tcg/cpacf_sha256.c b/target/s390x/tcg/cpacf_sha256.c
> index 67321b565c..de305b6838 100644
> --- a/target/s390x/tcg/cpacf_sha256.c
> +++ b/target/s390x/tcg/cpacf_sha256.c
> @@ -111,14 +111,24 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   {
>       enum { MAX_BLOCKS_PER_RUN = 128 }; /* 128 * 64 = 8K */
>       uint64_t len = *len_reg, processed = 0;
> -    int message_reg_len = 64;
> +    int message_reg_len;
>       uint32_t a[8];
>   
>       g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
>   
> -    if (!(env->psw.mask & PSW_MASK_64)) {
> +    /* check addressing mode, raise exception if not supported here */
> +    if (env->psw.mask & PSW_MASK_64) {
> +        message_reg_len = 64;
> +    } else if (env->psw.mask & PSW_MASK_32) {
> +        message_reg_len = 32;
>           len = (uint32_t)len;
> -        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
> +    } else {
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    /* for KIMD only: early bail out if length is zero */
> +    if (type == S390_FEAT_TYPE_KIMD && !len) {
> +        return 0;
>       }
>   
>       /* KIMD: length has to be properly aligned. */
> diff --git a/target/s390x/tcg/cpacf_sha512.c b/target/s390x/tcg/cpacf_sha512.c
> index edd8dae78f..cad8e0e1bd 100644
> --- a/target/s390x/tcg/cpacf_sha512.c
> +++ b/target/s390x/tcg/cpacf_sha512.c
> @@ -126,13 +126,23 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   {
>       enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
>       uint64_t len = *len_reg, a[8], processed = 0;
> -    int message_reg_len = 64;
> +    int message_reg_len;
>   
>       g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
>   
> -    if (!(env->psw.mask & PSW_MASK_64)) {
> +    /* check addressing mode, raise exception if not supported here */
> +    if (env->psw.mask & PSW_MASK_64) {
> +        message_reg_len = 64;
> +    } else if (env->psw.mask & PSW_MASK_32) {
> +        message_reg_len = 32;
>           len = (uint32_t)len;
> -        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
> +    } else {
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    /* for KIMD only: early bail out if length is zero */
> +    if (type == S390_FEAT_TYPE_KIMD && !len) {
> +        return 0;
>       }
>   
>       /* KIMD: length has to be properly aligned. */

