Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723968;
	b=3R5wOMhmPpuHWJiQozcaXIVlydk4HuPbMuBwY2P8ufW9fTpQj9PyZ0FIOn2fiqyGEJmt
	 AlrggdP/MVNlXOCjHBkuMHwzE7cDVh80OGyYI/7U2ZgAEYL0CoRl0cxkZgJeHN4xV2Skz
	 DDav8VBAVbNoGSo/a/mG+L3xDw5m2FueoICVS1zcMLVvcSyaHXvXAgsidZ2bH2Yuj/kxm
	 gZpqto8T7TBn7zJCW3lqyRdS5UXlOJRQ2OB+VPGM1BiT5C9Bwb01mByMje84plDD7VWY3
	 Dnjs/CFur4aIhfL/fdKSJ6y2FDFfvFN3r2tdb266OT/ecSJ3ErAl827jT/MqNALh5qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=82fFJNuae8Dr9XcmLE8VFsYXQbTETgQMhVFVyQ/YE2k=;
	b=cmC6w+9UFSugaZNWlH7CG3TJQw/gabUWONk1MXqOUe9DnDyJRGyI8YaFbcEHlhvOzxDj
	 Kj6UwCwGu2WEMNZCTgBCoPqPuw92s82flsvaRB7NThAKvFQ1HecYut8NvxyXfH/hwPL/G
	 gw/PLaacEcs9obS5ExPmNiudqVln/SbHDE+Lt/fWBWP1BKU8Mqo9ZHsQ4CuDzwE1uJEjj
	 4HIXzHZ1jO+tw37agQ/BxungKJn9wr0wMo3/cGz3umxQBDSbT0CTkTEs4/8XTSU7yRRZE
	 M+N5C8UZvio3iiY3JOCyxb51Kq97ZcQ4AjlJi8lAZveMDEw2S6mTa3EhgnvuuPdZfxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VQqKWoAo;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198E606EE88;
	Tue,  3 Nov 2026 16:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B198E606EE88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VQqKWoAo
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EE8qW2027529;
	Tue, 3 Nov 2026 16:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=82fFJNuae8Dr9XcmLE8VFsYXQbTETg
	QMhVFVyQ/YE2k=; b=VQqKWoAoT4bX63s56O2p+pi/jvsjyAkVonkGgKtuECvOry
	v7v80MnlfGsgc105VOAZ5Iee+4NboH0xFpUVExUDAyXQf3I+F2PT4EcZ3tUMYCUg
	NeN6IGHvxcOkaNsguIoQUhR92o7nHAkY2R5379018THSzekcTJ60h9U/Kzg5MUfA
	MomaRjAVTCIa1pS0QPYqSJ/tQXAseyNY6SWEi+VNV1MUF6nWjn3UUkqFbtbsK4sr
	VzPPvbfiyvr4JUK4xHz7qPpdgT4Dj5s72P9jibjij5+1oTAQLBWJEt8WaYBeDHsS
	65Q5gsMLrRGMd7INYfCqZ4F1n3DYfbeoWgsZ/2yQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826pyqs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:39:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EK14F2558167;
	Tue, 3 Nov 2026 16:39:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrc9v1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:39:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3GdL8X49611028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 16:39:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B236320043;
	Tue,  3 Nov 2026 16:39:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4529520040;
	Tue,  3 Nov 2026 16:39:21 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.65.50])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Nov 2026 16:39:21 +0000 (GMT)
Date: Tue, 3 Nov 2026 17:39:19 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Add assembler-level include guard to
 insn-common-asm.h
Message-ID: <9b3348d9-7510-48e4-8be8-31efabbf152c-agordeev@linux.ibm.com>
References: <20261102-insn-v1-1-df048a0be0d5@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-insn-v1-1-df048a0be0d5@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WwDaAQn6ttdoRVdp6ygPUTMMpOhz1z0F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXwQeV/W16ighB
 peHITsdzt7DF+eN9lh6IGn5GtywA2tujCxrhy6EuL5ZEtEVCFltKCXB6NqaFGtEnsNi2Ap3vr5P
 kAMGPpg1/bLt7ejJwVLaj0v+p/xjkNSV5POtEzj/g7Zk48FTPrgkluV4CYi4hmW5Xfu6Dq/SXCN
 6qEWvb2UjJwRNyGwClZRFv33Haa9OpUNs8PnMY+jpWXOS3rgexubp2IgnT5tkWtWLVebjcpxHza
 DvlFoapOf2mKRtSYC4qOQomecgdY+sG0I4JXuStjjBvqH1tlkJjrNgSmz8UKZEnLELoTb02BTj/
 iC4mhcRpL5VKhaC73AF+XlOE/sgdzaSctNJNOmjIuH/TM8t1YAGXGaJ0dmI/BIJNP93f+bTQS+M
 hs9bgdDSQKe7JU6QKfnfNVZsvFLlK8pdQYL9ei3pEeZArS5YYGqV9Oiqy/gNDhMVngZNnTYGBEp
 I+ZNo+glA5imPulR82A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX9mTUuWS5o7D+
 qkboziXbrmDvfmHtful1Z2s/uZds28R+O4E+sJadXD7lzqSOL2qV9o040S6XNWnmgwyUBAXicrA
 F7jogWaizLBlh0xmdUAcH4e+8oFdkHY=
X-Proofpoint-GUID: WwDaAQn6ttdoRVdp6ygPUTMMpOhz1z0F
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aea0e3e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=F7QhJY-Lf8TsYcsvKi0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030064

On Mon, Nov 02, 2026 at 05:51:03PM +0100, Steffen Eiden wrote:

Hi Steffen,

> The CPP include guard of insn-common-asm.h is ineffective when the file
> is read via a gas-level .include from inline asm. The assembler ignores
> all '#' lines, so every .include redefines GR_NUM/VX_NUM and fails with
> "Macro was already defined" if a translation unit emits more than one
> such include. This is not the case right now but may lead to future
> build issues.
> 
> Add a .ifndef guard with an L-prefixed (local, non-emitted) symbol so
> the file can be include multiple times per assembly unit.
> 
> Fixes: 495bc70aa3225 ("s390/fpu: Move GR_NUM / VX_NUM macros to separate header file")

I have a problem with Fixes here:
- as you noted above nothing fails right now
- the same behaviour was there before 495bc70aa3225 commit

Is there a real problem this patch fixes?

Do you happen to know why some other archs use .purgem in similar cases
(aka though appears ugly, should not we use .purgem too)?

> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/include/asm/insn-common-asm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/s390/include/asm/insn-common-asm.h b/arch/s390/include/asm/insn-common-asm.h
> index fd9b3cacb7c5..060116719846 100644
> --- a/arch/s390/include/asm/insn-common-asm.h
> +++ b/arch/s390/include/asm/insn-common-asm.h
> @@ -9,6 +9,10 @@
>  
>  #ifdef __ASSEMBLER__
>  
> +/* Prevent duplicated GAS macro definitions. CPP guards have no effect for GAS.*/
> +.ifndef .Lasm_s390_insn_common_asm_h
> +.Lasm_s390_insn_common_asm_h = 1
> +
>  /*
>   * GR_NUM - Retrieve general-purpose register number
>   *
> @@ -49,5 +53,7 @@
>  	.endif
>  .endm
>  
> +.endif	/* .Lasm_s390_insn_common_asm_h */
> +
>  #endif	/* __ASSEMBLER__ */
>  #endif	/* __ASM_S390_INSN_COMMON_ASM_H */

Thanks!
