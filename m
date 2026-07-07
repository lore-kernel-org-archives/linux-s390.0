Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C63AC0D8
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408909; cv=none; b=TJW6aSOryr5GiaJIaQCRUf0Llw46vRRLv/O7QrwIl4Ajxm15Kc6kepsaXNVbH+r2IbjFNiQYC2Cof7JqhWKmDaj381j5tUt4i935DPwSuZlSX/OyvyTNzrYriGRPXelzjiYApaEEM7tJS8i5+aDhq3c/S5YQ4r3jzao4sveYqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408909; c=relaxed/simple;
	bh=woTqTqaay2M1wpsd2GUnthkkfZltjHoXgShsqxA6Rqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVog8rucvPSosowJ8ajxHkJ0NPGvKUZn4vDT5a5UL1QDREDCy5NcQOdC1IaT82n0DNwkQh+SOP32XK28+eoNK9Ga3jwlL8ZTR78RgdpqNT/o6tLBI6c2un4JPT/y66l2RA1RoTXG5d1qi529X497T/C0PHZiyDfFeqPuXcaTj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZBiNRc1q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZBiNRc1q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674IKLL2725891;
	Tue, 7 Jul 2026 07:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k2n4Kz
	cH3LKqlj6yMadwVpvSIYNdx2Gwzs3sRkYg4qA=; b=ZBiNRc1qTko+Ah4oEKT7UH
	LQiIA2Ynd8P/atuT7kn0FPDP2qnHn7spTqp06sypcMZOKezeSE2ygxsVeiRa7oNY
	aoHwollU5oMwMJYT3vHFyRgTlzmcfhHqgxnUEbJoWyPPAI4kdG1XxzAyzIo98oks
	bUD9K7ewaZiUdnUh+OaPEmoNuPuiOLLOYirme7y9rGs6/de0GbujbOoTvKtDaoiV
	zO6UoorMOy5G6NNgsTESVREuNMZP3EZku5WGNSdDVJXJVlUvwfZlfweJBOP9kEbT
	OKm1PrLbaAygXG92xx9ooCRphlpQA3VxwjDYGSwo9Kt/mpNxbkufqRFy4Cwa9Q6w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqngpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:21:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6677Jccf009129;
	Tue, 7 Jul 2026 07:21:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw1nqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:21:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6677LKdQ13566252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 07:21:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD5232004D;
	Tue,  7 Jul 2026 07:21:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 503DF20049;
	Tue,  7 Jul 2026 07:21:20 +0000 (GMT)
Received: from [9.111.13.17] (unknown [9.111.13.17])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 07:21:20 +0000 (GMT)
Message-ID: <4ed5f841-f757-4ba2-80df-ba2d378a7c8c@linux.ibm.com>
Date: Tue, 7 Jul 2026 09:21:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/21] target/s390x: Minimal AES XTS support for cpacf
 pcc instruction
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-9-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260706094317.17032-9-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfX3jEp4hyOO3K/
 uakz5Yh2g0xVQIX7PRyzejMwrGM7B899z373Tg93lcpJ4mrF2fA1jPzc77FVQ72NOZ+rXhe5wry
 IQGDiLHY1B5oBydrFx7pQbUpd/lmYJw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfX1bYzaNrJkwdn
 BOktVwBm/YFhsDB4ToAQddQy1BQCtJrah09oEFTWRVMw8yeGCFa1O+M6NmpUgTj6Fdd4BahA+Ju
 bXmWtj5Jh2dIYkWGNol901cwGaZKhh/HZGaVw/vWNJPbxGK4+SblDJ4d6nU4r0zsbZOKFY4AvIf
 3aU0ouelK8JtsZHhXbpkXVL5feRYDrmNdyByU6OpUeitpOUjDkg4xfmZdCAKKZX4FtpqmTd/LBd
 ldMmbhvZCYTOTeHIovcQgqFBPnddP+UizBBtTjJ1FtCYsI8JZst624903WCWeUvsNUBxdVyU5t2
 0iFIoxtYGA5LGlCKe+CnwYVzvPPa5Pv2p5hNQ0BgJdUMwRA6eMELiLALRSNEMqgtyEotk0S3T4H
 5VOkb9YWycVEoFiSIVEDkniAvN67cSnxKTqk9BzOswTFQuZLgPRMcBTJ/JMnsDexXuN30Gi4Qxv
 BtgvEW7bPGrOeoRrPYw==
X-Proofpoint-GUID: foTcbI11_hLuhp7GahfjOZuJaqF0mUfk
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4ca8f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=prY60AAtWssrYS-MNBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: foTcbI11_hLuhp7GahfjOZuJaqF0mUfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070069

On 7/6/26 11:43, Harald Freudenberger wrote:
> Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
> and PCC-Compute-XTS-Parameter-AES-128 but only for the special

typo(?): --> PCC-Compute-XTS-Parameter-AES-256

> case block sequential number is 0. However, this covers the s390
> AES XTS implementation in the Linux kernel and Libica and thus
> also Opencryptoki clear key via Libica.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

Ordering? (T-b first, then S-o-b). See my comment below.
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |  2 +
>   target/s390x/tcg/cpacf.h         |  2 +
>   target/s390x/tcg/cpacf_aes.c     | 63 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 20 ++++++++++
>   4 files changed, 87 insertions(+)
> 
[...]
> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index 3d6aa19df2..f41b7dc541 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -290,3 +290,66 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   
>       return !len ? 0 : 3;
>   }
> +
> +int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                  uint64_t param_addr, uint8_t fc)
> +{
> +    uint8_t key[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
> +    int keysize, i;
> +    uint64_t addr;
> +    AES_KEY exkey;
> +
> +    switch (fc) {
> +    case CPACF_PCC_XTS_AES_128:
> +        keysize = 16;
> +        break;
> +    case CPACF_PCC_XTS_AES_256:
> +        keysize = 32;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /* fetch block sequence nr from param block into buf */
> +    for (i = 0; i < AES_BLOCK_SIZE; i++) {
> +        addr = wrap_address(env, param_addr + keysize + AES_BLOCK_SIZE + i);
> +        buf[i] = cpu_ldb_mmu(env, addr, oi, ra);
> +    }
> +
> +    /* is the block sequence nr 0 ? */
> +    for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++) {
> +            ;
> +    }
> +    if (i < AES_BLOCK_SIZE) {
> +        /* no, sorry handling of non zero block sequence is not implemented */
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return 1;
> +    }

Why not

for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++);
if (i < AES_BLOCK_SIZE) {
...

Or would that be against the coding guidelines?

I personally would prefer the following, because it is more obvious. But 
your solution also works, so feel free to change it or leave it as is.

for (i = 0; i < AES_BLOCK_SIZE; i++) {
     if (buf[i]) {
         /*
          * no, sorry handling of non zero block sequence is not
          * implemented
          */
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return 1;
     }
}

IMO, it is easier to read.

[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

