Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204852C11C6
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763046; cv=none; b=A0yBlI/+PQQ+Q2XhgC6roYREuA+LBXMJBN13ayeVxFcmZbGsNczSC++d+NkzkH6QHJrzCgaL8Gd23Jseclee1WyYugaxhl4cRmPoxmyPSLzgnNzgB8JZI867wknh3Dk+FxNo6TOYztelDDO1PiCkJaKg1x3MN6pLIMMu52/BztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763046; c=relaxed/simple;
	bh=58F6urhxwfqnisM7Kicw8vA69N876po0U5xPWQQ8iqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/J+q3zWYI4zu8T6wCwY6BxyrT8n0DeIqMlfuNqp8E/e68w2+xZy7r+64yAKBayLuBKED/BkbT48PwRm/absI3PdbdjL67OrYrhC1nUDDWzwx5TU5DgFHzwMA1lRr0mio+U3unF+duDj5w6MZOeMbNZGv1xneyLSMZ/vzP6ff5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IGTIBg4u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IGTIBg4u"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHnSqx1252740;
	Thu, 18 Jun 2026 06:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aT49/h
	MJ/p2b3FraIWCSy+o0QKz1ZeS+z+5NDmYGqR8=; b=IGTIBg4uBPmsFsfrgE8aXK
	0ooWzZIOovDj5fMkKVQt3nEOw9aC9q4EANSWSEBdSv2SnKHr9EXGLWPd/dOI10cA
	Y/uDWH9+/wk7tduCGhaZsw7w9i7AnBSKB6SVQQse5UNyG2jdvwbifjKawD8GcdbQ
	Rhpjy5U598HyV82ncRTL5KYx/EAkVnqtkHdAq1opvhQg4kvjmvWI/BCRdlQSxrlf
	I7EFjJtrn0QEcdZ6vEq3RnmBjtItQfEkZdtk+mJfmcQWqDjaCicXw5uL0TO430BN
	/stbE7lCb7/8/888dN8dVZ8BHvRxiuwpM0ExlMAxb49LSIcKE93QOLHP6ynZb0SQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ6m49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:10:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I64a42019496;
	Thu, 18 Jun 2026 06:10:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722a18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:10:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I6AWYv40698172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 06:10:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C17820043;
	Thu, 18 Jun 2026 06:10:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB4A820040;
	Thu, 18 Jun 2026 06:10:31 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 06:10:31 +0000 (GMT)
Message-ID: <1cf46c18-6b80-415a-bcb8-cb68dea6b69e@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:10:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/17] target/s390x: Support protected key AES CTR for
 cpacf kmctr instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-13-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-13-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX18omDHCqNMbY
 zHE5nnNd61A0kj0fX+oZkZmYXuZYpd/NL/YdoK3OTLstxh/AW46aCFN633SNFGiQw/DJOW+JeU8
 HsaOXYVi7mZf4vn/Qv2a053LEUhXFA4=
X-Proofpoint-ORIG-GUID: DM1-KtslAz70RAPZXXHfhhVARsHIeAuJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX0Dw7sPHk8aM3
 ycWkxHcMRmnRZUICjI8OyT1T6ej3IJaDXWTL59kIj85miFSXjB/xGNE0SoDHCGMfN944wSZqr2k
 PDM5XwSnzM7pHS27uA0o1swsvh3MnkSZQmwsIdm91+byUe6uM31gdfWdvnUp9ZUCgWU1Z7lWLru
 wcmTwg/w15E8yfHJuTNHTphdFxgtLsYozkPylPkmNk+PQ7aFqHIdVMosal710kQPOpSWNPgEQe0
 mPFZtUZJDejtw17sCivztSxUPHt592z4iQb1KCa0mb7yjQ1BTmpHtk8XwPs3iXhBlNqJw0cACLJ
 TKldMzVjotp34q1wAN3Ux3dnQ6hx2Q5STOQT/N1vGcInkVHq0ko3XMo3vEjPXum0pm0RkD0Atae
 vjaBXXqTetwqoVkDghr9HAToDfAh+drTk2YzY67yAcwNE2p6cgdyhUtrMMFnRNcq8ha/RXDQGjp
 UHI8mSLL9GcluHXZqlA==
X-Proofpoint-GUID: DM1-KtslAz70RAPZXXHfhhVARsHIeAuJ
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a338bdc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=UP5xVGQBSjxHt9vJOV8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180051



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
> and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  5 ++
>   target/s390x/tcg/cpacf_aes.c     | 90 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 105 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 074c53aecd..4a131dc191 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -938,6 +938,9 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KMCTR_AES_128,
>       S390_FEAT_KMCTR_AES_192,
>       S390_FEAT_KMCTR_AES_256,
> +    S390_FEAT_KMCTR_EAES_128,
> +    S390_FEAT_KMCTR_EAES_192,
> +    S390_FEAT_KMCTR_EAES_256,

EAES -> PAES or EAES -> ENCRYPTED_AES

>       S390_FEAT_PCC_XTS_AES_128,
>       S390_FEAT_PCC_XTS_AES_256,
>       S390_FEAT_PCKMO_AES_128,

[ snip ]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index a6487261e1..ffa286d422 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -729,3 +729,93 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   
>       return !len ? 0 : 3;
>   }
> +
> +int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                   uint64_t param_addr, uint64_t *dst_ptr_reg,
> +                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
> +                   uint64_t *ctr_ptr_reg, uint32_t type,
> +                   uint8_t fc, uint8_t mod)
> +{

[ snip ]

> +    /* fetch protected key from param block */
> +    for (i = 0; i < keysize; i++) {
> +        addr = wrap_address(env, param_addr + i);
> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
> +    }
> +    /* 'decrypt' the protected key */
> +    for (i = 0; i < keysize; i++) {
> +        key[i] ^= protkey_xor_pattern[i];

Outsourcing if you see a benefit.

> +    }
> +
> +    /* expand key */
> +    AES_set_encrypt_key(key, keysize * 8, &exkey);

[ snip ]

