Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24582F1FE3
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295518; cv=none; b=nn457hQFIYT+T5JmgFp7cCnBblRkKhpfgxL4sz6Vr4Tvtwx1rtN90lWk2T8P4x50JLeEfXqFY23XKisbFDFs9sU4NZNFQupVHr6M8KkrHxF6z00WqEl7Uh17bFwmJ71y+h59w+7VhzpwdJut5IljIpJdlISVk3CUjVkjshydFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295518; c=relaxed/simple;
	bh=JNndH+/TT3o74kw/qD35w1iU6knv5I3CurU35xWkXt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5/BiQAV2hTgp1nkkqGtXdyliDu5RGtGoO/cT+1i7RyhyRFzQpYYyjCfs7rPCF4yBn28Mq2Nu+VbNAVAlaRwSZxIacwGC+14j1ppLdJJf+1G6N7NriMOYoOLcedBUO0+4iFK8vi+iwu5oZwE5IghR3y8o7laVMyleYMNcFO81Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1KMG45S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R07L6B2B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1KMG45S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R07L6B2B"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5tqjP1972120
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 10:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uU/Ml621cQtEnZliL5dK89EJFC8pLUw2zGcbYsIGt2E=; b=S1KMG45S0BWArSq7
	jUAWPDxx8rmuM3sKXskhN8syHtvrrEWm+bmJB1uAnhBJj6cBodYqlbCX01qLYKbd
	YeZjonW8j9XejcrEMFEYjrawZzHMdRUOXzS/JZ+bhM/SOqnBEvkZlK7VCuSvVdxX
	UitYDeaNEqk6XecswTHjz/5Y8FwpFLVee5rGs611xV/mkB4uHpPrPE5FMNPkDCjf
	eAamY7Mb78ksrrIYtqc4oBL7NiYSZ99yu/1cq6GbgCH2Q28ktpa8u8EUyHS/vMcw
	ACpG9sP2SHXjqsJCsiyDTbXSheVk6RaLfVZquxQw2W2G56r2Th4vftJgYECBVTeW
	tJlVkw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f00evahqy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 10:05:15 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-728e3a5b3f2so244393137.1
        for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782295514; x=1782900314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uU/Ml621cQtEnZliL5dK89EJFC8pLUw2zGcbYsIGt2E=;
        b=R07L6B2Bl24wr7qdU5u5uDyF+AdUdlLzLwo/weelY2JrqNiFszFs9/1VyXQZSxRHh2
         vtp4C0TY+HKXBfr7YdNP3V6LsRs1BLvNQgPdew8amTVwxGK7+k8vWchK78RLJHAqeoqX
         Ifbm+kdE1FSzaLq0E3JOJEbRPXmJI0PNW7WnGC1QzqLc57KZ4cK4lWeYG9rUgvS0HgB0
         o5uuTQaAJggSq051kwyKx8JSNaNDc29XqHo7Pki85zIgloH8UDXpDgeklK9USaKkBqvz
         5GX2NE2IHiYLX6ZGhAuWbte+KSN2JK6/4Dmqg1vlvRCpU43XbJ04zpp0IVz2nkbwk7UK
         jjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782295514; x=1782900314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uU/Ml621cQtEnZliL5dK89EJFC8pLUw2zGcbYsIGt2E=;
        b=gAKaI+nTnWSK6ltKTM8Cy+fifL7GAP5Efj7H7zKp8cLBGFYohkSwIk45KweqNs+2IN
         bWpqLLrLU7D49KMbskTIUuW0AGOjF8oRAmK7KM51ntudjThsIGEsermsQhh5mA+3TK8s
         w/k0BsBn2BcCgGHcgOZc72RLugFrWU7SE0pIvwzb3QN9fdJFPMHKZQhcNwj8xzCeHsMH
         Pelm10M7D+AW57KMiuxKtUTaE/pEnSBq8iyfH93UCVeeU9RwagQNlR02BA8DwuewLA39
         UNhdYfh1cRbcnCoFYhRiwGYXpQt9PrQv2h8KhJAWNyiOBjHV+wg1R1VwAZXU1MLvR8+e
         PmRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8snUWzvA0W7pDboRdA6dCvSJGiKm1M/Nq+RW9VfeLYW5dgj09CAgKV/gbnyKMIEydcnCJHb9QWK5ME@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl3yiR2i6eJFnyA38UvdWhMWqqYUwMfEkv597BD5JICgK5PfZ7
	4P2gdVJh6ZmOd/WvuBON0kHtfNXjeqac4lzKTefujgcskStAWDbAcLeWG81v08MFjUSLhRte71v
	keYsg9oD8oG5Hm3ofy6jvpGl7ORYoPVvVWDWQJ4krE01o+4UwvCb7honMygS2TwWo
