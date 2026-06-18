Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7E14A4F0
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760730; cv=none; b=b6LMBNw6suGalSuu8rxDwCwOXVVvtMrzvbnI1VbWWWjbDvPyRLSZu0C0G/MqP/x0CGvRiCFOVvgp7kOBhDa3MuRa3XqWYnpkQkirOLYnadEtqXpIclOhUEzRyL8xOqyEFUJFPsty9JJfGhYeLUu529vxYWxJBL4G1T32il6uf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760730; c=relaxed/simple;
	bh=Hy0pdgpUBIzZ1uKQZYLKehZPaguVEWeATGWKenNWGE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwyLazKR4JasC1vAMgnl1+wBkxQ6SmsrvO9U3vBZs2Sk4oDuqetiAhqhKjNXErif58Xdx5rl/RpL67GTOwe/c55mMWZqIkUqP5REGtquJ0byXpsgt0g2/adbHcoe3b8K8a23v9dq76ZtoIdmLpM46cJb5nNlRlAqUia///cbO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Oscj4UY+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oscj4UY+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmQ0I977882;
	Thu, 18 Jun 2026 05:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fO+wh+
	mDGGWc48//5FLxZclcbTYviaHX2lbtfvFocT0=; b=Oscj4UY+rsMsuMpRoZg7Yn
	ge9H+BnuJOnipKQoySZ90afsTBQn9GSm/LYDK0uPpvllhlUzrBaOBpox6WJgcIFX
	c8D/tZJd01HMEWuCrXRajDA+Lfg8qu75OG37GUnd/w4bACJ6BpxUGOo8WN+4ef34
	buuQAGkfID5xBCOE6lzRI29cMbLOpJiC5Djf77fKSOmwRdz+gU6qf3LeQb4GTzyP
	LPDXmZP+PXwX58iH23K2RFIA7qg4+R1GR1ezW9NIrgfFrgDMBdYZmj1xsMTx8dgH
	s/cInuX6G7FuElBXjr0p61SD4e6Fw8XBpMM1pbL3ypXk7HatF1TBmsn7Fye5YYcA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6d1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:32:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I5K0Sm004940;
	Thu, 18 Jun 2026 05:32:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17225a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:32:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I5Vvmb40305138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 05:31:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 770DE20043;
	Thu, 18 Jun 2026 05:31:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4483320040;
	Thu, 18 Jun 2026 05:31:57 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 05:31:57 +0000 (GMT)
Message-ID: <d772143c-0cde-435b-8285-ee8f6dfa5278@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/17] target/s390x: Support AES CTR for cpacf kmctr
 instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-7-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 42CYkPkuhhQAQJtES9h5r0D3pRNiz2IJ
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a3382d2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=_nhTmGFvTDV60vWYlToA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX83OVUU0hesye
 sfq5IOUrcaDZbecryw/D3nxjpP3/Nwmaj57hdS+GH97wgHYNr+hIN5D+OXeZxKy2XTPIV771uQq
 u/E4gBtpfDNHH6IoBbwd5/Aux5C3gEI=
X-Proofpoint-ORIG-GUID: 42CYkPkuhhQAQJtES9h5r0D3pRNiz2IJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX1ZCMFz6LjEjl
 kdEbnnpoNPe08x2nZgclgfIowQL9M6uilNTUIY05GZmFpc1mjoWkUxmA4aj31aOIyk/Q1SI0cV8
 wnKNrBBdKFJSfVck0dM7oxGMqtam7gG9k1/E3YreHRbY9gJm59dNXQSEX0bBSprZYKbcqcba7eN
 6d9E9Wu1+OkV0qaTOFDzJs+adNAmRRoIX6BHmzR6TTMGetZ75BAV/zUcoBBwuuplqaOu4wis7fq
 G/b5yf449GyoosZMbvfiqAmA91F7e5Rz0Ud2uIPR2ySnzFpiuhMaKWtcE6q/N95xB5YID382otH
 H0ZObzpRGojhSV93fRpPq9CAX23xGT1sNL4gi8dh1Ett2nh6aGSIrxl5lYNkaMmkWEOBZK9q3Tl
 62CdfgLKDBMKiJo3yapoc9qeBXyocD+AW2uZ35oVBOzueTu/M1t57lySbC6ojy1wLrZStXElEBD
 L2TBDH7Vywyc3OabemA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180045



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KMCTR_AES_128, CPACF_KMCTR_AES_192
> and CPACF_KMCTR_AES_256 for the cpacf kmctr instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

With the one typo fixed:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  5 +++
>   target/s390x/tcg/cpacf_aes.c     | 76 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 24 ++++++++++
>   4 files changed, 108 insertions(+)

[ snip ]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index 6412cc187d..e200a9a87a 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -213,3 +213,79 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,

[ snip ]

> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
> +        /* read in nonce/ctr => ctr */
> +        aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
> +        /* encrypt ctr => buf */
> +        AES_encrypt(ctr, buf, &exkey);
> +        /* read in one block of input data => in */
> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
> +        /* exor input data with encrypted ctr => out */

typo: exor -> xor

> +        aes_xor(in, buf, out);
> +        /* write out the processed block */
> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
> +        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
> +    }
[ snip ]