X-Gm-Gg: AfdE7ckdPKdURVR41xfWbNfO8nklx0wHaO2gyXvblDsV3noEoBsEzj3yIGQTNBB3/Bf
	Rg3gQ6VcfL6B9I9Ixueeim8elhF8hjcUkYtTPDqOdXL+S6aoghdc4nCXbEy/4uRUO6zMPgycpPw
	ORqdFIlV+Vo9jQM6pTvm6nBQhdsUaV0+jX5g8UB4sbfsnIQWqoWzfDRVCMrA5OLj253r0cUo9Y/
	WStEdcOy/UiD1b2SQLOVpa+kqAB26WclifAqT2gXLem3QZfAIEkQ1oJdqbIqrh7QR7+3MGVd3wc
	SZ+65LMc4ApNA7fQAzx5DsjZpY1SLYo0dKi8DePmPabsTBjCB1HJWi9S3jl5aS3kEXQ4PNQaQNk
	Yh6kYqHVy8ErNNrK5Lb1d7xcCgaTw83Lx9NFzSwhZAykFF6KatXpJH6ou+myODg==
X-Received: by 2002:a05:6102:2d07:b0:6a2:b2a1:f16a with SMTP id ada2fe7eead31-72fd549000bmr3831255137.2.1782295514311;
        Wed, 24 Jun 2026 03:05:14 -0700 (PDT)
X-Received: by 2002:a05:6102:2d07:b0:6a2:b2a1:f16a with SMTP id ada2fe7eead31-72fd549000bmr3831223137.2.1782295513611;
        Wed, 24 Jun 2026 03:05:13 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49260915286sm104344865e9.1.2026.06.24.03.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 03:05:12 -0700 (PDT)
Message-ID: <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 12:05:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Content-Language: en-US
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624081029.23815-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfXx7vYt9SrRWWa
 XXIIBqwdmc11HkNy0l+Xu3nkiHGPh362JnXrkEdrmKtok/LirgsLGh7SlquIt9BHGVCsR1rlCXZ
 9Uc1vNFFM8v6/M47gxZIgefx0lb+Cqg=
X-Authority-Analysis: v=2.4 cv=JbaMa0KV c=1 sm=1 tr=0 ts=6a3babdb cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VnNF1IyMAAAA:8 a=nqnWPUv0DkUVY7dcfF8A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfXxMw2LipnAF4D
 AkgTvQumaF2PLRo6qbM33jTURuHl9q1zlm6NPMYxzehp6g/xa45xJ1fKs0B0fQL9mTfJa9FP/xx
 bRnA0dfrbdktuUvxKROLE1I/Q6MgyTXWBHe22dcHF7UIu2bF0c+yR2rR8yBjs6C+uFoO4sdf9MP
 WCjDLWd3DqrMASyD9+UnyQpzpYNmlifCAe0vWb9ARM6cmH2m4TqdnaLemnyCWojVsEf3TFGj8m3
 /gle/Uj5xtc5zH1wySyk33VbIuMbbO9lMPCJMciZR39wnUKdsSAi0/xFmArspW6tInN5pt0M9Ej
 /IDs5S5VBLkTaVRRLqx2atSSjxnDYu1HYNbedsoTMhff+Guc8QBTzrDIu3qVoaNp0NwJWavYf/S
 3BWysy3TEgkwZ0nE8cOVVD23rqqoNA==
X-Proofpoint-ORIG-GUID: z0VLJgIkS7-1hzaBoeN3jdML2gA6m14p
X-Proofpoint-GUID: z0VLJgIkS7-1hzaBoeN3jdML2gA6m14p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240083

Hi Harald,

On 24/6/26 10:09, Harald Freudenberger wrote:
> With the introduction of the address wrapping function
> wrap_address() the result can't be used to walk the
> source address any more. So introduce a new local variable
> to hold the wrapped address to avoid mixing source and
> wrapped address value.
> 
> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx argument")

This commit merely added an argument. I suppose you meant
9f17bfdab42 ("target/s390x: support SHA-512 extensions").

> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index ae392bce0e..29ad2aff43 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
>   
>       for (int i = 0; i < 8; i++, addr += 8) {
> -        addr = wrap_address(env, addr);
> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
> +        uint64_t _addr = wrap_address(env, addr);

s/_addr/wa/ or even directly inline?

            a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);

> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>       }
>   }

